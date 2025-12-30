//
//  STDataInfo.h
//  YiDong
//
//  Created by Admin on 2/2/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRegion : NSObject
{
    NSUInteger              uid;
    NSString*               name;
    NSMutableArray*         arrSubAreas;
}

@property (nonatomic, readwrite)    NSUInteger         uid;
@property (nonatomic, retain)       NSString*          name;
@property (nonatomic, retain)       NSMutableArray*    arrSubAreas;


+ (STRegion*) decodeFromJSON : (NSDictionary *) jsonObj key1 : (NSString*) key1 key2 : (NSString*) key2 key3 : (NSString*) key3;

@end

@interface STShop : NSObject
{
    NSUInteger              uid;
    NSUInteger              regionid;
    NSString*               shopname;
}

@property (nonatomic, readwrite)    NSUInteger         uid;
@property (nonatomic, readwrite)    NSUInteger         regionid;
@property (nonatomic, retain)       NSString*          shopname;

+ (STShop*) decodeFromJSON : (NSDictionary *) jsonObj key1 : (NSString*) key1 key2 : (NSString*) key2 key3 : (NSString*) key3;

@end

@interface STBndSpcID : NSObject
{
    NSInteger           brandID;
    NSInteger           specID;
    NSString*           title;
}

@property (nonatomic, readwrite)    NSInteger         brandID;
@property (nonatomic, readwrite)    NSInteger         specID;
@property (nonatomic, retain)       NSString*         title;

@end

@interface STDetailInfo : NSObject
{
    NSInteger       uid;
    NSString*       imgPath;
    NSString*       name;
    double          price;
    NSString*       cpu;
    NSString*       dispsize;
    NSString*       pixcnt;
    NSString*       osver;
    NSString*       memsize;
}

@property (nonatomic, readwrite)    NSInteger       uid;
@property (nonatomic, retain)       NSString*       imgPath;
@property (nonatomic, retain)       NSString*       name;
@property (nonatomic, readwrite)    double          price;
@property (nonatomic, retain)       NSString*       cpu;
@property (nonatomic, retain)       NSString*       dispsize;
@property (nonatomic, retain)       NSString*       pixcnt;
@property (nonatomic, retain)       NSString*       osver;
@property (nonatomic, retain)       NSString*       memsize;

@end

@interface STGiftList : NSObject
{
    NSString*       onegift;
    NSString*       twogift;
    NSString*       threegift;
    NSString*       fourgift;
    NSString*       fivegift;
    NSString*       sixgift;
    NSString*       pass;
    NSInteger       issued;
}

@property (nonatomic, retain)       NSString*       onegift;
@property (nonatomic, retain)       NSString*       twogift;
@property (nonatomic, retain)       NSString*       threegift;
@property (nonatomic, retain)       NSString*       fourgift;
@property (nonatomic, retain)       NSString*       fivegift;
@property (nonatomic, retain)       NSString*       sixgift;
@property (nonatomic, retain)       NSString*       pass;
@property (nonatomic, readwrite)    NSInteger       issued;

@end

@interface STSNCode : NSObject
{
    NSInteger       rank;
    NSString*       snum;
}

@property (nonatomic, readwrite)    NSInteger       rank;
@property (nonatomic, retain)       NSString*       snum;

@end
