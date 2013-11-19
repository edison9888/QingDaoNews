//
//  FirstPage.m
//  GYCheLunHangYe
//
//  Created by 王新勇 on 13-4-27.
//  Copyright (c) 2013年 王新勇. All rights reserved.
//

#import "CustomTableView.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"
#import "PublicMethod.h"
#import "CycleScrollView.h"
#import "CustomDetailPage.h"

//#import "HangYeZiXunCell.h"
//#import "HuiYuanQiYeCell.h"
//#import "ShuJuTongJiCell.h"

@interface CustomTableView ()
- (void) addItemsOnTop;
- (void) addItemsOnBottom;
- (NSString *) createRandomValue;

@end

@implementation CustomTableView
@synthesize tableviewWidth=_tableviewWidth;
@synthesize tableviewHeight=_tableviewHeight;
@synthesize superNav=_superNav;
@synthesize requestUrl=_requestUrl;
@synthesize keyArray=_keyArray;
@synthesize valueArray=_valueArray;
@synthesize viewTag=_viewTag;
@synthesize tableViewCellType=_tableViewCellType;
@synthesize detailThirdSourceUrl=_detailThirdSourceUrl;


-(void)dealloc{
    [_superNav release];
    [_requestUrl release];
    [_keyArray release];
    [_valueArray release];
    [_detailThirdSourceUrl release];
    [super dealloc];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//设置tabbar 背景图和title
- (NSString *)tabImageName
{
	return @"icon_1.png";
}

- (NSString *)tabTitle
{
	return self.title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    
    NSLog(@"%f====%f",_tableviewWidth,_tableviewHeight);
    [self.view setFrame:CGRectMake(0, 0, _tableviewWidth, _tableviewHeight)];
    //添加tableview
    [self.tableView setFrame:CGRectMake(0, 0, _tableviewWidth, _tableviewHeight)];
    
    
    // 下拉刷新
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
    self.headerView = headerView;
    
    // 上拉加载
    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    
    currentPage=0;
    
    infoArray = [[NSMutableArray alloc] init];
    //    for (int i = 0; i < 10; i++)
    //        [infoArray addObject:[self createRandomValue]];
    
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
}



//请求列表数据
-(void)getInfoList{
    
    //请求资讯信息
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:_requestUrl]];
    //[PublicMethod postRequest:request ParameterKeys:[NSArray arrayWithObjects:@"PageIndex",@"PageSize",@"PingTai", nil] andValueArray:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",currentPage],@"10",@"iOS", nil]];
    [PublicMethod postRequest:request ParameterKeys:_keyArray andValueArray:_valueArray];
    //分页参数
    [request setPostValue:[NSString stringWithFormat:@"%d",currentPage] forKey:@"PageIndex"];
    [request setTimeOutSeconds:60];
    request.delegate=self;
    [request startAsynchronous];
}



-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSString *response =[request responseString];
    NSDictionary *dict =[response JSONValue];
    NSMutableArray *array=[dict objectForKey:@"ArticleList"];
    if (array) {
        if (currentPage==0) {
            [infoArray removeAllObjects];
            [PublicMethod setObject:response key:@"KPTableview_array"];
        }
        
    }else{
        array=[[[PublicMethod getObjectForKey:@"KPTableview_array"] JSONValue] objectForKey:@"ArticleList"];
    }
    pageCount=[[[dict objectForKey:@"PageInfo"] objectForKey:@"PageCount"] intValue];
    [infoArray addObjectsFromArray:array];
    
    if ([infoArray count]==0) {
        [PublicMethod setAlertInfo:@"暂无数据" andSuperview:self.view];
    }
    
    [self.tableView reloadData];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [PublicMethod setAlertInfo:@"网络连接不畅" andSuperview:self.view];
    
    NSMutableArray *array;
    if ([PublicMethod getObjectForKey:@"KPTableview_array"]) {
        array=[[[PublicMethod getObjectForKey:@"KPTableview_array"] JSONValue] objectForKey:@"ArticleList"];
    }else {
        
        return;
    }
    
    pageCount=1;
    [infoArray addObjectsFromArray:array];
    
    [self.tableView reloadData];
}




#pragma mark - Pull to Refresh
- (void) pinHeaderView
{
    [super pinHeaderView];
    
    // do custom handling for the header view
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"请稍后...";
}
- (void) unpinHeaderView
{
    [super unpinHeaderView];
    
    // do custom handling for the header view
    [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}
//
// Update the header text while the user is dragging
//
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    if (willRefreshOnRelease)
        hv.title.text = @"松开即可更新...";
    else
        hv.title.text = @"下拉即可刷新...";
    
}
//
- (BOOL) refresh
{
    if (![super refresh])
        return NO;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:0];
    
    
    // See -addItemsOnTop for more info on how to finish loading
    return YES;
}
#pragma mark - Load More

- (void) willBeginLoadingMore
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator startAnimating];
}

- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = YES;
    }else{
        fv.infoLabel.hidden = NO;
    }
}
- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    
    
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:0];
    
    
    // Inform STableViewController that we have finished loading more items
    
    return YES;
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    
    if (!isRefreshing && isDragging && scrollView.contentOffset.y < 0) {
        [self headerViewDidScroll:scrollView.contentOffset.y < 0 - [self headerRefreshHeight]
                       scrollView:scrollView];
    } else if (!isLoadingMore && self.canLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        
        if (scrollPosition < [self footerLoadMoreHeight] && scrollPosition > -30) {
            
            [fv.infoLabel setText:@"上拉加载更多..."];
        }else if(scrollPosition < -30){
            [fv.infoLabel setText:@"释放开始加载..."];
            [self loadMore];
        }
        
    }
}

#pragma mark - Dummy data methods
- (void) addItemsOnTop
{
    
    currentPage=0;
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    
    if (currentPage >= pageCount-1){
        self.canLoadMore = NO; // signal that there won't be any more items to load
    }else{
        self.canLoadMore = YES;
    }
    
    
    
    
    if (!self.canLoadMore) {
        fv.infoLabel.hidden = YES;
    }else{
        fv.infoLabel.hidden = NO;
    }
    
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    [self refreshCompleted];
}


- (void) addItemsOnBottom
{
    currentPage++;
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
    
    
    if (currentPage >= pageCount-1)
        self.canLoadMore = NO; // signal that there won't be any more items to load
    else
        self.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [self loadMoreCompleted];
}


- (NSString *) createRandomValue
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
            [NSNumber numberWithInt:rand()]];
}


#pragma mark - Standard TableView delegates


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tableViewCellType == HangYeZiXunCellType || _tableViewCellType == HuiYuanQiYeCellType || _tableViewCellType == ChanPinXinXiCellType) {
        return 60;
    }else if(_tableViewCellType == ShuJuTongJiCellType){
        return 40;
    }
    
    return 0;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *dict =[infoArray objectAtIndex:[indexPath row]];
    
   // NSLog(@"%@",dict);
    
//    if (_tableViewCellType==HangYeZiXunCellType || _tableViewCellType == ChanPinXinXiCellType) {
//        //行业资讯
//        HangYeZiXunCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[[HangYeZiXunCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                           reuseIdentifier:CellIdentifier] autorelease];
//        }
//        [cell setLogoImageUrl:[NSString stringWithFormat:@"%@%@",IMAGEURL,[dict objectForKey:@"PicName"]] andTitle:[dict objectForKey:@"Name"] andContent:[dict objectForKey:@"Name"]];
//        return cell;
//        
//    }else if(_tableViewCellType==HuiYuanQiYeCellType){
//        //会员企业
//        HuiYuanQiYeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[[HuiYuanQiYeCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                           reuseIdentifier:CellIdentifier] autorelease];
//        }
//        
//        [cell setTitle:[dict objectForKey:@"Name"] andContent:[dict objectForKey:@"Name"] andTel:[dict objectForKey:@"Name"]];
//        return cell;
//        
//    }else if(_tableViewCellType == ShuJuTongJiCellType){
//        //数据统计
//        ShuJuTongJiCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[[ShuJuTongJiCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                           reuseIdentifier:CellIdentifier] autorelease];
//        }
//        
//        [cell setTitle:[dict objectForKey:@"Name"]];
//        return cell;
//    }else{
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CellIdentifier] autorelease];
        }
        
        cell.textLabel.text = [dict objectForKey:@"Name"];
        return cell;
        
//    }
    
    
    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CustomDetailPage *detail =[[CustomDetailPage alloc] init];
    detail.urlStr=@"http://www.baidu.com";
    [_superNav pushViewController:detail animated:YES];
    [detail release];
    
}


@end
