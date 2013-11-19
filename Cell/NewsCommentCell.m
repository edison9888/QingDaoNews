//
//  NewsCommentCell.m
//  NewsProject
//
//  Created by 姜勇 on 13-10-31.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsCommentCell.h"

@implementation NewsCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _nickLable=[(UILabel *)[self viewWithTag:101]retain];
    _timeLable=[(UILabel *)[self viewWithTag:102]retain];
    _contentLable=[(UILabel *)[self viewWithTag:103]retain];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //为标签添加数据
    _nickLable.text=self.commentModel.commentSource;
    _timeLable.text=self.commentModel.commentDate;
    _contentLable.text=self.commentModel.commentContent;
    
    
}
- (CGFloat)GetHeightCell:(NewsCommentModel *)commentModel
{
    return 10;
}
@end
