//
//  NewsVedioModel.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//
/*
 "Id" : 1021,
 "Name" : "20131008  第五十七期",
 "OrderId" : 1021,
 "VideoPic" : "",
 "VideoUrl" : "",
 "Summary" : ""
 
 */
#import "WXBaseModel.h"

@interface NewsVedioModel : WXBaseModel
@property (nonatomic,retain) NSNumber *vedioId;
@property (nonatomic, copy) NSString *vedioName;
@property (nonatomic, copy) NSString *vedioPic;
@property (nonatomic, copy) NSString *vedioUrl;
@property (nonatomic, copy) NSString *vedioSummary;
@end
