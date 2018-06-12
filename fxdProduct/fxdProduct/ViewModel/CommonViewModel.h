//
//  CommonViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/12/13.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface CommonViewModel : FXD_ViewModelBaseClass

/**
 版本检测
 */
-(void)appVersionChecker;

/**
 协议获取

 @param Type_id 协议类型\产品id
 @param typeCode 协议类型
 @param apply_id 申请件id
 @param periods 期数
 @param stagingType 1、按周还款、2、按每2周还款、3、按月还款
 */
-(void)obtainProductProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode apply_id:(NSString *)apply_id periods:(NSString *)periods stagingType:(NSString *)stagingType;
/**
 获取银行自动转账授权书

 @param Type_id 产品id
 @param typeCode 类型
 @param cardBankCode 银行编码
 @param cardNo 银行卡号
 */
-(void)obtainTransferAuthProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode cardBankCode:(NSString *)cardBankCode cardNo:(NSString *)cardNo stagingType:(NSString *)stagingType applicationId:(NSString *)applicationId;

/**
 获取银行自动转账授权书
 
 @param Type_id 产品id
 @param typeCode 类型
 @param cardBankCode 银行编码
 @param cardNo 银行卡号
 */
-(void)obtainTransferAuthProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode cardBankCode:(NSString *)cardBankCode cardNo:(NSString *)cardNo stagingType:(NSString *)stagingType applicationId:(NSString *)applicationId phoneModel:(NSString *)phoneModel amountOfSale:(NSString *)amountOfSale;

/**
 手机充值卡协议

 @param productId 产品id
 @param totalPrice 总价格
 @param applicationId 进件id
 */
-(void)obtainPhoneCardProtocolType:(NSString *)productId totalPrice:(NSString *)totalPrice applicationId:(NSString *)applicationId;
@end
