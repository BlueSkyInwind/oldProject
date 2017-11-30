//
//  SetTransactionPasswordViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"
#import "SetTradePasswordModel.h"

@interface SetTransactionPasswordViewModel : FXD_ViewModelBaseClass
/**
 验证身份证
 @param IDnum 身份证号
 */
-(void)VerifyIdentityCardNumber:(NSString *)IDnum;
/**
 验证就交易密码
 
 @param password 旧密码
 */
-(void)VerifyOldTradePassword:(NSString *)password;

/**
 保存新的交易密码
 
 @param firstPassword 首次密码
 @param secondpassword 二次密码
 @param operateType 操作类型   1设置、2重置
 */
-(void)saveNewTradePasswordFirst:(NSString *)firstPassword second:(NSString *)secondpassword operateType:(NSString *)operateType verify_code:(NSString *)verify_code;
/**
 效验交易密码
 
 @param verify_code_ 验证码
 */
-(void)verifyTradeSMS:(NSString *)verify_code_;

/**
 修改交易密码
 
 @param firstPassword 首次
 @param secondpassword 第二次
 @param oldPassword 旧 的
 */
-(void)modificationTradePasswordFirst:(NSString *)firstPassword second:(NSString *)secondpassword oldPassword:(NSString *)oldPassword;

@end
