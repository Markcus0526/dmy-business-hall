//
//  CourtseyViewController.m
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "CourtseyViewController.h"
#import "ServiceMethod.h"

@implementation CourtseyViewController

- (void) viewDidLoad
{
    // FIX ME
    // TEST CODE
    if( [GlobalConfig getTemplateID] == 2 )
    {
        _imgTitleBar.image = [UIImage imageNamed:@"titlebar_2.jpg"];
        [_btnBack setBackgroundImage:[UIImage imageNamed:@"backbutton_2.png"] forState:UIControlStateNormal];
    }
    
    [super viewDidLoad];
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    NSInteger uid = [GlobalConfig getUserID];
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetGiftList:uid macAddress:[GlobalFunc getDeviceMacAddress]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    float aspectFontSize = ScreenWidth * (12 / 320.f);
    // float aspectFontSize = _lblProvinceName.bounds.size.height;
    UIFont* aspectFont = [UIFont systemFontOfSize:aspectFontSize];
    [_txtCourtesyItem setFont:aspectFont];
    [_btnCourtesyStart.titleLabel setFont:aspectFont];
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
}

- (void) giftListResult:(STGiftList *)result withSvcResult:(NSInteger)svcResult
{
    [SVProgressHUD dismiss];
    
    if( svcResult != SVCERR_FAILURE )
    {
        if( result != nil )
        {
            NSString*   textRes = MSG_ONE_GIFT;
            
            // One gift
            if( stringNotNilOrEmpty(result.onegift) )
                textRes = [textRes stringByAppendingString:result.onegift];
            textRes = [textRes stringByAppendingString:@"\n"];
            
            // Two gift
            textRes = [textRes stringByAppendingString:MSG_TWO_GIFT];
            if( stringNotNilOrEmpty(result.twogift) )
                textRes = [textRes stringByAppendingString:result.twogift];
            textRes = [textRes stringByAppendingString:@"\n"];
            
            // Three gift
            textRes = [textRes stringByAppendingString:MSG_THREE_GIFT];
            if( stringNotNilOrEmpty(result.threegift) )
                textRes = [textRes stringByAppendingString:result.threegift];
            textRes = [textRes stringByAppendingString:@"\n"];
            
            // Four gift
            textRes = [textRes stringByAppendingString:MSG_FOUR_GIFT];
            if( stringNotNilOrEmpty(result.fourgift) )
                textRes = [textRes stringByAppendingString:result.fourgift];
            textRes = [textRes stringByAppendingString:@"\n"];
            
            // Five gift
            textRes = [textRes stringByAppendingString:MSG_FIVE_GIFT];
            if( stringNotNilOrEmpty(result.fivegift) )
                textRes = [textRes stringByAppendingString:result.fivegift];
            textRes = [textRes stringByAppendingString:@"\n"];
            
            // Six gift
            textRes = [textRes stringByAppendingString:MSG_SIX_GIFT];
            if( stringNotNilOrEmpty(result.sixgift) )
                textRes = [textRes stringByAppendingString:result.sixgift];
            
            _txtCourtesyItem.text = textRes;
            
            if( result.issued == 0 )
            {
                [_btnCourtesyStart setHidden:NO];
                [_btnSend setHidden:YES];
                [_txtPassword setHidden:YES];
            }
            else if ( result.issued == 1 )
            {
                [_btnCourtesyStart setHidden:YES];
                [_btnSend setHidden:NO];
                [_txtPassword setHidden:NO];
            }
            else
            {
                [_btnCourtesyStart setHidden:YES];
                [_btnSend setHidden:YES];
                [_txtPassword setHidden:YES];
            }
                
        }
        else
        {
            _txtCourtesyItem.text = @"";
            
            [_btnCourtesyStart setHidden:NO];
            [_btnSend setHidden:NO];
            [_txtPassword setHidden:NO];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:MSG_SERVICE_ERROR duration:DEF_TOAST_DELAY_TIME];
        return;
    }
}

- (IBAction)onTapSend:(id)sender {
    if( [_txtPassword.text length] < 1 )
    {
        [SVProgressHUD showErrorWithStatus:MSG_PLEASE_INPUT_PASSWORD duration:DEF_TOAST_DELAY_TIME];
        return;
    }
    
    // Hide keyboard.
    [self.view endEditing:YES];
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[[CommMgr getCommMgr] generalSvcMgr] GetReqGift:[GlobalConfig getUserID]
                                                 pwd:_txtPassword.text
                                          macAddress:[GlobalFunc getDeviceMacAddress]
                                              snCode:[GlobalConfig getSNCode]];
}

- (void) reqgiftResult:(NSInteger)result
{
    if( result == 0 )
    {
        [SVProgressHUD showSuccessWithStatus:MSG_GIFT_SUCCESS duration:DEF_TOAST_DELAY_TIME];
        
        [_btnCourtesyStart setHidden:YES];
        [_btnSend setHidden:YES];
        [_txtPassword setHidden:YES];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:MSG_GIFT_FAIL duration:DEF_TOAST_DELAY_TIME];
        
        [_btnCourtesyStart setHidden:NO];
        [_btnSend setHidden:YES];
        [_txtPassword setHidden:YES];
    }
}

- (IBAction)onTapCourtesyStart:(id)sender {
    [_viewInputPassword setHidden:NO];
    
    // Init input control of input dialog
    _txtInputPassword.text = @"";
}

- (IBAction)onTapDismissDialog:(id)sender {
    [_viewInputPassword setHidden:YES];
}

- (IBAction)onTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// Password Input Dialog
- (IBAction)onTapInput1:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"1"];
}
- (IBAction)onTapInput2:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"2"];
}
- (IBAction)onTapInput3:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"3"];
}
- (IBAction)onTapInput4:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"4"];
}
- (IBAction)onTapInput5:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"5"];
}
- (IBAction)onTapInput6:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"6"];
}
- (IBAction)onTapInput7:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"7"];
}
- (IBAction)onTapInput8:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"8"];
}
- (IBAction)onTapInput9:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"9"];
}
- (IBAction)onTapInput0:(id)sender
{
    _txtInputPassword.text = [_txtInputPassword.text stringByAppendingString:@"0"];
}
- (IBAction)onTapInputClearText:(id)sender
{
    _txtInputPassword.text = @"";
}
- (IBAction)onTapInputInputOk:(id)sender
{
    [_viewInputPassword setHidden:YES];
    
    mCourtesyPassword = _txtInputPassword.text;
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[[CommMgr getCommMgr] generalSvcMgr] CheckGiftPass:[GlobalConfig getUserID] pass:mCourtesyPassword];
}

- (void) checkGiftPassResult:(NSInteger)result withSvcResult:(NSInteger)svcResult
{
    if( svcResult == SVCERR_FAILURE )
    {
        [SVProgressHUD dismissWithError:MSG_SERVICE_ERROR afterDelay:DEF_TOAST_DELAY_TIME];
        return;
    }
    
    if( result < 0 )
    {
        [SVProgressHUD dismissWithError:MSG_PWD_NOMATCH afterDelay:DEF_TOAST_DELAY_TIME];
    }
    else if( result == 1 )
    {
        NSInteger nDegree = [GlobalFunc genRandFromInt : 6];
        double totalRotateAngle = (double)(3600 + 360 / (12 * 2) + (5-nDegree) * 60);
        
        // Set the animation's parameters
        [CATransaction begin];
        {
            CABasicAnimation* rotateAnim;
            rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            //rotateAnim.fromValue = 0;
            rotateAnim.toValue = [NSNumber numberWithFloat:[self angle2Radian:totalRotateAngle]];
            rotateAnim.duration = 10;
            rotateAnim.cumulative = YES;
            rotateAnim.repeatCount = 0;
            rotateAnim.autoreverses = YES;
            rotateAnim.fillMode = kCAFillModeForwards;
            rotateAnim.removedOnCompletion = NO;
            rotateAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            
            [CATransaction setCompletionBlock:^{

            }];
            
            [_imgCourtesyBack.layer addAnimation:rotateAnim forKey:@"quick_rotation"];
        }
        [CATransaction commit];
        
        // Connect Service to get SN Code.
        [[[CommMgr getCommMgr] generalSvcMgr] GetSNCode:[GlobalConfig getUserID] macAddress:[GlobalFunc getDeviceMacAddress]];
    }
    else
    {
        [SVProgressHUD dismissWithError:MSG_SERVICE_ERROR afterDelay:DEF_TOAST_DELAY_TIME];
    }
    
    [SVProgressHUD dismiss];
}

- (void) sncodeResult:(STSNCode *)result withSvcResult:(NSInteger)svcResult
{
    if( svcResult == SVCERR_SUCCESS )
    {
        [_imgCourtesyBack.layer removeAnimationForKey:@"quick_rotation"];
        
        if( result == nil )
        {
            [SVProgressHUD showErrorWithStatus:MSG_SERVICE_ERROR duration:DEF_TOAST_DELAY_TIME];
            return;
        }
        
        // FIX ME
        // TEST CODE
        // result.rank = 1;
        
        if( result.rank == -1 )
        {
            // Set the animation's parameters
            NSInteger nDegree = [GlobalFunc genRandFromInt : 6];
            double totalRotateAngle = (double)(1800 + 360 / (12 * 2) + (5-nDegree)*60);
            
            [CATransaction begin];
            {
                CABasicAnimation* rotateAnim;
                rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                rotateAnim.fromValue = 0;
                rotateAnim.toValue = [NSNumber numberWithFloat:[self angle2Radian:totalRotateAngle]];
                rotateAnim.duration = 5;
                rotateAnim.cumulative = YES;
                rotateAnim.repeatCount = 0;
                //rotateAnim.autoreverses = YES;
                rotateAnim.fillMode = kCAFillModeForwards;
                rotateAnim.removedOnCompletion = NO;
                rotateAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.3 :0.9 :0.7 :0.95];
                
                [CATransaction setCompletionBlock:^{

                }];
                
                [_imgCourtesyBack.layer addAnimation:rotateAnim forKey:@"quick_rotation1"];
            }
            [CATransaction commit];
        }
        else if( result.rank == -2 )
        {
            // Set the animation's parameters
            NSInteger nDegree = [GlobalFunc genRandFromInt : 6];
            double totalRotateAngle = (double)(1800 + 360 / (12 * 2) + (5-nDegree)*60);
            
            [CATransaction begin];
            {
                CABasicAnimation* rotateAnim;
                rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                rotateAnim.toValue = [NSNumber numberWithFloat:[self angle2Radian:totalRotateAngle]];
                rotateAnim.duration = 5;
                rotateAnim.cumulative = YES;
                rotateAnim.repeatCount = 0;
                //rotateAnim.autoreverses = YES;
                rotateAnim.fillMode = kCAFillModeForwards;
                rotateAnim.removedOnCompletion = NO;
                rotateAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.3 :0.9 :0.7 :0.95];
                
                [CATransaction setCompletionBlock:^{

                }];
                
                [_imgCourtesyBack.layer addAnimation:rotateAnim forKey:@"quick_rotation2"];
            }
            [CATransaction commit];
        }
        else
        {
            // Set the animation's parameter.
            double totalRotateAngle = (double)(1800 + 360 / (12 * 2) + (5-result.rank)*60+30);
            
            [CATransaction begin];
            {
                CABasicAnimation* rotateAnim;
                rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                rotateAnim.toValue = [NSNumber numberWithFloat:[self angle2Radian:totalRotateAngle]];
                rotateAnim.duration = 5;
                rotateAnim.cumulative = YES;
                rotateAnim.repeatCount = 0;
                //rotateAnim.autoreverses = YES;
                rotateAnim.fillMode = kCAFillModeForwards;
                rotateAnim.removedOnCompletion = NO;
                rotateAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.3 :0.9 :0.7 :0.95];
                
                [CATransaction setCompletionBlock:^{
                    [_txtPassword setHidden:NO];
                    [_btnSend setHidden:NO];
                    [_btnCourtesyStart setHidden:YES];
                }];
                
                [_imgCourtesyBack.layer addAnimation:rotateAnim forKey:@"quick_rotation3"];
            }
            [CATransaction commit];
        }
        
        [GlobalConfig setSNCode:result.snum];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:MSG_SERVICE_ERROR duration:DEF_TOAST_DELAY_TIME];
    }
}

- (double)angle2Radian:(double)fAngle
{
    return fAngle * M_PI / 180;
}
@end
