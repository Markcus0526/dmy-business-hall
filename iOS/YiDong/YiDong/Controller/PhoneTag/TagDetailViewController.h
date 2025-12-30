//
//  TagDetailViewController.h
//  YiDong
//
//  Created by Admin on 2/5/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagDetailViewController : SuperViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgDetailTag;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)onTapBack:(id)sender;

@end
