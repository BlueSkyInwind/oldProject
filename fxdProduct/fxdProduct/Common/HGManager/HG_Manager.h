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
 合规未开户跳转到银行卡页面

 @param applicationId 用户申请件id
 @param productId 用户产品id
 @param vc 跳转的controller
 */
-(void)jumpBankCtrlApplicationId:(NSString *)applicationId productId:(NSString *)productId vc:(id)vc;

/**
 合规激活用户，跳转到激活页面

 @param applicationId 用户申请件id
 @param vc 跳转的controller
 */
-(void)hgUserActiveJumpP2pCtrlApplicationId:(NSString *)applicationId vc:(id)vc;


/**
 合规未开户用户，跳转到激活页面

 @param bankNo 银行代号
 @param bankReservePhone 预留手机号
 @param bankShortName 银行名称缩写
 @param cardNo 银行卡号
 @param smsSeq 短信验证序列号
 @param userCode 合规用户编号
 @param verifyCode 短信验证码
 @param vc 跳转的controller
 */
-(void)hgUserRegJumpP2pCtrlBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone bankShortName:(NSString *)bankShortName cardId:(NSString *)cardId cardNo:(NSString *)cardNo smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode vc:(id)vc;


/**
 合规正常用户，提款

 @param cardId 银行卡id
 @param loanFor 借款用途
 @param periods 借款周期
 @param vc 跳转的controller
 */
-(void)hgUserBidDrawApplyCardId:(NSString *)cardId loanFor:(NSString *)loanFor periods:(NSString *)periods vc:(id)vc;


-(void)hgChangeBankCardBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone cardNo:(NSString *)cardNo orgSmsCode:(NSString *)orgSmsCode orgSmsSeq:(NSString *)orgSmsSeq smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode vc:(id)vc;
@end
