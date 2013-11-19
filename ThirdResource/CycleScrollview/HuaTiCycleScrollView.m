//
//  CycleScrollView.m
//  CycleScrollDemo
//
//  Created by Weever Lu on 12-6-14.
//  Copyright (c) 2012年 linkcity. All rights reserved.
//

#import "HuaTiCycleScrollView.h"
#import "EGOImageView.h"
#import "PublicMethod.h"

@implementation HuaTiCycleScrollView
@synthesize delegate;
@synthesize pageControl = _pageControl;
@synthesize title_array;

- (id)initWithFrame:(CGRect)frame cycleDirection:(CycleDirection)direction pictures:(NSArray *)pictureArray titleArray:(NSMutableArray *)titleArray
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        scrollFrame = frame;
        scrollDirection = direction;
        totalPage = pictureArray.count;
        curPage = 1;                                    // 显示的是图片数组里的第一张图片
        curImages = [[NSMutableArray alloc] init];
        imagesArray = [[NSArray alloc] initWithArray:pictureArray];
        self.title_array=[NSMutableArray arrayWithArray:titleArray];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        
        
        [self addSubview:scrollView];
        
        // 在水平方向滚动
        if(scrollDirection == CycleDirectionLandscape) {
            if (imagesArray.count!=1) {
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3,
                                                    scrollView.frame.size.height);
            }else{
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,
                                                    scrollView.frame.size.height);
            }
            
        }
        // 在垂直方向滚动
        if(scrollDirection == CycleDirectionPortait) {
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,
                                                scrollView.frame.size.height * 3);
        }
        
        [self addSubview:scrollView];
        [self refreshScrollView];
        
        
        UIImageView *imageview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"opcitybg.png"]];
        [imageview setFrame:CGRectMake(0, frame.size.height-25, frame.size.width, 25)];
        [self addSubview:imageview];
        [imageview release];
        
        
        
        
        _pageControl = [[MyPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-50, 320, 25)];
        [_pageControl setBackgroundColor:[UIColor clearColor]];
        //[_pageControl setImagePageStateNormal:[UIImage imageNamed:@"bannericon.png"]];//灰色圆点图片
        //[_pageControl setImagePageStateHighlighted:[UIImage imageNamed:@"bannericon_h.png"]];//黑色圆点图片
        [_pageControl setHidesForSinglePage:YES];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = totalPage;
        [_pageControl setCurrentPage:0];
        [self addSubview:_pageControl];
        
        
        UILabel *titleLabel0 =[[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height-20, 40, 15)];
        [titleLabel0 setTextColor:[UIColor whiteColor]];
        [titleLabel0 setFont:[UIFont boldSystemFontOfSize:12]];
        titleLabel0.backgroundColor=TextBlueColor
        [titleLabel0 setText:@"进行中"];
        [titleLabel0 setTextAlignment:UITextAlignmentCenter];
        [self addSubview:titleLabel0];
        [titleLabel0 release];
        
        UILabel *titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(60, frame.size.height-25, 320-60, 25)];
        titleLabel.textColor=TextBlueColor;
        [titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTag:1111];
        [titleLabel setText:[title_array objectAtIndex:0]];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        //time =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(automove) userInfo:nil repeats:YES];
    }
    
    return self;
}


//-(void)automove
//{
//    [scrollView setContentOffset:CGPointMake(0*320 , 0) animated:YES];
//
//}


- (void)refreshScrollView {
    
    NSArray *subViews = [scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:curPage];
    
    for (int i = 0; i < 3; i++) {
        EGOImageView *imageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"picnull2-1.png"]];
        [imageView setFrame:CGRectMake(0, 0, scrollFrame.size.width, scrollFrame.size.height)];
        imageView.userInteractionEnabled = YES;
        if ([[curImages objectAtIndex:i] rangeOfString:@"http://"].length>0) {
            if (![PublicMethod checkConnection]) {
                if ([[PublicMethod getObjectForKey:@"showImage3G"] isEqualToString:@"on"]) {
                    imageView.imageURL = [NSURL URLWithString:@""];
                }else{
                    imageView.imageURL = [NSURL URLWithString: [curImages objectAtIndex:i]];
                }
            }else{
                imageView.imageURL = [NSURL URLWithString: [curImages objectAtIndex:i]];
            }
        }else{
            
            //判断是否读离线
            if ([[curImages objectAtIndex:i] rangeOfString:@"Caches"].length>0) {
                [imageView setImage:[UIImage imageWithContentsOfFile:[curImages objectAtIndex:i]]];
                
            }else{
                imageView.image =[UIImage imageNamed:[curImages objectAtIndex:i]] ;
            }
            
        }
        
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [imageView addGestureRecognizer:singleTap];
        [singleTap release];
        
        // 水平滚动
        if(scrollDirection == CycleDirectionLandscape) {
            imageView.frame = CGRectOffset(imageView.frame, scrollFrame.size.width * i, 0);
        }
        // 垂直滚动
        if(scrollDirection == CycleDirectionPortait) {
            imageView.frame = CGRectOffset(imageView.frame, 0, scrollFrame.size.height * i);
        }
        
        
        [scrollView addSubview:imageView];
        
        [imageView release];
    }
    if (scrollDirection == CycleDirectionLandscape) {
        [scrollView setContentOffset:CGPointMake(scrollFrame.size.width, 0)];
    }
    if (scrollDirection == CycleDirectionPortait) {
        [scrollView setContentOffset:CGPointMake(0, scrollFrame.size.height)];
    }
}

- (NSArray *)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:curPage-1];
    int last = [self validPageValue:curPage+1];
    
    if([curImages count] != 0) [curImages removeAllObjects];
    
    [curImages addObject:[imagesArray objectAtIndex:pre-1]];
    [curImages addObject:[imagesArray objectAtIndex:curPage-1]];
    [curImages addObject:[imagesArray objectAtIndex:last-1]];
    
    
    //    [curTitle addObject:[title_array objectAtIndex:pre-1]];
    //    [curTitle addObject:[title_array objectAtIndex:curPage-1]];
    //    [curTitle addObject:[title_array objectAtIndex:last-1]];
    
    return curImages;
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == 0) value = totalPage;                   // value＝1为第一张，value = 0为前面一张
    if(value == totalPage + 1) value = 1;
    
    return value;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    int x = aScrollView.contentOffset.x;
    int y = aScrollView.contentOffset.y;
    //NSLog(@"did  x=%d  y=%d", x, y);
    
    // 水平滚动
    if(scrollDirection == CycleDirectionLandscape) {
        // 往下翻一张
        if(x >= (2*scrollFrame.size.width)) {
            curPage = [self validPageValue:curPage+1];
            [self refreshScrollView];
        }
        if(x <= 0) {
            curPage = [self validPageValue:curPage-1];
            [self refreshScrollView];
        }
    }
    
    
    
    _pageControl.currentPage = curPage-1;
    
    
    
    // 垂直滚动
    if(scrollDirection == CycleDirectionPortait) {
        // 往下翻一张
        if(y >= 2 * (scrollFrame.size.height)) {
            curPage = [self validPageValue:curPage+1];
            [self refreshScrollView];
        }
        if(y <= 0) {
            curPage = [self validPageValue:curPage-1];
            [self refreshScrollView];
        }
    }
    
    if ([delegate respondsToSelector:@selector(cycleScrollViewDelegate:didScrollImageView:)]) {
        [delegate cycleScrollViewDelegate:self didScrollImageView:curPage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    //int x = aScrollView.contentOffset.x;
    //int y = aScrollView.contentOffset.y;
    
    //NSLog(@"--end  x=%d  y=%d", x, y);
    
    UILabel *titleLabel =(UILabel *)[self viewWithTag:1111];
    [titleLabel setText:[title_array objectAtIndex:_pageControl.currentPage]];
    
    
    if (scrollDirection == CycleDirectionLandscape) {
        [scrollView setContentOffset:CGPointMake(scrollFrame.size.width, 0) animated:YES];
    }
    if (scrollDirection == CycleDirectionPortait) {
        [scrollView setContentOffset:CGPointMake(0, scrollFrame.size.height) animated:YES];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([delegate respondsToSelector:@selector(cycleScrollViewDelegate:didSelectImageView:)]) {
        [delegate cycleScrollViewDelegate:self didSelectImageView:curPage];
    }
}


- (void)dealloc
{
    [imagesArray release];
    [curImages release];
    [title_array release];
    [super dealloc];
}

@end
