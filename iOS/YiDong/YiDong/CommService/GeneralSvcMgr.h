//
//  GeneralSvcMgr.h
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STDataInfo.h"

@protocol GeneralSvcDelegate;

@interface GeneralSvcMgr : NSObject {
    
}

@property(strong, nonatomic) id<GeneralSvcDelegate> delegate;

- (void) GetBndSpec : (NSString*) shopID brand:(NSString*) brand
                    spec:(NSString*)spec scrwidth:(NSString*)scrwidth scrhei:(NSString*)scrhei;
- (void) GetVideoPath : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid;
- (void) GetSplashImgPath : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid;
- (void) GetFirstPageImgPath :  (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid;
- (void) GetBenifitList : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid;
- (void) GetSameBrandList : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid;
- (void) GetSameKindList : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid;
- (void) GetGiftList : (NSInteger) shopid macAddress : (NSString*) macAddress;
- (void) CheckGiftPass : (NSInteger) shopid pass : (NSString*) password;
- (void) GetSNCode : (NSInteger) shopid macAddress : (NSString*) macAddress;
- (void) GetReqGift : (NSInteger) shopid pwd : (NSString*) password macAddress : (NSString*) macAddress snCode : (NSString*) snCode;
- (void) GetStatiImageList : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid;
- (void) GetAllImgList : (NSInteger) shopid detno : (NSInteger) nDetNo;
- (void) GetTempID : (NSInteger) shopid;
- (void) GetShopList;
@end

@protocol GeneralSvcDelegate <NSObject>

@optional
- (void) bndSpecResult : (STBndSpcID*) result;
- (void) shopListResult : (NSMutableArray*)regions shops:(NSMutableArray*)shops;
- (void) videoPathResult : (NSString*) videoPath;
- (void) splashPathResult : (NSString*) splashPath;
- (void) firstPageImageResult : (NSString*) firstimagePath;
- (void) benifitListResult : (NSMutableArray*) benifitList;
- (void) samebrandListResult : (NSMutableArray*) result;
- (void) giftListResult : (STGiftList*) result withSvcResult : (NSInteger) svcResult;
- (void) checkGiftPassResult : (NSInteger) result withSvcResult : (NSInteger) svcResult;
- (void) sncodeResult : (STSNCode*) result withSvcResult : (NSInteger) svcResult;
- (void) reqgiftResult : (NSInteger) result;
- (void) statiImgListResult : (NSMutableArray*) statiList;
- (void) allImgListResult : (NSMutableArray*) statiList;
- (void) templateidResult : (NSInteger) result;
@end
