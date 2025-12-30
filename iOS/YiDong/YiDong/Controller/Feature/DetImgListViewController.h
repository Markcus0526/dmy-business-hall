//
//  DetImgListViewController.h
//  YiDong
//
//  Created by Admin on 2/6/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetImgListViewController : SuperViewController<GeneralSvcDelegate, UIScrollViewDelegate>
{
    NSInteger           mImgIndex, mImgCount;
    NSMutableArray*     mAllImgList;
    
    NSInteger           mUserID, mDetNo;
}
@property (weak, nonatomic) IBOutlet UIScrollView*scrollViewImgList;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
- (IBAction)onTapBack:(id)sender;

@end
