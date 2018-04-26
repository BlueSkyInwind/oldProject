//
//  CardAuthSmsSendParamModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/25.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardAuthSmsSendParamModel : JSONModel

//授权平台code
@property (nonatomic, strong)NSString<Optional> *authPlatCode;
//银行code
@property (nonatomic, strong)NSString<Optional> *bankCode;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *cardNo;
//手机号
@property (nonatomic, strong)NSString<Optional> *phone;

@end
