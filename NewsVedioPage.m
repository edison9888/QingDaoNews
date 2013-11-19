//
//  NewsVedioPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsVedioPage.h"
#import "PublicMethod.h"
#import "IndexPage.h"
#import "JSONKit.h"
#import "NewsVedioShow.h"
@interface NewsVedioPage ()

@end

@implementation NewsVedioPage

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
    //self.tabArray=[[NSMutableArray alloc]init];
    [self _initNavigationBar];
    [self _initTopBar];

}
#pragma mark -初始化导航栏
- (void)_initNavigationBar
{
    self.tabArray=[[NSMutableArray alloc]init];
    UIImageView *navigationBar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customNav.png"]];
    navigationBar.frame=CGRectMake(0, 0+Frame_Y, 320, 44);
    [self.view addSubview:navigationBar];
    [self.view sendSubviewToBack:navigationBar];
    [navigationBar release];
    
    UILabel *commentLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 0+Frame_Y, 100, 37)];
    commentLable.backgroundColor=[UIColor clearColor];
    commentLable.text=@"精彩视频";
    commentLable.font=[UIFont systemFontOfSize:20.0f];
    commentLable.textColor=[UIColor whiteColor];
    [self.view addSubview:commentLable];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 6+Frame_Y, 45, 30);
    [backBtn setImage:[UIImage imageNamed:@"listicon.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"listicon_h.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backTopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    // [backBtn release];
}
- (void)backTopView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- 顶部滑动栏
- (void)_initTopBar
{
    //顶部左右滑动tab背景
    UIImageView *tabbg =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"submenu_bg.png"]];
    [tabbg setFrame:CGRectMake(0, 44+Frame_Y, 320, 44)];
    [self.view addSubview:tabbg];
    [tabbg release];
    //请求二级菜单
    //[self getVedioTabArray];
    
    self.tabArray =[NSMutableArray arrayWithObjects:@"第一视点",@"快讯",@"HI新闻",@"HI分享", nil];
    //NSLog(@"tableArray%@",self.tabArray);
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44+Frame_Y, 320, 44)];
    [scrollview setTag:98];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [scrollview setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:scrollview];
    if ([self.tabArray count]>5) {
        [scrollview setContentSize:CGSizeMake([_tabArray count]*55, 33)];
    }
    [scrollview release];
    
    
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
    NewsVedioShow *infoList =[[NewsVedioShow alloc] init];
    infoList.catId=self.catId;
    infoList.inforId=[self.tabArray objectAtIndex:0];
    infoList.num=0;
    infoList.superNav=self.navigationController;
    infoList.view.tag=101;
    [infoList.view setFrame:CGRectMake(0, 44+33+Frame_Y+11, 320, UI_SCREEN_HEIGHT-44-33-20-11)];
    [self.view addSubview:infoList.view];
    
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
    
    //要闻
    if ([self.view viewWithTag:100+tag]) {
        [self.view bringSubviewToFront:[self.view viewWithTag:100+tag]];
    }else{
        NewsVedioShow *infoList =[[NewsVedioShow alloc] init];
        infoList.inforId=inforId;
        infoList.catId=self.catId;
        infoList.num=tag-1;
        infoList.superNav=self.navigationController;
        infoList.view.tag=100+tag;
        [infoList.view setFrame:CGRectMake(0, 44+33+Frame_Y+11, 320, UI_SCREEN_HEIGHT-44-33-20-11)];
        [self.view addSubview:infoList.view];
    }
}
#pragma mark -获取二级菜单
- (void)getVedioTabArray
{
    NSURL *url=[NSURL URLWithString:api_newsVedioDetail_url(self.catId)];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    [request startSynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data=[request responseData];
    id result=[data objectFromJSONData];
    NSArray *statues=[result objectForKey:@"SubCata"];
    for (NSDictionary *dic in statues) {
        NSString *name=[dic objectForKey:@"Name"];
        [self.tabArray addObject:name];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
