//
//  PictureCell.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-14.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "PictureModel.h"
@interface PictureCell : UITableViewCell
@property (nonatomic, retain) UILabel *content;
@property (nonatomic, retain) UILabel *number;
- (void)layoutImageView:(PictureModel *) model indexPath:(NSInteger) index;
@end
