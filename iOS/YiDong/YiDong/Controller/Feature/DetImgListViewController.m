//
//  DetImgListViewController.m
//  YiDong
//
//  Created by Admin on 2/6/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "DetImgListViewController.h"

@implementation DetImgListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollViewImgList.delegate = self;
    
    mUserID = [GlobalConfig getUserID];
    mDetNo = [GlobalConfig getDetNo];
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetAllImgList:mUserID detno:mDetNo];
    
    mImgIndex = 0;
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
}

- (void) allImgListResult:(NSMutableArray *)statiList
{
    if( statiList == nil  || [statiList count] < 1 )
    {
        [SVProgressHUD dismissWithError:MSG_SERVICE_ERROR afterDelay:DEF_TOAST_DELAY_TIME];
        return;
    }
    
    mAllImgList = statiList;
    [self loadDetImgList];
    
    [SVProgressHUD dismiss];
}

- (void) loadDetImgList
{
    mImgCount = [mAllImgList count];
    NSInteger nOldCount = [GlobalConfig getAllImgListCount:mUserID withDetNo:mDetNo];
    
    if( mImgCount != nOldCount )
    {
        for(NSInteger i = 0; i < mImgCount; i ++)
        {
            [self downloadOneImage:i];
        }
    }
    else
    {
        for(NSInteger i = 0; i < mImgCount; i ++)
        {
            NSString* featurePath = [GlobalConfig getAllImgListPath:i withShopID:mUserID withDetNo:mDetNo];
            NSString* urlPath = [mAllImgList objectAtIndex:i];
            if( [featurePath compare:urlPath] != NSOrderedSame || IS_FILE_EXIST([GlobalConfig getLocalAllImgListPath:i withShopID:mUserID withDetNo:mDetNo]) == NO )
            {
                [self downloadOneImage:i];
            }
        }
    }
    
    [GlobalConfig setAllImgListCount:mImgCount withShopID:mUserID withDetNo:mDetNo];
    
    for(UIView* subView in [_scrollViewImgList subviews] )
        [subView removeFromSuperview];
    [_scrollViewImgList setBackgroundColor:[UIColor grayColor]];
    
    int nowX = 0;
    int itemWidth = _scrollViewImgList.frame.size.width;
    int itemHeight = _scrollViewImgList.frame.size.height;
    
    for(NSInteger i = 0; i < mImgCount; i ++)
    {
        CGRect itemRect = CGRectMake(nowX, 0, itemWidth, itemHeight);
        UIImageView* imagePicture = [[UIImageView alloc] initWithFrame:itemRect];
        [imagePicture setContentMode:UIViewContentModeScaleToFill];
        
        NSString* localPath = [GlobalConfig getLocalAllImgListPath:i withShopID:mUserID withDetNo:mDetNo];
        if( stringNotNilOrEmpty(localPath))
            imagePicture.image = [UIImage imageWithContentsOfFile:localPath];
        else
            imagePicture.image = [UIImage imageNamed:@"defbackimage.png"];
        
        nowX += itemWidth;
        [_scrollViewImgList addSubview:imagePicture];
    }
    
    [_scrollViewImgList setContentInset:UIEdgeInsetsMake(0, 0, itemHeight, nowX)];
    
    _pageCtrl.numberOfPages = mImgCount;
    _pageCtrl.currentPage = 0;
    _pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageCtrl.pageIndicatorTintColor = [UIColor grayColor];
}

- (void) downloadOneImage : (NSInteger) index
{
    NSString* imgPath = [mAllImgList objectAtIndex:index];
    
    // Get local download file path.
    NSString* localFilePath = [GlobalFunc downloadResource:imgPath localStore:DOWNLOAD_DIR_PATH];
    if( stringNotNilOrEmpty(localFilePath) )
    {
        // UIImage* image = [UIImage imageWithContentsOfFile:localFilePath];
        //[mLocalFeatureImgPathArr addObject:localFilePath];
        
        [GlobalConfig setAllImgListPath:imgPath withShopID:mUserID withDetNo:mDetNo withIndex:index];
        [GlobalConfig setLocalAllImgListPath:localFilePath withShopID:mUserID withDetNo:mDetNo withIndex:index];
    }
    else
    {
        // localFilePath = [BUNDLE pathForResource:@"defbackimage" ofType:@"png"];
        // UIImage* image = [UIImage imageNamed:@"defbackimage.png"];
        //[mLocalFeatureImgPathArr addObject:localFilePath];
        
        [GlobalConfig setAllImgListPath:@"" withShopID:mUserID withDetNo:mDetNo withIndex:index];
        [GlobalConfig setLocalAllImgListPath:@"" withShopID:mUserID withDetNo:mDetNo withIndex:index];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( scrollView == _scrollViewImgList )
    {
        int width = _scrollViewImgList.frame.size.width;
        float xPos = _scrollViewImgList.contentOffset.x;
        
        //Calculate the page we are on based on x coordinate position and width of scroll view
        mImgIndex = (int)xPos / width;
        if(mImgIndex >= mImgCount)
            mImgIndex = mImgCount - 1;
        if(mImgIndex < 0)
            mImgIndex = 0;
        
        _pageCtrl.currentPage = mImgIndex;
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
