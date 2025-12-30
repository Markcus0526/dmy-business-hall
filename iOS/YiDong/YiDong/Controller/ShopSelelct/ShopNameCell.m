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
    UIFont* fontName = [UIFont systemFontOfSize:(ScreenWidth * (17 / 320.f))];
    [_lblShopName setFont:fontName];
    
    if( stringNotNilOrEmpty(str) )
        [_lblShopName setText:str];
    else
        [_lblShopName setText:@""];
}

@end
