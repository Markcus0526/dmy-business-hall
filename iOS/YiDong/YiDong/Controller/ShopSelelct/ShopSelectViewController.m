//
//  ShopSelectViewController.m
//  YiDong
//
//  Created by Admin on 2/2/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "ShopSelectViewController.h"
#import "ShopNameCell.h"
#import "CommMgr.h"
#import "SVProgressHUD.h"

@implementation ShopSelectViewController

- (IBAction)onTapProvince:(id)sender {
    
    mCurSelType = 0;
    
    [_mTblShopView reloadData];
    [_mViewShopList setHidden:NO];
}

- (IBAction)onTapCity:(id)sender {
    
    mCurSelType = 1;
    
    [_mTblShopView reloadData];
    [_mViewShopList setHidden:NO];
}

- (IBAction)onTapDistrict:(id)sender {
    
    mCurSelType = 2;
    
    [_mTblShopView reloadData];
    [_mViewShopList setHidden:NO];
}

- (IBAction)onTapShop:(id)sender {
    
    mCurSelType = 3;
    
    [_mTblShopView reloadData];
    [_mViewShopList setHidden:YES];
}

- (IBAction)onTapOK:(id)sender
{
    [_mViewShopList setHidden:YES];
    
    // Submit current shop info to service.
    NSString* shopID = [NSString stringWithFormat:@"%d", mCurShopID];
    
    NSString* devBrand = [GlobalFunc getDeviceType];
    NSString* devModel = [GlobalFunc getDeviceModel];
    
    CGRect scrSize = [[UIScreen mainScreen] bounds];
    NSString* scrWidth = [NSString stringWithFormat:@"%d", (NSInteger) scrSize.size.width];
    NSString* scrHeight = [NSString stringWithFormat:@"%d", (NSInteger) scrSize.size.height];
    
    
    
    // Show Please wait toast.
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetBndSpec:shopID brand:devBrand spec:devModel scrwidth:scrWidth scrhei:scrHeight];
}

- (IBAction)onTapCancel:(id)sender {
    [_mViewShopList setHidden:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Adjust font.
    float aspectFontSize = ScreenWidth * (17 / 320.f);
    // float aspectFontSize = _lblProvinceName.bounds.size.height;
    UIFont* aspectFont = [UIFont systemFontOfSize:aspectFontSize];
    
    [_lblProvinceName setFont : aspectFont];
    [_lblCityName setFont : aspectFont];
    [_lblDistrictName setFont : aspectFont];
    [_lblShopName setFont : aspectFont];
    
    [_lblProvinceCaption setFont : aspectFont];
    [_lblCityCaption setFont : aspectFont];
    [_lblDistrictCaption setFont : aspectFont];
    [_lblShopCaption setFont : aspectFont];
    [_btnSelectOK.titleLabel setFont : aspectFont];
    
    // CGSize  btnSize = _btnSelectOK.bounds.size;
    
//    if( [[GlobalFunc getDeviceType] containsString:@"iPad"] )
//    {
//        CGRect  newBounds = CGRectMake(0, 0, ScreenWidth * (132 / 320.f), ScreenHeight * (68 / 568.f));
//        [_btnSelectOK setBounds:newBounds];
//    }
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Init table view.
    _mTblShopView.delegate = self;
    _mTblShopView.dataSource = self;
    _mTblShopView.separatorColor = [UIColor blackColor];
    
    // Init region && shop
    mCurRegionID = 0;
    mCurShopID = 0;
    
    mCurSelType = 0;
    mCurProv = nil;
    mCurCity = nil;
    mCurDistrict = nil;
    
    // Init Controls.
    _lblProvinceName.text = @"";
    _lblCityName.text = @"";
    _lblDistrictName.text = @"";
    _lblShopName.text = @"";
    
    // Show Please wait toast.
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetShopList];
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( [mArrRegions count] < 1 || [mArrShops count] < 1 )
        return 0;
    
    if( mCurSelType == 0 ) // Province
    {
        return [mArrRegions count];
    }
    else if( mCurSelType == 1 ) // City
    {
        if( mCurProv == nil|| mCurProv.arrSubAreas == nil )
            return 0;
        return [mCurProv.arrSubAreas count];
    }
    else if( mCurSelType == 2 ) // District
    {
        if( mCurCity == nil || mCurCity.arrSubAreas == nil )
            return 0;
        return [mCurCity.arrSubAreas count];
    }
    else if( mCurSelType == 3 ) // Shop
    {
        if( mArrShops == nil )
            return 0;
        
        NSInteger   nCount = 0;
        for(STShop* oneShop in mArrShops)
        {
            if( oneShop.regionid == mCurRegionID )
                nCount ++;
        }
        
        return nCount;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight * (40 / 568.f);
}

- (STShop*) GetShopInfoFromIndex : (NSInteger) index
{
    STShop* retShop = nil;
    if( [mArrShops count] < 1 || [mArrRegions count] < 1 )
        return retShop;
    
    for(STShop* oneShop in mArrShops)
    {
        if( oneShop.regionid == mCurRegionID )
            retShop = oneShop;
    }

    return retShop;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"";
    UITableViewCell *cell = nil;
    NSInteger   rowIndex = indexPath.row;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if([mArrRegions count] < 1 || [mArrShops count] < 1)
        return cell;

    cellIdentifier = @"ShopCell";
    ShopNameCell* nameCell = [_mTblShopView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = nameCell;

    NSString*   dispString = @"";
    if( mCurSelType == 0 ) // Province
    {
        if( rowIndex >= [mArrRegions count] )
            return cell;
        
        STRegion* region = [mArrRegions objectAtIndex:rowIndex];
        dispString = region.name;
    }
    else if( mCurSelType == 1 ) // City
    {
        if( mCurProv != nil && mCurProv.arrSubAreas != nil )
        {
            STRegion* region = [mCurProv.arrSubAreas objectAtIndex:rowIndex];
            dispString = region.name;
        }
        else
            return cell;
    }
    else if( mCurSelType == 2 ) // District
    {
        if( mCurCity != nil && mCurCity.arrSubAreas != nil )
        {
            STRegion* region = [mCurCity.arrSubAreas objectAtIndex:rowIndex];
            dispString = region.name;
        }
        else
            return cell;
    }
    else if( mCurSelType == 3 ) // Shop
    {
        if( mArrShops == nil )
            return cell;
        
        STShop* shop = [self GetShopInfoFromIndex:rowIndex];
        if( shop != nil )
            dispString = shop.shopname;
        else
            return cell;
    }
    
    [nameCell setDispString:dispString];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowIndex = indexPath.row;
    
    if( mCurSelType == 0 )
    {
        STRegion* curRegion = [mArrRegions objectAtIndex:rowIndex];
        mCurProv = curRegion;
        
        NSArray* arrDefaultCities = mCurProv.arrSubAreas;
        if (arrDefaultCities != nil && [arrDefaultCities count] > 0 )
        {
            mCurCity = [arrDefaultCities objectAtIndex:0];
            NSArray* arrDefaultAreas = mCurCity.arrSubAreas;
            if (arrDefaultAreas != nil && [arrDefaultAreas count] > 0 )
            {
                mCurDistrict = [arrDefaultAreas objectAtIndex:0];
                
                _lblProvinceName.text = mCurProv.name;
                _lblCityName.text = mCurCity.name;
                _lblDistrictName.text = mCurDistrict.name;
                
                mCurRegionID = mCurDistrict.uid;
                [self SetShopFromRegionID];
                
            }
            else
            {
                _lblProvinceName.text = mCurProv.name;
                _lblCityName.text = mCurCity.name;
                _lblDistrictName.text = @"";
                mCurRegionID = mCurCity.uid;
                
                [self SetShopFromRegionID];
            }
        }
        else
        {
            _lblProvinceName.text = mCurProv.name;
            _lblCityName.text = @"";
            _lblDistrictName.text = @"";
            mCurRegionID = mCurProv.uid;
            
            [self SetShopFromRegionID];
        }
    }
    else if( mCurSelType == 1 )
    {
        STRegion* curCity = [mCurProv.arrSubAreas objectAtIndex:rowIndex];
        mCurCity = curCity;
        
        NSArray* arrDefaultAreas = mCurCity.arrSubAreas;
        if (arrDefaultAreas != nil && [arrDefaultAreas count] > 0 )
        {
            mCurDistrict = [arrDefaultAreas objectAtIndex:0];
            
            _lblProvinceName.text = mCurProv.name;
            _lblCityName.text = mCurCity.name;
            _lblDistrictName.text = mCurDistrict.name;
            
            mCurRegionID = mCurDistrict.uid;
            [self SetShopFromRegionID];
            
        }
        else
        {
            _lblProvinceName.text = mCurProv.name;
            _lblCityName.text = mCurCity.name;
            _lblDistrictName.text = @"";
            mCurRegionID = mCurCity.uid;
            
            [self SetShopFromRegionID];
        }
    }
    else if( mCurSelType == 2 )
    {
        STRegion* curDistrict = [mCurCity.arrSubAreas objectAtIndex:rowIndex];
        mCurDistrict = curDistrict;
        
        _lblProvinceName.text = mCurProv.name;
        _lblCityName.text = mCurCity.name;
        _lblDistrictName.text = mCurDistrict.name;
        
        mCurRegionID = mCurDistrict.uid;
        [self SetShopFromRegionID];

    }
    else if( mCurSelType == 3 )
    {
        STShop* shop = [self GetShopInfoFromIndex:rowIndex];
        
        if( shop == nil || stringNotNilOrEmpty(shop.shopname) )
        {
            _lblShopName.text = shop.shopname;
            mCurShopID = shop.uid;
        }
        else
        {
            _lblShopName.text = @"";
            mCurShopID = 0;
        }
    }
    
    [_mViewShopList setHidden:YES];
}

- (void) SetShopFromRegionID
{
    if( [mArrShops count] < 1 || [mArrRegions count] < 1 )
        return ;
    
    NSInteger i;
    for(i = 0; i < [mArrShops count]; i ++)
    {
        STShop* shop = [mArrShops objectAtIndex:i];
        if( shop.regionid == mCurRegionID )
            break;
    }
    
    if( i < [mArrShops count] )
    {
        STShop* shop = [mArrShops objectAtIndex:i];
        _lblShopName.text = shop.shopname;
        
        mCurShopID = shop.uid;
    }
    else
    {
        _lblShopName.text = @"";
        mCurShopID = 0;
    }
}

- (void) shopListResult:(NSMutableArray *)regions shops:(NSMutableArray *)shops
{
    if( regions == nil || [[regions description] compare:@"<null>"] == NSOrderedSame || [regions count] <= 0 ||
        shops == nil || [[shops description] compare:@"<null>"] == NSOrderedSame || [shops count] <= 0 )
    {
        [SVProgressHUD dismissWithError:MSG_NETWORK_ERROR afterDelay:DEF_TOAST_DELAY_TIME];
        return;
    }
    
    [_btnSelectOK setEnabled:TRUE];
    
    mArrRegions = regions;
    mArrShops = shops;
    
    mCurProv = [mArrRegions objectAtIndex:0];
    NSArray* arrDefaultCities = mCurProv.arrSubAreas;
    if (arrDefaultCities != nil && [arrDefaultCities count] > 0 )
    {
        mCurCity = [arrDefaultCities objectAtIndex:0];
        NSArray* arrDefaultAreas = mCurCity.arrSubAreas;
        if (arrDefaultAreas != nil && [arrDefaultAreas count] > 0 )
        {
            mCurDistrict = [arrDefaultAreas objectAtIndex:0];
            
            _lblProvinceName.text = mCurProv.name;
            _lblCityName.text = mCurCity.name;
            _lblDistrictName.text = mCurDistrict.name;
            
            mCurRegionID = mCurDistrict.uid;
            [self SetShopFromRegionID];
                
        }
        else
        {
            _lblProvinceName.text = mCurProv.name;
            _lblCityName.text = mCurCity.name;
            _lblDistrictName.text = @"";
            mCurRegionID = mCurCity.uid;
            
            [self SetShopFromRegionID];
        }
    }
    else
    {
        _lblProvinceName.text = mCurProv.name;
        _lblCityName.text = @"";
        _lblDistrictName.text = @"";
        mCurRegionID = mCurProv.uid;
        
        [self SetShopFromRegionID];
    }
    
    [_mTblShopView reloadData];
    [SVProgressHUD dismiss];
}

- (void) bndSpecResult:(STBndSpcID *)result
{
    [SVProgressHUD dismiss];
    
    if( result == nil || result.brandID == 0 || result.specID == 0 )
    {
        return;
    }
    
    // Save current login info to GlobalConfig.
    [GlobalConfig setFirstLogin];
    [GlobalConfig setUserID:mCurShopID];
    [GlobalConfig setBrandID:result.brandID];
    [GlobalConfig setSpecID:result.specID];
    [GlobalConfig setCompanyName:result.title];
    
    // FIX ME
    // go to main video view controller
    [self performSegueWithIdentifier:@"segueLoginToMain" sender:self];
}

@end
