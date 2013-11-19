//
//  CommentViewController.m
//  NewsProject
//
//  Created by 姜勇 on 13-11-4.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "CommentViewController.h"
#import "Dialog.h"
#import "PublicMethod.h"
#import "CommentPage.h"
@interface CommentViewController ()

@end

@implementation CommentViewController

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
	[self.view setBackgroundColor:[UIColor whiteColor]];
    [self _initCommentView];
    [self _initNavigationBar];
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
    commentLable.text=@"评论";
    commentLable.font=[UIFont systemFontOfSize:20.0f];
    commentLable.textColor=[UIColor whiteColor];
    [self.view addSubview:commentLable];

    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 6+Frame_Y, 45, 30);
    [backBtn setImage:[UIImage imageNamed:@"listicon.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"listicon_h.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backTopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *showComment=[UIButton buttonWithType:UIButtonTypeCustom];
    showComment.frame=CGRectMake(320-32-10, 7+Frame_Y, 32, 30);
    [showComment setImage:[UIImage imageNamed:@"shezhi.png"] forState:UIControlStateNormal];
    [showComment setImage:[UIImage imageNamed:@"shezhi_h.png"] forState:UIControlStateHighlighted];
    [showComment addTarget:self action:@selector(showCommentPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showComment];

}
#pragma mark - 初始化评论界面
- (void)_initCommentView
{
    commentName=[[UILabel alloc]initWithFrame:CGRectMake(10, 20+44, 60, 60)];
    commentName.backgroundColor=[UIColor clearColor];
    commentName.text=@"昵称：";
    commentName.font=[UIFont systemFontOfSize:16.0f];
    [self.view addSubview:commentName];
    
    name=[[UITextField alloc]initWithFrame:CGRectMake(70, 30+44, 200, 30)];
    [name setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:name];
    
    commentMessage=[[UILabel alloc]initWithFrame:CGRectMake(10, 80+44, 60, 60)];
    commentMessage.backgroundColor=[UIColor clearColor];
    commentMessage.text=@"评论：";
    commentMessage.font=[UIFont systemFontOfSize:16.0f];
    [self.view addSubview:commentMessage];
    
    message=[[UITextField alloc]initWithFrame:CGRectMake(70, 85+44, 200, 200)];
    [message setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:message];
    
    UIButton *sendComment=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendComment.frame=CGRectMake(120, 310+44, 100, 50);
    [sendComment setTitle:@"提交" forState:UIControlStateNormal];
    [sendComment addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendComment];
}
//返回上一页面
- (void)backTopView{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//跳转到详情页面
- (void)showCommentPage
{
    CommentPage *commentPage=[[CommentPage alloc]init];
    commentPage.newId=self.commentId;
    [self.navigationController pushViewController:commentPage animated:YES];
}
#pragma mark - 发表评论内容
- (void)sendComment
{
    [Dialog progressToast:@"正在发表"];
    [self startSendComment];
    
}
- (void)startSendComment
{
    // GET
//    NSURL *url=[NSURL URLWithString:api_newsComment_url(self.commentId, message.text, name.text)];
//    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
//    request.delegate=self;
//    [request startAsynchronous];
    //POST
    NSString *urlStr=[NSString stringWithFormat:@"http://test.mlib123.com/API/Review/Add.ashx?docId=%d",self.commentId];
    NSURL *postUrl=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *dataRequest=[[ASIFormDataRequest alloc]initWithURL:postUrl];
    dataRequest.delegate=self;
    NSDictionary *params=[[NSDictionary alloc]initWithObjectsAndKeys:name.text,@"source",
                          message.text,@"message", nil];
    NSArray *allKey=[params allKeys];
    for (int i=0; i<params.count; i++) {
        NSString *key=[allKey objectAtIndex:i];
        id value=[params objectForKey:key];
        if ([value isKindOfClass:[NSData class]]) {
            [dataRequest addData:value forKey:key];
        }else{
            [dataRequest addPostValue:value forKey:key];
        }
    }
    
    [dataRequest startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [Dialog toastCenter:@"评论成功"];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [Dialog toastCenter:@"评论失败"];
}
// 取消第一响应事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [name resignFirstResponder];
    [message resignFirstResponder];
}
#pragma mark-
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
