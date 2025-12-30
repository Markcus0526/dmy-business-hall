//
//  MainViewController.m
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIScreen.h>

#import "CommMgr.h"


@implementation MainViewController

- (IBAction)onTapFeatureTouch:(id)sender {
    // "Feature" Action Process Here.
    
}

- (IBAction)onTapTagTouch:(id)sender {
    // "Tag" Action Process Here.
    
}

- (IBAction)onTapExitTouch:(id)sender {
    // "Exit" Action Process Here.
    [self StopAnimTimer];
    
    exit(0);
}

- (void) StartAnimTimer
{
    dblCourtseyAngle = 0.0; // "Courtsey" image first angle.
    nCompanyLabelPosX = ScreenWidth + 10; // Company name first pos.
    
    _lblCompanyName.text = WELCOME_STR;
    _lblCompanyName.transform = CGAffineTransformMakeTranslation(nCompanyLabelPosX, 0);
    
    CourtseyAnimTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(TimerProc) userInfo:nil repeats:YES];
    [CourtseyAnimTimer fire];
    [[NSRunLoop mainRunLoop] addTimer:CourtseyAnimTimer forMode:NSRunLoopCommonModes];
}

- (void) StopAnimTimer
{
    [CourtseyAnimTimer invalidate];
    CourtseyAnimTimer = nil;
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    float aspectFontSize = ScreenWidth * (17 / 320.f);
    // float aspectFontSize = _lblProvinceName.bounds.size.height;
    UIFont* aspectFont = [UIFont systemFontOfSize:aspectFontSize];
    [_lblCompanyName setFont:aspectFont];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize "courtsey" rotate anim.
    [self StartAnimTimer];
    
    NSString* savedCompanyName = [GlobalConfig getCompanyName];
    NSString* dispCompanyName;
    
    // Initialize company name label.
    if( stringNotNilOrEmpty(savedCompanyName) )
    {
        NSString* aCompName = [NSString stringWithString:savedCompanyName];
        aCompName = [aCompName stringByAppendingString:WELCOME_STR];
        dispCompanyName = aCompName;
    }
    else
    {
        dispCompanyName = WELCOME_STR;
    }
    
    realTextSize = [dispCompanyName sizeWithFont:_lblCompanyName.font];
    _lblCompanyName.text = dispCompanyName;
    CGRect parentFrame = _viewCompanyName.frame;
    _lblCompanyName.frame = CGRectMake(nCompanyLabelPosX, 0, parentFrame.size.width, parentFrame.size.height);
    
    // FIX ME
    // TEST CODE
    if( [GlobalConfig getTemplateID] == 2)
    {
        _imgTitleBar.image = [UIImage imageNamed:@"titlebar_2.jpg"];
        [_btnFeature setBackgroundImage:[UIImage imageNamed:@"featurebutton_2.png"] forState:UIControlStateNormal];
        [_btnPhoneTag setBackgroundImage:[UIImage imageNamed:@"tagbutton_2.png"] forState:UIControlStateNormal];
        [_btnExit setBackgroundImage:[UIImage imageNamed:@"exitbutton_2.png"] forState:UIControlStateNormal];
    }
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetFirstPageImgPath:[GlobalConfig getUserID]
                                                      brandid:[GlobalConfig getBrandID]
                                                       specid:[GlobalConfig getSpecID]];
}

- (void) firstPageImageResult:(NSString *)firstimagePath
{
    NSString* defPath = [BUNDLE pathForResource:@"defbackimage" ofType:@"png"];
    
    NSString* oldImgPath = [GlobalConfig getFirstPageImgPath];
    [GlobalConfig setFirstPageImgPath:firstimagePath];
    
    NSString* resultImgPath = nil;
    
    if( stringNotNilOrEmpty(firstimagePath) ) // Server video path is not NULL
    {
        NSString* localImgPath = [GlobalConfig getLocalFirstPageImgPath];
        
        if( stringNotNilOrEmpty(oldImgPath) && [oldImgPath compare:firstimagePath] == NSOrderedSame ) // Whenever we download video.
        {
            if( stringNotNilOrEmpty(localImgPath) == NO || IS_FILE_EXIST(localImgPath) == NO )
            {
                NSString* localFileName = [GlobalFunc downloadResource:firstimagePath localStore:DOWNLOAD_DIR_PATH];
                if ( stringNotNilOrEmpty(localImgPath) ) // If URL is valid.
                {
                    [GlobalConfig setLocalFirstPageImgPath:localFileName];
                    resultImgPath = localFileName;
                }
                else // Download Fails
                    resultImgPath = defPath;
            }
            else
                resultImgPath = localImgPath;
        }
        else // Never download.
        {
            NSString* localFileName = [GlobalFunc downloadResource:firstimagePath localStore:DOWNLOAD_DIR_PATH];
            
            if ( stringNotNilOrEmpty(localFileName) ) // If URL is valid.
            {
                [GlobalConfig setLocalFirstPageImgPath:localFileName];
                resultImgPath = localFileName;
            }
            else // Download Fails
                resultImgPath = defPath;
        }
    }
    else
        resultImgPath = defPath;
    
    _imgFirstPage.image = [UIImage imageWithContentsOfFile:resultImgPath];
    
    [SVProgressHUD dismiss];
}

- (void) TimerProc
{
     // Rotating courtsey.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.05];
    
    dblCourtseyAngle += 0.5;
    if(dblCourtseyAngle > 2 * M_PI)
        dblCourtseyAngle -= 2 * M_PI;
    
    _imgCourtsey.transform = CGAffineTransformMakeRotation(dblCourtseyAngle);
    
    [UIView commitAnimations];
    
    // Animating company label.
    if( [_lblCompanyName.text length] > 0 )
    {
        if( nCompanyLabelPosX < -[_lblCompanyName bounds].size.width - 10 )
            nCompanyLabelPosX = ScreenWidth + 10;
        
        CGRect parentFrame = _viewCompanyName.frame;
        _lblCompanyName.frame = CGRectMake(nCompanyLabelPosX, 0, parentFrame.size.width, parentFrame.size.height);
        
        nCompanyLabelPosX -= 3;
    }
}

@end
