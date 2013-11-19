//
//  VedioPage.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-14.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreFooterView.h"
#import "Dialog.h"
@interface VedioPage : UIViewController <UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,EGORefreshTableHeaderDelegate,LoadMoreFooterViewDelegate>
{
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    LoadMoreFooterView        *_loadMoreFooterView;
    NSInteger                 _currentPage;//页数
    RequestType               _requestType;//下拉刷新标示
    BOOL                      _reloading;//是否加载
}

@property (nonatomic) BOOL                          isLoaded;//是否加载
@property (retain, nonatomic) NSMutableArray        *data;//图片集合
@property (retain, nonatomic) ASIHTTPRequest        *newsRequest;//数据请求
@property (retain, nonatomic) UITableView           *mainTableView;
@property (retain, nonatomic) NSMutableArray        *modelArray;
@property (nonatomic, retain) NSMutableArray        *newsArray;
@property (nonatomic, retain) MBProgressHUD         *HUD;
@end
