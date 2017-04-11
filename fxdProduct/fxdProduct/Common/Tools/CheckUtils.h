//
//  CheckUtils.h
//  fxdProduct
//
//  Created by dd on 15/9/6.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckUtils : NSObject

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则判断金额输入不能以0开头
+ (BOOL)checkMoneyNumber:(NSString *) moneyNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文
+ (BOOL)checkUserNameHanzi : (NSString *) userName;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户姓名,20位的中文英文
+ (BOOL)checkUserDetail : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则判断数字,1到30位的数字
+ (BOOL)checkNumber1_30wei : (NSString *) number;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

@end
