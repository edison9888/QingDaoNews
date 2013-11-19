//
//  NewsVedioList.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "WXBaseModel.h"

@interface NewsVedioList : WXBaseModel
@property (nonatomic, retain) NSNumber *catId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titlePic;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *vedioUrl;

@end
