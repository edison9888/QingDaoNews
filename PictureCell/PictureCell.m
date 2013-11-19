//
//  PictureCell.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-14.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *cellbg =[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"newslistbg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]];
        [cellbg setFrame:CGRectMake(10, 5, 300, 136)];
        [self.contentView addSubview:cellbg];
        
        self.content=[[UILabel alloc]initWithFrame:CGRectZero];
        self.content.backgroundColor=[UIColor clearColor];
        //self.content.tintColor=[UIColor grayColor];
        self.content.textColor=[UIColor grayColor];
        self.content.font=[UIFont systemFontOfSize:10.0f];
        [self.contentView addSubview:self.content];
        
        self.number=[[UILabel alloc]initWithFrame:CGRectZero];
        self.number.backgroundColor=[UIColor clearColor];
       // self.number.tintColor=[UIColor grayColor];
        self.number.textColor=[UIColor grayColor];
        self.number.font=[UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:self.number];
        for (int i=0; i<3; i++) {
            //标题图片
            EGOImageView *imageview =[[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"page_image_loading1.png"]];
            [imageview setBackgroundColor:[UIColor clearColor]];
            //imageview.frame=CGRectMake(18+97*i, 17, 90, 70);
            imageview.tag=5+i;
            [self addSubview:imageview];
            [imageview release];
        }
    }
    return self;
}
- (void)layoutImageView:(PictureModel *) model indexPath:(NSInteger) index
{
    EGOImageView *image1=(EGOImageView *)[self viewWithTag:5];
    EGOImageView *image2=(EGOImageView *)[self viewWithTag:6];
    EGOImageView *image3=(EGOImageView *)[self viewWithTag:7];
    
    if (index%2==0) {
        image1.frame=CGRectMake(16, 6, 290, 120);
        [image2 setHidden:YES];
        [image3 setHidden:YES];
        self.content.frame=CGRectMake(11, 130, 100, 10);
        self.content.text=@"海信新闻";
        self.number.frame=CGRectMake(280, 130, 30, 10);
        self.number.text=@"12张";
        
    }else{
        image1.frame=CGRectMake(11, 5, 100, 110);
        image2.frame=CGRectMake(110, 5, 100, 110);
        image3.frame=CGRectMake(210, 5, 100, 110);
        self.content.frame=CGRectMake(12, 120, 100, 10);
        self.content.text=@"海信新闻";
        self.number.frame=CGRectMake(280, 120, 30, 10);
        self.number.text=@"12张";
        [image2 setHidden:NO];
        [image3 setHidden:NO];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
