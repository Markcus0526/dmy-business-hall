//
//  Config.h
//  YiDong
//
//  Created by Admin on 2/3/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalConfig : NSObject

+ (void) setFirstLogin;
+ (BOOL) getFirstLogin;

+ (void) setUserID : (NSInteger) userid;
+ (NSInteger) getUserID;

+ (void) setTemplateID : (NSInteger) templateid;
+ (NSInteger) getTemplateID;

+ (void) setBrandID : (NSInteger) brandid;
+ (NSInteger) getBrandID;

+ (void) setSpecID : (NSInteger) specid;
+ (NSInteger) getSpecID;

+ (void) setCompanyName : (NSString*) companyName;
+ (NSString*) getCompanyName;

+ (void) setVideoPath : (NSString*) videoPath;
+ (NSString*) getVideoPath;

+ (void) setLocalVideoPath : (NSString*) videoPath;
+ (NSString*) getLocalVideoPath;

+ (void) setSplashImgPath : (NSString*) videoPath;
+ (NSString*) getSplashImgPath;

+ (void) setLocalSplashImgPath : (NSString*) videoPath;
+ (NSString*) getLocalSplashImgPath;

+ (void) setFirstPageImgPath : (NSString*) videoPath;
+ (NSString*) getFirstPageImgPath;

+ (void) setLocalFirstPageImgPath : (NSString*) videoPath;
+ (NSString*) getLocalFirstPageImgPath;

+ (void) setFeatureImgCount : (NSInteger) imgCount;
+ (NSInteger) getFeatureImgCount;

+ (void) setFeatureImgPath : (NSString*) imgPath withIndex : (NSInteger) imgIndex;
+ (NSString*) getFeatureImgPath : (NSInteger) imgIndex;

+ (void) setLocalFeatureImgPath : (NSString*) imgPath withIndex : (NSInteger) imgIndex;
+ (NSString*) getLocalFeatureImgPath : (NSInteger) imgIndex;

+ (void) setSNCode : (NSString*) snCode;
+ (NSString*) getSNCode;

+ (void) setStatiImgCount : (NSInteger) imgCount;
+ (NSInteger) getStatiImgCount;

+ (void) setStatiImgPath : (NSString*) imgPath withIndex : (NSInteger) imgIndex;
+ (NSString*) getStatiImgPath : (NSInteger) imgIndex;

+ (void) setLocalStatiImgPath : (NSString*) imgPath withIndex : (NSInteger) imgIndex;
+ (NSString*) getLocalStatiImgPath : (NSInteger) imgIndex;

+ (void) setDetailStatiImgPath : (NSString*) localPath;
+ (NSString*) getDetailStatiImgPath;

+ (void) setDetNo : (NSInteger) nDetNo;
+ (NSInteger) getDetNo;

+ (void) setAllImgListCount : (NSInteger) imgCount withShopID : (NSInteger) shopid withDetNo : (NSInteger) detNo;
+ (NSInteger) getAllImgListCount : (NSInteger) shopid withDetNo : (NSInteger) detNo;

+ (void) setAllImgListPath : (NSString*) imgPath withShopID : (NSInteger)
                            shopid withDetNo : (NSInteger) detNo withIndex : (NSInteger) imgIndex;
+ (NSString*) getAllImgListPath : (NSInteger) imgIndex withShopID : (NSInteger) shopid withDetNo : (NSInteger) detNo;

+ (void) setLocalAllImgListCount : (NSInteger) imgCount withShopID : (NSInteger) shopid withDetNo : (NSInteger) detNo;
+ (NSInteger) getLocalAllImgListCount : (NSInteger) shopid withDetNo : (NSInteger) detNo;

+ (void) setLocalAllImgListPath : (NSString*) imgPath withShopID : (NSInteger)
shopid withDetNo : (NSInteger) detNo withIndex : (NSInteger) imgIndex;
+ (NSString*) getLocalAllImgListPath : (NSInteger) imgIndex withShopID : (NSInteger) shopid withDetNo : (NSInteger) detNo;

@end
