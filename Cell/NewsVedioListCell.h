//
//  NewsVedioListCell.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-12.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsVedioList.h"
#import "EGOImageView.h"
@interface NewsVedioListCell : UITableViewCell
@property (nonatomic, retain) NewsVedioList *NewsVedioList;
@property (nonatomic, retain) UILabel *titleLable;
@property (nonatomic, retain) UIImageView *picLable;
@property (nonatomic, retain) UILabel *sourceLable;
@property (nonatomic, retain) UILabel *dateLable;
@end
