//
//  VideoPlayViewController.m
//  YiDong
//
//  Created by Admin on 2/3/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "VideoPlayViewController.h"
#import <UIKit/UIDevice.h>

@implementation VideoPlayViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    mMoviePlayer = nil;
    
    // Connect service to get video URL.
    NSInteger   uid = [GlobalConfig getUserID];
    NSInteger   bndID = [GlobalConfig getBrandID];
    NSInteger   spcID = [GlobalConfig getSpecID];
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    STBndSpcID* logInfo = [[STBndSpcID alloc] init];
    logInfo.brandID = bndID;
    logInfo.specID = spcID;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetVideoPath:uid brandid:bndID specid:spcID];
}

//—called when the movie is done playing—
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    [mMoviePlayer pause];
    [mMoviePlayer play];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Re-allocate video play view.
    [self videoPathResult : [GlobalConfig getVideoPath]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [APPLICATION setIdleTimerDisabled:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [APPLICATION setIdleTimerDisabled:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)onTapClickVideoView:(id)sender {
    [self uninitVideoControl];
}

- (void) videoPathResult:(NSString *)videoPath
{
    NSString* defPath = [BUNDLE pathForResource:@"video" ofType:@"mp4"];

    NSString* oldVideoPath = [GlobalConfig getVideoPath];
    [GlobalConfig setVideoPath:videoPath];
    
    NSString*   resultVideoPath = nil;

    if( stringNotNilOrEmpty(videoPath) ) // Server video path is not NULL
    {
        NSString* localVideoPath = [GlobalConfig getLocalVideoPath];
        
        if( stringNotNilOrEmpty(oldVideoPath) && [oldVideoPath compare:videoPath] == NSOrderedSame ) // Whenever we download video.
        {
            if( stringNotNilOrEmpty(localVideoPath) == NO || IS_FILE_EXIST(localVideoPath) == NO )
            {
                NSString* localFileName = [GlobalFunc downloadResource:videoPath localStore:DOWNLOAD_DIR_PATH];
                if ( stringNotNilOrEmpty(localFileName) ) // If URL is valid.
                {
                    [GlobalConfig setLocalVideoPath:localFileName];
                    resultVideoPath = localFileName;
                }
                else // Download Fails
                    resultVideoPath = defPath;
            }
            else
                [self initVideoControl:localVideoPath];
        }
        else // Never download or different from past
        {
            NSString* localFileName = [GlobalFunc downloadResource:videoPath localStore:DOWNLOAD_DIR_PATH];
            
            if ( stringNotNilOrEmpty(localFileName) ) // If URL is valid.
            {
                [GlobalConfig setLocalVideoPath:localFileName];
                resultVideoPath = localFileName;
            }
            else // Download Fails
                resultVideoPath = defPath;
        }
    }
    else
    {
        resultVideoPath = defPath;
    }
    
    [self initVideoControl:resultVideoPath];
    
    [SVProgressHUD dismiss];
}

- (void) initVideoControl : (NSString*) videoPath
{
    if( mMoviePlayer != nil ) // Already has been created.
        return;
    
    mMoviePlayer = [[MPMoviePlayerController alloc]
                    initWithContentURL:[NSURL fileURLWithPath:videoPath]];
    
    mMoviePlayer.controlStyle = MPMovieControlStyleNone;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(movieFinishedCallback:)
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:mMoviePlayer];
    
    //—set the size of the movie view and then add it to the View window—
    // Rotate video view to landscape right.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.05];
    
    mMoviePlayer.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    [UIView commitAnimations];
    
    mMoviePlayer.view.bounds = CGRectMake(-ScreenHeight / 2, ScreenWidth / 2, ScreenHeight, ScreenWidth);
    
    // player.view.frame = CGRectMake(10, 10, 300, 300);
    //[player setFullscreen:true];
    [_videoPlayView addSubview:mMoviePlayer.view];
    
    // _videoPlayView.frame = CGRectMake(-ScreenHeight / 2, ScreenWidth / 2, ScreenHeight, ScreenWidth);
    
    //—play movie—
    [mMoviePlayer play];
}

- (void) uninitVideoControl
{
    if( mMoviePlayer != nil )
    {
        [[NSNotificationCenter defaultCenter]   removeObserver:self
                                                          name:MPMoviePlayerPlaybackDidFinishNotification
                                                        object:mMoviePlayer];
        
        [mMoviePlayer stop];
        [mMoviePlayer.view removeFromSuperview];
        mMoviePlayer = nil;
        // [mMoviePlayer release];
        
    }
}

@end
