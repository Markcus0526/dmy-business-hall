//
//  Config.m
//  YiDong
//
//  Created by Admin on 2/3/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import "Config.h"

#define CONFIG_KEY_FIRSLOGIN                    @"FirstLogin"
#define CONFIG_KEY_USERID                       @"UserID"
#define CONFIG_KEY_BRANDID                      @"BrandID"
#define CONFIG_KEY_SPECID                       @"SpecID"
#define CONFIG_KEY_COMPANYNAME                  @"CompanyName"
#define CONFIG_KEY_TEMPID                       @"TempID"
#define CONFIG_KEY_SNCODE                       @"SNCode"
#define CONFIG_KEY_VIDEOPATH                    @"VideoPath"
#define CONFIG_KEY_LOCALVIDEOPATH               @"LocalVideoPath"
#define CONFIG_KEY_SPLASHIMG                    @"SplashImg"
#define CONFIG_KEY_LOCALSPLASHIMG               @"LocalSplashImg"
#define CONFIG_KEY_FIRSTPAGEIMG                 @"FirstPageImg"
#define CONFIG_KEY_LOCALFIRSTPAGEIMG            @"LocalFirstPageImg"
#define CONFIG_KEY_MAINMENUIMG                  @"MainMenuImg"
#define CONFIG_KEY_LOCALMAINMENUIMG             @"LocalMainMenuImg"
#define CONFIG_KEY_FEATUREIMGCOUNT              @"FeatureImgCount"
#define CONFIG_KEY_FEATUREIMG                   @"FeatureImg"
#define CONFIG_KEY_LOCALFEATUREIMG              @"LocalFeatureImg"
#define CONFIG_KEY_STATIIMGCOUNT                @"StatiImgCount"
#define CONFIG_KEY_STATIIMG                     @"StatiImg"
#define CONFIG_KEY_LOCALSTATIIMG                @"LocalStatiImg"

#define CONFIG_KEY_DETAIL_TEMP_IMG              @"TempStatiImg"
#define CONFIG_KEY_DETNO                        @"DetNo"

#define CONFIG_KEY_ALLIMGLIST                   @"AllImgList"

#define CONFIG_KEY_SNCODE                       @"SNCode"

@implementation GlobalConfig

+ (void) setFirstLogin
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:CONFIG_KEY_FIRSLOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL) getFirstLogin
{
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_FIRSLOGIN];
    if( stringNotNilOrEmpty(value) )
        return NO;
    return YES;
}

+ (void) setUserID : (NSInteger) userid
{
    NSString* strUserID = [NSString stringWithFormat:@"%d", userid];
    
    [[NSUserDefaults standardUserDefaults] setObject:strUserID forKey:CONFIG_KEY_USERID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger) getUserID
{
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_USERID];
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setTemplateID : (NSInteger) templateid
{
    NSString* strUserID = [NSString stringWithFormat:@"%d", templateid];
    
    [[NSUserDefaults standardUserDefaults] setObject:strUserID forKey:CONFIG_KEY_TEMPID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) getTemplateID
{
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_TEMPID];
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setBrandID : (NSInteger) brandid
{
    NSString* strUserID = [NSString stringWithFormat:@"%d", brandid];
    
    [[NSUserDefaults standardUserDefaults] setObject:strUserID forKey:CONFIG_KEY_BRANDID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) getBrandID
{
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_BRANDID];
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setSpecID : (NSInteger) specid
{
    NSString* strSpecID = [NSString stringWithFormat:@"%d", specid];
    
    [[NSUserDefaults standardUserDefaults] setObject:strSpecID forKey:CONFIG_KEY_SPECID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSInteger) getSpecID
{
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_SPECID];
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setCompanyName : (NSString*) companyName
{
    if( companyName == nil || [companyName isKindOfClass:[NSNull class]] == YES )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:companyName forKey:CONFIG_KEY_COMPANYNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getCompanyName
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_COMPANYNAME];
}

+ (void) setVideoPath : (NSString*) videoPath
{
    if( videoPath == nil )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:videoPath forKey:CONFIG_KEY_VIDEOPATH];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+ (NSString*) getVideoPath
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_VIDEOPATH];
}

+ (void) setLocalVideoPath : (NSString*) videoPath
{
    if( videoPath == nil )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:videoPath forKey:CONFIG_KEY_LOCALVIDEOPATH];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getLocalVideoPath
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_LOCALVIDEOPATH];
}

+ (void) setSplashImgPath:(NSString *)imgPath
{
    if( imgPath == nil )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:CONFIG_KEY_SPLASHIMG];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString*) getSplashImgPath
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_SPLASHIMG];
}

+ (void) setLocalSplashImgPath:(NSString *)imgPath
{
    if( imgPath == nil )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:CONFIG_KEY_LOCALSPLASHIMG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getLocalSplashImgPath
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_LOCALSPLASHIMG];
}

+ (void) setFirstPageImgPath : (NSString*) imgPath
{
    if( imgPath == nil )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:CONFIG_KEY_FIRSTPAGEIMG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getFirstPageImgPath
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_FIRSTPAGEIMG];
}

+ (void) setLocalFirstPageImgPath : (NSString*) imgPath
{
    if( imgPath == nil )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:CONFIG_KEY_LOCALFIRSTPAGEIMG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getLocalFirstPageImgPath
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_LOCALFIRSTPAGEIMG];
}

+ (void) setFeatureImgCount : (NSInteger) imgCount
{
    NSString* strImgCount = [NSString stringWithFormat:@"%d", imgCount];
    
    [[NSUserDefaults standardUserDefaults] setObject:strImgCount forKey:CONFIG_KEY_FEATUREIMGCOUNT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) getFeatureImgCount
{
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_FEATUREIMGCOUNT];
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setFeatureImgPath : (NSString*) imgPath withIndex : (NSInteger) imgIndex
{
    if( imgPath == nil )
        return;
    
    NSString* indexStr = [NSString stringWithFormat:@"%d", imgIndex];
    NSString* keyStr = CONFIG_KEY_FEATUREIMG;
    keyStr = [keyStr stringByAppendingString:indexStr];
    
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:keyStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getFeatureImgPath : (NSInteger) imgIndex
{
    NSString* indexStr = [NSString stringWithFormat:@"%d", imgIndex];
    NSString* keyStr = CONFIG_KEY_FEATUREIMG;
    keyStr = [keyStr stringByAppendingString:indexStr];

    return [[NSUserDefaults standardUserDefaults] stringForKey:keyStr];
}

+ (void) setLocalFeatureImgPath : (NSString*) imgPath withIndex : (NSInteger) imgIndex
{
    if( imgPath == nil )
        return;
    
    NSString* indexStr = [NSString stringWithFormat:@"%d", imgIndex];
    NSString* keyStr = CONFIG_KEY_LOCALFEATUREIMG;
    keyStr = [keyStr stringByAppendingString:indexStr];
    
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:keyStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getLocalFeatureImgPath : (NSInteger) imgIndex
{
    NSString* indexStr = [NSString stringWithFormat:@"%d", imgIndex];
    NSString* keyStr = CONFIG_KEY_LOCALFEATUREIMG;
    keyStr = [keyStr stringByAppendingString:indexStr];
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:keyStr];
}

+ (void) setSNCode : (NSString*) snCode
{
    if( snCode == nil )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:snCode forKey:CONFIG_KEY_SNCODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getSNCode
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_SNCODE];
}

+ (void) setStatiImgCount : (NSInteger) imgCount
{
    NSString* strImgCount = [NSString stringWithFormat:@"%d", imgCount];
    
    [[NSUserDefaults standardUserDefaults] setObject:strImgCount forKey:CONFIG_KEY_STATIIMGCOUNT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) getStatiImgCount
{
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_STATIIMGCOUNT];
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setStatiImgPath : (NSString*) imgPath withIndex : (NSInteger) imgIndex
{
    if( imgPath == nil )
        return;
    
    NSString* indexStr = [NSString stringWithFormat:@"%d", imgIndex];
    NSString* keyStr = CONFIG_KEY_STATIIMG;
    keyStr = [keyStr stringByAppendingString:indexStr];
    
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:keyStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getStatiImgPath : (NSInteger) imgIndex
{
    NSString* indexStr = [NSString stringWithFormat:@"%d", imgIndex];
    NSString* keyStr = CONFIG_KEY_STATIIMG;
    keyStr = [keyStr stringByAppendingString:indexStr];
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:keyStr];
}

+ (void) setLocalStatiImgPath : (NSString*) imgPath withIndex : (NSInteger) imgIndex
{
    if( imgPath == nil )
        return;
    
    NSString* indexStr = [NSString stringWithFormat:@"%d", imgIndex];
    NSString* keyStr = CONFIG_KEY_LOCALSTATIIMG;
    keyStr = [keyStr stringByAppendingString:indexStr];
    
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:keyStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getLocalStatiImgPath : (NSInteger) imgIndex
{
    NSString* indexStr = [NSString stringWithFormat:@"%d", imgIndex];
    NSString* keyStr = CONFIG_KEY_LOCALSTATIIMG;
    keyStr = [keyStr stringByAppendingString:indexStr];
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:keyStr];
}

+ (void) setDetailStatiImgPath : (NSString*) localPath
{
    if( localPath == nil )
        return;
    
    [[NSUserDefaults standardUserDefaults] setObject:localPath forKey:CONFIG_KEY_DETAIL_TEMP_IMG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getDetailStatiImgPath
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_DETAIL_TEMP_IMG];
}

+ (void) setDetNo : (NSInteger) nDetNo
{
    NSString* strImgCount = [NSString stringWithFormat:@"%d", nDetNo];
    
    [[NSUserDefaults standardUserDefaults] setObject:strImgCount forKey:CONFIG_KEY_DETNO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) getDetNo
{
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:CONFIG_KEY_DETNO];
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setAllImgListCount : (NSInteger) imgCount withShopID : (NSInteger) shopid withDetNo : (NSInteger) detNo
{
//    NSMutableArray* keyArr = [[NSMutableArray alloc] initWithObjects:@"ShopID", @"DetNo", @"ImgCount", nil];
//    NSMutableArray* valueArr = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%d", shopid],
//                                [NSString stringWithFormat:@"%d", detNo],
//                                [NSString stringWithFormat:@"%d", imgCount], nil];
//    
//    NSDictionary* dict = [[NSDictionary alloc] initWithObjects:keyArr forKeys:valueArr];

    // NSString* strImgCount = [NSString stringWithFormat:@"ShopID=%d DetNo=%d ImgCount=%d", shopid, detNo, imgCount];
    
    NSString* prefKey = [NSString stringWithFormat:@"AllImgList ShopID=%d DetNo=%d", shopid, detNo];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", imgCount] forKey:prefKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) getAllImgListCount : (NSInteger) shopid withDetNo : (NSInteger) detNo
{
    NSString* prefKey = [NSString stringWithFormat:@"AllImgList ShopID=%d DetNo=%d", shopid, detNo];
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:prefKey];
    
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setAllImgListPath : (NSString*) imgPath withShopID : (NSInteger)
shopid withDetNo : (NSInteger) detNo withIndex : (NSInteger) imgIndex
{
    NSString* prefKey = [NSString stringWithFormat:@"AllImgList ShopID=%d DetNo=%d ImgIndex = %d", shopid, detNo, imgIndex];
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:prefKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getAllImgListPath : (NSInteger) imgIndex withShopID : (NSInteger) shopid withDetNo : (NSInteger) detNo
{
    NSString* prefKey = [NSString stringWithFormat:@"AllImgList ShopID=%d DetNo=%d ImgIndex = %d", shopid, detNo, imgIndex];
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:prefKey];
    
    return value;
}

+ (void) setLocalAllImgListCount : (NSInteger) imgCount withShopID : (NSInteger) shopid withDetNo : (NSInteger) detNo
{
    NSString* prefKey = [NSString stringWithFormat:@"LocalAllImgList ShopID=%d DetNo=%d", shopid, detNo];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", imgCount] forKey:prefKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) getLocalAllImgListCount : (NSInteger) shopid withDetNo : (NSInteger) detNo
{
    NSString* prefKey = [NSString stringWithFormat:@"LocalAllImgList ShopID=%d DetNo=%d", shopid, detNo];
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:prefKey];
    
    if( stringNotNilOrEmpty(value) )
        return [value integerValue];
    
    return 0;
}

+ (void) setLocalAllImgListPath : (NSString*) imgPath withShopID : (NSInteger)
shopid withDetNo : (NSInteger) detNo withIndex : (NSInteger) imgIndex
{
    NSString* prefKey = [NSString stringWithFormat:@"LocalAllImgList ShopID=%d DetNo=%d ImgIndex = %d", shopid, detNo, imgIndex];
    [[NSUserDefaults standardUserDefaults] setObject:imgPath forKey:prefKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getLocalAllImgListPath : (NSInteger) imgIndex withShopID : (NSInteger) shopid withDetNo : (NSInteger) detNo
{
    NSString* prefKey = [NSString stringWithFormat:@"LocalAllImgList ShopID=%d DetNo=%d ImgIndex = %d", shopid, detNo, imgIndex];
    NSString* value = [[NSUserDefaults standardUserDefaults] stringForKey:prefKey];
    
    return value;
}

@end
