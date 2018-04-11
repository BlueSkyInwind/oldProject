//
//  QBBWitnDrawModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/10.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QBBWitnDrawModel : JSONModel

//钱爸爸提供的公司商户号
@property (nonatomic, strong)NSString<Optional> *merchant;
//交易流水号
@property (nonatomic, strong)NSString<Optional> *orderId;
//前端交易页面跳转到钱爸爸提现的url
@property (nonatomic, strong)NSString<Optional> *requesturl;
//前端交易页面异步跳转回发薪贷平台的url
@property (nonatomic, strong)NSString<Optional> *returnurl;
//签名串
@property (nonatomic, strong)NSString<Optional> *sign;
//合作商平台的用户唯一识别id（发薪贷用户id）
@property (nonatomic, strong)NSString<Optional> *thirdCustId;
//当前时间时间戳
@property (nonatomic, strong)NSString<Optional> *timestamp;
//发薪贷token
@property (nonatomic, strong)NSString<Optional> *token;
//功能码，代表业务的识别类型
@property (nonatomic, strong)NSString<Optional> *tranCode;
//发薪贷用户在钱爸爸平台的用户id
@property (nonatomic, strong)NSString<Optional> *userId;

@end
