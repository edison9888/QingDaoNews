//
//  LeftPage.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePage.h"
#import "PicturePage.h"
#import "NewsPage.h"
#import "WorkPage.h"
#import "VedioPage.h"
#import "StaffPage.h"

@interface LeftPage : UIViewController

@property (nonatomic, retain) UINavigationController *homeNav;
@property (nonatomic, retain) UINavigationController *picNav;
@property (nonatomic, retain) UINavigationController *newsNav;
@property (nonatomic, retain) UINavigationController *topicNav;
@property (nonatomic, retain) UINavigationController *workNav;
@property (nonatomic, retain) UINavigationController *staffNav;
@property (nonatomic, retain) UINavigationController *vedioNav;

@end
