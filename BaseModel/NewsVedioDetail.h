//
//  NewsVedioDetail.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-11.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//
/*
 "Id" : 137,
 "CatId" : 1022,
 "Title" : "44年海信龄：刘师傅——去食堂的路走一次少一次",
 "TitlePic" : "2013/11/04/20131104004413_722ddffb.jpg",
 "Publisher" : "超级管理员",
 "PublishDate" : "2013-11-04 00:42:49",
 "Baoliu1" : "http://hiccvideo.hisense.com/masvod/public/2013/10/08/20131008_141960f9577_r27_800k.mp4",
 "InfoSource" : "公关部",
 "VideoUrl" : "http://hiccvideo.hisense.com/masvod/public/2013/10/08/20131008_141960f9577_r27_800k.mp4",
 */

#import "WXBaseModel.h"
#import "NewsVedioList.h"
@interface NewsVedioDetail : WXBaseModel
@property (nonatomic,retain) NSArray *vedioList;
@end
