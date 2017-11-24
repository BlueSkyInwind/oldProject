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

@end
