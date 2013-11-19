//
//  MyPageControl.m
//  GuoXin
//
//  Created by 王新勇 on 13-7-2.
//  Copyright (c) 2013年 王新勇. All rights reserved.
//

#import "MyPageControl.h"

@interface MyPageControl(private)  // 声明一个私有方法, 该方法不允许对象直接使用
- (void)updateDots;
@end


@implementation MyPageControl  // 实现部分


@synthesize imagePageStateNormal;
@synthesize imagePageStateHighlighted;


- (id)initWithFrame:(CGRect)frame { // 初始化
    self = [super initWithFrame:frame];
    return self;
}


- (void)setImagePageStateNormal:(UIImage *)image {  // 设置正常状态点按钮的图片
    [imagePageStateHighlighted release];
    imagePageStateHighlighted = [image retain];
    [self updateDots];
}


- (void)setImagePageStateHighlighted:(UIImage *)image { // 设置高亮状态点按钮图片
    [imagePageStateNormal release];
    imagePageStateNormal = [image retain];
    [self updateDots];
}


- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { // 点击事件
    [super endTrackingWithTouch:touch withEvent:event];
    [self updateDots];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}



- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    //activeImage = [UIImage imageNamed:@"icon_star"];
    //inActiveIamge = [UIImage imageNamed:@"icon_dot"];
    int count = [self.subviews count];
    for (int i = 0; i < count; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        CGRect frame =dot.frame;
        frame.size.width=10;
        frame.size.height=10;
        frame.origin.x=frame.origin.x-5*i;
        dot.frame=frame;
        [dot setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)updateDots { // 更新显示所有的点按钮
    
    
    if (imagePageStateNormal || imagePageStateHighlighted)
    {
        NSArray *subview = self.subviews;  // 获取所有子视图
        for (NSInteger i = 0; i < [subview count]; i++)
        {
//            UIImageView *dot = [subview objectAtIndex:i];  // 以下不解释, 看了基本明白
//            CGRect frame =dot.frame;
//            frame.size.width=10;
//            frame.size.height=10;
//            dot.frame=frame;
//            dot.image = self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted;
            
            
            
            if ([[subview objectAtIndex:i] isKindOfClass:[UIImageView class]]) {
                UIImageView *dot =[subview objectAtIndex:i];  // 以下不解释, 看了基本明白
                dot.image = self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted;
            }else{
                UIView *view =[subview objectAtIndex:i];
                if (view.subviews.count==0) {
                    UIImageView *imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
                    [imageview setImage:self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted];
                    [view addSubview:imageview];
                    [imageview release];
                }else{
                    UIImageView *imageview =[view.subviews objectAtIndex:0];  // 以下不解释, 看了基本明白
                    imageview.image = self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted;
                }
                
            }
            
            
            
        }
    }
    
}


- (void)dealloc { // 释放内存
    [imagePageStateNormal release], imagePageStateNormal = nil;
    [imagePageStateHighlighted release], imagePageStateHighlighted = nil;
    [super dealloc];
}

@end
