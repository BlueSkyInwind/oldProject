//
//  PhonerechargeCardServiceViewModel.h
//  fxdProduct
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhonerechargeCardServiceViewModel : FXD_ViewModelBaseClass

/**
 手机卡列表
 */
-(void)obtainRechargeCardListInfo;

/**
 订单确认

 @param productNumber 产品号
 */
-(void)obtainOrderConfirmInfo:(NSString *)productNumber;

/**
 订单确认

 @param productNumber 卡编号
 @param num 数量
 */
-(void)obtainOrderConfirmRequest:(NSString *)productNumber cardNum:(NSString *)num;

/**
 查询手机卡订单列表
 */
-(void)obtainOrderContractStagingSelectOrdersByUserId;

/**
 订单详情

 @param orderNumber 订单号
 */
-(void)obtainOrderDetailInfoRequest:(NSString *)orderNumber;

/**
 创建进件

 @param cardNO 卡号
 @param verifyCode 验证码
 */
-(void)createPhoneCardOrder:(NSString *)cardNO verifyCode:(NSString *)verifyCode;


@end
