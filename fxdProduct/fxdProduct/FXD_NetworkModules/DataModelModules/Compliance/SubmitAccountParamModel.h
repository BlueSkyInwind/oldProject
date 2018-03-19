//
//  SubmitAccountParamModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SubmitAccountParamModel : JSONModel

//银行编号
@property (nonatomic, strong)NSString<Optional> *bankNo;
//银行预留手机
@property (nonatomic, strong)NSString<Optional> *bankReservePhone;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *cardNo;
//绑定的银行卡id，没有不传    
@property (nonatomic, strong)NSString<Optional> *cardId;
//页面返回地址
@property (nonatomic, strong)NSString<Optional> *retUrl;
//短信验证序列号
@property (nonatomic, strong)NSString<Optional> *smsSeq;
//短信验证码
@property (nonatomic, strong)NSString<Optional> *verifyCode;
//银行名称缩写
@property (nonatomic, strong)NSString<Optional> *bankShortName;
//合规用户编号
@property (nonatomic, strong)NSString<Optional> *userCode;
@end
