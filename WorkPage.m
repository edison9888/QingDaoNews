//
//  WorkPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "WorkPage.h"
#import "PublicMethod.h"
#import "AppDelegate.h"
#import "IndexPage.h"
#import "JSONKit.h"
#import "NewsVedioPage.h"
@interface WorkPage ()

@end

@implementation WorkPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//左侧当行页面
-(void)leftBtnPressed{
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] menuController] showLeftController:YES];
    
}

//右侧个人用户页面
-(void)rightBtnPressed{
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] menuController] showRightController:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    //顶部导航栏样式
    [self _initNavigation];
    //初始化表格
    [self _initTableView];
    //加载数据
    [self loadNetDataSource];
    
    self.HUD=[[MBProgressHUD alloc]initWithView:self.view];
    self.HUD.labelText=@"加载中";
    [self.view addSubview:self.HUD];
    [self.HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (void)myTask
{
    sleep(10);
}
#pragma mark- 顶部导航栏
- (void)_initNavigation
{
    for (int i=0; i<4; i++) {
        if (i==1) {
            //图片
            UIImageView *imageview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title.png"]];
            [imageview setFrame:CGRectMake(0, 0+Frame_Y, 320, 44)];
            [self.view addSubview:imageview];
            [self.view sendSubviewToBack:imageview];
            [imageview release];
        }else if(i==3){
            //标题
            UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(55, 0+Frame_Y, 210, 44)];
            [navTitle setText:@"经营热点"];
            [navTitle setTextAlignment:NSTextAlignmentCenter];
            [navTitle setBackgroundColor:[UIColor clearColor]];
            [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
            [navTitle setNumberOfLines:0];
            [navTitle setTextColor:[UIColor whiteColor]];
            [self.view addSubview:navTitle];
            [navTitle release];
        }else{
            //左右按钮
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            if (i==0) {
                //左按钮
                [btn setFrame:CGRectMake(10, 7+Frame_Y, 45, 30)];
                [btn setBackgroundImage:[UIImage imageNamed:@"listicon.png"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"listicon_h.png"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(leftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
            }else{
                //右按钮
                [btn setFrame:CGRectMake(320-32-10, 7+Frame_Y, 32, 30)];
                [btn setBackgroundImage:[UIImage imageNamed:@"shezhi.png"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"shezhi_h.png"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
            }
            [self.view addSubview:btn];
        }
    }

}
//初始化列表视图
- (void)_initTableView
{
    self.mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 42+Frame_Y, UIScreen_Width, UIScreen_Height) style:UITableViewCellStyleDefault];
    self.mainTableView.delegate=self;
    self.mainTableView.dataSource=self;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   // self.mainTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -UIScreen_Height-Frame_Y, UIScreen_Width, UIScreen_Height)];
        view.delegate = self;
        [self.mainTableView addSubview:view];
        _refreshHeaderView = view;
        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}
- (void)loadNetDataSource
{
    NSURL *url=[NSURL URLWithString:api_newVedio_url];
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc]initWithURL:url];
    request.delegate=self;
    [request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data=[request responseData];
    id result=[data objectFromJSONData];
    
    NSArray *statues=[result objectForKey:@"List"];
    NSMutableArray *models=[NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *model in statues) {
        NewsVedioModel *vedioModel=[[NewsVedioModel alloc]initWithDataDic:model];
        [models addObject:vedioModel];
    }
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    }
    
    if (_requestType == RequestTypeNormal) {
        [self.data removeAllObjects];
    }
    if (models!=nil) {
        [self.HUD removeFromSuperview];
    }
    
    self.data=models;
    [self.mainTableView reloadData];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [Dialog toastCenter:@"网络连接失败"];
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    }

}
#pragma  mark -UITableViewSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndifiter=@"cellIndifiter";
    NewsVedioCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndifiter];
    if (cell==nil) {
        cell=[[NewsVedioCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndifiter];
    }
    cell.vedioModel=[self.data objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsVedioPage *vedioPage=[[NewsVedioPage alloc]init];
    NewsVedioModel *model=[self.data objectAtIndex:indexPath.row];
    vedioPage.catId=[model.vedioId integerValue];
    [self.navigationController pushViewController:vedioPage animated:YES];
}
#pragma mark - UIScrollView delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    _reloading = YES;
    _requestType = RequestTypeNormal;
    _currentPage = 0;
    [self loadNetDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
