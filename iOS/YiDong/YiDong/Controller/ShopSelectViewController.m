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
    [_mViewShopList setHidden:NO];
}

- (IBAction)onTapCity:(id)sender {
    [_mViewShopList setHidden:NO];
}

- (IBAction)onTapDistrict:(id)sender {
    [_mViewShopList setHidden:NO];
}

- (IBAction)onTapShop:(id)sender {
    [_mViewShopList setHidden:YES];
}

- (IBAction)onTapOK:(id)sender
{
    [_mViewShopList setHidden:YES];
}

- (IBAction)onTapCancel:(id)sender {
    [_mViewShopList setHidden:YES];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Init table view.
    _mTblShopView.delegate = self;
    _mTblShopView.dataSource = self;
    _mTblShopView.separatorColor = [UIColor blackColor];
    
    BACKGROUND_TEST_NETWORK_RETURN;
    
    // [SVProgressHUD showWithStatus:MSG_PLEASE_WAIT maskType:SVProgressHUDMaskTypeClear];
    
    [[CommMgr getCommMgr] generalSvcMgr].delegate = self;
    [[[CommMgr getCommMgr] generalSvcMgr] GetShopList];
    
    // Test Data.
    mArrDisp = [[NSMutableArray alloc] init];
    [mArrDisp addObject:@"Beijing"];
    [mArrDisp addObject:@"Hangzhou"];
    [mArrDisp addObject:@"Hangzhou"];
    [mArrDisp addObject:@"Hangzhou"];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([mArrDisp count] <= 0)
        return 0;
    
    //if(bDataNomore)
        return mArrDisp.count;
    //else
    //    return arrNews.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
//    if(indexPath.row >= mArrDisp.count)
//        return 44;
//    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"";
    UITableViewCell *cell = nil;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if([mArrDisp count] <= 0)
        return cell;

    cellIdentifier = @"ShopCell";
    ShopNameCell* nameCell = [_mTblShopView dequeueReusableCellWithIdentifier:cellIdentifier];
    [nameCell setDispString:[mArrDisp objectAtIndex:indexPath.row]];

    //[cell initData]
    
//    if(indexPath.row == mArrDisp.count)
//    {
//        cellIdentifier = @"footer_cell";
//        FooterCell *footerCell = (FooterCell*)[tvNews dequeueReusableCellWithIdentifier:cellIdentifier];
//        cell = footerCell;
//    }
//    else
//    {
//        cellIdentifier = @"news_cell";
//        NewsCell *newsCell = (NewsCell*)[tvNews dequeueReusableCellWithIdentifier:cellIdentifier];
//        [newsCell initData:[arrNews objectAtIndex:indexPath.row] parent:self];
//        cell = newsCell;
//    }
    
    return nameCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([mArrDisp count] <= 0)
        return;
    
    int index = indexPath.row;
    
//    if(index >= mArrDisp.count)
//    {
//        [self footerRefreshing];
//    }
//    else
//    {
//        STNewsInfo *newsInfo = [mArrDisp objectAtIndex:index];
//        
//        NewsContentVC * vcNewsContent = (NewsContentVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"newscontent"];
//        vcNewsContent.hidesBottomBarWhenPushed =YES;
//        vcNewsContent.nid = newsInfo.nid;
//        vcNewsContent.arrNews = arrNews;
//        [self.navigationController pushViewController:vcNewsContent animated:YES];
//    }
    
    NSString* selName = [mArrDisp objectAtIndex:index];
    NSLog(@"selected name = '%@'", selName);
    
    [_mViewShopList setHidden:YES];
}

@end
