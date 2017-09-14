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

#pragma mark - 新API
//提款信息页面
-(void)obtainDrawingInformation;

/**
 工薪贷获取费用
 */
-(void)obtainSalaryProductFeeOfperiod:(NSString *)periods;


@end


@interface ComplianceViewModel : ViewModelClass

/**
 获取fxd合规用户状态
 */

-(void)getUserStatus:(NSString *)applicationId;

/**
 提款申请件记录
 */

-(void)saveLoanCase:(NSString *)type ApplicationID:(NSString *)applicationId Period:(NSString *)period PurposeSelect:(NSString *)purposeSelect;

/**
 发标前查询进件
 */
-(void)getFXDCaseInfo;



@end

@interface CheckBankViewModel : ViewModelClass

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

/**
 合规银行卡列表
 */
//-(void)queryCardListInfo;


@end
