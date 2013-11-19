//
//  RightPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-15.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "RightPage.h"
#import "PublicMethod.h"
#import "CollectPage.h"
#import "AppDelegate.h"
@interface RightPage ()

@end

@implementation RightPage

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
    [self _initView];
}
- (void)_initView
{
    //页面总背景
    UIImageView *pageBg =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftnar_bg.png"]];
    [pageBg setFrame:CGRectMake(90, 0, 230, UI_SCREEN_HEIGHT-20+Frame_Y)];
    [self.view addSubview:pageBg];
    [pageBg release];
    
    UIButton *collect = [UIButton buttonWithType:UIButtonTypeCustom];
    collect.frame=CGRectMake(87+10+10+20, 100, 60, 60);
    [collect setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
    [collect setImage:[UIImage imageNamed:@"shoucang_h.png"] forState:UIControlStateHighlighted];
    [collect addTarget:self action:@selector(collectView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collect];
    
}
- (void)collectView
{
    CollectPage *collectPage=[[CollectPage alloc]init];
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:collectPage];
    [nav setNavigationBarHidden:YES];
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] menuController] presentModalViewController:nav animated:YES];
    [nav release];
    [collectPage release];;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
