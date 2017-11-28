//
//  NSString+AES.m
//  AES_256
//
//  Created by Mac Mini 10.10 on 16/3/30.
//  Copyright © 2016年 Bison. All rights reserved.
//

#import "NSString+AES.h"

@implementation NSString (AES)

//加密
- (NSString *) AES256_Encrypt:(NSString *)key{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //对数据进行加密
    NSData *result = [data AES256_Encrypt:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

//解密
- (NSString *)AES256_Decrypt:(NSString *)key{
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data AES256_Decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}


-(int)DF_hashCode {
    int hash = 0;
    for (int i = 0; i<[self length]; i++) {
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        char *unicode = (char *)[s cStringUsingEncoding:NSUnicodeStringEncoding];
        int charactorUnicode = 0;
        size_t length = strlen(unicode);
        for (int n = 0; n < length; n ++) {
            charactorUnicode += (int)((unicode[n] & 0xff) << (n * sizeof(char) * 8));
        }
        hash = hash * 31 + charactorUnicode;
    }
    return hash;
}

//加密 返回base64
- (NSString *) AES256JAVA_Encrypt:(NSString *)key{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //对数据进行加密
    NSData *result = [data AES256_Encrypt:key];
    NSString *base64String = [result base64EncodedStringWithOptions:0];
    return base64String;
}

//解密
- (NSString *) AES256JAVA_Decrypt:(NSString *)key{
    NSString *decodedString;
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    if (decodedData && decodedData.length > 0) {
        Byte *datas = (Byte*)[decodedData bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:decodedData.length * 2];
        for(int i = 0; i < decodedData.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        decodedString =  [output copy];
    }
    
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:decodedString.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [decodedString length] / 2; i++) {
        byte_chars[0] = [decodedString characterAtIndex:i*2];
        byte_chars[1] = [decodedString characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data AES256_Decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}



@end
