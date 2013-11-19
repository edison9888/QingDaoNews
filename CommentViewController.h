//
//  CommentViewController.h
//  NewsProject
//
//  Created by 姜勇 on 13-11-4.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@interface CommentViewController : UIViewController <ASIHTTPRequestDelegate>
{
    UILabel         *commentName;
    UITextField     *name;
    UILabel         *commentMessage;
    UITextField     *message;
}
@property (assign, nonatomic) NSInteger commentId;
@end
