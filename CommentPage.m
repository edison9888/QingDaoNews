//
//  CommentPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-7.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "CommentPage.h"
#import "PublicMethod.h"
#import "NewsCommentModel.h"
#import "NewsCommentCell.h"
#import "JSONKit.h"
#import "Dialog.h"
@interface CommentPage ()

@end

@implementation CommentPage

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
    self.commentTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, UIScreen_Width, UIScreen_Height-20+Frame_Y) style:UITableViewStylePlain];
    self.commentTable.delegate=self;
    self.commentTable.dataSource=self;
    [self.view addSubview:self.commentTable];
    [self _initView];
    [self startLoadCommentWithPage:self.newId];
    [Dialog progressToast:@"等一下"];
}
#pragma mark -添加导航栏
- (void)_initView
{
    UIImageView *navigationBar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customNav.png"]];
    navigationBar.frame=CGRectMake(0, 0+Frame_Y, 320, 44);
    [self.view addSubview:navigationBar];
    [self.view sendSubviewToBack:navigationBar];
    [navigationBar release];
    
    UILabel *commentLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 0+Frame_Y, 100, 37)];
    commentLable.backgroundColor=[UIColor clearColor];
    commentLable.text=@"评论列表";
    commentLable.font=[UIFont systemFontOfSize:20.0f];
    commentLable.textColor=[UIColor whiteColor];
    [self.view addSubview:commentLable];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 6+Frame_Y, 45, 30);
    [backBtn setImage:[UIImage imageNamed:@"listicon.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"listicon_h.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backTopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}
//返回按钮
- (void)backTopView
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- 数据请求
- (void)startLoadCommentWithPage:(NSInteger) newsId
{
    NSURL *url=[NSURL URLWithString:api_newsCommentDetail_url(newsId)];
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc]initWithURL:url];
    request.delegate=self;
    [request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *data=[request responseData];
    id result=[data objectFromJSONData];
    NSArray *statues=[result objectForKey:@"List"];
    NSMutableArray *commentArray=[NSMutableArray arrayWithCapacity:statues.count];
    for (NSDictionary *comment in statues) {
        NewsCommentModel *commentModel=[[NewsCommentModel alloc]initWithDataDic:comment];
        [commentArray addObject:commentModel];
    }
    self.data=commentArray;
    [self.commentTable reloadData];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [Dialog toastCenter:@"请求数据失败"];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndifiter=@"cellIndifiter";
    NewsCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndifiter];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"NewsCommentCell" owner:self options:nil]lastObject];
    }
    NewsCommentModel *comment=[self.data objectAtIndex:indexPath.row];
    cell.commentModel=comment;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
