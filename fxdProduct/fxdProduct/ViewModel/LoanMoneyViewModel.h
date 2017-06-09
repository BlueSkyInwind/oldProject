//
//  LoanMoneyViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ViewModelClass.h"

@interface LoanMoneyViewModel : ViewModelClass

/**
 三方协议协议内容获取接口
 */
-(void)getProductProtocol:(NSArray *)paramArray;

/**
 
 合规的合同列表
 */
-(void)getContractList:(NSString *)bid_id;

/**
 审批金额查询接口
 */
-(void)getApprovalAmount;

@end
