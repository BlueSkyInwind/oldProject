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
-(void)hgSubmitAccountInfoBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone cardNo:(NSString *)cardNo retUrl:(NSString *)retUrl smsSeq:(NSString *)smsSeq verifyCode:(NSString *)verifyCode;

//对接合规平台，换绑卡发送短信验证码
-(void)hgSendSmsCodeBusiType:(NSString *)busiType smsTempType:(NSString *)smsTempType bankCardNo:(NSString *)bankCardNo capitalPlatform:(NSString *)capitalPlatform mobile:(NSString *)mobile userCode:(NSString *)userCode;
@end
