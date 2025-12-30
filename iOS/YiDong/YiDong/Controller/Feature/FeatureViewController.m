//
//  FeatureViewController.m
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "FeatureViewController.h"

@implementation FeatureViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // FIX ME
    // TEST CODE
    if( [GlobalConfig getTemplateID] == 2 )
    {
        _imgTitleBar.image = [UIImage imageNamed:@"titlebar_2.jpg"];
        [_btnPhoneSpec setBackgroundImage:[UIImage imageNamed:@"comparebackbutton_2.png"] forState:UIControlStateNormal];
        [_btnBack setBackgroundImage:[UIImage imageNamed:@"backbutton_2.png"] forState:UIControlStateNormal];
    }
    
    
    _scrollViewFeatures.delegate = self;
    mFeatureIndex = 0;
    
    NSInteger uid = [GlobalConfig getUserID];
    NSInteger bndid = [GlobalConfig getBrandID];
    NSInteger specid = [GlobalConfig getSpecID];
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetBenifitList:uid brandid:bndid specid:specid];
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
}

- (void) benifitListResult:(NSMutableArray *)benifitList
{
    mFeatureImgPathArr = benifitList;
    
    if( benifitList != nil && [benifitList count] > 0 )
    {
        [self loadFeatureImage];
    
        [SVProgressHUD dismiss];
    }
    else
    {
        // FIX ME
        [SVProgressHUD dismissWithError:MSG_NOEXIST_BNDSPC afterDelay:DEF_TOAST_DELAY_TIME];
        // [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void) loadFeatureImage
{
    mFeatureImgCount = [mFeatureImgPathArr count];
    NSInteger nOldCount = [GlobalConfig getFeatureImgCount];
    
    if( mFeatureImgCount != nOldCount )
    {
        for(NSInteger i = 0; i < mFeatureImgCount; i ++)
        {
            [self downloadOneImage:i];
        }
    }
    else
    {
        for(NSInteger i = 0; i < mFeatureImgCount; i ++)
        {
            NSString* featurePath = [GlobalConfig getFeatureImgPath:i];
            NSString* urlPath = [mFeatureImgPathArr objectAtIndex:i];
            if( [featurePath compare:urlPath] != NSOrderedSame || IS_FILE_EXIST([GlobalConfig getLocalFeatureImgPath:i]) == NO )
            {
                [self downloadOneImage:i];
            }
        }
    }
    
    [GlobalConfig setFeatureImgCount:mFeatureImgCount];
    
    for(UIView* subView in [_scrollViewFeatures subviews] )
        [subView removeFromSuperview];
    [_scrollViewFeatures setBackgroundColor:[UIColor grayColor]];
    
    int nowX = 0;
    int itemWidth = _scrollViewFeatures.frame.size.width;
    int itemHeight = _scrollViewFeatures.frame.size.height;
    
    for(NSInteger i = 0; i < mFeatureImgCount; i ++)
    {
        CGRect itemRect = CGRectMake(nowX, 0, itemWidth, itemHeight);
        UIImageView* imagePicture = [[UIImageView alloc] initWithFrame:itemRect];
        [imagePicture setContentMode:UIViewContentModeScaleToFill];
        
        NSString* localPath = [GlobalConfig getLocalFeatureImgPath:i];
        if( stringNotNilOrEmpty(localPath))
            imagePicture.image = [UIImage imageWithContentsOfFile:localPath];
        else
            imagePicture.image = [UIImage imageNamed:@"defbackimage.png"];
            
        nowX += itemWidth;
        [_scrollViewFeatures addSubview:imagePicture];
        
        UIButton *btnPictureItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnPictureItem setFrame:itemRect];
        [btnPictureItem addTarget:self action:@selector(onPictureClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollViewFeatures addSubview:btnPictureItem];
    }
    
    [_scrollViewFeatures setContentInset:UIEdgeInsetsMake(0, 0, itemHeight, nowX)];
    
    _pageCtrlFeature.numberOfPages = mFeatureImgCount;
    _pageCtrlFeature.currentPage = 0;
    _pageCtrlFeature.currentPageIndicatorTintColor = [UIColor redColor];
    _pageCtrlFeature.pageIndicatorTintColor = [UIColor grayColor];
}

- (void) onPictureClicked : (id) sender
{
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( scrollView == _scrollViewFeatures )
    {
        int width = _scrollViewFeatures.frame.size.width;
        float xPos = _scrollViewFeatures.contentOffset.x;
        
        //Calculate the page we are on based on x coordinate position and width of scroll view
        mFeatureIndex = (int)xPos / width;
        if(mFeatureIndex >= mFeatureImgCount)
            mFeatureIndex = mFeatureImgCount - 1;
        if(mFeatureIndex < 0)
            mFeatureIndex = 0;
        
        _pageCtrlFeature.currentPage = mFeatureIndex;
    }
}

- (void) downloadOneImage : (NSInteger) index
{
    NSString* imgPath = [mFeatureImgPathArr objectAtIndex:index];
    
    // Get local download file path.
    NSString* localFilePath = [GlobalFunc downloadResource:imgPath localStore:DOWNLOAD_DIR_PATH];
    if( stringNotNilOrEmpty(localFilePath) )
    {
        // UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
        //[mLocalFeatureImgPathArr addObject:localFilePath];
        
        [GlobalConfig setFeatureImgPath:imgPath withIndex:index];
        [GlobalConfig setLocalFeatureImgPath:localFilePath withIndex:index];
    }
    else
    {
        // localFilePath = [BUNDLE pathForResource:@"defbackimage" ofType:@"png"];
        // UIImage* image = [UIImage imageNamed:@"defbackimage.png"];
        //[mLocalFeatureImgPathArr addObject:localFilePath];
        
        [GlobalConfig setFeatureImgPath:@"" withIndex:index];
        [GlobalConfig setLocalFeatureImgPath:@"" withIndex:index];
    }
}

- (IBAction)onTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
