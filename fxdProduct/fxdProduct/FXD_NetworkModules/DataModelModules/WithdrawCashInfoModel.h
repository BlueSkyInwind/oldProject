//
//  WithdrawCashInfoModel.h
//  fxdProduct
//
//  Created by sxp on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WithdrawCashInfoModel : JSONModel

//我的现金||账户余额
@property (strong,nonatomic)NSString<Optional> * amount;
//返回消息
@property (strong,nonatomic)NSString<Optional> * message;
//常见问题
@property (strong,nonatomic)NSString<Optional> * problemDesc;
//提现红包id
@property (strong,nonatomic)NSString<Optional> * redpacketId;
//返回状态（0成功、1已逾期、2金额不足、3未设置交易密码、4身份认证和绑卡认证未完成）
@property (strong,nonatomic)NSString<Optional> * status;
//提现说明
@property (strong,nonatomic)NSString<Optional> * withdrawDesc;

@end
