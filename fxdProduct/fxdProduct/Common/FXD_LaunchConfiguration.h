//
//  FXD_LaunchConfiguration.h
//  fxdProduct
//
//  Created by dd on 15/9/8.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXD_LaunchConfiguration : NSObject
+ (FXD_LaunchConfiguration *)shared;

/**
 初始化app配置
 */
-(void)InitializeAppConfiguration;
@end
