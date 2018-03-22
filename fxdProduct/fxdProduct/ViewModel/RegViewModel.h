//
//  RegViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/5/27.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXD_ViewModelBaseClass.h"
#import "RegParamModel.h"
#import "DES3Util.h"

@interface RegViewModel : FXD_ViewModelBaseClass


/**
 注册请求
 
 @param number 手机号
 @param password 密码
 @param verifycode 验证码
 @param invitationCode 邀请码
 @param picVerifyId 图片验证码id
 @param picVerifyCode 图片验证码id
 */
- (void)fatchRegMoblieNumber:(NSString *)number
                      password:(NSString *)password
                    verifyCode:(NSString *)verifycode
                invitationCode:(NSString*)invitationCode
                   picVerifyId:(NSString *)picVerifyId
                 picVerifyCode:(NSString *)picVerifyCode;


@end
