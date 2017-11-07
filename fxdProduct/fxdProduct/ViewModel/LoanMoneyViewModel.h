//
//  LoanMoneyViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface LoanMoneyViewModel : FXD_ViewModelBaseClass

/**
 三方协议协议内容获取接口
 */
-(void)getProductProtocol:(NSArray *)paramArray;

/**
 
 合规的合同列表
 */
-(void)getContractList:(NSString *)bid_id;

/**
 合规合同内容

 @param pact_no_
 @param bid_id_
 @param debt_id_
 */
-(void)getContactCon:(NSString *)pact_no_  Bid_id_:(NSString *)bid_id_  Debt_id_:(NSString *)debt_id_;


/**
 审批金额查询接口
 */
-(void)getApprovalAmount;

/**
 放款中 还款中 展期中 状态实时获取
 */
-(void)getApplicationStatus:(NSString *)flag;

/**
 待还款界面信息获取
 */

-(void)getRepayInfo;

@end
