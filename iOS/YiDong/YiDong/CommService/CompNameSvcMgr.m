//
//  CompNameSvcMgr.m
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "CompNameSvcMgr.h"

#import "ServiceMethod.h"

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@implementation CompNameSvcMgr

@synthesize delegate;

- (void) GetCompanyName:(NSString *)shopID brand:(NSString *)brand
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
         
         if (delegate != nil && [delegate respondsToSelector:@selector(compNameResult:specid:title:)])
         {
             [self parseCompanyName:responseStr];
         }
         NSLog(@"Request Successful, response '%@'", responseStr);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (delegate != nil && [delegate respondsToSelector:@selector(compNameResult:specid:title:)])
         {
             [delegate compNameResult:0 specid:0 title:nil];
         }
         NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
     }];
}

-(void) parseCompanyName : (NSString*) responseStr
{
    NSError * e;
    
    NSInteger jsonRet = SVCERR_FAILURE;
    NSString * message = @"";
    
    NSInteger   branchID = 0;
    NSInteger   specID = 0;
    NSString*   title = nil;
    
    if (responseStr)
    {
        NSDictionary *tmp1 = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers                                                             error: &e];
        
        // get service result
        jsonRet = [[tmp1 objectForKey:SVCC_RETCODE] intValue];
        message = [tmp1 objectForKey:SVCC_RETMSG];
        
        if( jsonRet == SVCERR_SUCCESS )
        {
            NSDictionary* jsonDic = [tmp1 objectForKey:SVCC_RETDATA];
        
            branchID = [[jsonDic objectForKey:SVCC_BRANDID] intValue];
            specID = [[jsonDic objectForKey:SVCC_SPECID] intValue];
            title = [jsonDic objectForKey:SVCC_TITLE];
        }
    }
    
    [delegate compNameResult:branchID specid:specID title:title];
}

@end
