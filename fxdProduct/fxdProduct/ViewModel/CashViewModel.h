//
//  CashViewModel.h
//  fxdProduct
//
//  Created by sxp on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface CashViewModel : FXD_ViewModelBaseClass


/**
 个人中心（优惠券,现金红包,账户余额）
 */
-(void)getPersonalCenterInfo;


/**
 现金红包,账户余额（点击列表操作展示提现页）

 @param operateType 操作类型（1现金红包、2账户余额）
 */
-(void)loadWithdrawCashInfoOperateType:(NSString *)operateType;


/**
 提现

 @param amount 提现金额
 @param bankCardId 银行卡id
 @param operateType 操作类型（1现金红包、2账户余额）
 @param payPassword 支付密码
 
 */
-(void)withdrawCashAmount:(NSString *)amount bankCardId:(NSString *)bankCardId operateType:(NSString *)operateType payPassword:(NSString *)payPassword;


/**
 校验提现条件

 @param operateType 操作类型（1现金红包、2账户余额）
 */
-(void)checkWithdrawCashOperateType:(NSString *)operateType;



/**
 现金红包收提明细

 @param operateType 操作类型（1现金红包、2账户余额
 @param pageNum 当前页
 @param pageSize 每页数量
 */
-(void)withdrawCashDetailOperateType:(NSString *)operateType pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize;

@end
