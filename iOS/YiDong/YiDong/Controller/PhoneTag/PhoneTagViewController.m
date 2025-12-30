//
//  PhoneTagViewController.m
//  YiDong
//
//  Created by Admin on 2/5/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "PhoneTagViewController.h"

@interface PhoneTagViewController ()

@end

@implementation PhoneTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // FIX ME
    // TEST CODE
    if( [GlobalConfig getTemplateID] == 2 )
    {
        [_btnBack setBackgroundImage:[UIImage imageNamed:@"backbutton_2.png"] forState:UIControlStateNormal];
    }
    
    _scrollViewPhoneTag.delegate = self;
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetStatiImageList:[GlobalConfig getUserID]
                                                    brandid:[GlobalConfig getBrandID]
                                                     specid:[GlobalConfig getSpecID]];
    mStatiImgCount = 0;
    mStatiImgIndex = 0;
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
}

- (void) statiImgListResult:(NSMutableArray *)statiList
{
    if( statiList == nil || [statiList count] < 1 )
    {
        [SVProgressHUD dismissWithError:MSG_SERVICE_ERROR afterDelay:DEF_TOAST_DELAY_TIME];
        return;
    }
    
    mStatiImgPathList = statiList;
    
    [self loadStatiImage];
    
    [SVProgressHUD dismiss];
}

- (void) loadStatiImage
{
    mStatiImgCount = [mStatiImgPathList count];
    NSInteger nOldCount = [GlobalConfig getStatiImgCount];
    
    if( mStatiImgCount != nOldCount )
    {
        for(NSInteger i = 0; i < mStatiImgCount; i ++)
        {
            [self downloadOneImage:i];
        }
    }
    else
    {
        for(NSInteger i = 0; i < mStatiImgCount; i ++)
        {
            NSString* featurePath = [GlobalConfig getStatiImgPath:i];
            NSString* urlPath = [mStatiImgPathList objectAtIndex:i];
            if( [featurePath compare:urlPath] != NSOrderedSame || IS_FILE_EXIST([GlobalConfig getLocalStatiImgPath:i]) == NO )
            {
                [self downloadOneImage:i];
            }
        }
    }
    
    [GlobalConfig setStatiImgCount:mStatiImgCount];
    
    for(UIView* subView in [_scrollViewPhoneTag subviews] )
        [subView removeFromSuperview];
    [_scrollViewPhoneTag setBackgroundColor:[UIColor grayColor]];
    
    int nowX = 0;
    int itemWidth = _scrollViewPhoneTag.frame.size.width;
    int itemHeight = _scrollViewPhoneTag.frame.size.height;
    
    for(NSInteger i = 0; i < mStatiImgCount; i ++)
    {
        CGRect itemRect = CGRectMake(nowX, 0, itemWidth, itemHeight);
        UIImageView* imagePicture = [[UIImageView alloc] initWithFrame:itemRect];
        [imagePicture setContentMode:UIViewContentModeScaleToFill];
        
        NSString* localPath = [GlobalConfig getLocalStatiImgPath:i];
        if( stringNotNilOrEmpty(localPath) )
            imagePicture.image = [UIImage imageWithContentsOfFile:localPath];
        else
            imagePicture.image = [UIImage imageNamed:@"defbackimage.png"];
        
        nowX += itemWidth;
        [_scrollViewPhoneTag addSubview:imagePicture];
        
//        UIButton *btnPictureItem = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btnPictureItem setFrame:itemRect];
//        [btnPictureItem addTarget:self action:@selector(onPictureClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_scrollViewPhoneTag addSubview:btnPictureItem];
    }
    
    [_scrollViewPhoneTag setContentInset:UIEdgeInsetsMake(0, 0, itemHeight, nowX)];
    
    _pageCtrlPhoneTag.numberOfPages = mStatiImgCount;
    _pageCtrlPhoneTag.currentPage = 0;
    _pageCtrlPhoneTag.currentPageIndicatorTintColor = [UIColor redColor];
    _pageCtrlPhoneTag.pageIndicatorTintColor = [UIColor grayColor];
}

- (IBAction) onPictureClicked:(id)sender
{
    [GlobalConfig setDetailStatiImgPath:[GlobalConfig getLocalStatiImgPath:mStatiImgIndex]];
    
    [self performSegueWithIdentifier:@"segueTagToDetail" sender:self];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( scrollView == _scrollViewPhoneTag )
    {
        int width = _scrollViewPhoneTag.frame.size.width;
        float xPos = _scrollViewPhoneTag.contentOffset.x;
        
        if( mStatiImgCount > 1 )
        {
            //Calculate the page we are on based on x coordinate position and width of scroll view
            mStatiImgIndex = (int)xPos / width;
            if(mStatiImgIndex >= mStatiImgCount)
                mStatiImgIndex = mStatiImgCount - 1;
            if(mStatiImgIndex < 0)
                mStatiImgIndex = 0;
        }
        
        _pageCtrlPhoneTag.currentPage = mStatiImgIndex;
    }
}

- (void) downloadOneImage : (NSInteger) index
{
    NSString* imgPath = [mStatiImgPathList objectAtIndex:index];
    
    // Get local download file path.
    NSString* localFilePath = [GlobalFunc downloadResource:imgPath localStore:DOWNLOAD_DIR_PATH];
    if( stringNotNilOrEmpty(localFilePath) )
    {
        [GlobalConfig setStatiImgPath:imgPath withIndex:index];
        [GlobalConfig setLocalStatiImgPath:localFilePath withIndex:index];
    }
    else
    {
        [GlobalConfig setStatiImgPath:@"" withIndex:index];
        [GlobalConfig setLocalStatiImgPath:@"" withIndex:index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
