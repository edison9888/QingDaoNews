//
//  WeatherPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-13.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "WeatherPage.h"
#import "WeatherModel.h"
#import "PublicMethod.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
@interface WeatherPage ()

@end

@implementation WeatherPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.data=[[NSMutableArray alloc]init];
    [self startLoadWeather];
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view withLabel:@"请稍后..." animated:YES];
    [self.HUD setTag:1987];
}
- (void)startLoadWeather
{
    //天气预报url
   // NSString *cityStr=@"101120201";
    NSString *path=@"http://m.weather.com.cn/data/cityNumber.html";
    path=[path stringByReplacingOccurrencesOfString:@"cityNumber" withString:self.cityId];
    NSURL *url=[NSURL URLWithString:path];
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc]initWithURL:url];
    request.delegate=self;
    [request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data=[request responseData];
    id result=[data objectFromJSONData];
    NSDictionary *statues=[result objectForKey:@"weatherinfo"];
    NSMutableArray *weatherModel=[[NSMutableArray alloc]init];
    WeatherModel *weather=[[WeatherModel alloc]initWithDataDic:statues];
    [weatherModel addObject:weather];
    self.data=weatherModel;
    
    if (self.data!=nil) {
        [self.HUD removeFromSuperview];
    }
    [self setWeatherValue];
}
- (void)setWeatherValue
{
    WeatherModel *weather = [self.data objectAtIndex:0];
    
    self.city.text = weather.weatherCity;// 当前城市
    self.todayWeek.text = weather.weatherWeek;//当前星期
    self.date.text = weather.weatherDate_y;//当前日期
    self.content.text = weather.weatherIndex_d;//内容
    //一周的温度
    NSString *temp1 = weather.weatherTemp1;
    NSString *temp2 = weather.weatherTemp2;
    NSString *temp3 = weather.weatherTemp3;
    NSString *temp4 = weather.weatherTemp4;
    NSString *temp5 = weather.weatherTemp5;
    NSString *temp6 = weather.weatherTemp6;
    //一周天气图片
   // NSString *image2 = weather.weatherImage2;//星期一
    NSString *image4 = weather.weatherImage4;//星期二
    NSString *image6 = weather.weatherImage6;//星期三
    NSString *image8 = weather.weatherImage8;//星期四
    NSString *image10 = weather.weatherImage10;//星期五
    NSString *image12 = weather.weatherImage12;//星期六
    
    NSString *imgUrl=[[NSString alloc]init];
    NSString *img1=[[NSString alloc]init];
    NSString *img2=[[NSString alloc]init];
    NSString *img3=[[NSString alloc]init];

    if ([self.todayWeek.text hasSuffix:@"一"]) {
        self.todayWenDu.text = temp1;
        imgUrl=weather.weatherImage2;
        img1=image4;
        img2=image6;
        img3=image8;
        self.week1.text = @"星期二";
        self.week2.text = @"星期三";
        self.week3.text = @"星期四";
        self.wendu1.text = temp2;
        self.wendu2.text = temp3;
        self.wendu3.text = temp4;
    }else if([self.todayWeek.text hasSuffix:@"二"]){
        self.todayWenDu.text = temp2;
        imgUrl=weather.weatherImage4;
        img1=image6;
        img2=image8;
        img3=image10;
        self.week1.text = @"星期三";
        self.week2.text = @"星期四";
        self.week3.text = @"星期五";
        self.wendu1.text = temp3;
        self.wendu2.text = temp4;
        self.wendu3.text = temp5;
    }else if ([self.todayWeek.text hasSuffix:@"三"]){
        self.todayWenDu.text = temp3;
        imgUrl=weather.weatherImage6;
        img1=image8;
        img2=image10;
        img3=image12;
        self.week1.text = @"星期四";
        self.week2.text = @"星期五";
        self.week3.text = @"星期六";
        self.wendu1.text = temp4;
        self.wendu2.text = temp5;
        self.wendu3.text = temp6;
    }else if ([self.todayWeek.text hasSuffix:@"四"]){
        self.todayWenDu.text = temp4;
        imgUrl=weather.weatherImage8;
        img1=image8;
        img2=image10;
        img3=image12;
        self.week1.text = @"星期四";
        self.week2.text = @"星期五";
        self.week3.text = @"星期六";
        self.wendu1.text = temp4;
        self.wendu2.text = temp5;
        self.wendu3.text = temp6;
    }else if ([self.todayWeek.text hasSuffix:@"五"]){
        self.todayWenDu.text = temp5;
        imgUrl=weather.weatherImage10;
        img1=image8;
        img2=image10;
        img3=image12;
        self.week1.text = @"星期四";
        self.week2.text = @"星期五";
        self.week3.text = @"星期六";
        self.wendu1.text = temp4;
        self.wendu2.text = temp5;
        self.wendu3.text = temp6;
    }else if ([self.todayWeek.text hasSuffix:@"六"]){
        self.todayWenDu.text = temp6;
        imgUrl=weather.weatherImage12;
        img1=image8;
        img2=image10;
        img3=image12;
        self.week1.text = @"星期四";
        self.week2.text = @"星期五";
        self.week3.text = @"星期六";
        self.wendu1.text = temp4;
        self.wendu2.text = temp5;
        self.wendu3.text = temp6;
    }
    //设置当天天气图片
    NSInteger num = [imgUrl integerValue];
    if (num==99) {
        num=0;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.weather.com.cn/img/b%d.gif",num]];
    [self.todayWeather setImageWithURL:url];
    //设置后三天的图片
    NSInteger num1=[img1 integerValue];
    NSInteger num2=[img2 integerValue];
    NSInteger num3=[img3 integerValue];
    
    if (num1==99) {
        num1=0;
    }
    if (num2==99){
        num2=0;
    }
    if (num3==99){
        num3=0;
    }
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.weather.com.cn/img/b%d.gif",num1]];
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.weather.com.cn/img/b%d.gif",num2]];
    NSURL *url3 = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.weather.com.cn/img/b%d.gif",num3]];
    
    [self.weatherImage1 setImageWithURL:url1];
    [self.weatherImage2 setImageWithURL:url2];
    [self.weatherImage3 setImageWithURL:url3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_todayImage release];
    [_city release];
    [_todayWeek release];
    [_date release];
    [_content release];
    [_week1 release];
    [_week2 release];
    [_week3 release];
    [_wendu1 release];
    [_wendu2 release];
    [_wendu3 release];
    [_weatherImage1 release];
    [_weatherImage2 release];
    [_weatherImage3 release];
    [_todayWeather release];
    [_todayWenDu release];
    [super dealloc];
}
//刷新按钮
- (IBAction)refreshWeather:(id)sender {
    [self startLoadWeather];
}
@end
