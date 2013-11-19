//
//  NewsReply.h
//  NewsProject
//
//  Created by 姜勇 on 13-11-4.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//
//{
//    "Id" : 132,
//    "Source" : "张经理",
//    "Content" : "管理员回复评论内容",
//    "PublishDate" : "2013-11-01 11:42:44"
//}
#import "WXBaseModel.h"

@interface NewsReply : WXBaseModel
@property (assign, nonatomic) NSNumber *replyId;
@property (copy, nonatomic) NSString *replySource;
@property (copy, nonatomic) NSString *replyContent;
@property (copy, nonatomic) NSString *replyDate;
@end
