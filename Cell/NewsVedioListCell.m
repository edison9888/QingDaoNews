//
//  NewsVedioListCell.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-12.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsVedioListCell.h"
#import "UIImageView+WebCache.h"
@implementation NewsVedioListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLable=[[UILabel alloc]initWithFrame:CGRectZero];
        self.titleLable.backgroundColor=[UIColor clearColor];
        self.titleLable.font=[UIFont systemFontOfSize:16.0f];
        self.titleLable.textColor=[UIColor blackColor];
        self.titleLable.numberOfLines=0;
        [self.contentView addSubview:self.titleLable];
        
//        self.picLable=[[UIImageView alloc]initWithFrame:CGRectZero];
//        [self.contentView addSubview:self.picLable];
        UIImage *image=[UIImage imageNamed:@"page_image_loading1.png"];
        EGOImageView *picLable=[[EGOImageView alloc]initWithPlaceholderImage:image];
        picLable.tag=1988;
        [self.contentView addSubview:picLable];
        
        self.sourceLable=[[UILabel alloc]initWithFrame:CGRectZero];
        self.sourceLable.backgroundColor=[UIColor clearColor];
        self.sourceLable.font=[UIFont systemFontOfSize:14.0f];
        self.sourceLable.textColor=[UIColor grayColor];
        [self.contentView addSubview:self.sourceLable];
        
        self.dateLable=[[UILabel alloc]initWithFrame:CGRectZero];
        self.dateLable.backgroundColor=[UIColor clearColor];
        self.dateLable.font=[UIFont systemFontOfSize:14.0f];
        self.dateLable.textColor=[UIColor grayColor];
        [self.contentView addSubview:self.dateLable];

        
    }
    return self;
}
- (void)layoutSubviews
{
    EGOImageView *picLable=(EGOImageView *)[self viewWithTag:1988];
    picLable.frame=CGRectMake(10, 10, 80, 66);
    NSString *picStr=[NSString stringWithFormat:@"http://test.mlib123.com/UploadFiles/%@",self.NewsVedioList.titlePic];
    NSURL *url=[NSURL URLWithString:picStr];
    
    // self.titlePicImage.image=[UIImage imageNamed:@"page_image_loading1.png"];
    [picLable setImageURL:url];
    //[self.contentView addSubview:self.titlePicImage];
    
    self.titleLable.frame=CGRectMake(95, 2, 220, 50);
    self.titleLable.text=self.NewsVedioList.title;
    
    self.dateLable.frame=CGRectMake(176, 55, 198, 20);
    self.dateLable.text=self.NewsVedioList.date;
    
    self.sourceLable.frame=CGRectMake(95, 50, 100, 30);
    self.sourceLable.text=self.NewsVedioList.source;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
