//
//  CycleScrollView.h
//  CycleScrollDemo
//
//  Created by Weever Lu on 12-6-14.
//  Copyright (c) 2012年 linkcity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageControl.h"

typedef enum {
    CycleDirectionPortait,          // 垂直滚动
    CycleDirectionLandscape         // 水平滚动
}CycleDirection;

@protocol HuaTiCycleScrollViewDelegate;

@interface HuaTiCycleScrollView : UIView <UIScrollViewDelegate> {
    
    UIScrollView *scrollView;
    NSMutableArray *title_array;
    
    int totalPage;
    int curPage;
    CGRect scrollFrame;
    
    CycleDirection scrollDirection;     // scrollView滚动的方向
    NSArray *imagesArray;               // 存放所有需要滚动的图片 UIImage
    NSMutableArray *curImages;          // 存放当前滚动的三张图片
    
    //NSTimer *time;
    
    id delegate;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic,readonly) MyPageControl *pageControl;
@property (nonatomic,retain) NSMutableArray *title_array;

- (int)validPageValue:(NSInteger)value;
- (id)initWithFrame:(CGRect)frame cycleDirection:(CycleDirection)direction pictures:(NSArray *)pictureArray titleArray:(NSMutableArray *)titleArray;
- (NSArray *)getDisplayImagesWithCurpage:(int)page;
- (void)refreshScrollView;


@end

@protocol HuaTiCycleScrollViewDelegate <NSObject>
@optional
- (void)cycleScrollViewDelegate:(HuaTiCycleScrollView *)cycleScrollView didSelectImageView:(int)index;
- (void)cycleScrollViewDelegate:(HuaTiCycleScrollView *)cycleScrollView didScrollImageView:(int)index;

@end