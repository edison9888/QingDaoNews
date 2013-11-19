//
//  PublicMethod.m
//  CarShow
//
//  Created by wang rain on 12-4-24.
//  Copyright (c) 2012年 青岛联科时代科技. All rights reserved.
//

#import "PublicMethod.h"
#import "Reachability.h"
#import "SGInfoAlert.h"
#import "CustomTableView.h"


@implementation PublicMethod


+(BOOL)checkConnection
{
    Reachability *connect =[Reachability reachabilityWithHostName:@"www.baidu.com"];
	switch ([connect currentReachabilityStatus]) {
		case NotReachable:
			//NSLog(@"没有网络");
            return FALSE;
			break;
		case ReachableViaWWAN:
			//NSLog(@"3G网络");
            return FALSE;
			break;
		case ReachableViaWiFi:
			//NSLog(@"WiFi网络");
            return TRUE;
			break;
		default:
            return FALSE;
			break;
	}
}




+(void)setObject:(id)object key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(id)getObjectForKey:(NSString *)key
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }else{
        return NULL;
    }
}


+(void)removeObjectForKey:(NSString *)key{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}



//获取手机唯一标识
+(NSString *)getAppKey{
    //手机唯一标识
    NSString *appkey =[self getObjectForKey:@"appKey"];
    return appkey;
}

//请求传参
+(void)postRequest:(ASIFormDataRequest *)request ParameterKeys:(NSArray *)keyArray  andValueArray:(NSArray *)valueArray
{
    for (int i=0 ; i<[keyArray count]; i++) {
        [request setPostValue:[valueArray objectAtIndex:i] forKey:[keyArray objectAtIndex:i]];
    }
}


//弹出提示框
+(void)setAlertInfo:(NSString *)info
       andSuperview:(UIView *)view{
    [SGInfoAlert showInfo:info
                  bgColor:[[UIColor darkGrayColor] CGColor]
                   inView:view
                 vertical:0.19];
}



//获取新闻栏目二级tab
+(NSURL *)getXinWenTab{
    NSString *urlstr =[NSString stringWithFormat:@"%@/News/NewsFieldAdapter/GetNewsField",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//获取首页顶部信息
+(NSURL *)getIndexTopInfo{
    NSString *urlstr =[NSString stringWithFormat:@"%@/News/NewsAdapter/GetImageNews",SERVERURL];
    return [NSURL URLWithString:urlstr];
}




//获取首页底部信息
+(NSURL *)getInndexBottomInfo{
    NSString *urlstr =[NSString stringWithFormat:@"%@/News/NewsAdapter/GetNews",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//获取校园栏目二级tab
+(NSURL *)getXiaoYuanTab{
    NSString *urlstr =[NSString stringWithFormat:@"%@/News/NewsFieldAdapter/GetSchoolNewsField",SERVERURL];
    return [NSURL URLWithString:urlstr];
}




//获取服务栏目二级tab
+(NSURL *)getFuWuTab{
    NSString *urlstr =[NSString stringWithFormat:@"%@/Activity/ActivityAdapter/GetActivityFields",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//获取服务列表页
+(NSURL *)getFuWuList{
    NSString *urlstr =[NSString stringWithFormat:@"%@/Activity/ActivityAdapter/GetActivitys",SERVERURL];
    return [NSURL URLWithString:urlstr];
}



//获取提交感兴趣接口
+(NSURL *)getGanXingQu{
    NSString *urlstr =[NSString stringWithFormat:@"%@/Activity/ActivityAdapter/FocurActivity",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//获取提交要参加接口
+(NSURL *)getYaoCanJia{
    NSString *urlstr =[NSString stringWithFormat:@"%@/Activity/ActivityAdapter/JoinActivity",SERVERURL];
    return [NSURL URLWithString:urlstr];
}














//获取话题栏目二级tab
+(NSURL *)getHuaTiTab{
    NSString *urlstr =[NSString stringWithFormat:@"%@/FollowPost/FollowPostAdapter/GetFollowPostFields",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//获取话题顶部信息
+(NSURL *)getHuaTiTopInfo{
    NSString *urlstr =[NSString stringWithFormat:@"%@/FollowPost/FollowPostAdapter/GetImageFollowPosts",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//获取话题底部信息
+(NSURL *)getHuaTiBottomInfo{
    NSString *urlstr =[NSString stringWithFormat:@"%@/FollowPost/FollowPostAdapter/GetFollowPosts",SERVERURL];
    return [NSURL URLWithString:urlstr];
}



//获取话题投票接口
+(NSURL *)getTouPiao{
    NSString *urlstr =[NSString stringWithFormat:@"%@/FollowPost/FollowPostAdapter/Vote",SERVERURL];
    return [NSURL URLWithString:urlstr];
}






//用户登陆接口
+(NSURL *)getLogin{
    NSString *urlstr =[NSString stringWithFormat:@"%@/User/UserAdapter/Login",SERVERURL];
    return [NSURL URLWithString:urlstr];
}



//用户注册接口
+(NSURL *)getRegster{
    NSString *urlstr =[NSString stringWithFormat:@"%@/User/UserAdapter/Reg",SERVERURL];
    return [NSURL URLWithString:urlstr];
}






//我的关注活动列表
+(NSURL *)getMyGuanZhuHuoDong{
    NSString *urlstr =[NSString stringWithFormat:@"%@/Activity/ActivityAdapter/MyFocurActivity",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//我的参加活动列表
+(NSURL *)getMyCanJiaHuoDong{
    NSString *urlstr =[NSString stringWithFormat:@"%@/Activity/ActivityAdapter/MyJoinActivity",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//我的话题列表
+(NSURL *)getMyHuaTi{
    NSString *urlstr =[NSString stringWithFormat:@"%@/FollowPost/FollowPostAdapter/MyFollowPost",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//获得广告图片
+(NSURL *)getAdvert{
    NSString *urlstr =[NSString stringWithFormat:@"%@/CoverAdvert/CoverAdvertAdapter/GetCoverAdvert",SERVERURL];
    return [NSURL URLWithString:urlstr];
}


//获得离线数据接口
+(NSURL *)getLiXianShuJu{
    NSString *urlstr =[NSString stringWithFormat:@"%@/offLine/offlineadapter/getoffline",SERVERURL];
    return [NSURL URLWithString:urlstr];
}




@end
