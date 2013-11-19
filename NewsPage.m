//
//  NewsPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsPage.h"
#import "PublicMethod.h"
#import "AppDelegate.h"
#import "IndexPage.h"
@interface NewsPage ()

@end

@implementation NewsPage
@synthesize tabArray=_tabArray;
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

//右侧个人用户页面
-(void)rightBtnPressed{
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] menuController] showRightController:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self _initNavigationBar];
    [self _initTopBar];
}
#pragma mark- 顶部导航栏样式
- (void)_initNavigationBar
{
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
            [navTitle setText:@"岛城要闻"];
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
                [btn setBackgroundImage:[UIImage imageNamed:@"shezhi.png"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"shezhi_h.png"] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
                
            }
            [self.view addSubview:btn];
        }
    }

}
#pragma mark- 顶部滑动栏
- (void)_initTopBar
{
    //顶部左右滑动tab背景
    UIImageView *tabbg =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"submenu_bg.png"]];
    [tabbg setFrame:CGRectMake(0, 44+Frame_Y, 320, 44)];
    [self.view addSubview:tabbg];
    [tabbg release];
    self.tabArray =[NSArray arrayWithObjects:@"要闻",@"新闻",@"图片",@"话题", nil];
    
    UIScrollView *scrollview =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 44+Frame_Y, 320, 44)];
    [scrollview setTag:98];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:scrollview];
    if ([self.tabArray count]>5) {
        [scrollview setContentSize:CGSizeMake([_tabArray count]*55, 33)];
    }
    [scrollview release];
    
    UIScrollView *pageView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 88+Frame_Y, 320, UI_SCREEN_HEIGHT)];
    [pageView setTag:10000];
    [pageView setBackgroundColor:[UIColor clearColor]];
    [pageView setShowsHorizontalScrollIndicator:NO];
    [pageView setPagingEnabled:YES];
    pageView.delegate=self;
    [pageView setContentSize:CGSizeMake(320*4, UI_SCREEN_HEIGHT)];
    [self.view addSubview:pageView];
    
    //顶部左右可移动背景
    UIImageView *movebg =[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"subnavicon.png"] stretchableImageWithLeftCapWidth:22 topCapHeight:20]];
    if ([self.tabArray count]<=5) {
        [movebg setFrame:CGRectMake((320-55*([_tabArray count]))/2, 7, 55, 22)];
    }else{
        [movebg setFrame:CGRectMake(0, 7, 55, 24)];
    }
    
    [movebg setTag:99];
    [scrollview addSubview:movebg];
    [movebg release];
    
    for (int i=0; i<[self.tabArray count]; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"yaowenbtn.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"yaowenbtn_h.png"] forState:UIControlStateHighlighted];
        [btn setTag:i+1];//tab按钮tag
        [btn setTitle:[self.tabArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        if (i==0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"yaowenbtn_h.png"] forState:UIControlStateNormal];
        }
        
        if ([self.tabArray count]<=4) {
            [btn setFrame:CGRectMake((320-80*([_tabArray count]))/2+80*i, 0, 80, 44)];
        }else{
            [btn setFrame:CGRectMake(80*i, 0,80,44)];
            [scrollview setContentSize:CGSizeMake(80*(i+1), 44)];
        }
        
        [btn addTarget:self action:@selector(tabBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:btn];
    }
    
    
    //添加新闻页面
    IndexPage *infoList =[[IndexPage alloc] init];
    infoList.inforId=[self.tabArray objectAtIndex:0];
    infoList.superNav=self.navigationController;
    infoList.view.tag=101;
    [infoList.view setFrame:CGRectMake(0, 0-Frame_Y, 320, UI_SCREEN_HEIGHT-44-33-20-11)];
    [pageView addSubview:infoList.view];
}
#pragma mark- 按钮滑动
-(void)tabBtnPressed:(UIButton *)btn{
    NSInteger tag = btn.tag;
    //移动image背景
    UIImageView *movebg = (UIImageView *)[self.view viewWithTag:99];
    [UIView animateWithDuration:0.3 animations:^{
        
        [movebg setFrame:CGRectMake(btn.frame.origin.x, 7, 55, 22)];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            
        }];
    }];
    
    //改变按钮颜色
    for (int i=0; i<7; i++) {
        UIButton *btn = (UIButton *)[[self.view viewWithTag:98] viewWithTag:i+1];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"yaowenbtn.png"] forState:UIControlStateNormal];
        
    }
    [btn setBackgroundImage:[UIImage imageNamed:@"yaowenbtn_h.png"] forState:UIControlStateNormal];
    
    NSString *inforId=[self.tabArray objectAtIndex:tag-1];
    
    UIScrollView *pageView=(UIScrollView *)[self.view viewWithTag:10000];
    if ([pageView viewWithTag:100+tag]) {
        [pageView setContentOffset:CGPointMake([pageView viewWithTag:100+tag].frame.origin.x, 0) animated:YES];
    }else{
        IndexPage *infoList =[[IndexPage alloc] init];
        infoList.inforId=inforId;
        infoList.superNav=self.navigationController;
        infoList.view.tag=100+tag;
        [infoList.view setFrame:CGRectMake(320*(tag-1), 0-Frame_Y, 320, UI_SCREEN_HEIGHT-44-33-20-11)];
        [pageView setContentOffset:CGPointMake(infoList.view.frame.origin.x, 0) animated:YES];
        [pageView addSubview:infoList.view];
    }

}
#pragma mark - UIScrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
   // NSLog(@"%f",scrollView.contentOffset.x);
    //移动image背景
    UIImageView *movebg = (UIImageView *)[self.view viewWithTag:99];
    [UIView animateWithDuration:0.3 animations:^{
        
        [movebg setFrame:CGRectMake((scrollView.contentOffset.x)/4, 7, 55, 22)];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            
        }];
    }];
    
    //改变按钮颜色
    for (int i=0; i<7; i++) {
        UIButton *btn = (UIButton *)[[self.view viewWithTag:98] viewWithTag:i+1];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"yaowenbtn.png"] forState:UIControlStateNormal];
        
    }
    CGFloat btnTag = scrollView.contentOffset.x/320+1.0;
    UIButton *btn=(UIButton *)[self.view viewWithTag:btnTag];
    [btn setBackgroundImage:[UIImage imageNamed:@"yaowenbtn_h.png"] forState:UIControlStateNormal];
    
    NSString *inforId=[self.tabArray objectAtIndex:btnTag-1];
    
    
    UIScrollView *pageView=(UIScrollView *)[self.view viewWithTag:10000];
    if ([pageView viewWithTag:100+btnTag]) {
        [pageView setContentOffset:CGPointMake([pageView viewWithTag:100+btnTag].frame.origin.x, 0) animated:YES];
    }else{
        IndexPage *infoList =[[IndexPage alloc] init];
        infoList.inforId=inforId;
        infoList.superNav=self.navigationController;
        infoList.view.tag=100+btnTag;
        [infoList.view setFrame:CGRectMake(320*(btnTag-1), 0-Frame_Y, 320, UI_SCREEN_HEIGHT-44-33-20-11)];
        [pageView setContentOffset:CGPointMake(infoList.view.frame.origin.x, 0) animated:YES];
        [pageView addSubview:infoList.view];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
