//
//  ZXDetailPage.h
//  QDSports
//
//  Created by wang rain on 12-7-7.
//  Copyright (c) 2012年 青岛联科时代科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDetailPage : UIViewController<UIWebViewDelegate>{
    NSString *urlStr;
}

@property(nonatomic,retain) NSString *urlStr;
@property(nonatomic,retain) NSString *navTitle;

@end
