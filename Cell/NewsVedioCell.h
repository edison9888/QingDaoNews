//
//  NewsVedioCell.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//
/*
 "Name" : "20131008  第五十七期",
 "OrderId" : 1021,
 "VideoPic" : "",
 "VideoUrl" : "",
 "Summary" : ""
 */
#import <UIKit/UIKit.h>
#import "NewsVedioModel.h"
@interface NewsVedioCell : UITableViewCell
@property (nonatomic, retain) NewsVedioModel *vedioModel;
@property (nonatomic, retain) UILabel *nameLable;
@property (nonatomic, retain) UIImageView *picLable;
@property (nonatomic, retain) UILabel *sumaryLable;
@end
