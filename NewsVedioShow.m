//
//  NewsVedioShow.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsVedioShow.h"
#import "PublicMethod.h"
#import "JSONKit.h"
#import "NewsVedioDetail.h"
#import "NewsVedioList.h"
#import "NewsVedioListCell.h"
#import "NewsPlayVedio.h"
@interface NewsVedioShow ()

@end

@implementation NewsVedioShow

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //新闻数组
    self.newsArray=[[NSMutableArray alloc]init];
    
    _isLoaded = YES;
    _currentPage = 0;
    _requestType = RequestTypeNormal;
    self.modelArray=[[NSMutableArray alloc]init];
    
    [self _initTableView];
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

#pragma mark - 初始化列表视图
- (void)_initTableView
{
    self.tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 380) style:UITableViewStylePlain];
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
    [self.view addSubview:self.tabView];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -UIScreen_Height, UIScreen_Width, UIScreen_Height)];
        view.delegate = self;
        [self.tabView addSubview:view];
        _refreshHeaderView = view;
        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
}
#pragma mark - Load Net Data Source
//请求数据
- (void)loadNetDataSource
{
    [self initPicRequestWithPage:_currentPage];
}
//开始加载数据
- (void)initPicRequestWithPage:(NSInteger)page
{
    NSURL *url=[NSURL URLWithString:api_newsVedioDetail_url(self.catId)];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    [request startAsynchronous];
    

}
//加载网络数据完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data=request.responseData;
    id result = [data objectFromJSONData];
    int i=0;
    NSArray *status=[result objectForKey:@"SubCata"];
    NSMutableArray *models=[NSMutableArray arrayWithCapacity:status.count];
    
    NSMutableArray *array1=[[NSMutableArray alloc]init];
    NSMutableArray *array2=[[NSMutableArray alloc]init];
    NSMutableArray *array3=[[NSMutableArray alloc]init];
    NSMutableArray *array4=[[NSMutableArray alloc]init];

    for (NSDictionary *model in status) {
        NSArray *array = [model objectForKey:@"VideoList"];
        for (NSDictionary *list in array) {
            NewsVedioList *vedioList = [[NewsVedioList alloc]initWithDataDic:list];
            //[models addObject:vedioList];
            if (i==0) {
                [array1 addObject:vedioList];
            }else if (i==1){
                [array2 addObject:vedioList];
            }else if (i==2){
                [array3 addObject:vedioList];
            }else if (i==3){
                [array4 addObject:vedioList];
            }
            
        }
        i++;
    }
    switch (self.num) {
        case 0:
            [self.modelArray addObjectsFromArray:array1];
            break;
         case 1:
            [self.modelArray addObjectsFromArray:array2];
            break;
        case 2:
            [self.modelArray addObjectsFromArray:array3];
            break;
        case 3:
            [self.modelArray addObjectsFromArray:array4];
            break;
        default:
            break;
    }
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tabView];
    }
    
    if (_requestType == RequestTypeNormal) {
        [self.data removeAllObjects];
    }
    
    //[self.modelArray addObjectsFromArray:models];
    if (self.modelArray!=nil) {
        [self.HUD removeFromSuperview];
    }
    //self.data=models;
    //[self.modelArray addObjectsFromArray:array1];
    self.data=self.modelArray;
    [self.tabView reloadData];

}
//加载网络失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self dataSourceDidError];
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tabView];
    }

}
//加载失败的提示
- (void)dataSourceDidError
{
    [Dialog toastCenter:@"无法连接到网络"];
    
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tabView];
    }
}
#pragma mark - UITableView Source

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
    NewsVedioListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndifiter];
    if (cell==nil) {
        cell=[[NewsVedioListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndifiter];
    }
    NewsVedioList *vedioList=[self.data objectAtIndex:indexPath.row];
    cell.NewsVedioList=vedioList;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsPlayVedio *playVedio=[[NewsPlayVedio alloc]init];
    NewsVedioList *vedioList=[self.data objectAtIndex:indexPath.row];
    playVedio.vedioUrl=vedioList.vedioUrl;
    [_superNav pushViewController:playVedio animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
