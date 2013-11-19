//
//  StaffPage.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityPage.h"
@interface StaffPage : UIViewController <UIScrollViewDelegate,AddCityDelegate>
@property (nonatomic, retain) NSMutableArray *tabArray;
@property (nonatomic, retain) UIScrollView *pageView;
@property (nonatomic) NSInteger page;
@end
