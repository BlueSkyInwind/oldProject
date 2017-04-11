//
//  FXDAppUpdateChecker.h
//  fxdProduct
//
//  Created by dd on 2016/11/16.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXDAppUpdateChecker : NSObject

+ (FXDAppUpdateChecker *)sharedUpdateChecker;

- (void)checkAPPVersion;

@end
