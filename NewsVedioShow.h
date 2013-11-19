//
//  NewsVedioShow.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "ASIHTTPRequest.h"
#import "Dialog.h"
@interface NewsVedioShow : UIViewController <UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UIScrollViewDelegate>
{
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSInteger                 _currentPage;//页数
    RequestType               _requestType;//下拉刷新标示
    BOOL                      _reloading;//是否加载
}

@property (nonatomic) BOOL                          isLoaded;//是否加载
@property (retain, nonatomic) NSMutableArray        *data;//图片集合
@property (retain, nonatomic) ASIHTTPRequest        *newsRequest;//数据请求
@property (retain, nonatomic) NSMutableArray        *modelArray;
@property (nonatomic, retain) NSMutableArray        *newsArray;
@property (nonatomic, retain) MBProgressHUD         *HUD;

@property (nonatomic, retain) UITableView *tabView;
@property (nonatomic, retain) UINavigationController *superNav;//导航栏
@property (nonatomic, retain) NSString *inforId;
@property (nonatomic) NSInteger num;//顶部按钮
@property (nonatomic) NSInteger catId;//视频的id号
@property (nonatomic, retain) NSURL *url;


@end
