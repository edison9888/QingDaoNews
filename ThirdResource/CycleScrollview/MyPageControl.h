//
//  MyPageControl.h
//  GuoXin
//
//  Created by 王新勇 on 13-7-2.
//  Copyright (c) 2013年 王新勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageControl : UIPageControl
{
    UIImage *imagePageStateNormal;
    UIImage *imagePageStateHighlighted;
}

- (id)initWithFrame:(CGRect)frame;
@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;

@end
