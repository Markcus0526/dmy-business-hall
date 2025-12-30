//
//  ShopNameCell.m
//  YiDong
//
//  Created by Admin on 2/2/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "ShopNameCell.h"

@implementation ShopNameCell

- (void) setDispString:(NSString *)str
{
    NSString* aStr = [NSString stringWithString:str];
    [_lblShopName setText:aStr];
}

@end
