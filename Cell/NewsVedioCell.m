//
//  NewsVedioCell.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsVedioCell.h"
#import "UIImageView+WebCache.h"
@implementation NewsVedioCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *cellbg =[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"newslistbg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        [cellbg setFrame:CGRectMake(10, 5, 300, 80)];
        [self.contentView addSubview:cellbg];
        
        self.nameLable=[[UILabel alloc]initWithFrame:CGRectZero];
        self.nameLable.backgroundColor=[UIColor clearColor];
        self.nameLable.font=[UIFont systemFontOfSize:16.0f];
        self.nameLable.textColor=[UIColor blackColor];
        [self.contentView addSubview:self.nameLable];
        
        self.sumaryLable=[[UILabel alloc]initWithFrame:CGRectZero];
        self.sumaryLable.backgroundColor=[UIColor clearColor];
        self.sumaryLable.font=[UIFont systemFontOfSize:14.0f];
        self.sumaryLable.textColor=[UIColor grayColor];
        self.sumaryLable.numberOfLines=0;
        [self.contentView addSubview:self.sumaryLable];
        
        self.picLable=[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:self.picLable];

    }
    return self;
}
- (void)layoutSubviews
{
    self.nameLable.frame=CGRectMake(86, 2, 220, 50);
    self.nameLable.text=self.vedioModel.vedioName;
    
    self.sumaryLable.frame=CGRectMake(70, 30, 220, 50);
    self.sumaryLable.text=self.vedioModel.vedioSummary;
    
    //self.picLable.frame=CGRectMake(10, 10, 76, 66);
//    NSString *picUrl=self.vedioModel.vedioPic;
//    if ([picUrl isEqual:NULL]) {
//        NSLog(@"%@",picUrl);
//    }else{
//        NSURL *url=[NSURL URLWithString:picUrl];
//        [self.picLable setImageWithURL:url];
//    }
    
//    if (self.vedioModel.vedioPic!=NULL) {
////        NSURL *url=[NSURL URLWithString:self.vedioModel.vedioPic];
////        [self.picLable setImageWithURL:url];
//        NSLog(@"picUrl---%@",self.vedioModel.vedioPic);
//    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
