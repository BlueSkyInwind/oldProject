//
//  BankInfoViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/9/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface BankInfoViewModel : FXD_ViewModelBaseClass

/**
 获取用户的银行卡列表
 */
-(void)obtainUserBankCardListPlatformType:(NSString *)platformType;

/**
 提交续期请求
 */
-(void)obtainUserCommitStaging:(NSString *)staging cardId:(NSString *)cardId;

/**
 获取续期规则
 */
-(void)obtainUserStagingRule;


-(void)obtainTrilateralLink:(NSString * )stagingId redPacketAmount:(NSString *)redPacketAmount redPacketId:(NSString *)redPacketId  payType:(NSString *)payType stagingContinue:(BOOL)stagingContinue;

/**
 选择模式的列表
 */
-(void)ChoosePatternList;

@end
