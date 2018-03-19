//
//  CheckViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"
@interface CheckViewModel : FXD_ViewModelBaseClass


#pragma mark - 新API
//提款信息页面
-(void)obtainDrawingInformation;

/**
 工薪贷获取费用
 */
-(void)obtainSalaryProductFeeOfperiod:(NSString *)periods;
/**
 提款
 
 @param period_ 期数
 @param loan_for_ 用途
 @param drawAmount 金额
 @param card_id 卡id
 */
-(void)withDrawalsApplyPeriod:(NSString *)period_ loan_for:(NSString *)loan_for_ DrawAmount:(NSString *)drawAmount  card_id:(NSString *)card_id;

/**
 新版提款

 @param card_id 卡id
 */
-(void)newWithDrawalsApplyCard_id:(NSString *)card_id;
/**
 新的提款信息获取
 */
-(void)withDrawFundsInfoApply;

@end

@interface CheckBankViewModel : FXD_ViewModelBaseClass

/**
 银行卡获取接口
 */
//-(void)getBankListInfo;

/**
 支持银行卡列表
 
 @param platform 平台     2 - 银生宝   4 - 汇付
 */
-(void)getSupportBankListInfo:(NSString *)platform;

/**
 合规银行卡查询
 */
-(void)queryCardInfo;



@end
