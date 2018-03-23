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


@end
