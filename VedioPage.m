//
//  VedioPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-14.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "VedioPage.h"
#import "PublicMethod.h"
#import "AppDelegate.h"
#import "PictureModel.h"
#import "PictureCell.h"
@interface VedioPage ()

@end

@implementation VedioPage

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
            [navTitle setText:@"图集"];
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
- (void)_initTableView
{
    self.mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 42+Frame_Y, UIScreen_Width, UIScreen_Height) style:UITableViewCellStyleDefault];
    self.mainTableView.delegate=self;
    self.mainTableView.dataSource=self;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -UIScreen_Height+Frame_Y, UIScreen_Width, UIScreen_Height)];
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
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.data count];
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndifiter=@"cellIndifiter";
    PictureCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndifiter];
    if (cell==nil) {
        cell=[[PictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndifiter];
    }
    PictureModel *model=[[PictureModel alloc]init];
    [cell layoutImageView:model indexPath:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
#pragma mark -加载图片数据
- (void)loadNetDataSource
{

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
#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
