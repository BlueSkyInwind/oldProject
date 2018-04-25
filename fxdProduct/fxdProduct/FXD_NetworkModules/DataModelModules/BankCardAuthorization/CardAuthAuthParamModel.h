//
//  CardAuthAuthParamModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/25.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol CardAuthAuthAuthCodeListParamModel <NSObject>

@end

@interface CardAuthAuthAuthCodeListParamModel : JSONModel

//平台code
@property (nonatomic, strong)NSString<Optional> *authPlatCode;
//授权短信
@property (nonatomic, strong)NSString<Optional> *authSmsCode;


@end

@interface CardAuthAuthParamModel : JSONModel

//
@property (nonatomic, strong)NSArray<CardAuthAuthAuthCodeListParamModel,Optional> *authCodeList;
//银行code
@property (nonatomic, strong)NSString<Optional> *bankCode;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *cardNo;
//手机号
@property (nonatomic, strong)NSString<Optional> *phone;

@end



