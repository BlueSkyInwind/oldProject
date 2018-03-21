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

/**
 获取产品协议（新产品）
 
 @param applicationId 申请件id
 @param inverBorrowId 投资人id  合规放款的用户，调用借款协议时传
 @param periods 期数  精英贷不传，其他产品传
 @param productId 产品id  注册协议 product_id_ : user_reg 隐私保护协议 product_id_ :user_privacy 运营商信息授权协议 产品id product_id_ :operInfo 用户信息授权协议 product:    fxd_userpro
 @param productType 产品类型  2 薪意贷 （其他产品不传）
 @param protocolType 协议类型  1，转账授权书2，借款协议3，信用咨询及管理服务协议4，运营商信息授权协议5，用户信息授权服务协议6，技术服务协议7，风险管理与数据服务协议8注册协议 9隐私保护协议 18 电子签章授权委托协议
 @param stagingType 还款方式  1、按周还款、2、按每2周还款、3、按月还款
 @param vc 跳转的controller
 */

-(void)hgGetProductNewProtocolApplicationId:(NSString *)applicationId inverBorrowId:(NSString *)inverBorrowId periods:(NSString *)periods productId:(NSString *)productId productType:(NSString *)productType protocolType:(NSString *)protocolType stagingType:(NSString *)stagingType vc:(id)vc;


@end
