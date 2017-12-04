//
//  WithdrawCashModel.h
//  fxdProduct
//
//  Created by sxp on 2017/11/27.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WithdrawCashModel : JSONModel

//提现金额
@property (strong,nonatomic)NSString<Optional> * amount;
//预计到账时间（如：2017-11-20 14:30）
@property (strong,nonatomic)NSString<Optional> * arriveDate;
//银行卡（如：招商银行 尾号6233）
@property (strong,nonatomic)NSString<Optional> * bankCode;
//返回消息
@property (strong,nonatomic)NSString<Optional> * message;
//返回状态（0提现申请已提交、1交易密码错误、2交易密码已冻结）
@property (strong,nonatomic)NSString<Optional> * status;

@end
