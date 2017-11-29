//
//  NSString+AES.h
//  AES_256
//
//  Created by Mac Mini 10.10 on 16/3/30.
//  Copyright © 2016年 Bison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+AES.h"

@interface NSString (AES)

///加密
- (NSString *) AES256_Encrypt:(NSString *)key;

///解密
- (NSString *) AES256_Decrypt:(NSString *)key;

///JAVA服务器用的hashCode
-(int)DF_hashCode;

///JAVA服务器用的加密
- (NSString *) AES256JAVA_Encrypt:(NSString *)key;

///JAVA服务器用的解密
- (NSString *) AES256JAVA_Decrypt:(NSString *)key;
@end
