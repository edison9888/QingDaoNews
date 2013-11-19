//
//  AddCityPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-13.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "AddCityPage.h"
#import "PublicMethod.h"
@interface AddCityPage ()

@end

@implementation AddCityPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initNavigationBar];
}
#pragma mark -初始化导航栏
- (void)_initNavigationBar
{
    UIImageView *navigationBar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Title.png"]];
    navigationBar.frame=CGRectMake(0, 0+Frame_Y, 320, 44);
    [self.view addSubview:navigationBar];
    [self.view sendSubviewToBack:navigationBar];
    [navigationBar release];
    
    UILabel *commentLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 0+Frame_Y, 100, 37)];
    commentLable.backgroundColor=[UIColor clearColor];
    commentLable.text=@"添加城市";
    commentLable.font=[UIFont systemFontOfSize:20.0f];
    commentLable.textColor=[UIColor whiteColor];
    [self.view addSubview:commentLable];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 6+Frame_Y, 45, 30);
    [backBtn setImage:[UIImage imageNamed:@"listicon.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"listicon_h.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backTopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *beijing=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    beijing.frame=CGRectMake(0, 50+Frame_Y, 45, 30);
    beijing.tag=1000;
    [beijing setTitle:@"北京" forState:UIControlStateNormal];
    [beijing addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beijing];

    UIButton *qingdao=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    qingdao.frame=CGRectMake(70, 50+Frame_Y, 45, 30);
    qingdao.tag=2000;
    [qingdao setTitle:@"青岛" forState:UIControlStateNormal];
    [qingdao addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qingdao];
    
    UIButton *jingde=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    jingde.frame=CGRectMake(140, 50+Frame_Y, 45, 30);
    jingde.tag=3000;
    [jingde setTitle:@"景德镇" forState:UIControlStateNormal];
    [jingde addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jingde];
    
    UIButton *shanghai=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    shanghai.frame=CGRectMake(210, 50+Frame_Y, 45, 30);
    shanghai.tag=4000;
    [shanghai setTitle:@"上海" forState:UIControlStateNormal];
    [shanghai addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shanghai];
}
- (void)backTopView
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)back:(UIButton *)btn
{
    UIButton *weatherBtn=(UIButton *)[self.view viewWithTag:btn.tag];
    NSString *city = weatherBtn.titleLabel.text;
    if ([city isEqualToString:@"北京"]) {
        self.cityId = @"101010100";
    }else if ([city isEqualToString:@"青岛"]){
         self.cityId = @"101120201";
    }else if ([city isEqualToString:@"景德镇"]){
        self.cityId=@"101240801";
    }else if ([city isEqualToString:@"上海"]){
        self.cityId=@"101020100";
    }
    [self.cityDelegate addNewCity:self.cityId];
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
