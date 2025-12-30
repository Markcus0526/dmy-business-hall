//
//  ShopSelectViewController.h
//  YiDong
//
//  Created by Admin on 2/2/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STDataInfo.h"

@interface ShopSelectViewController : SuperViewController<GeneralSvcDelegate,UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>
{
    NSMutableArray*    mArrRegions;
    NSMutableArray*    mArrShops;
    
    STRegion*          mCurProv;
    STRegion*          mCurCity;
    STRegion*           mCurDistrict;
    
    NSInteger           mCurRegionID;
    NSInteger           mCurShopID;
    
    NSInteger           mCurSelType; // 0 = Province, 1 = City, 2 = District, 3 = Shop
}

@property (weak, nonatomic) IBOutlet UIView *mViewShopList;
@property (weak, nonatomic) IBOutlet UITableView *mTblShopView;
@property (weak, nonatomic) IBOutlet UILabel *lblProvinceName;
@property (weak, nonatomic) IBOutlet UILabel *lblCityName;
@property (weak, nonatomic) IBOutlet UILabel *lblDistrictName;
@property (weak, nonatomic) IBOutlet UILabel *lblShopName;

@property (weak, nonatomic) IBOutlet UILabel *lblProvinceCaption;
@property (weak, nonatomic) IBOutlet UILabel *lblCityCaption;
@property (weak, nonatomic) IBOutlet UILabel *lblDistrictCaption;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectOK;
@property (weak, nonatomic) IBOutlet UILabel *lblShopCaption;
- (IBAction)onTapProvince:(id)sender;
- (IBAction)onTapCity:(id)sender;
- (IBAction)onTapDistrict:(id)sender;
- (IBAction)onTapShop:(id)sender;
- (IBAction)onTapOK:(id)sender;
- (IBAction)onTapCancel:(id)sender;

@end
