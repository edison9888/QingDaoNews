//
//  NewsVedioModel.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//
#import "NewsVedioModel.h"

@implementation NewsVedioModel
- (NSDictionary *)attributeMapDictionary
{
    NSDictionary *dic=@{@"vedioId":@"Id",
                        @"vedioName":@"Name",
                        @"vedioPic":@"VideoPic",
                        @"vedioUrl":@"VideoUrl",
                        @"vedioSummary":@"Summary"
                        };
    return dic;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}
@end
