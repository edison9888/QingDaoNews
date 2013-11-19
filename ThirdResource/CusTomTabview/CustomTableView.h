//
//  FirstPage.h
//  GYCheLunHangYe
//
//  Created by 王新勇 on 13-4-27.
//  Copyright (c) 2013年 王新勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STableViewController.h"
#import "ASIFormDataRequest.h"

@interface CustomTableView : STableViewController<ASIHTTPRequestDelegate>{
    
    NSMutableArray *infoArray;  //存放列表数据
    NSInteger currentPage; //当前页
    NSInteger pageCount;   //总页数
    ASIFormDataRequest *formRequest;
}



@property (nonatomic , assign) float tableviewWidth;
@property (nonatomic , assign) float tableviewHeight;
@property (nonatomic , retain) NSString *requestUrl;
@property (nonatomic , retain) NSMutableArray *keyArray;
@property (nonatomic , retain) NSMutableArray *valueArray;
@property (nonatomic , retain) UINavigationController *superNav;
@property (nonatomic , assign) NSInteger viewTag;
@property (nonatomic , assign) NSInteger tableViewCellType;
@property(nonatomic,retain) NSString *detailThirdSourceUrl;





@end
