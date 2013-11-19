//
//  RootCell.m
//  TableDemods
//
//  Created by 姜勇 on 13-11-15.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "RootCell.h"

@implementation RootCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
- (void)layoutSubviews
{
    self.titleLable.frame=CGRectMake(90, 2, 220, 50);
    
    self.publishDateLable.frame=CGRectMake(176, 55, 198, 20);
    
    self.infoSourceLable.frame=CGRectMake(90, 50, 100, 30);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
