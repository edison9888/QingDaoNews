//
//  StaffPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "StaffPage.h"
#import "PublicMethod.h"
#import "AppDelegate.h"
#import "WeatherModel.h"
#import "WeatherPage.h"
@interface StaffPage ()

@end

@implementation StaffPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//左侧当行页面
-(void)leftBtnPressed{
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] menuController] showLeftController:YES];
    
}

- (void)rightBtnPressed
{
    AddCityPage *addCity=[[AddCityPage alloc]init];
    addCity.cityDelegate=self;
    [self.navigationController pushViewController:addCity animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    //顶部导航栏样式
    for (int i=0; i<4; i++) {
        if (i==1) {
            //图片
            UIImageView *imageview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Title.png"]];
            [imageview setFrame:CGRectMake(0, 0+Frame_Y, 320, 44)];
            [self.view addSubview:imageview];
            [self.view sendSubviewToBack:imageview];
            [imageview release];
        }else if(i==3){
            //标题
            UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(55, 0+Frame_Y, 210, 44)];
            [navTitle setText:@"天气预报"];
            [navTitle setTextAlignment:NSTextAlignmentCenter];
            [navTitle setBackgroundColor:[UIColor clearColor]];
            [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
            [navTitle setNumberOfLines:0];
            [navTitle setTextColor:[UIColor whiteColor]];
            [self.view addSubview:navTitle];
            [navTitle release];
        }else{
            //左右按钮
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            if (i==0) {
                //左按钮
                [btn setFrame:CGRectMake(10, 7+Frame_Y, 45, 30)];
                [btn setBackgroundImage:[UIImage imageNamed:@"listicon.png"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"listicon_h.png"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(leftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
            }else{
                //右按钮
                [btn setFrame:CGRectMake(320-32-10, 7+Frame_Y, 32, 30)];
                [btn setBackgroundImage:[UIImage imageNamed:@"Add.png"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"Add.png"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
                
            }
            [self.view addSubview:btn];
        }
    }
    [self _initWeatherView];

}
#pragma mark- 顶部滑动栏
- (void)_initWeatherView
{
    self.pageView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, UI_SCREEN_HEIGHT)];
    [self.pageView setTag:10000];
    [self.pageView setBackgroundColor:[UIColor clearColor]];
    [self.pageView setShowsHorizontalScrollIndicator:NO];
    [self.pageView setPagingEnabled:YES];
    self.pageView.delegate=self;
    [self.view addSubview:self.pageView];
    
    WeatherPage *weather=[[WeatherPage alloc]initWithNibName:@"WeatherPage" bundle:nil];
    weather.cityId=@"101120201";
    [weather.view setFrame:CGRectMake(0, 0, 320, UI_SCREEN_HEIGHT-44-33-20-11)];
    [self.pageView addSubview:weather.view];

}
#pragma mark- 按钮滑动
- (void)addNewCity:(NSString *)cityId
{
    WeatherPage *weather=[[WeatherPage alloc]initWithNibName:@"WeatherPage" bundle:nil];
    weather.cityId=cityId;
    self.page=self.page+1;
    [self.pageView setContentSize:CGSizeMake(320*(self.page+1), UI_SCREEN_HEIGHT)];
    [weather.view setFrame:CGRectMake(320*self.page, 0, 320, UI_SCREEN_HEIGHT-44-33-20-11)];
    //跳转到添加城市的页面
    [self.pageView setContentOffset:CGPointMake(320*self.page, 0)];
    [self.pageView addSubview:weather.view];
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIPageControl *pageController=[[UIPageControl alloc]initWithFrame:CGRectMake(160, 450, 50, 20)];
    pageController.currentPage=0;
    pageController.pageIndicatorTintColor=[UIColor redColor];
    pageController.numberOfPages=scrollView.contentOffset.x/320;
    [self.pageView addSubview:pageController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
