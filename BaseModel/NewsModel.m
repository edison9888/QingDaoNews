//
//  NewsModel.m
//  NewsProject
//
//  Created by 姜勇 on 13-10-26.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//


#import "NewsModel.h"

@implementation NewsModel
- (NSDictionary *)attributeMapDictionary
{
    NSDictionary *dic=@{@"NewsId":@"Id",
                        @"NewsCatId":@"CatId",
                        @"NewsTitle":@"Title",
                        @"NewsPic":@"TitlePic",
                        @"NewsType":@"Type",
                        @"NewsContent":@"Content",
                        @"NewsOrderId":@"OrderId",
                        @"NewsPublisherId":@"PublisherId",
                        @"NewsPublisher":@"Publisher",
                        @"NewsPublishDate":@"PublishDate",
                        @"NewsInfoSource":@"InfoSource",};
    return dic;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    //将用户的数据映射到当前对象的属性上
}
@end
