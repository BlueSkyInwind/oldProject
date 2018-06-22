//
//  NSString+Validate.m
//  AreaCodeRegex
//
//  Created by EasonWang on 15/11/30.
//  Copyright © 2015年 EasonWang. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

/**
 *	@brief	固定电话区号格式化（将形如 01085792889 格式化为 010-85792889）
 *
 *	@return	返回格式化后的号码（形如 010-85792889）
 */
- (NSString*)areaCodeFormat
{
    // 先去掉两边空格
    NSMutableString *value = [NSMutableString stringWithString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    // 先匹配是否有连字符/空格，如果有则直接返回
    NSString *regex = @"^0\\d{2,3}[- ]\\d{7,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if([predicate evaluateWithObject:value]){
        // 替换掉中间的空格
        return [value stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    }
    
    // 格式化号码 三位区号
    regex = [NSString stringWithFormat:@"^(%@)\\d{7,8}$",[self regex_areaCode_threeDigit]];
    predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([predicate evaluateWithObject:value]){
        // 插入连字符 "-"
        [value insertString:@"-" atIndex:3];
        return value;
    }
    
    
    // 格式化号码 四位区号
    regex = [NSString stringWithFormat:@"^(%@)\\d{7,8}$",[self regex_areaCode_fourDigit]];
    predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([predicate evaluateWithObject:value]){
        // 插入连字符 "-"
        [value insertString:@"-" atIndex:4];
        return value;
    }
    
    return nil;
}

/**
 *	@brief	验证固定电话区号是否正确（e.g. 010正确，030错误）
 *
 *	@return	返回固定电话区号是否正确
 */
- (BOOL)isAreaCode
{
    
    NSString *regex = [NSString stringWithFormat:@"^%@|%@$",[self regex_areaCode_threeDigit],[self regex_areaCode_fourDigit]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([predicate evaluateWithObject:self]){
        return YES;
    }
    
    return NO;
}


/**
 *	@brief	获取三位数区号的正则表达式（三位数区号形如 010）
 */
- (NSString*)regex_areaCode_threeDigit
{
    return @"010|02[0-57-9]|85[23]";
}
/**
 *	@brief	获取四位数区号的正则表达式（四位数区号形如 0311）
 */
- (NSString*)regex_areaCode_fourDigit
{
    // 03xx
    NSString *fourDigit03 = @"03([157]\\d|35|49|9[1-68])";
    // 04xx
    NSString *fourDigit04 = @"04([17]\\d|2[179]|[3,5][1-9]|4[08]|6[4789]|8[23])";
    // 05xx
    NSString *fourDigit05 = @"05([1357]\\d|2[37]|4[36]|6[1-6]|80|9[1-9])";
    // 06xx
    NSString *fourDigit06 = @"06(3[1-5]|6[01238]|9[12])";
    // 07xx
    NSString *fourDigit07 = @"07(01|[13579]\\d|2[248]|4[3-6]|6[023689])";
    // 08xx
    NSString *fourDigit08 = @"08(1[23678]|2[567]|[37]\\d|5[1-9]|8[3678]|9[1-8])";
    // 09xx
    NSString *fourDigit09 = @"09(0[123689]|[17][0-79]|[39]\\d|4[13]|5[1-5])";
    
    return [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@",fourDigit03,fourDigit04,fourDigit05,fourDigit06,fourDigit07,fourDigit08,fourDigit09];
}

-(NSString *)openpf{
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
    NSMutableString * str1 = [[data base64EncodedStringWithOptions:0] mutableCopy];
    
    NSData * str2 = [SERVERNAME dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString * str3 = [[str2 base64EncodedStringWithOptions:0] mutableCopy];
    for (i = 0; i < str3.length; i ++) {
        [str1 deleteCharactersInRange:NSMakeRange(i + 1, 1)];
    }
    NSString * resultStr = str1;
    return resultStr;
}

-(NSString *)closepf{
    
    NSString * decodedString;
    NSData * str2 = [SERVERNAME dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString * str3 = [[str2 base64EncodedStringWithOptions:0] mutableCopy];
    NSString * str4 = [self stringByAppendingString:str3];
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:str4 options:0];
    if (decodedData && decodedData.length > 0) {
        Byte *datas = (Byte*)[decodedData bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:decodedData.length * 2];
        for(int i = 0; i < decodedData.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        decodedString =  [output copy];
    }
    return decodedString;
}


/**
 删除字符串中的空格

 @param string 旧字符串
 @return 新的字符串
 */
-(NSString*)noneSpaseString{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 手机插入空格

 @return 新的字符串
 */
- (NSString*)parseString{
    if (!self) {
        return nil;
    }
    NSMutableString* mStr = [NSMutableString stringWithString:[self stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (mStr.length >3) {
        [mStr insertString:@" " atIndex:3];
    }if(mStr.length > 8) {
        [mStr insertString:@" " atIndex:8];
    }
    return mStr;
}

- (NSString *)formatTailNumber
{
    return [self substringWithRange:NSMakeRange(self.length - 4, 4)];
}

@end
