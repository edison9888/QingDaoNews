//
//  ZXDetailPage.m
//  QDSports
//
//  Created by wang rain on 12-7-7.
//  Copyright (c) 2012年 青岛联科时代科技. All rights reserved.
//

#import "CustomDetailPage.h"
#import "PublicMethod.h"

@interface CustomDetailPage ()

@end

@implementation CustomDetailPage
@synthesize urlStr;
@synthesize navTitle=_navTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.tabBarController tabbarShow];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController tabbarHidden];
}


-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=_navTitle;
    UIImageView *pageBg =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pageBg.png"]];
    [pageBg setFrame:CGRectMake(0, 0, 320, UI_SCREEN_HEIGHT-20-44)];
    [self.view addSubview:pageBg];
    [pageBg release];
    
    //自定义定义navbar左边返回按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0,30.0)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left_arrow.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=leftBarBtn;
    [leftBtn release];
    [leftBarBtn release];
    
//    UIImageView *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_SCREEN_HEIGHT-20)];
//    [imageview setImage:[UIImage imageNamed:@"index_bg.png"]];
//    [self.view addSubview:imageview];
//    [self.view sendSubviewToBack:imageview];
//    [imageview release];
//    
//    
//    UIImageView *navBg =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    [navBg setImage:[UIImage imageNamed:@"title_bg.png"]];
//    [self.view addSubview:navBg];
//    [navBg release];
//    
//    UILabel *titlelabel =[[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 44)];
//    [titlelabel setText:@"详细页"];
//    [titlelabel setBackgroundColor:[UIColor clearColor]];
//    [titlelabel setTextAlignment:NSTextAlignmentCenter];
//    [titlelabel setTextColor:[UIColor whiteColor]];
//    [titlelabel setFont:[UIFont boldSystemFontOfSize:20]];
//    [self.view addSubview:titlelabel];
//    [titlelabel release];
//    
//    
//    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0,44)];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
//    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back_btn_hover.png"] forState:UIControlStateHighlighted];
//    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:leftBtn];
//    [leftBtn release];
    
    UIWebView *webview =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, UI_SCREEN_HEIGHT-20-44)];
    webview.scalesPageToFit = YES;  //缩放
    webview.backgroundColor=[UIColor clearColor];
    webview.delegate=self;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [self.view addSubview:webview];
    [webview release];
    
    UIActivityIndicatorView *active =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    active.center=CGPointMake(320/2, 416/2);
    active.tag=1987;
    [self.view addSubview:active];
    [active startAnimating];
    [active release];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([self.view viewWithTag:1987]) {
        [[self.view viewWithTag:1987] removeFromSuperview];
    }
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([self.view viewWithTag:1987]) {
        [[self.view viewWithTag:1987] removeFromSuperview];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.urlStr=nil;
}

-(void)dealloc{
    [super dealloc];
    [urlStr release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
