//
//  NewsVedioDetail.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//
#import "NewsVedioDetail.h"

@implementation NewsVedioDetail


- (NSDictionary *)attributeMapDictionary
{
//    NSDictionary *dic=@{@"title":@"Title",
//                        @"titlePic":@"TitlePic",
//                        @"date":@"PublishDate",
//                        @"source":@"InfoSource",
//                        @"vedioUrl":@"VideoUrl"};
    NSDictionary *dic=@{@"vedioList":@"VideoList"};
    return dic;
}

- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    
}
@end
