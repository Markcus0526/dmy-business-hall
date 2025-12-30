//
//  CourtseyViewController.h
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourtseyViewController : SuperViewController<GeneralSvcDelegate>
{
    NSString*       mCourtesyPassword;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgCourtesyBack;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextView *txtCourtesyItem;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UIButton *btnCourtesyStart;

@property (weak, nonatomic) IBOutlet UITextField *txtInputPassword;
@property (weak, nonatomic) IBOutlet UIView *viewInputPassword;
@property (weak, nonatomic) IBOutlet UIImageView *imgTitleBar;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)onTapInput1:(id)sender;
- (IBAction)onTapInput2:(id)sender;
- (IBAction)onTapInput3:(id)sender;
- (IBAction)onTapInput4:(id)sender;
- (IBAction)onTapInput5:(id)sender;
- (IBAction)onTapInput6:(id)sender;
- (IBAction)onTapInput7:(id)sender;
- (IBAction)onTapInput8:(id)sender;
- (IBAction)onTapInput9:(id)sender;
- (IBAction)onTapInput0:(id)sender;
- (IBAction)onTapInputClearText:(id)sender;
- (IBAction)onTapInputInputOk:(id)sender;

- (IBAction)onTapSend:(id)sender;
- (IBAction)onTapCourtesyStart:(id)sender;
- (IBAction)onTapDismissDialog:(id)sender;
- (IBAction)onTapBack:(id)sender;

@end
