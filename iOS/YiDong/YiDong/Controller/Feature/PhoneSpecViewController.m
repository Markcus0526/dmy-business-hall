//
//  PhoneSpecViewController.m
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "PhoneSpecViewController.h"
#import "PhoneSpecTableCell.h"

@implementation PhoneSpecViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // FIX ME
    // TEST CODE
    if( [GlobalConfig getTemplateID] == 2 )
    {
        _imgTitleBar.image = [UIImage imageNamed:@"titlebar_2.jpg"];
        [_btnSpec1 setBackgroundImage:[UIImage imageNamed:@"brandbutton_2.png"] forState:UIControlStateNormal];
        [_btnSpec2 setBackgroundImage:[UIImage imageNamed:@"comparebackbutton_2.png"] forState:UIControlStateNormal];
        [_btnSpec3 setBackgroundImage:[UIImage imageNamed:@"kindbutton_2.png"] forState:UIControlStateNormal];
    }

    // Init table view.
    _tblViewPhoneSpec.delegate = self;
    _tblViewPhoneSpec.dataSource = self;
    _tblViewPhoneSpec.separatorColor = [UIColor blackColor];
    
    // Connect service to get same brand spec.
    mViewType = -1;
    [self svcGetSameBrandList];
}

- (void) idleTimerExceeded
{
    [super idleTimerExceeded];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self resetIdleTimer];
}

- (void) svcGetSameBrandList
{
    NSInteger uid = [GlobalConfig getUserID];
    NSInteger bndid = [GlobalConfig getBrandID];
    NSInteger specid = [GlobalConfig getSpecID];
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetSameBrandList:uid brandid:bndid specid:specid];
}

- (void) svcGetSameKindList
{
    NSInteger uid = [GlobalConfig getUserID];
    NSInteger bndid = [GlobalConfig getBrandID];
    NSInteger specid = [GlobalConfig getSpecID];
    
    SHOW_PLEASEWAINT_TOAST;
    TEST_NETWORK_RETURN;
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetSameKindList:uid brandid:bndid specid:specid];
}

// Table View Related Implementation.
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( mDeatilDataArr == nil )
        return 0;
    
    return [mDeatilDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"";
    UITableViewCell *cell = nil;
    NSInteger       rowIndex = indexPath.row;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if( mDeatilDataArr == nil || [mDeatilDataArr count] < 1 )
        return cell;
    
    cellIdentifier = @"PhoneSpecCell";
    PhoneSpecTableCell* phoneSpecCell = [_tblViewPhoneSpec dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = phoneSpecCell;
    
    if( rowIndex > [mDeatilDataArr count])
        return cell;
    
    STDetailInfo* info = [mDeatilDataArr objectAtIndex:rowIndex];
    [phoneSpecCell setSTDetailData:info];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( mDeatilDataArr == nil || [mDeatilDataArr count] < 1 )
        return;
    
    STDetailInfo* detInfo = [mDeatilDataArr objectAtIndex:indexPath.row];
    [GlobalConfig setDetNo:[detInfo uid]];
    
    // [self.navigationController performSegueWithIdentifier:@"segueDetImgList" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168;
}

- (void) samebrandListResult:(NSMutableArray *)result
{
    mDeatilDataArr = result;
     [_tblViewPhoneSpec reloadData];
    
    if( mViewType == -1 ) mViewType = 0;
    else if( mViewType == 0 ) mViewType = 1;
    else if( mViewType == 1 ) mViewType = 0;
    
    if( result == nil || [result count] < 1 )
    {
        [SVProgressHUD dismissWithError:MSG_NOEXIST_BNDSPC afterDelay:DEF_TOAST_DELAY_TIME];
        return;
    }
    
    [SVProgressHUD dismiss];
}

- (IBAction)onTapBackToFeature:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onTapSameBrand:(id)sender {
    if( mViewType == 1 ) // Current view is same Kind
    {
        [self svcGetSameBrandList];
    }
}

- (IBAction)onTapSameKind:(id)sender {
    if( mViewType == 0 ) // Current view is same Brand
    {
        [self svcGetSameKindList];
    }
    
}
@end
