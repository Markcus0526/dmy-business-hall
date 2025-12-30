//
//  CommMgr.h
//  YiDong
//
//  Created by Admin on 2/1/15.
//  Copyright (c) 2015 Choe Sin Hyok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralSvcMgr.h"

@interface CommMgr : NSObject {
    
    GeneralSvcMgr*      generalSvcMgr;
    
    CommMgr*            commMgr;
}

+ (CommMgr *) getCommMgr;
+ (BOOL) hasConnectivity;
- (void) loadCommModules;

@property (nonatomic, retain) GeneralSvcMgr* generalSvcMgr;

@property (nonatomic, retain) CommMgr* commMgr;

@end
