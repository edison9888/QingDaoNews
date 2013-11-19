//
//  CollectPage.h
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-15.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface CollectPage : UIViewController <UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
@property (nonatomic, copy) NSString *ceshi;
@property (nonatomic, retain) UITableView *collectTable;
@property (nonatomic, retain) NSMutableArray *data;
@end
