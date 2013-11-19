//
//  LeftPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-6.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "LeftPage.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "PublicMethod.h"
@interface LeftPage ()

@end

@implementation LeftPage
@synthesize homeNav=_homeNav;
@synthesize picNav=_picNav;
@synthesize newsNav=_newsNav;
@synthesize topicNav=_topicNav;
@synthesize workNav=_workNav;
@synthesize staffNav=_staffNav;

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
	
    //页面总背景
    UIImageView *pageBg =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftnar_bg.png"]];
    [pageBg setFrame:CGRectMake(0, 0, 200, UI_SCREEN_HEIGHT-20+Frame_Y)];
    [self.view addSubview:pageBg];
    [pageBg release];
    
    
    UIScrollView *scrollview =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0+Frame_Y, 320, UI_SCREEN_HEIGHT-20)];
    [scrollview setContentSize:CGSizeMake(320, UI_SCREEN_HEIGHT-20+1)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollview];
    [scrollview release];
    
    for (int i=0; i<6; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:i+1];
        [btn setFrame:CGRectMake(0, 51*i, 200, 51)];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
        if (i==0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"left_news.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"left_news_h.png"] forState:UIControlStateHighlighted];
            [btn setTitle:@"首页" forState:UIControlStateNormal];
        }else if(i==1){
            [btn setBackgroundImage:[UIImage imageNamed:@"left_bendi.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"left_bendi_h.png"] forState:UIControlStateHighlighted];
            [btn setTitle:@"话题" forState:UIControlStateNormal];
        }else if(i==2){
            [btn setBackgroundImage:[UIImage imageNamed:@"left_pic.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"left_pic_h.png"] forState:UIControlStateHighlighted];
            [btn setTitle:@"新闻" forState:UIControlStateNormal];
        }else if(i==3){
            [btn setBackgroundImage:[UIImage imageNamed:@"left_bendi.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"left_bendi.png"] forState:UIControlStateHighlighted];
            [btn setTitle:@"图集" forState:UIControlStateNormal];
        }else if(i==4){
            [btn setBackgroundImage:[UIImage imageNamed:@"left_topic.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"left_topic_h.png"] forState:UIControlStateHighlighted];
            [btn setTitle:@"经营" forState:UIControlStateNormal];
        }else if(i==5){
            [btn setBackgroundImage:[UIImage imageNamed:@"left_pic.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"left_pic_h.png"] forState:UIControlStateHighlighted];
            [btn setTitle:@"天气" forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(itemBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:btn];
    }

}
#pragma mark - 选中菜单跳转
- (void)itemBtnPressed:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menuController;
    
    switch (tag) {
        case 1:
        {
            UINavigationController *homeNav1= ((AppDelegate *)[[UIApplication sharedApplication] delegate]).homeNav;
            [menuController setRootController:homeNav1 animated:YES];
        }
            break;
         case 2:
        {
            //校园
            if (!_picNav) {
                PicturePage *picturePage =[[PicturePage alloc] init];
                _picNav = [[UINavigationController alloc] initWithRootViewController:picturePage];
                [_picNav setNavigationBarHidden:YES];
            }
            [menuController setRootController:_picNav animated:YES];
            _picNav.title=@"图片";
            
        }
            break;
        case 3:
        {
            if (!_newsNav) {
                NewsPage *newsPage=[[NewsPage alloc]init];
                _newsNav = [[UINavigationController alloc]initWithRootViewController:newsPage];
                [_newsNav setNavigationBarHidden:YES];
            }
            [menuController setRootController:_newsNav animated:YES];
            _newsNav.title=@"新闻";
        }
            break;
        case 4:
        {
            if (!_vedioNav) {
                VedioPage *vedioPage=[[VedioPage alloc]init];
                _vedioNav=[[UINavigationController alloc]initWithRootViewController:vedioPage];
                [_vedioNav setNavigationBarHidden:YES];
            }
            [menuController setRootController:_vedioNav animated:YES];
            _vedioNav.title=@"员工";
        }
            break;
        case 5:
        {
            if (!_workNav) {
                WorkPage *workPage=[[WorkPage alloc]init];
                _workNav=[[UINavigationController alloc]initWithRootViewController:workPage];
                [_workNav setNavigationBarHidden:YES];
            }
            [menuController setRootController:_workNav animated:YES];
            _workNav.title=@"经营";
        }
            break;
        case 6:
        {
            if (!_staffNav) {
                StaffPage *staffPage=[[StaffPage alloc]init];
                _staffNav=[[UINavigationController alloc]initWithRootViewController:staffPage];
                [_staffNav setNavigationBarHidden:YES];
            }
            [menuController setRootController:_staffNav animated:YES];
            _staffNav.title=@"天气";
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
