//
//  CompNameSvcMgr.h
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompNameSvcDelegate;

@interface CompNameSvcMgr : NSObject {
    
}

@property(strong, nonatomic) id<CompNameSvcDelegate> delegate;

- (void) GetCompanyName : (NSString*) shopID brand:(NSString*) brand
                    spec:(NSString*)spec scrwidth:(NSString*)scrwidth scrhei:(NSString*)scrhei;

@end

@protocol CompNameSvcDelegate <NSObject>

@optional
- (void) compNameResult : (NSInteger)branchID specid:(NSInteger)specid title:(NSString*)title;

@end
