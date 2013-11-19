//
//  WeatherModel.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-8.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel
- (NSDictionary *)attributeMapDictionary
{
    NSDictionary *dic=@{@"weatherCity":@"city",
                        @"weatherCity_en":@"city_en",
                        @"weatherDate_y":@"date_y",
                        @"weatherWeek":@"week",
                        @"weatherTemp1":@"temp1",
                        @"weatherTemp2":@"temp2",
                        @"weatherTemp3":@"temp3",
                        @"weatherTemp4":@"temp4",
                        @"weatherTemp5":@"temp5",
                        @"weatherTemp6":@"temp6",
                        @"weatherImage1":@"img1",
                        @"weatherImage2":@"img2",
                        @"weatherImage3":@"img3",
                        @"weatherImage4":@"img4",
                        @"weatherImage5":@"img5",
                        @"weatherImage6":@"img6",
                        @"weatherImage7":@"img7",
                        @"weatherImage8":@"img8",
                        @"weatherImage9":@"img9",
                        @"weatherImage10":@"img10",
                        @"weatherImage11":@"img11",
                        @"weatherImage12":@"img12",
                        @"weatherIndex":@"index",
                        @"weatherIndex_d":@"index_d",
                        @"weatherIndex48":@"index48",
                        @"weatherIndex48_d":@"index48_d"
                        };
    return dic;
}
- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
}
@end
