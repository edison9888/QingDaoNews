//
//  NewsModel.h
//  NewsProject
//
//  Created by 姜勇 on 13-10-26.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//


#import "WXBaseModel.h"

@interface NewsModel : WXBaseModel
@property (copy, nonatomic) NSNumber *NewsId;
@property (copy, nonatomic) NSNumber *NewsCatId;
@property (copy, nonatomic) NSString *NewsTitle;
@property (copy, nonatomic) NSString *NewsPic;
@property (copy, nonatomic) NSNumber *NewsType;
@property (copy, nonatomic) NSNumber *NewsOrderId;
@property (copy, nonatomic) NSString *NewsPublisherId;
@property (copy, nonatomic) NSString *NewsPublisher;
@property (copy, nonatomic) NSString *NewsPublishDate;
@property (copy, nonatomic) NSString *NewsInfoSource;
@property (copy, nonatomic) NSString *NewsContent;
@end
