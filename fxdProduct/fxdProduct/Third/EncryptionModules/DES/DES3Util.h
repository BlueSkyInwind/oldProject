//
//  DESUtil.h
//  DESDemo
//
//  Created by dd on 15/8/24.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject

// 加密方法
+ (NSString *)encrypt:(NSString *) plainText;

// 解密方法
+ (NSString *)decrypt:(NSString *) encryptText;

@end
