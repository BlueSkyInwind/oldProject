//
//  HG_Manager.h
//  fxdProduct
//
//  Created by sxp on 2017/10/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HG_Manager : NSObject

+ (HG_Manager *)sharedHGManager;


/**
 合规获取老用户激活跳转页面参数

 @param capitalPlatform 资金平台类型
 @param vc 跳转的controller
 */
-(void)hgUserActiveJumpP2pCtrlCapitalPlatform:(NSString *)capitalPlatform vc:(id)vc;


/**
 提交合规开户信息

 @param bankNo 银行代号
 @param bankReservePhone 预留手机号
 @param bankShortName 银行名称缩写
 @param cardId 绑定的银行卡id，没有不传
 @param cardNo 银行卡号
 @param smsSeq 短信验证序列号
 @param userCode 合规用户编号
 @param verifyCode 短信验证码
 @param vc 跳转的controller
 */
-(void)hgUserRegJumpP2pCtrlBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone bankShortName:(NSString *)bankShortName cardId:(NSString *)cardId cardNo:(NSString *)cardNo smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode vc:(id)vc;


/**
 提交合规换绑银行卡信息
 
 @param bankNo 银行编号
 @param bankReservePhone 银行预留手机
 @param bankShortName 银行名称缩写
 @param cardNo 银行卡号
 @param orgSmsCode 旧绑定银行卡短信验证码
 @param orgSmsSeq 旧绑定银行卡短信序号
 @param retUrl 页面返回地址
 @param smsSeq 短信验证序列号
 @param userCode 合规用户编号
 @param verifyCode 短信验证码
 @param vc 跳转的controller
 */
-(void)hgChangeBankCardBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone bankShortName:(NSString *)bankShortName cardNo:(NSString *)cardNo orgSmsCode:(NSString *)orgSmsCode orgSmsSeq:(NSString *)orgSmsSeq smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode vc:(id)vc;

@end
