//
//  SmsCodeParamModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SmsCodeParamModel : JSONModel

//业务类型:user_register(开户),rebind(换绑卡),recharge(充值)
@property (nonatomic, strong)NSString<Optional> *BusiType;
//换绑卡时短信类型O(旧的);N(新的) 非必传，开户可以不传
@property (nonatomic, strong)NSString<Optional> *SmsTempType;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *bankCardNo;
//资金平台1，合规
@property (nonatomic, strong)NSString<Optional> *capitalPlatform;
//银行预留手机号
@property (nonatomic, strong)NSString<Optional> *mobile;
//用户平台编号
@property (nonatomic, strong)NSString<Optional> *userCode;
//客户端  1:PC,2:微信,3:苹果,4:安卓
@property (nonatomic, strong)NSString<Optional> *client;

@end
