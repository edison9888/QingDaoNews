//
//  DetailViewController.h
//  NewsProject
//
//  Created by 姜勇 on 13-10-31.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "Dialog.h"

@interface DetailViewController : UIViewController <ASIHTTPRequestDelegate>
{
    NSMutableArray *title;
    NSMutableArray *date;
    NSMutableArray *source;
    NSMutableArray *pic;
    NSMutableArray *newsIds;
}
@property (nonatomic, assign) NSInteger idNumber;
@property (nonatomic, assign) NewsModel *newsModel;
@property (nonatomic, assign) UILabel   *titleLable;
@property (nonatomic, assign) UILabel   *dateLable;
@property (nonatomic, assign) UILabel   *infoLable;
@property (nonatomic, assign) UIScrollView *detailScrollview;
@property (nonatomic, assign) UIWebView *detailWeb;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, retain) MBProgressHUD *HUD;

@end
