//
//  Tool.h
//  fxdProduct
//
//  Created by dd on 15/9/16.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tool : NSObject

#pragma mark- 时间处理
+ (float)getIOSVersion;

//获取今天日期
+ (NSString *)getToday;
//获取现在的时间
+ (NSString *)getNowTime;
//将时间转换为时间戳
+ (NSTimeInterval)timeToTimestamp:(NSString *)timeStr;
//时间戳转换为时间
+ (NSString *)timestampToTime:(NSTimeInterval)timestamp;
//时间戳转换为'年月日'
+ (NSString *)timestampToTimeFormat:(NSTimeInterval)timestamp;
//Date转化为'年月日'
+ (NSString *)dateToFormatString:(NSDate *)date;
//判断一个对象是否有用某个属性
+ (BOOL)getVariableWithClass:(Class)myClass varName:(NSString *)name;

+ (UInt64)getNowTimeMS;

//计算时间
+ (NSString *)countDate:(NSString *)date and:(int)addDays;

#pragma mark- 对象处理

//判断字典是否有某key值
+(BOOL)dicContainsKey:(NSDictionary *)dic keyValue:(NSString *)key;
//判断对象是否为空
+(BOOL)objectIsEmpty:(id)object;
//把空的的字符串转换为@“”
+(NSString *)EmptyObjectContainEmptyString:(id)object;
//判断手机号是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//得到加密后的参数
+ (NSDictionary *)getParameters:(id)params;
//将加密后的数据解密后转换为字符串
+ (NSString *)dataToStringwithdata:(NSData*)data;
//将加密后的数据解密后转换为字典
+ (NSDictionary *)dataToDictionary:(NSData *)data;
///对象转字符串
+ (NSString *)objextToJSON:(id)param;
//设置沙盒
+ (void)saveUserDefaul:(NSString *)content Key:(NSString *)key;
+ (NSString *)getContentWithKey:(NSString *)key;

/**
 *  @author dd, 16-01-20 19:01:42
 *
 *  圆角设置
 */
+ (void)setCorner:(UIView *)view borderColor:(UIColor *)color;
+ (void)setCornerWithoutRadius:(UIView *)view borderColor:(UIColor *)color;

+(NSString *)toCapitalLetters:(NSString *)money;
/**
 *  计算字符串宽度
 *
 *  @param text 文本内容
 *  @param size 字体大小
 *
 *  @return 返回文本宽度
 */
+ (CGFloat)widthForText:(NSString *)text font:(CGFloat)size;

+ (void)showMessage:(NSString *)msg vc:(UIViewController *)vc;


 /**
 启动粘贴板

 @param copyStr 拷贝内容
 @param vc 目标controller
 @param str 提示内容
 */
+(void)ClipboardOfCopy:(NSString *)copyStr VC:(UIViewController *)vc prompt:(NSString *)str;


















@end
