//
//  TagDetailViewController.m
//  YiDong
//
//  Created by Admin on 2/5/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "TagDetailViewController.h"

@interface TagDetailViewController ()

@end

@implementation TagDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // FIX ME
    // TEST CODE
    if( [GlobalConfig getTemplateID] == 2 )
    {
        [_btnBack setBackgroundImage:[UIImage imageNamed:@"backbutton_2.png"] forState:UIControlStateNormal];
    }
    
    NSString* detailImgPath = [GlobalConfig getDetailStatiImgPath];
    if( stringNotNilOrEmpty(detailImgPath) )
        _imgDetailTag.image = [UIImage imageWithContentsOfFile:detailImgPath];
    else
        _imgDetailTag.image = [UIImage imageNamed:@"defbackimage.png"];
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
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
