//
//  NewsCell.m
//  NewsProject
//
//  Created by 姜勇 on 13-10-27.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsCell.h"
#import "EGOImageView.h"
#import "UIImageView+WebCache.h"
@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIImageView *cellbg =[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"newslistbg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
//        [cellbg setFrame:CGRectMake(10, 5, 300, 80)];
//        [self.contentView addSubview:cellbg];
        
        //self.titlePicImage=[[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *image=[UIImage imageNamed:@"page_image_loading1.png"];
        EGOImageView *titlePicImage=[[EGOImageView alloc]initWithPlaceholderImage:image];
        titlePicImage.tag=1000;
        [self.contentView addSubview:titlePicImage];
        
        self.titleLable=[[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLable.backgroundColor=[UIColor clearColor];
        self.titleLable.font=[UIFont systemFontOfSize:15.0f];
        self.titleLable.textColor=[UIColor blueColor];
        self.titleLable.numberOfLines=4;
        [self.contentView addSubview:self.titleLable];
        
        self.publishDateLable=[[UILabel alloc]initWithFrame:CGRectZero];
        self.publishDateLable.backgroundColor=[UIColor clearColor];
        self.publishDateLable.font=[UIFont systemFontOfSize:14.0f];
        self.publishDateLable.textColor=[UIColor grayColor];
        [self.contentView addSubview:self.publishDateLable];
        
        self.infoSourceLable=[[UILabel alloc]initWithFrame:CGRectZero];
        self.infoSourceLable.backgroundColor=[UIColor clearColor];
        self.infoSourceLable.textColor=[UIColor grayColor];
        self.infoSourceLable.font=[UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:self.infoSourceLable];
    }
    return self;
}
//- (void)layoutSubviews
//{
//    //字体标题的高度
//    //CGFloat height=[self GetCellHeight:self.newsModel];
//    EGOImageView *titlePicImage=(EGOImageView *)[self viewWithTag:1000];
//    titlePicImage.frame=CGRectMake(10, 10, 76, 66);
//    NSString *picStr=[NSString stringWithFormat:@"http://test.mlib123.com/UploadFiles/%@",self.newsModel.NewsPic];
//    NSURL *url=[NSURL URLWithString:picStr];
//    
//   // self.titlePicImage.image=[UIImage imageNamed:@"page_image_loading1.png"];
//    [titlePicImage setImageURL:url];
//    //[self.contentView addSubview:self.titlePicImage];
//
//    self.titleLable.frame=CGRectMake(90, 2, 220, 50);
//    self.titleLable.text=self.newsModel.NewsTitle;
//    
//    self.publishDateLable.frame=CGRectMake(176, 55, 198, 20);
//    self.publishDateLable.text=self.newsModel.NewsPublishDate;
//    
//    self.infoSourceLable.frame=CGRectMake(90, 50, 100, 30);
//    self.infoSourceLable.text=self.newsModel.NewsInfoSource;
//}
- (void)setContentWihtFrame
{
    EGOImageView *titlePicImage=(EGOImageView *)[self viewWithTag:1000];
    titlePicImage.frame=CGRectMake(10, 10, 76, 66);
    NSString *picStr=[NSString stringWithFormat:@"http://test.mlib123.com/UploadFiles/%@",self.newsModel.NewsPic];
    NSURL *url=[NSURL URLWithString:picStr];
    [titlePicImage setImageURL:url];
    
    self.titleLable.frame=CGRectMake(90, 2, 220, 50);
    self.titleLable.text=self.newsModel.NewsTitle;
    
    self.publishDateLable.frame=CGRectMake(176, 55, 198, 20);
    self.publishDateLable.text=self.newsModel.NewsPublishDate;
    
    self.infoSourceLable.frame=CGRectMake(90, 50, 100, 30);
    self.infoSourceLable.text=self.newsModel.NewsInfoSource;

}
//返回lable的高度
- (CGFloat)GetCellHeight:(NewsModel *)model
{
    NSString *titleStr=model.NewsTitle;
    CGSize size=[titleStr sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(220, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height=size.height;
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

@end
