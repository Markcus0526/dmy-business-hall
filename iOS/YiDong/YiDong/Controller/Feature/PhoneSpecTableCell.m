//
//  PhoneSpecTableCell.m
//  YiDong
//
//  Created by Admin on 2/4/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "PhoneSpecTableCell.h"

@implementation PhoneSpecTableCell

- (void) setSTDetailData:(STDetailInfo *)info
{
    [_imgPhoneSpec setImageWithURL:[NSURL URLWithString:info.imgPath] placeholderImage:[UIImage imageNamed:@"defphone.png"]];
    
    if( stringNotNilOrEmpty(info.name) )
       [_lblPhoneSpec_Name setTitle:info.name forState:UIControlStateNormal];
    else
        [_lblPhoneSpec_Name setTitle:MSG_NOCONTENT forState:UIControlStateNormal];
    
    NSString*   price = nil;
    if( info.price == (NSInteger)info.price )
        price = [NSString stringWithFormat:@"%.0f", info.price];
    else
        price = [NSString stringWithFormat:@"%.2f", info.price];

    _lblPhone_CoastVal.text = price;
    
    if( stringNotNilOrEmpty(info.dispsize) && stringNotNilOrEmpty(info.name) )
        _lblPhone_SizeVal.text = info.dispsize;
    else
        _lblPhone_SizeVal.text = MSG_NOCONTENT;
    
    if( stringNotNilOrEmpty(info.cpu) && stringNotNilOrEmpty(info.name) )
        _lblPhone_CpuVal.text = info.cpu;
    else
        _lblPhone_CpuVal.text = MSG_NOCONTENT;
    
    if( stringNotNilOrEmpty(info.memsize) && stringNotNilOrEmpty(info.name) )
        _lblPhone_MemVal.text = info.memsize;
    else
        _lblPhone_MemVal.text = MSG_NOCONTENT;
    
    if( stringNotNilOrEmpty(info.pixcnt) && stringNotNilOrEmpty(info.name) )
        _lblPhoen_CameraVal.text = info.pixcnt;
    else
        _lblPhoen_CameraVal.text = MSG_NOCONTENT;
    
    if( stringNotNilOrEmpty(info.osver) && stringNotNilOrEmpty(info.name) )
        _lblPhone_OSVal.text = info.osver;
    else
        _lblPhone_OSVal.text = MSG_NOCONTENT;
}

@end
