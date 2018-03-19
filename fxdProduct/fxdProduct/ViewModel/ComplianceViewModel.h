//
//  ComplianceViewModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface ComplianceViewModel : FXD_ViewModelBaseClass

//获取合规开户信息
-(void)hgAccountInfo;

//提交合规开户信息
-(void)hgSubmitAccountInfoBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone bankShortName:(NSString *)bankShortName cardId: (NSString *)cardId cardNo:(NSString *)cardNo retUrl:(NSString *)retUrl smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode;

//对接合规平台，换绑卡发送短信验证码
-(void)hgSendSmsCodeBusiType:(NSString *)busiType smsTempType:(NSString *)smsTempType bankCardNo:(NSString *)bankCardNo capitalPlatform:(NSString *)capitalPlatform mobile:(NSString *)mobile userCode:(NSString *)userCode;

//提交合规换绑银行卡信息
-(void)hgChangeBankCardBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone bankShortName:(NSString *)bankShortName cardNo:(NSString *)cardNo orgSmsCode:(NSString *)orgSmsCode orgSmsSeq:(NSString *)orgSmsSeq smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode;

//获取合规换绑卡信息
-(void)hgChangeBankCardInfo;

//合规获取老用户激活跳转页面参数
-(void)hgUserActiveCapitalPlatform:(NSString *)capitalPlatform;
//合规用户状态查询
-(void)hgQueryUserStatus;

@end
