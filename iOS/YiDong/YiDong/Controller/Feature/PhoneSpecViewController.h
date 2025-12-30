//
//  PhoneSpecViewController.h
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneSpecViewController : SuperViewController<GeneralSvcDelegate,UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>
{
    NSMutableArray*     mDeatilDataArr;
    NSInteger           mViewType; // 0 = Same Brand List 1 = Same Kind List
}
@property (weak, nonatomic) IBOutlet UITableView *tblViewPhoneSpec;
@property (weak, nonatomic) IBOutlet UIImageView *imgTitleBar;
@property (weak, nonatomic) IBOutlet UIButton *btnSpec1;
@property (weak, nonatomic) IBOutlet UIButton *btnSpec3;
@property (weak, nonatomic) IBOutlet UIButton *btnSpec2;
- (IBAction)onTapBackToFeature:(id)sender;
- (IBAction)onTapSameBrand:(id)sender;
- (IBAction)onTapSameKind:(id)sender;

@end
