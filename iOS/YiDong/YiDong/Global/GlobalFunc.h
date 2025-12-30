//
//  GlobalFunc.h
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TEST_NETWORK_RETURN if ([CommMgr hasConnectivity] == NO) { \
[SVProgressHUD dismissWithError:@"没有网络连接"]; \
return; \
}

#define BACKGROUND_TEST_NETWORK_RETURN    if ([CommMgr hasConnectivity] == NO) { \
return; \
}

typedef NS_ENUM(NSInteger, DEVICE_KIND) {
    IPHONE4= 1,
    IPHONE5,
    IPAD,
};

@interface GlobalFunc : NSObject {
}

+ (BOOL) isOverIOS8;
+ (BOOL) isOverIOS7;
+ (float)getSystemVersion;

+ (void) makeErrorWindow : (NSString *)content TopOffset:(NSInteger)topOffset BottomOffset:(NSInteger)bottomOffset View:(UIView *)view;


+ (NSString *) getCurTime : (NSString*)fmt;
+ (NSString *) convertDateToString : (NSDate *)date fmt:(NSString *)fmt;
+ (NSDate *) convertStringToDate : (NSString *)date fmt:(NSString *)fmt;
+ (NSDateComponents *) convertNSDateToNSDateComponents : (NSDate *)date;

+ (NSInteger) phoneType;

+ (NSString *) getRealImagePath :(NSString *)path :(NSString *)rate :(NSString *)size;
+ (NSString *) getBackImagePath :(NSString *)path :(NSString *)rate :(NSString *)size;

+ (NSString*) base64forData:(NSData*)theData;
+ (NSData*) base64forString:(NSString*)theString;

+ (NSString *) appNameAndVersionNumberDisplayString;

+ (NSString *) md5:(NSString *) input;

+ (NSString*)getAdvertiseIdentifier;
+ (NSString*)getDeviceIDForVendor;
+ (NSString*)getDeviceMacAddress;       // used for IMEI

+ (void)callPhone : (NSString *)phoneNum;

+ (NSString*) getDeviceType;
+ (NSString*) getDeviceModel;

+ (int)getIntValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (long)getLongValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (NSString*)getStringValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (double)getDoubleValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;
+ (float)getFloatValueWithKey:(NSString*)key Dict:(NSDictionary*)dict;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (NSString *)downloadResource:(NSString*) resURL localStore : (NSString*) localDir;
+ (int)genRandFromInt : (NSInteger) ticks;

@end
