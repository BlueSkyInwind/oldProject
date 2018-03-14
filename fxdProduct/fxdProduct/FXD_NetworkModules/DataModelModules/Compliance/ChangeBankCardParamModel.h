//
//  ChangeBankCardParamModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/13.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ChangeBankCardParamModel : JSONModel

//银行编号
@property(nonatomic,strong)NSString<Optional> * bankNo;
//银行预留手机
@property(nonatomic,strong)NSString<Optional> * bankReservePhone;
//银行卡号
@property(nonatomic,strong)NSString<Optional> * cardNo;
//旧绑定银行卡短信验证码
@property(nonatomic,strong)NSString<Optional> * orgSmsCode;
//旧绑定银行卡短信序号
@property(nonatomic,strong)NSString<Optional> * orgSmsSeq;
//短信验证序列号
@property(nonatomic,strong)NSString<Optional> * smsSeq;
//合规用户编号
@property(nonatomic,strong)NSString<Optional> * userCode;
//短信验证码
@property(nonatomic,strong)NSString<Optional> * verifyCode;


@end
