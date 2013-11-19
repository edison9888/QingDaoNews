//
//  IndexPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "IndexPage.h"
#import "PublicMethod.h"
#import "JSONKit.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsTitleCell.h"
#import "Dialog.h"

@interface IndexPage ()

@end

@implementation IndexPage
@synthesize detail=_detail;
@synthesize superNav=_superNav;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    //[Dialog progressToast:@"等一下"];
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
    self.tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0+Frame_Y, 320, 430) style:UITableViewStylePlain];
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
    [self.view addSubview:self.tabView];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -UIScreen_Height-Frame_Y, UIScreen_Width, UIScreen_Height)];
        view.delegate = self;
        [self.tabView addSubview:view];
        _refreshHeaderView = view;
        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    if (_loadMoreFooterView ==nil) {
        _loadMoreFooterView = [[LoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0-Frame_Y, UIScreen_Width, 40)];
        _loadMoreFooterView.delegate = self;
        self.tabView.tableFooterView = _loadMoreFooterView;
    }

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
    if ([self.inforId isEqualToString:@"要闻"]) {
        self.url=[NSURL URLWithString:api_workRequest_url(page)];
    }else if([self.inforId isEqualToString:@"图片"]){
        self.url=[NSURL URLWithString:api_companyRequest_(page)];
    }else if ([self.inforId isEqualToString:@"新闻"]){
        self.url=[NSURL URLWithString:api_newsRequest_url(page)];
    }else if ([self.inforId isEqualToString:@"话题"]){
        self.url=[NSURL URLWithString:api_request_url(page)];
    }

    self.newsRequest = [ASIHTTPRequest requestWithURL:self.url];
    self.newsRequest.delegate = self;
    [self.newsRequest startAsynchronous];
    
}
//加载网络数据完成
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data=request.responseData;
    id result = [data objectFromJSONData];
    NSArray *status=[result objectForKey:@"List"];
    NSMutableArray *models=[NSMutableArray arrayWithCapacity:status.count];
    for (NSDictionary *model in status) {
        NewsModel *newsModel=[[NewsModel alloc]initWithDataDic:model];
        [models addObject:newsModel];
    }
    
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tabView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:self.tabView];
    }
    
    if (_requestType == RequestTypeNormal) {
        [self.data removeAllObjects];
    }
    
    [self.modelArray addObjectsFromArray:models];
    if (self.modelArray!=nil) {
        [self.HUD removeFromSuperview];
    }
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
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:self.tabView];
    }
}
//加载失败的提示
- (void)dataSourceDidError
{
    [Dialog toastCenter:@"无法连接到网络"];
    
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tabView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:self.tabView];
    }
}

#pragma mark- UITableViewSource
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
    NewsModel *model=[self.data objectAtIndex:indexPath.row];
    NSString *picStr=model.NewsPic;
    if ([picStr isEqualToString:@""]) {
        static NSString *cellNoImageIndifiter=@"cellNoImageIndifiter";
        NewsTitleCell *cell=[tableView dequeueReusableCellWithIdentifier:cellNoImageIndifiter];
        if (cell==nil) {
            cell=[[NewsTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNoImageIndifiter];
        }
        cell.newsModel=model;
        return cell;
    }else{
        static NSString *cellIndifiter=@"cellInfiter";
        NewsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndifiter];
        if (cell==nil) {
            cell=[[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndifiter];
        }
        
        cell.newsModel=model;
        [cell setContentWihtFrame];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model=[self.modelArray objectAtIndex:indexPath.row];
    DetailViewController *details=[[DetailViewController alloc]init];
    self.detail=details;
    details.idNumber=[model.NewsId integerValue];
    [_superNav pushViewController:details animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
#pragma mark - UIScrollView delegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_loadMoreFooterView loadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreFooterView loadMoreshScrollViewDidEndDragging:scrollView];
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

#pragma mark - LoadMoreFooterView delegate method

- (void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreFooterView *)view
{
    _reloading = YES;
    _requestType = RequestTypeLoadMore;
    
    _currentPage++;
    [self loadNetDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
