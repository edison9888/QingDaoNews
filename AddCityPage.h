//
//  AddCityPage.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-13.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCityDelegate <NSObject>

- (void)addNewCity:(NSString *)cityId;

@end
@interface AddCityPage : UIViewController
@property (nonatomic, strong) id<AddCityDelegate> cityDelegate;
@property (nonatomic, copy) NSString *cityId;
@end
