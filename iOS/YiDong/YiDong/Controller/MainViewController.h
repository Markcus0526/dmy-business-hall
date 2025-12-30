//
//  MainViewController.h
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface MainViewController : UIViewController
@interface MainViewController : SuperViewController<GeneralSvcDelegate>
{
    NSTimer     *CourtseyAnimTimer;
    
    double      dblCourtseyAngle;
    NSInteger   nCompanyLabelPosX;
    
    NSString*   strCompanyName;
    
    CGSize      realTextSize;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgCourtsey;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
// @property (strong, nonatomic) NSString* strCompanyName;
@property (weak, nonatomic) IBOutlet UIImageView *imgTitleBar;
@property (weak, nonatomic) IBOutlet UIButton *btnFeature;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoneTag;
@property (weak, nonatomic) IBOutlet UIButton *btnExit;
@property (weak, nonatomic) IBOutlet UIImageView *imgFirstPage;
@property (weak, nonatomic) IBOutlet UIView *viewCompanyName;

- (IBAction)onTapFeatureTouch:(id)sender;
- (IBAction)onTapTagTouch:(id)sender;
- (IBAction)onTapExitTouch:(id)sender;

- (void) TimerProc;
- (void) StartAnimTimer;
- (void) StopAnimTimer;

@end
