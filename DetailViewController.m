//
//  DetailViewController.m
//  NewsProject
//
//  Created by 姜勇 on 13-10-31.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentViewController.h"
#import "PublicMethod.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)init{
    self=[super init];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    title=[[NSMutableArray alloc]initWithCapacity:10];
    date=[[NSMutableArray alloc]initWithCapacity:10];
    source=[[NSMutableArray alloc]initWithCapacity:10];
    pic=[[NSMutableArray alloc]initWithCapacity:10];
    newsIds=[[NSMutableArray alloc]initWithCapacity:10];
    
    [self _initView];
    [self _initNavigationBar];
    [self loadNewsDetailSource];
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view withLabel:@"请稍后..." animated:YES];
    [self.HUD setTag:1987];
}
#pragma mark -初始化数据视图
- (void)_initView
{
    self.titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 44+Frame_Y, 320, 60)];
    self.titleLable.font=[UIFont systemFontOfSize:20.0f];
    self.titleLable.numberOfLines=4;
    self.titleLable.textAlignment=NSTextAlignmentCenter;
    self.titleLable.backgroundColor=[UIColor clearColor];
    self.titleLable.textColor=[UIColor blackColor];
    
    self.dateLable=[[UILabel alloc]initWithFrame:CGRectMake(170, 60+44+Frame_Y, 200, 20)];
    self.dateLable.font=[UIFont systemFontOfSize:14.0f];
    self.dateLable.backgroundColor=[UIColor clearColor];
    self.dateLable.textColor=[UIColor grayColor];
    
    self.infoLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 60+44+Frame_Y, 100, 20)];
    self.infoLable.backgroundColor=[UIColor clearColor];
    self.infoLable.font=[UIFont systemFontOfSize:14.0f];
    self.infoLable.textColor=[UIColor grayColor];
    
    self.detailWeb=[[UIWebView alloc]initWithFrame:CGRectMake(0, 96+44+Frame_Y, 320, 330)];
    [self.view addSubview:self.detailWeb];
    [self.view addSubview:self.titleLable];
    [self.view addSubview:self.dateLable];
    [self.view addSubview:self.infoLable];
}
#pragma mark -初始化导航栏
- (void)_initNavigationBar
{
    UIImageView *navigationBar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customNav.png"]];
    navigationBar.frame=CGRectMake(0, 0+Frame_Y, 320, 44);
    [self.view addSubview:navigationBar];
    [self.view sendSubviewToBack:navigationBar];
    [navigationBar release];
    
    UILabel *commentLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 0+Frame_Y, 100, 37)];
    commentLable.backgroundColor=[UIColor clearColor];
    commentLable.text=@"新闻详情";
    commentLable.font=[UIFont systemFontOfSize:20.0f];
    commentLable.textColor=[UIColor whiteColor];
    [self.view addSubview:commentLable];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 6+Frame_Y, 45, 30);
    [backBtn setImage:[UIImage imageNamed:@"listicon.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"listicon_h.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backTopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.frame=CGRectMake(320-32-10, 7+Frame_Y, 32, 30);
    [commentBtn setImage:[UIImage imageNamed:@"group_btn_write_on.png"] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"group_btn_write_on@2x.png"] forState:UIControlStateHighlighted];
    [commentBtn addTarget:self action:@selector(commentPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentBtn];
    
    UIButton *collect=[UIButton buttonWithType:UIButtonTypeCustom];
    collect.frame=CGRectMake(230, 1+Frame_Y, 40, 40);
    [collect setImage:[UIImage imageNamed:@"detailshoucang_h.png"] forState:UIControlStateNormal];
    [collect setImage:[UIImage imageNamed:@"detailshoucang_h.png"] forState:UIControlStateHighlighted];
    [collect addTarget:self action:@selector(collected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collect];
    
}
- (void)backTopView
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)commentPage
{
    CommentViewController *commentView=[[CommentViewController alloc]init];
    commentView.commentId=self.idNumber;
    [self.navigationController pushViewController:commentView animated:YES];

}
- (void)collected
{
    [Dialog toastCenter:@"收藏成功"];
    //获取本地数据
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"titles"]) {
        id titleArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"titles"];
        id dateArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"dates"];
        id sourceArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"sources"];
        id picArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"pics"];
        id newId=[[NSUserDefaults standardUserDefaults]objectForKey:@"newsId"];
        for (int i=0; i<[titleArray count]; i++) {
            [title addObject:[titleArray objectAtIndex:i]];
            [date addObject:[dateArray objectAtIndex:i]];
            [source addObject:[sourceArray objectAtIndex:i]];
            [pic addObject:[picArray objectAtIndex:i]];
            [newsIds addObject:[newId objectAtIndex:i]];
        }
        
    }

    [title addObject:self.newsModel.NewsTitle];
    [date addObject: self.newsModel.NewsPublishDate];
    [source addObject: self.newsModel.NewsInfoSource];
    [pic addObject: self.newsModel.NewsPic];
    [newsIds addObject:self.newsModel.NewsId];
    
    
    //将数据存储到本地
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"titles"];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"dates"];
    [[NSUserDefaults standardUserDefaults] setObject:source forKey:@"sources"];
    [[NSUserDefaults standardUserDefaults] setObject:pic forKey:@"pics"];
    [[NSUserDefaults standardUserDefaults] setObject:newsIds forKey:@"newsId"];

}
#pragma mark -加载数据
- (void)loadNewsDetailSource
{
    [self startLoadSource:self.idNumber];
    if (self.idNumber==0) {
        [Dialog toastCenter:@"无法连接到网络"];
    }else{
        
    }
}
- (void)startLoadSource:(NSInteger) newsId
{
    NSURL *url=[NSURL URLWithString:api_newsDetail_url(newsId)];
    ASIHTTPRequest *detailRequest=[[ASIHTTPRequest alloc]initWithURL:url];
    detailRequest.delegate=self;
    [detailRequest startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data=[request responseData];
    id result=[data objectFromJSONData];
    NSString *content=[result objectForKey:@"Content"];
    NSString *titles=[result objectForKey:@"Title"];
    NSString *infoSource=[result objectForKey:@"InfoSource"];
    NSString *dates=[result objectForKey:@"PublishDate"];
    self.dateLable.text=dates;
    self.infoLable.text=infoSource;
    self.titleLable.text=titles;
    if (![self.titleLable.text isEqualToString:@" "]) {
        [self.HUD removeFromSuperview];
    }
    NSString *detailString=[NSString stringWithFormat:@"<html><head></head><body><style>img{width:280px;align:center;}</style>%@</body></html>",content];
    [self.detailWeb loadHTMLString:detailString baseURL:Nil];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [Dialog toastCenter:@"加载失败"];
    [self.HUD removeFromSuperview];

}
#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
