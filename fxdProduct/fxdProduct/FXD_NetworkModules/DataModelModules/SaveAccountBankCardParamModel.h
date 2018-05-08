//
//  SaveAccountBankCardParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SaveAccountBankCardParamModel : JSONModel

//卡名称
@property (nonatomic,copy)NSString *card_bank_;
//卡类型  1-信用卡；2-借记卡
@property (nonatomic,copy)NSString *card_type_;
//银行卡号
@property (nonatomic,copy)NSString *card_no_;
//手机号码
@property (nonatomic,copy)NSString *bank_reserve_phone_;
//验证码
@property (nonatomic,copy)NSString *verify_code_;
//信用卡安全码  信用卡必传
@property (nonatomic,copy)NSString *card_cvv2_;
//信用卡有效期  格式MMYY，形如0418
@property (nonatomic,copy)NSString *card_date_;
//请求类型
@property (nonatomic,copy)NSString *reques_type_;

@end
