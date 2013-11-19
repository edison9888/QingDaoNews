//
//  RootCell.h
//  TableDemods
//
//  Created by 姜勇 on 13-11-15.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootCell : UITableViewCell
@property (nonatomic, assign) UILabel      *titleLable;      //新闻标题
@property (nonatomic, assign) UILabel      *publishDateLable;//新闻日期
@property (nonatomic, assign) UILabel      *infoSourceLable; //新闻来源
@end
