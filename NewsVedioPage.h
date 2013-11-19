//
//  NewsVedioPage.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Dialog.h"
@interface NewsVedioPage : UIViewController <ASIHTTPRequestDelegate>
@property (nonatomic, strong) NSMutableArray *tabArray;
@property (nonatomic) NSInteger catId;
@property (nonatomic, retain) MBProgressHUD         *HUD;
@end
