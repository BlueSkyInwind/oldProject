//
//  AuthenticationViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/6/26.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ViewModelClass.h"

@interface AuthenticationViewModel : ViewModelClass

/**
 手机运营商认证

 @param number 手机号
 @param password 密码
 @param smsCode 验证码
 @param picCode 图片验证码
 */
-(void)TCphoneAuthenticationPhoneNum:(NSString *)number password:(NSString *)password smsCode:(NSString *)smsCode picCode:(NSString *)picCode;

@end
