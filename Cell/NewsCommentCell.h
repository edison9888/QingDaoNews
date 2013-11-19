//
//  NewsCommentCell.h
//  NewsProject
//
//  Created by 姜勇 on 13-10-31.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCommentModel.h"

@interface NewsCommentCell : UITableViewCell
{

    UILabel         *_nickLable;    //昵称
    UILabel         *_timeLable;    //时间
    UILabel         *_contentLable; //评论内容
}
@property (nonatomic, retain)NewsCommentModel *commentModel;
- (CGFloat)GetHeightCell:(NewsCommentModel *)commentModel;
@end
