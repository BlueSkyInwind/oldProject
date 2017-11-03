//
//  BankCardsParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/5.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BankCardsParamModel : JSONModel

/*银行代号*/
@property (nonatomic,copy)NSString *bank_code_;
/*银行卡号*/
@property (nonatomic,copy)NSString *card_number_;
/*账户手机号*/
@property (nonatomic,copy)NSString *from_mobile_;
/*银行卡绑定手机号*/
@property (nonatomic,copy)NSString *mobile_;
/*原手机验证码扩展域*/
@property (nonatomic,copy)NSString *ordsms_ext_;
/*手机验证码*/
@property (nonatomic,copy)NSString *sms_code_;
/*验证码序列号*/
@property (nonatomic,copy)NSString *sms_seq_;
/*业务类型*/
@property (nonatomic,copy)NSString *trade_type_;

@end
