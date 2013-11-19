//
//  PublicMethod.h
//  CarShow
//
//  Created by wang rain on 12-4-24.
//  Copyright (c) 2012年 青岛联科时代科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "ASIFormDataRequest.h"
//#import "JSON.h"
#import "MBProgressHUD.h"


//全国版服务器地址
#define SERVERURL @"http://123.147.162.180:8090/Api"

//新闻校园详细页
#define DETAILURL @"http://123.147.162.180:8090/Api/News/NewsAdapter/GetNewsDetail"

//服务详细页
#define FUWUDETAIL @"http://123.147.162.180:8090/Api/Activity/ActivityAdapter/GetActivityDetail"

//话题详细页
#define HUATIDETAIL @"http://123.147.162.180:8090/Api/FollowPost/FollowPostAdapter/GetFollowPost"


//全国版图片地址
#define IMAGEURL  @"http://123.147.162.180:8090"
//-----------------岛城新闻------------------------
//图片
#define api_request_url(page)      [NSString stringWithFormat:@"http://test.mlib123.com/API/Info/List.ashx?catId=247&pageIndex=%d&pageSize=6",page]
//员工
#define api_workRequest_url(page)  [NSString stringWithFormat:@"http://test.mlib123.com/API/Info/List.ashx?catId=254&pageIndex=%d&pageSize=8",page]
//首页
#define api_headRequest_url        [NSString stringWithFormat:@"http://test.mlib123.com/API/Info/List.ashx?catId=1017"]

#define api_firstRequest_url       [NSString stringWithFormat:@"http://test.mlib123.com/API/Info/List.ashx?catId=1011&pageIndex=0&pageSize=6"]
//经营
#define api_companyRequest_(page)  [NSString stringWithFormat:@"http://test.mlib123.com/API/Info/List.ashx?catId=236&pageIndex=%d&pageSize=6",page]
//新闻
#define api_newsRequest_url(page)  [NSString stringWithFormat:@"http://test.mlib123.com/API/Info/List.ashx?catId=248&pageIndex=%d&pageSize=8",page]
//新闻详情页
#define api_newsDetail_url(id)     [NSString stringWithFormat:@"http://test.mlib123.com/API/Info/Detail.ashx?id=%d",id]
//新闻评论页面
#define api_newsComment_url(newsId,message,source) [NSString stringWithFormat:@"http://test.mlib123.com/API/Review/Add.ashx?docId=%d&message=%@&source=%@",newsId,message,source]
//新闻评论页面2
#define api_newsComments_url [NSString stringWithFormat:@"http://test.mlib123.com/API/Review/Add.ashx?"]
//新闻评论详情
#define api_newsCommentDetail_url(infoId) [NSString stringWithFormat:@"http://test.mlib123.com/API/Review/List.ashx?InfoId=%d&pageIndex=0&pageSize=5",infoId]
//天气预报
#define api_newWeather_url [NSString stringWithFormat:@"http://m.weather.com.cn/data/cityNumber.html"]
//视频列表
#define api_newVedio_url [NSString stringWithFormat:@"http://test.mlib123.com/API/Video/VideoList.ashx?pageIndex=0&pageSize=5"]
//视频详情列表
#define api_newsVedioDetail_url(infoId) [NSString stringWithFormat:@"http://test.mlib123.com/API/Video/SubVideoList.ashx?CatId=%d",infoId]


#define UIScreen_Height [UIScreen mainScreen].bounds.size.height
#define UIScreen_Width  [UIScreen mainScreen].bounds.size.width

#define TextBlueColor ([UIColor colorWithRed:23/255.0 green:118/255.0 blue:187/255.0 alpha:1]);
#define TextGrayColor ([UIColor colorWithRed:81/255.0 green:99/255.0 blue:119/255.0 alpha:1]);


#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define EACHPAGECOUNT 15

#define Frame_Y ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0 ? 20 : 0.0)


#define testUserName  @"13111111111"
#define testUserPassword  @"123456"




typedef enum{
	HangYeZiXunCellType=0,//行业资讯栏目下cell样式
	HuiYuanQiYeCellType=1,//会员企业栏目下cell样式
	ChanPinXinXiCellType=2,//产品信息栏目下cell样式
    ShuJuTongJiCellType=3,//数据统计栏目下的cell样式
} TableViewCellType;





@interface PublicMethod : NSObject


- (NSString *)URLDecodedString;

+(BOOL)checkConnection;


+(void)setObject:(id)object key:(NSString *)key;

+(id)getObjectForKey:(NSString *)key;

+(void)removeObjectForKey:(NSString *)key;


//获取手机唯一标识
+(NSString *)getAppKey;


//请求传参
+(void)postRequest:(ASIFormDataRequest *)request ParameterKeys:(NSArray *)keyArray  andValueArray:(NSArray *)valueArray;



//弹出提示框
+(void)setAlertInfo:(NSString *)info
       andSuperview:(UIView *)view;



//添加通用tableview
+(void)addTableViewFrame:(CGRect)rect
           andRequestUrl:(NSString *)requestUrl
           andDetailtUrl:(NSString *)detailtUrl
             andKeyArray:(NSMutableArray *)keyArray
           andValueArray:(NSMutableArray *)valueArray
    andTableViewCellType:(NSInteger)cellType
             andSuperNav:(UINavigationController *)superNav
                  andTag:(NSInteger)viewTag
            andSuperView:(UIView *)view;




//获取新闻栏目二级tab
+(NSURL *)getXinWenTab;



//获取首页顶部信息
+(NSURL *)getIndexTopInfo;


//获取首页底部信息
+(NSURL *)getInndexBottomInfo;


//获取校园栏目二级tab
+(NSURL *)getXiaoYuanTab;


//获取服务栏目二级tab
+(NSURL *)getFuWuTab;


//获取服务列表页
+(NSURL *)getFuWuList;


//获取提交感兴趣接口
+(NSURL *)getGanXingQu;


//获取提交要参加接口
+(NSURL *)getYaoCanJia;




//获取话题栏目二级tab
+(NSURL *)getHuaTiTab;

//获取话题顶部信息
+(NSURL *)getHuaTiTopInfo;


//获取话题底部信息
+(NSURL *)getHuaTiBottomInfo;


//获取话题投票接口
+(NSURL *)getTouPiao;






//用户登陆接口
+(NSURL *)getLogin;

//用户注册接口
+(NSURL *)getRegster;




//我的关注活动列表
+(NSURL *)getMyGuanZhuHuoDong;


//我的参加活动列表
+(NSURL *)getMyCanJiaHuoDong;


//我的话题列表
+(NSURL *)getMyHuaTi;




//获得广告图片
+(NSURL *)getAdvert;



//获得离线数据接口
+(NSURL *)getLiXianShuJu;



@end
