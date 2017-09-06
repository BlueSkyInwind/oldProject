//
//  BankInfoViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/9/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ViewModelClass.h"

@interface BankInfoViewModel : ViewModelClass

/**
 获取用户的银行卡列表
 */
-(void)obtainUserBankCardList;

/**
 提交续期请求
 */
-(void)obtainUserCommitStaging:(NSString *)staging cardId:(NSString *)cardId;

/**
 获取续期规则
 */
-(void)obtainUserStagingRule;
@end
