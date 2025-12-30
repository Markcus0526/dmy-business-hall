//
//  ShopNameCell.h
//  YiDong
//
//  Created by Admin on 2/2/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblShopName;

- (void) setDispString:(NSString*) str;

@end
