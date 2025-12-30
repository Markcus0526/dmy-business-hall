//
//  GeneralSvcMgr.m
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "GeneralSvcMgr.h"

#import "ServiceMethod.h"

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@implementation GeneralSvcMgr

@synthesize delegate;

- (void) GetBndSpec:(NSString *)shopID brand:(NSString *)brand
                   spec:(NSString *)spec scrwidth:(NSString *)scrwidth scrhei:(NSString *)scrhei
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_COMPNAME];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            shopID, @"uid",
                            brand, @"name",
                            spec, @"specname",
                            scrwidth, @"width",
                            scrhei, @"height",
                            nil];
    
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(bndSpecResult:)])
         {
             [self parseBndSpecID:responseStr];
         }
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(bndSpecResult:)])
         {
             [delegate bndSpecResult:nil];
         }
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetShopList
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_SHOPLIST];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    [httpClient getPath:method parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(shopListResult:shops:)])
         {
             [self parseShopListName:responseStr];
         }
         
         // NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(shopListResult:shops:)])
         {
             [delegate shopListResult:nil shops:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetVideoPath : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_VIDEOPATH];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            [NSString stringWithFormat:@"%d", brandid], @"brandid",
                            [NSString stringWithFormat:@"%d", specid], @"specid",
                            nil];
    
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(videoPathResult:)])
         {
             [self parseVideoPath:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(videoPathResult:)])
         {
             // FIX ME
             [delegate videoPathResult:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetSplashImgPath:(NSInteger)shopid brandid:(NSInteger)brandid specid:(NSInteger)specid
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_SPLASHIMGPATH];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            [NSString stringWithFormat:@"%d", brandid], @"brandid",
                            [NSString stringWithFormat:@"%d", specid], @"specid",
                            nil];
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(splashPathResult:)])
         {
             [self parseSplashImgPath:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(splashPathResult:)])
         {
             // FIX ME
             [delegate splashPathResult:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetFirstPageImgPath:(NSInteger)shopid brandid:(NSInteger)brandid specid:(NSInteger)specid
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_FIRSTPAGEIMG_PATH];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            [NSString stringWithFormat:@"%d", brandid], @"brandid",
                            [NSString stringWithFormat:@"%d", specid], @"specid",
                            nil];
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(firstPageImageResult:)])
         {
             [self parseFirstPageImgPath:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(firstPageImageResult:)])
         {
             // FIX ME
             [delegate firstPageImageResult:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetBenifitList:(NSInteger)shopid brandid:(NSInteger)brandid specid:(NSInteger)specid
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_BENIFETLIST];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            [NSString stringWithFormat:@"%d", brandid], @"brandid",
                            [NSString stringWithFormat:@"%d", specid], @"specid",
                            nil];
    
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(benifitListResult:)])
         {
             [self parseBenifitList:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(benifitListResult:)])
         {
             // FIX ME
             [delegate benifitListResult:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];

}

- (void) GetSameBrandList : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_SAMEBRANDLIST];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            [NSString stringWithFormat:@"%d", brandid], @"brandid",
                            [NSString stringWithFormat:@"%d", specid], @"specid",
                            nil];
    
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(samebrandListResult:)])
         {
             [self parseSameBrandList:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(samebrandListResult:)])
         {
             // FIX ME
             [delegate samebrandListResult:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetSameKindList : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_SAMEKINDLIST];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            [NSString stringWithFormat:@"%d", brandid], @"brandid",
                            [NSString stringWithFormat:@"%d", specid], @"specid",
                            nil];
    
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(samebrandListResult:)])
         {
             [self parseSameBrandList:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(samebrandListResult:)])
         {
             // FIX ME
             [delegate samebrandListResult:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
    
}

- (void) GetGiftList:(NSInteger)shopid macAddress:(NSString*)macAddress
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_GIFTLIST];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            macAddress, @"macaddr",
                            nil];

    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(giftListResult:withSvcResult:)])
         {
             [self parseGiftList:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(giftListResult:withSvcResult:)])
         {
             // FIX ME
             [delegate giftListResult:nil withSvcResult:SVCERR_FAILURE];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) CheckGiftPass : (NSInteger) shopid pass : (NSString*) password
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_CHECK_GIFTPASS];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"shopid",
                            password, @"pwd",
                            nil];

    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(checkGiftPassResult:withSvcResult:)])
         {
             [self parseCheckGiftPass:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(checkGiftPassResult:withSvcResult:)])
         {
             // FIX ME
             [delegate checkGiftPassResult:-1 withSvcResult:SVCERR_FAILURE];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetSNCode:(NSInteger)shopid macAddress:(NSString *)macAddress
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_SNCODE];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            macAddress, @"macaddr",
                            nil];
    
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(sncodeResult:withSvcResult:)])
         {
             [self parseSNCode:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(sncodeResult:withSvcResult:)])
         {
             // FIX ME
             [delegate sncodeResult:nil withSvcResult:SVCERR_FAILURE];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetReqGift : (NSInteger) shopid pwd : (NSString*) password macAddress : (NSString*) macAddress snCode : (NSString*) snCode
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_REQGIFT];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            password, @"pwd",
                            macAddress, @"macaddr",
                            snCode, @"snnum",
                            nil];

    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(reqgiftResult:)])
         {
             [self parseReqGift:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(reqgiftResult:)])
         {
             // FIX ME
             [delegate reqgiftResult:SVCERR_FAILURE];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetStatiImageList : (NSInteger) shopid brandid : (NSInteger) brandid specid : (NSInteger) specid
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_STATIIMGLIST];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            [NSString stringWithFormat:@"%d", brandid], @"brandid",
                            [NSString stringWithFormat:@"%d", specid], @"specid",
                            nil];
    
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(statiImgListResult:)])
         {
             [self parseStatiImgList:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(statiImgListResult:)])
         {
             // FIX ME
             [delegate statiImgListResult:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
    
}

- (void) GetAllImgList : (NSInteger) shopid detno : (NSInteger) nDetNo
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_ALLIMGLIST];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"shopid",
                            [NSString stringWithFormat:@"%d", nDetNo], @"detid",
                            nil];
    
    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(allImgListResult:)])
         {
             [self parseAllImgList:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(allImgListResult:)])
         {
             // FIX ME
             [delegate allImgListResult:nil];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

- (void) GetTempID:(NSInteger)shopid
{
    NSMutableString *method = [NSMutableString string];
    [method appendString:SVC_BASE_URL];
    [method appendString:SVCCMD_GET_TEMPLATEID];
    
    NSURL *url = [NSURL URLWithString:SVC_BASE_URL];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", shopid], @"uid",
                            nil];

    [httpClient getPath:method parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if (delegate != nil && [delegate respondsToSelector:@selector(templateidResult:)])
         {
             [self parseTemplateID:responseStr];
         }
         
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(templateidResult:)])
         {
             // FIX ME
             [delegate templateidResult:0];
         }
         
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

-(void) parseBndSpecID : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    
    STBndSpcID* result = nil;
    
    if (responseStr)
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        if( jsonRet == SVCERR_SUCCESS )
        {
            result = [[STBndSpcID alloc] init];
            
            NSDictionary* jsonDic = [tmp1 objectForKey:SVCC_RETDATA];
        
            result.brandID = [[jsonDic objectForKey:SVCC_BRANDID] intValue];
            result.specID = [[jsonDic objectForKey:SVCC_SPECID] intValue];
            result.title = [jsonDic objectForKey:SVCC_TITLE];
        }
    }
    
    [delegate bndSpecResult:result];
}

-(void) parseShopListName : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    
    NSMutableArray* regionArr = [[NSMutableArray alloc] init];
    NSMutableArray* shopArr = [[NSMutableArray alloc] init];
    
    if (responseStr)
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        if( jsonRet != SVCERR_FAILURE )
        {
            NSDictionary* jsonDic = [tmp1 objectForKey:SVCC_RETDATA];
            
            NSMutableArray* arrRegions = [jsonDic objectForKey:SVCC_REGIONS];
            NSMutableArray* arrShops = [jsonDic objectForKey:SVCC_SHOPS];
            
            for( NSDictionary* oneRegion in arrRegions )
            {
                STRegion* regionInfo = [STRegion decodeFromJSON:oneRegion key1:SVCC_UID key2:SVCC_NAME key3:SVCC_SUBAREAS];
                [regionArr addObject:regionInfo];
            }
            
            for( NSDictionary* oneShop in arrShops )
            {
                STShop* shopInfo = [STShop decodeFromJSON:oneShop key1:SVCC_UID key2:SVCC_REGIONID key3:SVCC_SHOPNAME];
                [shopArr addObject:shopInfo];
            }
        }
    }
    
    [delegate shopListResult:regionArr shops:shopArr];
}

- (void) parseVideoPath : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    
    NSString* retVideoPath = nil;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            retVideoPath = [tmp1 objectForKey:SVCC_RETDATA];
        }
    }
    
    [delegate videoPathResult:retVideoPath];
}

- (void) parseSplashImgPath : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    
    NSString* retImgPath = nil;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            retImgPath = [tmp1 objectForKey:SVCC_RETDATA];
        }
    }
    
    [delegate splashPathResult:retImgPath];
}

- (void) parseFirstPageImgPath : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    
    NSString* retImgPath = nil;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            retImgPath = [tmp1 objectForKey:SVCC_RETDATA];
        }
    }
    
    [delegate firstPageImageResult:retImgPath];
}


- (void) parseBenifitList : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    NSMutableArray* benifitList = nil;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            id retValue = [tmp1 objectForKey:SVCC_RETDATA];
            NSMutableArray* jsonDict = nil;
            
            if( [retValue isKindOfClass:[NSArray class]] )
                jsonDict = (NSMutableArray*)retValue;
            
            if( jsonDict != nil && [jsonDict count] > 0 )
            {
                benifitList = [[NSMutableArray alloc] init];
                for( NSDictionary* jsonObj in jsonDict )
                {
                    NSString* benifit = [jsonObj objectForKey:SVCC_IMGPATH];
                    [benifitList addObject:benifit];
                }
            }
        }
    }
    
    [delegate benifitListResult:benifitList];
}

- (void) parseSameBrandList : (NSString*) responseStr
{
    NSError* e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString* message = @"";

    NSMutableArray* sameBrandList = nil;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            id ret = [tmp1 objectForKey:SVCC_RETDATA];
            NSMutableArray* jsonArr = nil;
            if( [ret isKindOfClass:[NSArray class]] )
                jsonArr = ret;
            
            if( jsonArr != nil && [jsonArr count] > 0 )
            {
                sameBrandList = [[NSMutableArray alloc] init];
                
                for(NSDictionary* jsonDict in jsonArr)
                {
                    STDetailInfo* result = [[STDetailInfo alloc] init];
                    
                    result.uid = [[jsonDict objectForKey:SVCC_UID] intValue];
                    result.imgPath = [jsonDict objectForKey:SVCC_BRAND_IMGPATH];
                    result.name = [jsonDict objectForKey:SVCC_NAME];
                    result.price = [[jsonDict objectForKey:SVCC_PRICE] doubleValue];
                    result.cpu = [jsonDict objectForKey:SVCC_CPU];
                    result.dispsize = [jsonDict objectForKey:SVCC_DISPSIZE];
                    result.pixcnt = [jsonDict objectForKey:SVCC_PIXCNT];
                    result.osver = [jsonDict objectForKey:SVCC_OSVER];
                    result.memsize = [jsonDict objectForKey:SVCC_MEMSIZE];
                    
                    [sameBrandList addObject:result];
                }
            }
        }
    }
    
    [delegate samebrandListResult:sameBrandList];
}

- (void) parseGiftList : (NSString*) responseStr
{
    NSError* e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString* message = @"";

    STGiftList* result = nil;
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            result = [[STGiftList alloc] init];
            
            NSDictionary* jsonDic = [tmp1 objectForKey:SVCC_RETDATA];
            result.onegift = [jsonDic objectForKey:SVCC_ONE_GIFT];
            result.twogift = [jsonDic objectForKey:SVCC_TWO_GIFT];
            result.threegift = [jsonDic objectForKey:SVCC_THREE_GIFT];
            result.fourgift = [jsonDic objectForKey:SVCC_FOUR_GIFT];
            result.fivegift = [jsonDic objectForKey:SVCC_FIVE_GIFT];
            result.sixgift = [jsonDic objectForKey:SVCC_SIX_GIFT];
            result.pass = [jsonDic objectForKey:SVCC_PASS_GIFT];
            result.issued = [[jsonDic objectForKey:SVCC_ISSUED_GIFT] intValue];
        }
    }
    
    [delegate giftListResult:result withSvcResult:jsonRet];
}

- (void) parseCheckGiftPass : (NSString*) responseStr
{
    NSError* e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString* message = @"";
    
    NSInteger   result = -1;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        if( jsonRet != SVCERR_FAILURE )
        {
            result = [[tmp1 objectForKey:SVCC_RETDATA] intValue];
        }
    }
    
    [delegate checkGiftPassResult:result withSvcResult:jsonRet];
}

- (void) parseSNCode : (NSString*) responseStr
{
    NSError* e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString* message = @"";
    
    STSNCode* result = nil;
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            result = [[STSNCode alloc] init];
            
            NSDictionary* jsonDic = [tmp1 objectForKey:SVCC_RETDATA];
            result.rank = [[jsonDic objectForKey:SVCC_RANK] integerValue];
            result.snum = [jsonDic objectForKey:SVCC_SNUM];
        }
    }
    
    [delegate sncodeResult:result withSvcResult:jsonRet];
}

- (void) parseReqGift : (NSString*) responseStr
{
    NSError* e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString* message = @"";
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        if( jsonRet != SVCERR_FAILURE )
        {
            jsonRet = [[tmp1 objectForKey:SVCC_RETDATA] intValue];
        }
    }
    
    [delegate reqgiftResult:jsonRet];

}

- (void) parseStatiImgList : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    NSMutableArray* imgList = nil;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            id retValue = [tmp1 objectForKey:SVCC_RETDATA];
            NSMutableArray* jsonDict = nil;
            
            if( [retValue isKindOfClass:[NSArray class]] )
                jsonDict = (NSMutableArray*)retValue;
            
            if( jsonDict != nil && [jsonDict count] > 0 )
            {
                imgList = [[NSMutableArray alloc] init];
                for( NSDictionary* jsonObj in jsonDict )
                {
                    NSString* benifit = [jsonObj objectForKey:SVCC_IMGPATH];
                    [imgList addObject:benifit];
                }
            }
        }
    }
    
    [delegate statiImgListResult:imgList];
}

- (void) parseAllImgList : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    NSMutableArray* imgList = nil;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            id retValue = [tmp1 objectForKey:SVCC_RETDATA];
            NSMutableArray* jsonDict = nil;
            
            if( [retValue isKindOfClass:[NSArray class]] )
                jsonDict = (NSMutableArray*)retValue;
            
            if( jsonDict != nil && [jsonDict count] > 0 )
            {
                imgList = [[NSMutableArray alloc] init];
                for( NSDictionary* jsonObj in jsonDict )
                {
                    NSString* benifit = [jsonObj objectForKey:SVCC_IMGPATH];
                    [imgList addObject:benifit];
                }
            }
        }
    }
    
    [delegate allImgListResult:imgList];
}

- (void) parseTemplateID : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    NSInteger   result = 0;
    
    if( responseStr )
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        // get service data
        if( jsonRet != SVCERR_FAILURE )
        {
            result = [[tmp1 objectForKey:SVCC_RETDATA] intValue];
        }
    }
    
    [delegate templateidResult:result];
}

@end
