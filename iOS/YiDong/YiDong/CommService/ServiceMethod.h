//
//  ServiceMethod.h
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#ifndef YiDong_ServiceMethod_h
#define YiDong_ServiceMethod_h

#define SVCERR_SUCCESS                      0                       // 성공
#define SVCERR_FAILURE                      1

#define SVCMSG_SUCCESS                      @"操作成功"
#define SVCMSG_FAILURE                      @"网络不给力，操作失败"

// #define SVC_BASE_URL                        @"http://116.112.15.30:8000/service.svc/"
// #define SVC_BASE_URL                        @"http://192.168.1.41:1050/Service.svc/"
#define SVC_BASE_URL                        @"http://218.60.131.41:10151/Service.svc/"
#define SVCCMD_GET_COMPNAME                 @"getBndSpcID"
#define SVCCMD_GET_SHOPLIST                 @"getShopList"
#define SVCCMD_GET_VIDEOPATH                @"getVideoPath"
#define SVCCMD_GET_SPLASHIMGPATH            @"getSplashImgPath"
#define SVCCMD_GET_FIRSTPAGEIMG_PATH        @"getFirstPageImgPath"
#define SVCCMD_GET_BENIFETLIST              @"getBenefitList"
#define SVCCMD_GET_SAMEBRANDLIST            @"getSameBrandList"
#define SVCCMD_GET_SAMEKINDLIST             @"getSameKindList"
#define SVCCMD_GET_TEMPLATEID               @"getTemplateID"
#define SVCCMD_GET_STATIIMGLIST             @"getSetList"
#define SVCCMD_GET_GIFTLIST                 @"getGiftList"
#define SVCCMD_GET_SNCODE                   @"getSNCode"
#define SVCCMD_GET_REQGIFT                  @"getReqGift"
#define SVCCMD_CHECK_GIFTPASS               @"checkGiftPass"
#define SVCCMD_GET_ALLIMGLIST               @"getAllImgList"

#define SVCC_RETCODE                        @"RETCODE"
#define SVCC_RETMSG                         @"RETMSG"
#define SVCC_RETDATA                        @"RETDATA"

// Company Name Defines.
#define SVCC_BRANDID                        @"brandid"
#define SVCC_SPECID                         @"specid"
#define SVCC_TITLE                          @"title"

// Shop List Defines.
#define SVCC_UID                            @"uid"
#define SVCC_NAME                           @"name"
#define SVCC_SUBAREAS                       @"subareas"
#define SVCC_REGIONID                       @"regionid"
#define SVCC_SHOPNAME                       @"shopname"

#define SVCC_REGIONS                        @"Regions"
#define SVCC_SHOPS                          @"Shops"

// Benefit List Defines.
#define SVCC_IMGPATH                        @"imgPath"

// Same Brand List
#define SVCC_BRAND_IMGPATH                  @"imgpath"
#define SVCC_PRICE                          @"price"
#define SVCC_CPU                            @"cpu"
#define SVCC_DISPSIZE                       @"dispsize"
#define SVCC_PIXCNT                         @"pixcnt"
#define SVCC_OSVER                          @"osver"
#define SVCC_MEMSIZE                        @"memsize"

// Gift List
#define SVCC_ONE_GIFT                       @"onegift"
#define SVCC_TWO_GIFT                       @"twogift"
#define SVCC_THREE_GIFT                     @"threegift"
#define SVCC_FOUR_GIFT                      @"fourgift"
#define SVCC_FIVE_GIFT                      @"fivegift"
#define SVCC_SIX_GIFT                       @"sixgift"
#define SVCC_PASS_GIFT                      @"pass"
#define SVCC_ISSUED_GIFT                    @"issued"

// SN Code
#define SVCC_RANK                           @"rank"
#define SVCC_SNUM                           @"snum"

#endif
