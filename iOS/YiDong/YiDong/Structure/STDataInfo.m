//
//  STDataInfo.m
//  YiDong
//
//  Created by Admin on 2/2/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "STDataInfo.h"


@implementation STRegion

@synthesize uid;
@synthesize name;
@synthesize arrSubAreas;

+ (STRegion*) decodeFromJSON : (NSDictionary *) jsonObj key1 : (NSString*) key1 key2 : (NSString*) key2 key3 : (NSString*) key3
{
    STRegion*     objRet = [[STRegion alloc] init];
    
    objRet.uid = [[jsonObj objectForKey:key1] intValue];
    objRet.name = [jsonObj objectForKey:key2];
    objRet.arrSubAreas = nil;
    
    id keyAttValue = [jsonObj objectForKey:key3];
    
    NSMutableArray* subAreas = nil;
    
    if( [keyAttValue isKindOfClass:[NSArray class]] )
        subAreas = (NSMutableArray*)keyAttValue;
    else
    {
        return objRet;
    }
    
    if( [subAreas count] > 0 )
    {
        objRet.arrSubAreas = [[NSMutableArray alloc] init];
    
        for(NSDictionary* area in subAreas)
        {
            STRegion*     obj = [STRegion decodeFromJSON:area key1:key1 key2:key2 key3:key3];
            [objRet.arrSubAreas addObject:obj];
        }
    }
    
    return objRet;
}

@end

@implementation STShop

@synthesize uid;
@synthesize regionid;
@synthesize shopname;

+ (STShop*) decodeFromJSON:(NSDictionary *)jsonObj key1:(NSString *)key1 key2:(NSString *)key2 key3:(NSString *)key3
{
    STShop*     objRet = [[STShop alloc] init];
    
    objRet.uid = [[jsonObj objectForKey:key1] intValue];
    objRet.regionid = [[jsonObj objectForKey:key2] intValue];
    objRet.shopname = [jsonObj objectForKey:key3];
    
    return objRet;
}

@end

@implementation STBndSpcID

@synthesize brandID;
@synthesize specID;
@synthesize title;

@end

@implementation STDetailInfo

@synthesize uid;
@synthesize imgPath;
@synthesize name;
@synthesize price;
@synthesize cpu;
@synthesize dispsize;
@synthesize pixcnt;
@synthesize osver;
@synthesize memsize;

@end

@implementation STGiftList

@synthesize onegift;
@synthesize twogift;
@synthesize threegift;
@synthesize fourgift;
@synthesize fivegift;
@synthesize sixgift;
@synthesize pass;
@synthesize issued;

@end

@implementation STSNCode

@synthesize rank;
@synthesize snum;

@end
