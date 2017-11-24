//
//  SendSmsParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SendSmsParamModel : JSONModel

/*业务类型  开户：user_register，充值：recharge，换卡：rebind*/
@property (nonatomic,copy)NSString *busi_type_;
/*除了业务类型是recharge以外，都必传*/
@property (nonatomic,copy)NSString *card_number_;
/*手机号  银行卡号对应的银行预留手机号*/
@property (nonatomic,copy)NSString *mobile_;
/*短信类型  O-原手机号发送短信，N-新手机号。只有busi_type_为rebind时才必输*/
@property (nonatomic,copy)NSString *sms_type_;

/**/
@property (nonatomic,copy)NSString *from_mobile_;

@end
