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
//-(void)obtainRechargeCardListInfo;

/**
 订单详情

 @param orderNumber 订单号
 */
-(void)obtainOrderDetailInfoRequest:(NSString *)orderNumber;

@end
