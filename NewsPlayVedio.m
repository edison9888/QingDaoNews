//
//  NewsPlayVedio.m
//  QingDaoNews
//
//  Created by 姜勇 on 13-11-12.
//  Copyright (c) 2013年 姜勇. All rights reserved.
//

#import "NewsPlayVedio.h"
#import "PublicMethod.h"
#import "ALMoviePlayerController.h"
@interface NewsPlayVedio () <ALMoviePlayerControllerDelegate>

@property (nonatomic, strong) ALMoviePlayerController *moviePlayer;
@property (nonatomic) CGRect defaultFrame;

@end

@implementation NewsPlayVedio

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self _initNavigationBar];
    //create a player
    self.moviePlayer = [[ALMoviePlayerController alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.moviePlayer.view.alpha = 0.f;
    self.moviePlayer.delegate = self; //IMPORTANT!
    
    //create the controls
    ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:self.moviePlayer style:ALMoviePlayerControlsStyleDefault];
    //[movieControls setAdjustsFullscreenImage:NO];
    [movieControls setBarColor:[UIColor colorWithRed:195/255.0 green:29/255.0 blue:29/255.0 alpha:0.5]];
    [movieControls setTimeRemainingDecrements:YES];
    //[movieControls setFadeDelay:2.0];
    //[movieControls setBarHeight:100.f];
    //[movieControls setSeekRate:2.f];
    
    //assign controls
    [self.moviePlayer setControls:movieControls];
    [self.view addSubview:self.moviePlayer.view];
    
    //THEN set contentURL
    [self.moviePlayer setContentURL:[NSURL URLWithString:self.vedioUrl]];
    
    //delay initial load so statusBarOrientation returns correct value
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self configureViewForOrientation:[UIApplication sharedApplication].statusBarOrientation];
        [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
            self.moviePlayer.view.alpha = 1.f;
        } completion:^(BOOL finished) {
            self.navigationItem.leftBarButtonItem.enabled = YES;
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }];
    });
    
}
#pragma mark -初始化导航栏
- (void)_initNavigationBar
{
    UIImageView *navigationBar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"customNav.png"]];
    navigationBar.frame=CGRectMake(0, 0+Frame_Y, 320, 44);
    [self.view addSubview:navigationBar];
    [self.view sendSubviewToBack:navigationBar];
    [navigationBar release];
    
    UILabel *commentLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 0+Frame_Y, 100, 37)];
    commentLable.backgroundColor=[UIColor clearColor];
    commentLable.text=@"新闻详情";
    commentLable.font=[UIFont systemFontOfSize:20.0f];
    commentLable.textColor=[UIColor whiteColor];
    [self.view addSubview:commentLable];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 6+Frame_Y, 45, 30);
    [backBtn setImage:[UIImage imageNamed:@"listicon.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"listicon_h.png"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backTopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}
- (void)backTopView
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.moviePlayer stop];
}
- (void)configureViewForOrientation:(UIInterfaceOrientation)orientation {
    CGFloat videoWidth = 0;
    CGFloat videoHeight = 0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        videoWidth = 700.f;
        videoHeight = 535.f;
    } else {
        videoWidth = self.view.frame.size.width;
        videoHeight = 220.f;
    }
    
    //calulate the frame on every rotation, so when we're returning from fullscreen mode we'll know where to position the movie plauyer
    self.defaultFrame = CGRectMake(self.view.frame.size.width/2 - videoWidth/2, self.view.frame.size.height/2 - videoHeight/2, videoWidth, videoHeight);
    
    //only manage the movie player frame when it's not in fullscreen. when in fullscreen, the frame is automatically managed
    if (self.moviePlayer.isFullscreen)
        return;
    
    //you MUST use [ALMoviePlayerController setFrame:] to adjust frame, NOT [ALMoviePlayerController.view setFrame:]
    [self.moviePlayer setFrame:self.defaultFrame];
}

//these files are in the public domain and no longer have property rights
- (void)localFile {
    [self.moviePlayer stop];
    [self.moviePlayer setContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"popeye" ofType:@"mp4"]]];
    [self.moviePlayer play];
}

- (void)remoteFile {
    [self.moviePlayer stop];
    [self.moviePlayer setContentURL:[NSURL URLWithString:@"ehttp://hiccvideo.hisense.com/masvod/public/2013/10/08/20131008_1419605567d_r27_800k.mp4"]];
    [self.moviePlayer play];
}

//IMPORTANT!
- (void)moviePlayerWillMoveFromWindow {
    //movie player must be readded to this view upon exiting fullscreen mode.
    if (![self.view.subviews containsObject:self.moviePlayer.view])
        [self.view addSubview:self.moviePlayer.view];
    
    //you MUST use [ALMoviePlayerController setFrame:] to adjust frame, NOT [ALMoviePlayerController.view setFrame:]
    [self.moviePlayer setFrame:self.defaultFrame];
}

- (void)movieTimedOut {
    NSLog(@"MOVIE TIMED OUT");
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self configureViewForOrientation:toInterfaceOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
