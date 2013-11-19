//
//  NewsCommentModel.h
//  NewsProject
//
//  Created by 姜勇 on 13-10-31.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "WXBaseModel.h"
#import "NewsReply.h"
@interface NewsCommentModel : WXBaseModel
@property (assign, nonatomic) NSNumber *commentId;
@property (copy, nonatomic)   NSString *commentTitle;
@property (assign, nonatomic) NSNumber *commentInfoId;
@property (copy, nonatomic)   NSString *commentSource;
@property (copy, nonatomic)   NSString *commentContent;
@property (copy, nonatomic)   NSString *commentDate;
@property (assign, nonatomic) NewsReply *commentReply;

@end
