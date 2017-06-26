//
//  LoginViewModel.h
//  fxdProduct
//
//  Created by dd on 16/1/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "ViewModelClass.h"
#import "LoginParamModel.h"

@interface LoginViewModel : ViewModelClass

/**
 登录请求
 
 @param number 手机号
 @param password 密码
 @param fingerPrint 设备指纹
 @param verifycode 验证码
 */
- (void)fatchLoginMoblieNumber:(NSString *)number password:(NSString *)password  fingerPrint:(NSString*)fingerPrint  verifyCode:(NSString *)verifycode;

/**
 上传位置信息

 @param longitude 经度
 @param latitude 纬度
 */
-(void)uploadLocationInfoLongitude:(NSString *)longitude Latitude:(NSString *)latitude;



@end
