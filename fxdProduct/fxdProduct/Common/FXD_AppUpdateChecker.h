//
//  FXD_AppUpdateChecker.h
//  fxdProduct
//
//  Created by dd on 2016/11/16.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXD_AppUpdateChecker : NSObject

+ (FXD_AppUpdateChecker *)sharedUpdateChecker;

- (void)checkAPPVersion;

@end
