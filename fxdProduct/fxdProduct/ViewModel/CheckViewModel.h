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
 支持银行卡列表
 
 @param platform 平台     2 - 银生宝   4 - 汇付
 */
-(void)getSupportBankListInfo:(NSString *)platform;




@end
