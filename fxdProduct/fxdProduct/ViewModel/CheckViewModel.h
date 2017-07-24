//
//  CheckViewModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ViewModelClass.h"
#import "GetCaseInfo.h"
@interface CheckViewModel : ViewModelClass

/**
 审批金额查询接口
 */

-(void)approvalAmount;
@end


@interface ComplianceViewModel : ViewModelClass

/**
 获取fxd合规用户状态
 */

-(void)getUserStatus:(GetCaseInfo *)caseInfo;

/**
 提款申请件记录
 */

-(void)saveLoanCase:(NSString *)type CaseInfo:(GetCaseInfo *)caseInfo Period:(NSString *)period PurposeSelect:(NSString *)purposeSelect;

/**
 发标前查询进件
 */
-(void)getFXDCaseInfo;

@end

@interface CheckBankViewModel : ViewModelClass

/**
 银行卡获取接口
 */
-(void)getBankListInfo;

/**
 合规银行卡查询
 */
-(void)queryCardInfo;

/**
 合规银行卡列表
 */
-(void)queryCardListInfo;


@end
