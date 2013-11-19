//
//  NewsTitleCell.m
//  NewsProject
//
//  Created by 姜勇 on 13-10-27.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsTitleCell.h"

@implementation NewsTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}
- (void)_initView
{
    UIImageView *cellbg =[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"newslistbg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
    [cellbg setFrame:CGRectMake(10, 5, 300, 80)];
    [self.contentView addSubview:cellbg];
    
    self.titleLable=[[UILabel alloc]initWithFrame:CGRectZero];
    self.titleLable.backgroundColor=[UIColor clearColor];
    self.titleLable.font=[UIFont systemFontOfSize:18.0f];
    self.titleLable.textColor=[UIColor blueColor];
    self.titleLable.textAlignment=NSTextAlignmentLeft;
    self.titleLable.numberOfLines=4;
    [self.contentView addSubview:self.titleLable];
    
    self.publishDateLable=[[UILabel alloc]initWithFrame:CGRectZero];
    self.publishDateLable.backgroundColor=[UIColor clearColor];
    self.publishDateLable.font=[UIFont systemFontOfSize:14.0f];
    self.publishDateLable.textColor=[UIColor grayColor];
    self.publishDateLable.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.publishDateLable];
    
    self.infoSourceLable=[[UILabel alloc]initWithFrame:CGRectZero];
    self.infoSourceLable.backgroundColor=[UIColor clearColor];
    self.infoSourceLable.textColor=[UIColor grayColor];
    self.infoSourceLable.textAlignment=NSTextAlignmentLeft;
    self.infoSourceLable.font=[UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:self.infoSourceLable];
}
- (void)layoutSubviews
{
    self.titleLable.frame=CGRectMake(10, 0, 320, 50);
    self.titleLable.text=self.newsModel.NewsTitle;
    
    self.infoSourceLable.frame=CGRectMake(93, 50, 100, 30);
    self.infoSourceLable.text=self.newsModel.NewsInfoSource;
    
    self.publishDateLable.frame=CGRectMake(176, 55, 198, 20);
    self.publishDateLable.text=self.newsModel.NewsPublishDate;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
