//
//  LoginViewModel.h
//  fxdProduct
//
//  Created by dd on 16/1/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"
#import "LoginParamModel.h"

@interface LoginViewModel : FXD_ViewModelBaseClass

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

/**
 上传registerID

 @param registerID 推送id
 */
-(void)uploadUserRegisterID:(NSString *)registerID;

/**
 删除用户的registerID
 */
-(void)deleteUserRegisterID;

/**
 更新设备
 
 @param mobliePhone 手机号
 @param verify_code_ 验证码
 */
-(void)updateDeviceID:(NSString *)mobliePhone verify_code:(NSString *)verify_code_;

/**
 退出登录
 */
-(void)userLoginOut;

@end
