//
//  QbbSubmitInfoModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QbbSubmitInfoModel : JSONModel

//钱爸爸提供的公司商户号
@property (nonatomic, strong)NSString<Optional> *actionUrl;
//交易流水号
@property (nonatomic, strong)NSString<Optional> *mobile;
//前端交易页面跳转到钱爸爸提现的url
@property (nonatomic, strong)NSString<Optional> *timestamp;
//前端交易页面异步跳转回发薪贷平台的url
@property (nonatomic, strong)NSString<Optional> *merchant;
//签名串
@property (nonatomic, strong)NSString<Optional> *tranCode;
//合作商平台的用户唯一识别id（发薪贷用户id）
@property (nonatomic, strong)NSString<Optional> *userId;
//当前时间时间戳
@property (nonatomic, strong)NSString<Optional> *token;
//发薪贷token
@property (nonatomic, strong)NSString<Optional> *idNo;
//签名串
@property (nonatomic, strong)NSString<Optional> *orderId;
//合作商平台的用户唯一识别id（发薪贷用户id）
@property (nonatomic, strong)NSString<Optional> *accNo;
//当前时间时间戳
@property (nonatomic, strong)NSString<Optional> *returnurl;
//发薪贷token
@property (nonatomic, strong)NSString<Optional> *idType;
//签名串
@property (nonatomic, strong)NSString<Optional> *thirdCustId;
//合作商平台的用户唯一识别id（发薪贷用户id）
@property (nonatomic, strong)NSString<Optional> *name;
//当前时间时间戳
@property (nonatomic, strong)NSString<Optional> *sign;

@end
