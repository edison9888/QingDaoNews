//
//  HomePage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "HomePage.h"
#import "PublicMethod.h"
#import "AppDelegate.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsTitleCell.h"
#import "JSONKit.h"

@interface HomePage ()

@end

@implementation HomePage
@synthesize detail=_detail;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - 左右两侧边栏
//左侧当行页面
-(void)leftBtnPressed{
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] menuController] showLeftController:YES];
    
}

//右侧个人用户页面
-(void)rightBtnPressed{
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] menuController] showRightController:YES];
}
#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //新闻数组
    self.newsArray=[[NSMutableArray alloc]init];
    
    _isLoaded = YES;
    _currentPage = 0;
    _requestType = RequestTypeNormal;
    self.modelArray=[[NSMutableArray alloc]init];
    
    [self _initNavigationBar];
    [self _initTableView];
    [self loadNetDataSource];
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view withLabel:@"请稍后..." animated:YES];
    [self.HUD setTag:1987];
}
#pragma mark -初始化界面
//顶部导航栏样式
- (void)_initNavigationBar
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
            [navTitle setText:@"青岛新闻"];
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
    self.mainTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -UIScreen_Height-Frame_Y, UIScreen_Width, UIScreen_Height)];
        view.delegate = self;
        [self.mainTableView addSubview:view];
        _refreshHeaderView = view;
        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    if (_loadMoreFooterView ==nil) {
        _loadMoreFooterView = [[LoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0-Frame_Y, UIScreen_Width, 40)];
        _loadMoreFooterView.delegate = self;
        self.mainTableView.tableFooterView = _loadMoreFooterView;
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
    NSURL *url=[NSURL URLWithString:api_newsRequest_url(page)];
    self.newsRequest = [ASIHTTPRequest requestWithURL:url];
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
    
    //新闻标题
    NSMutableArray *title=[NSMutableArray arrayWithCapacity:models.count];
    //新闻日期
    NSMutableArray *date=[NSMutableArray arrayWithCapacity:models.count];
    //新闻来源
    NSMutableArray *source=[NSMutableArray arrayWithCapacity:models.count];
    //图片来源
    NSMutableArray *pic=[NSMutableArray arrayWithCapacity:models.count];
    
    for (NSDictionary *model in status) {
        NewsModel *newsModel=[[NewsModel alloc]initWithDataDic:model];
        [models addObject:newsModel];
        
        //将数据存到数组
        [title addObject:newsModel.NewsTitle];
        [date addObject:newsModel.NewsPublishDate];
        [source addObject:newsModel.NewsInfoSource];
        [pic addObject:newsModel.NewsPic];
        
    }
    //将数据存储到本地
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"title"];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"date"];
    [[NSUserDefaults standardUserDefaults] setObject:source forKey:@"source"];
    [[NSUserDefaults standardUserDefaults] setObject:pic forKey:@"pic"];

    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    }
    
    if (_requestType == RequestTypeNormal) {
        [self.data removeAllObjects];
    }
    
    [self.modelArray addObjectsFromArray:models];

    if (self.modelArray!=nil) {
        [self.HUD removeFromSuperview];
    }
    
    self.data=self.modelArray;
    [self.mainTableView reloadData];
}
//加载网络失败
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self dataSourceDidError];
//    if (_reloading) {
//        _reloading = NO;
//        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
//        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
//    }
    //获取本地数据
    id titleArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"title"];
    id dateArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"date"];
    id sourceArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"source"];
    id picArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"pic"];
    //将数据读取出来放到Model中
    NSMutableArray *model=[NSMutableArray arrayWithCapacity:[titleArray count]];
    for (int i=0;i<[titleArray count];i++) {
        NewsModel *newsModel=[[NewsModel alloc]init];
        newsModel.NewsTitle = [titleArray objectAtIndex:i];
        newsModel.NewsPublishDate = [dateArray objectAtIndex:i];
        newsModel.NewsInfoSource = [sourceArray objectAtIndex:i];
        newsModel.NewsPic = [picArray objectAtIndex:i];
        [model addObject:newsModel];
    }
    //更新数据
    if (model!=nil) {
        [self.HUD removeFromSuperview];
    }
    self.data = model;
    [self.mainTableView reloadData];

}
//加载失败的提示
- (void)dataSourceDidError
{
    [Dialog toastCenter:@"无法连接到网络"];
    
    if (_reloading) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
        [_loadMoreFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    NewsModel *model=[self.data objectAtIndex:indexPath.row];
    DetailViewController *details=[[DetailViewController alloc]init];
    self.detail=details;
    self.detail.newsModel=model;
    self.detail.idNumber=[model.NewsId integerValue];
    [self.navigationController pushViewController:self.detail animated:YES];
    
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
