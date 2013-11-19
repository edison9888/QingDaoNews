//
//  CollectPage.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-15.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "CollectPage.h"
#import "PublicMethod.h"
#import "AppDelegate.h"
#import "NewsCell.h"
#import "NewsTitleCell.h"
#import "RootCell.h"
@interface CollectPage ()

@end

@implementation CollectPage


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"收藏";
    }
    return self;
}
//左侧当行页面
-(void)leftBtnPressed{
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}
- (void)rightBtnPressed
{
    [self.collectTable setEditing:!self.collectTable.isEditing animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.data=[[NSMutableArray alloc]init];
    [self _initNavigation];
    [self _initTableView];
}
#pragma mark- 导航栏
- (void)_initNavigation
{
    //顶部导航栏样式
    for (int i=0; i<2; i++) {
        if (i==1) {
            //图片
            UIImageView *imageview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"customNav.png"]];
            [imageview setFrame:CGRectMake(0, 0+Frame_Y, 320, 44)];
            [self.view addSubview:imageview];
            [self.view sendSubviewToBack:imageview];
            [imageview release];
        }else{
            //左右按钮
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            //左按钮
            [btn setFrame:CGRectMake(0, 0+Frame_Y, 55, 44)];
            [btn setBackgroundImage:[UIImage imageNamed:@"backicon.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"backicon_h.png"] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(leftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            
            UIButton *right =[UIButton buttonWithType:UIButtonTypeCustom];
            //左按钮
            [right setFrame:CGRectMake(260, 0+Frame_Y, 40, 40)];
            [right setBackgroundImage:[UIImage imageNamed:@"downclose.png"] forState:UIControlStateNormal];
            [right setBackgroundImage:[UIImage imageNamed:@"downclose_h.png"] forState:UIControlStateHighlighted];
            [right addTarget:self action:@selector(rightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:right];
        }
    }
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(140, 0+Frame_Y, 100, 44)];
    titleLable.backgroundColor=[UIColor clearColor];
    titleLable.text=@"收藏";
    titleLable.font=[UIFont systemFontOfSize:20.0f];
    titleLable.textColor=[UIColor whiteColor];
    [self.view addSubview:titleLable];

}
#pragma mark - 表格
- (void)_initTableView
{
    self.collectTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 44+Frame_Y, 320, 410) style:UITableViewStylePlain];
    self.collectTable.delegate=self;
    self.collectTable.dataSource=self;
    [self.collectTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.collectTable.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.collectTable];
    
    //获取本地数据
    id titleArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"titles"];
    id dateArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"dates"];
    id sourceArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"sources"];
    id picArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"pics"];
    id newsIds=[[NSUserDefaults standardUserDefaults]objectForKey:@"newsId"];
    //将数据读取出来放到Model中
    NSMutableArray *model=[NSMutableArray arrayWithCapacity:[titleArray count]];
    for (int i=0;i<[titleArray count];i++) {
        NewsModel *newsModel=[[NewsModel alloc]init];
        newsModel.NewsTitle = [titleArray objectAtIndex:i];
        newsModel.NewsPublishDate = [dateArray objectAtIndex:i];
        newsModel.NewsInfoSource = [sourceArray objectAtIndex:i];
        newsModel.NewsPic = [picArray objectAtIndex:i];
        newsModel.NewsId=[newsIds objectAtIndex:i];
        [model addObject:newsModel];
    }
    self.data=model;
}

#pragma mark- UITableViewSource
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
    NewsModel *model=[self.data objectAtIndex:indexPath.row];
    NSString *picStr=model.NewsPic;
    if ([picStr isEqualToString:@""]) {
        static NSString *cellNoImageIndifiter=@"cellNoImageIndifiter";
        NewsTitleCell *cell=[tableView dequeueReusableCellWithIdentifier:cellNoImageIndifiter];
        if (cell==nil) {
            cell=[[NewsTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNoImageIndifiter];
        }
        cell.newsModel=model;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        static NSString *cellIndifiter=@"cellInfiter";
        NewsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndifiter];
        if (cell==nil) {
            cell=[[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndifiter];
        }
        
        cell.newsModel=model;
        [cell setContentWihtFrame];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model=[self.data objectAtIndex:indexPath.row];
    DetailViewController *details=[[DetailViewController alloc]init];
    details.newsModel=model;
    details.idNumber=[model.NewsId integerValue];
    [self.navigationController pushViewController:details animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
//要求委托方的编辑风格在表视图的一个特定的位置。
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
    result = UITableViewCellEditingStyleDelete;
    
    return result;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{//设置是否显示一个可编辑视图的视图控制器。
    [super setEditing:editing animated:animated];
    [self.collectTable setEditing:editing animated:animated];//切换接收者的进入和退出编辑模式。
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        NSInteger row = [indexPath row];
        //获取本地数据
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"titles"]) {
            id titleArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"titles"];
            id dateArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"dates"];
            id sourceArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"sources"];
            id picArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"pics"];

            NSLog(@"%@",titleArray);
                [titleArray removeObjectAtIndex:row];
                [dateArray removeObjectAtIndex:row];
                [sourceArray removeObjectAtIndex:row];
                [picArray removeObjectAtIndex:row];
            
//            [[NSUserDefaults standardUserDefaults] setObject:titleArray forKey:@"titles"];
//            [[NSUserDefaults standardUserDefaults] setObject:dateArray forKey:@"dates"];
//            [[NSUserDefaults standardUserDefaults] setObject:sourceArray forKey:@"sources"];
//            [[NSUserDefaults standardUserDefaults] setObject:picArray forKey:@"pics"];
            
        }



        [self.data removeObjectAtIndex:row];
        NSArray *deleteList = [NSArray arrayWithObjects:indexPath, nil];
        [self.collectTable deleteRowsAtIndexPaths:deleteList withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
