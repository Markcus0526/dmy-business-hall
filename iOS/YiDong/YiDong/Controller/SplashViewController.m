//
//  SplashViewController.m
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "SplashViewController.h"

@implementation SplashViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Connect service to get splash img URL.
    NSInteger   uid = [GlobalConfig getUserID];
    NSInteger   bndID = [GlobalConfig getBrandID];
    NSInteger   spcID = [GlobalConfig getSpecID];
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetSplashImgPath:uid brandid:bndID specid:spcID];
    
    [[[CommMgr getCommMgr] generalSvcMgr] GetTempID:uid];
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
}

- (void) splashPathResult:(NSString *)splashPath
{
    NSString* defPath = [BUNDLE pathForResource:@"defbackimage" ofType:@"png"];
    
    NSString* oldImgPath = [GlobalConfig getSplashImgPath];
    [GlobalConfig setSplashImgPath:splashPath];
    
    NSString* resultImgPath = nil;
    
    if( stringNotNilOrEmpty(splashPath) ) // Server video path is not NULL
    {
        NSString* localImgPath = [GlobalConfig getLocalSplashImgPath];
        
        if( stringNotNilOrEmpty(oldImgPath) && [oldImgPath compare:splashPath] == NSOrderedSame ) // Whenever we download video.
        {
            if( stringNotNilOrEmpty(localImgPath) == NO || IS_FILE_EXIST(localImgPath) == NO )
            {
                NSString* localFileName = [GlobalFunc downloadResource:splashPath localStore:DOWNLOAD_DIR_PATH];
                if ( stringNotNilOrEmpty(localImgPath) ) // If URL is valid.
                {
                    [GlobalConfig setLocalSplashImgPath:localFileName];
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
            NSString* localFileName = [GlobalFunc downloadResource:splashPath localStore:DOWNLOAD_DIR_PATH];
            
            if ( stringNotNilOrEmpty(localFileName) ) // If URL is valid.
            {
                [GlobalConfig setLocalSplashImgPath:localFileName];
                resultImgPath = localFileName;
            }
            else // Download Fails
                resultImgPath = defPath;
        }
    }
    else
        resultImgPath = defPath;
    
    [self initSplashImgControl:resultImgPath];
    
    [SVProgressHUD dismiss];
}

- (void) templateidResult:(NSInteger)result
{
    [GlobalConfig setTemplateID:result];
}

- (void) initSplashImgControl : (NSString*) imgPath
{
    UIImage* img = [UIImage imageWithContentsOfFile:imgPath];
    if( img == nil )
        img = [UIImage imageWithContentsOfFile:[BUNDLE pathForResource:@"defbackimage" ofType:@"png"]];
    
    _imgSplashView.image = img;
}

@end
