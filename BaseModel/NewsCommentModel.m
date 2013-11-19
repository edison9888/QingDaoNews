//
//  NewsCommentModel.m
//  NewsProject
//
//  Created by 姜勇 on 13-10-31.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsCommentModel.h"

@implementation NewsCommentModel
- (NSDictionary *)attributeMapDictionary
{
    NSDictionary *dic=@{@"commentId":@"Id",
                        @"commentTitle":@"Title",
                        @"commentInfoId":@"InfoId",
                        @"commentSource":@"Source",
                        @"commentContent":@"Content",
                        @"commentDate":@"PublishDate"};
    return dic;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    NSDictionary *replyDic=[dataDic objectForKey:@"Reply"];
    if (replyDic!=nil) {
        NewsReply *replyModel=[[NewsReply alloc]initWithDataDic:replyDic];
        self.commentReply=replyModel;
    }

}
@end
