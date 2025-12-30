//
//  FeatureViewController.h
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureViewController : SuperViewController<GeneralSvcDelegate, UIScrollViewDelegate>
{
    NSMutableArray*     mFeatureImgPathArr;
    NSInteger           mFeatureIndex;
    NSInteger           mFeatureImgCount;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewFeatures;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrlFeature;
@property (weak, nonatomic) IBOutlet UIImageView *imgTitleBar;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoneSpec;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)onTapBack:(id)sender;

@end
