//
//  WeatherPage.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-13.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Dialog.h"
@interface WeatherPage : UIViewController <ASIHTTPRequestDelegate>
@property (retain, nonatomic) NSMutableArray *data;
@property (retain, nonatomic) NSString *cityId;
@property (retain, nonatomic) IBOutlet UIImageView *todayImage;
@property (retain, nonatomic) IBOutlet UILabel *city;
@property (retain, nonatomic) IBOutlet UILabel *todayWeek;
@property (retain, nonatomic) IBOutlet UILabel *date;
@property (retain, nonatomic) IBOutlet UILabel *content;
@property (retain, nonatomic) IBOutlet UILabel *week1;
@property (retain, nonatomic) IBOutlet UILabel *week2;
@property (retain, nonatomic) IBOutlet UILabel *week3;
@property (retain, nonatomic) IBOutlet UILabel *wendu1;
@property (retain, nonatomic) IBOutlet UILabel *wendu2;
@property (retain, nonatomic) IBOutlet UILabel *wendu3;
@property (retain, nonatomic) IBOutlet UIImageView *weatherImage1;
@property (retain, nonatomic) IBOutlet UIImageView *weatherImage2;
@property (retain, nonatomic) IBOutlet UIImageView *weatherImage3;
@property (retain, nonatomic) IBOutlet UIImageView *todayWeather;
@property (retain, nonatomic) IBOutlet UILabel *todayWenDu;
@property (retain, nonatomic) MBProgressHUD *HUD;
- (IBAction)refreshWeather:(id)sender;

@end
