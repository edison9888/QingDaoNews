//
//  AppDelegate.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePage.h"
#import "DDMenuController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) DDMenuController *menuController;
@property (retain, nonatomic) HomePage *homePage;
@property (retain, nonatomic) UINavigationController *homeNav;
@end
