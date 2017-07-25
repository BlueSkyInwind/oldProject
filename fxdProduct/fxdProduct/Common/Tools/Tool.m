//
//  Tool.m
//  fxdProduct
//
//  Created by dd on 15/9/16.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "Tool.h"
#import "DES3Util.h"
#import <objc/runtime.h>

@implementation Tool

//获取加密参数
+ (NSDictionary *)getParameters:(id)params
{
    return @{@"record":[self getEncryptStringWithParameters:params]};
}

//加密json串
+ (NSString *)getEncryptStringWithParameters:(id)params
{
    NSError *error = nil;
    NSString *jsonString;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        DLog(@"[net]GotParams: %@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSString *enValues = [DES3Util encrypt:jsonString];
    return enValues;
}
+ (NSString *)dataToStringwithdata:(id)params
{
    NSString *result  =[[ NSString alloc] initWithData:params encoding:NSUTF8StringEncoding];
    return result;
}

+ (NSDictionary *)dataToDictionary:(id)params
{
//    NSString *receiveStr = [params objectForKey:@"record"];
//    NSString *decStr = [DES3Util decrypt:receiveStr];
//    DLog(@"---%@",decStr);
    NSData * data = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return jsonDict;
}

+ (NSString *)objextToJSON:(id)param
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}


#pragma mark- 时间处理

+ (NSString *)getToday
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)getNowTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
//将时间转换为时间戳
+ (NSTimeInterval)timeToTimestamp:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSTimeInterval timesp = [date timeIntervalSince1970];
    formatter = nil;
    return timesp;
}

//时间戳转换为时间
+ (NSString *)timestampToTime:(NSTimeInterval)timestamp
{
    //    NSString *longOftimesTamp = [NSString stringWithFormat:@"%.0lf", timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = nil;
    //    if (longOftimesTamp.length > 10) {
    date  = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //    }else{
    //        date  = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //    }
    NSString *timeStr = [formatter stringFromDate:date];
    formatter = nil;
    return timeStr;
}

+ (NSString *)timestampToTimeFormat:(NSTimeInterval)timestamp
{
    //    NSString *longOftimesTamp = [NSString stringWithFormat:@"%.0lf", timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = nil;
    //    if (longOftimesTamp.length > 10) {
    date  = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //    }else{
    //        date  = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //    }
    NSString *timeStr = [formatter stringFromDate:date];
    formatter = nil;
    return timeStr;
}

+ (NSString *)dateToFormatString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [formatter stringFromDate:date];
    formatter = nil;
    return timeStr;
}

+ (UInt64)getNowTimeMS
{
    return [[NSDate date] timeIntervalSince1970]*1000;
}

+ (NSString *)countDate:(NSString *)date and:(int)addDays
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [dateFormatter dateFromString:date];
    NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * addDays];
    return [dateFormatter stringFromDate:newDate];
}


//判断字典是否有某key值
+(BOOL)dicContainsKey:(NSDictionary *)dic keyValue:(NSString *)key
{
    if ([self objectIsEmpty:dic]) {
        return NO;
    }
    
    NSArray *keyArray = [dic allKeys];
    
    if ([keyArray containsObject:key]) {
        
        return YES;
    }
    return NO;
}

//判断对象是否为空
+(BOOL)objectIsEmpty:(id)object
{
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (nil == object){
        return YES;
    }
    return NO;
}

+ (BOOL)getVariableWithClass:(Class)myClass varName:(NSString *)name
{
    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    if (ivars) {
        for (i = 0; i < outCount; i++) {
            Ivar property = ivars[i];
            if (property) {
                const char *type = ivar_getTypeEncoding(property);
                NSString *stringType = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
                if (![stringType hasPrefix:@"@"]) {//遇到非objective-c对象,跳过继续执行
                    continue;
                }
                
                NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
                keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
                if ([keyName isEqualToString:name]) {
                    return true;
                }
            }
        }
    }
    return false;
}

+(NSString *)EmptyObjectContainEmptyString:(id)object
{
    if ([self objectIsEmpty:object]) {
        return @"";
    }
    else
    {
        return object;
    }
}

//判断手机号是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,147,183
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181
     */
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0-9]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，183
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[156])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else {
        return NO;
    }
}

//设置沙盒
+ (void)saveUserDefaul:(NSString *)content Key:(NSString *)key;
{
    [[NSUserDefaults standardUserDefaults] setObject:content forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getContentWithKey:(NSString *)key;
{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


//圆角设置
+(void)setCorner:(UIView *)view borderColor:(UIColor *)color
{
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = color.CGColor;
}
+(void)setCornerWithoutRadius:(UIView *)view borderColor:(UIColor *)color
{
    view.layer.cornerRadius = 0;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = color.CGColor;
}

+(NSString *)toCapitalLetters:(NSString *)money
{
    //首先转化成标准格式        “200.23”
    NSMutableString *tempStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    //位
    NSArray *carryArr1=@[@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *carryArr2=@[@"分",@"角"];
    //数字
    NSArray *numArr=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    
    NSArray *temarr = [tempStr componentsSeparatedByString:@"."];
    //小数点前的数值字符串
    NSString *firstStr=[NSString stringWithFormat:@"%@",temarr[0]];
    //小数点后的数值字符串
    NSString *secondStr=[NSString stringWithFormat:@"%@",temarr[1]];
    
    //是否拼接了“零”，做标记
    bool zero=NO;
    //拼接数据的可变字符串
    NSMutableString *endStr=[[NSMutableString alloc] init];
    
    /**
     *  首先遍历firstStr，从最高位往个位遍历    高位----->个位
     */
    
    for(int i=(int)firstStr.length;i>0;i--)
    {
        //取最高位数
        NSInteger MyData=[[firstStr substringWithRange:NSMakeRange(firstStr.length-i, 1)] integerValue];
        
        if ([numArr[MyData] isEqualToString:@"零"]) {
            
            if ([carryArr1[i-1] isEqualToString:@"万"]||[carryArr1[i-1] isEqualToString:@"亿"]||[carryArr1[i-1] isEqualToString:@"元"]||[carryArr1[i-1] isEqualToString:@"兆"]) {
                //去除有“零万”
                if (zero) {
                    endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:(endStr.length-1)]];
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }else{
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }
                
                //去除有“亿万”、"兆万"的情况
                if ([carryArr1[i-1] isEqualToString:@"万"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"亿"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                }
                //去除“兆亿”
                if ([carryArr1[i-1] isEqualToString:@"亿"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                }
                
                
            }else{
                if (!zero) {
                    [endStr appendString:numArr[MyData]];
                    zero=YES;
                }
                
            }
            
        }else{
            //拼接数字
            [endStr appendString:numArr[MyData]];
            //拼接位
            [endStr appendString:carryArr1[i-1]];
            //不为“零”
            zero=NO;
        }
    }
    
    /**
     *  再遍历secondStr    角位----->分位
     */
    
    if ([secondStr isEqualToString:@"00"]) {
        [endStr appendString:@"整"];
    }else{
        for(int i=(int)secondStr.length;i>0;i--)
        {
            //取最高位数
            NSInteger MyData=[[secondStr substringWithRange:NSMakeRange(secondStr.length-i, 1)] integerValue];
            
            [endStr appendString:numArr[MyData]];
            [endStr appendString:carryArr2[i-1]];
        }
    }
    
    return endStr;
}

/**
 *  计算字符串宽度
 *
 *  @param text 文本内容
 *  @param size 字体大小
 *
 *  @return 返回文本宽度
 */
+ (CGFloat)widthForText:(NSString *)text font:(CGFloat)size
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    CGSize aSize = [text sizeWithAttributes:attributes];
    return aSize.width;
}




@end
