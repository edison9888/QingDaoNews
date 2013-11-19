//
//  NewsTitleCell.h
//  NewsProject
//
//  Created by 姜勇 on 13-10-27.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTitleCell : UITableViewCell
@property (nonatomic, assign) UILabel      *titleLable;      //新闻标题
@property (nonatomic, assign) UILabel      *publishDateLable;//新闻日期
@property (nonatomic, assign) UILabel      *infoSourceLable; //新闻来源
@property (nonatomic, assign) NewsModel    *newsModel;       //新闻模型

@end
