//
//  ShopSelectViewController.h
//  YiDong
//
//  Created by Admin on 2/2/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopSelectViewController : SuperViewController<GeneralSvcDelegate,UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>
{
    NSMutableArray*    mArrDisp;
}

@property (weak, nonatomic) IBOutlet UIView *mViewShopList;
@property (weak, nonatomic) IBOutlet UITableView *mTblShopView;
- (IBAction)onTapProvince:(id)sender;
- (IBAction)onTapCity:(id)sender;
- (IBAction)onTapDistrict:(id)sender;
- (IBAction)onTapShop:(id)sender;
- (IBAction)onTapOK:(id)sender;
- (IBAction)onTapCancel:(id)sender;

@end
