//
//  WithdrawCashParamModel.h
//  fxdProduct
//
//  Created by sxp on 2017/11/27.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WithdrawCashParamModel : JSONModel

//提现金额
@property (nonatomic,copy)NSString *amount;
//银行卡id
@property (nonatomic,copy)NSString *bankCardId;
//支付密码
@property (nonatomic,copy)NSString *payPassword;

@end
