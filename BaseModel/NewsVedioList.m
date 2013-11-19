//
//  NewsVedioList.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsVedioList.h"

@implementation NewsVedioList
@synthesize title;
@synthesize titlePic;
@synthesize date;
@synthesize source;
@synthesize vedioUrl;
- (NSDictionary *)attributeMapDictionary
{
        NSDictionary *dic=@{@"title":@"Title",
                            @"titlePic":@"TitlePic",
                            @"date":@"PublishDate",
                            @"source":@"InfoSource",
                            @"vedioUrl":@"VideoUrl"};
    return dic;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}
@end
