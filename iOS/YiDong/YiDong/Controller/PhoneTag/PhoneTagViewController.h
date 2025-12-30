//
//  PhoneTagViewController.h
//  YiDong
//
//  Created by Admin on 2/5/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneTagViewController : SuperViewController<GeneralSvcDelegate, UIScrollViewDelegate>
{
    NSMutableArray*     mStatiImgPathList;
    
    NSInteger           mStatiImgIndex;
    NSInteger           mStatiImgCount;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewPhoneTag;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrlPhoneTag;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)onTapBack:(id)sender;

@end
