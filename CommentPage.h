//
//  CommentPage.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-7.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "NewsCommentCell.h"
#import "NewsCommentModel.h"
#import "PublicMethod.h"
@interface CommentPage : UIViewController <UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
@property (assign ,nonatomic) NSInteger newId;
@property (assign ,nonatomic) UITableView *commentTable;
@property (retain ,nonatomic) NSMutableArray *data;
@end
