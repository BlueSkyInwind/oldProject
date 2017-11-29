//
//  CheckWithdrawCashModel.h
//  fxdProduct
//
//  Created by sxp on 2017/11/29.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CheckWithdrawCashModel : JSONModel

//返回状态（0校验通过、1校验异常、2已逾期、3金额不足、4未设置交易密码、5身份认证和绑卡认证未完成）
@property (strong,nonatomic)NSString<Optional> * status;
//返回消息
@property (strong,nonatomic)NSString<Optional> * message;

@end
