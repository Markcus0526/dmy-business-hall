//
//  PhoneSpecTableCell.h
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneSpecTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoneSpec;
@property (weak, nonatomic) IBOutlet UIButton *lblPhoneSpec_Name;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone_CoastVal;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone_SizeVal;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone_CpuVal;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone_MemVal;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoen_CameraVal;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone_OSVal;

- (void) setSTDetailData : (STDetailInfo*) info;

@end
