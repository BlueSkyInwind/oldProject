//
//  AccountModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BankListModel <NSObject>

@end


@interface BankListModel : JSONModel
//默认银行名称
@property (nonatomic, strong)NSString<Optional> *bankCode;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *bankName;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *bankNo;
//默认银行名称
@property (nonatomic, strong)NSString<Optional> *createTime;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *imgUrl;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *quickPaymentFlag;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *status;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *updateTime;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *id_;
@end

@interface AccountModel : JSONModel
//默认银行名称
@property (nonatomic, strong)NSString<Optional> *bankName;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *bankNum;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *bankShortName;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *cardId;
//身份证号码
@property (nonatomic, strong)NSString<Optional> *idCode;
//姓名
@property (nonatomic, strong)NSString<Optional> *name;
//银行预留手机号
@property (nonatomic, strong)NSString<Optional> *telephone;
//银行预留手机号
@property (nonatomic, strong)NSString<Optional> *userCode;
//银行编号
@property (nonatomic, strong)NSString<Optional> *bankNo;
//支持银行列表
@property(nonatomic,strong)NSArray<BankListModel,Optional> * bankList;

@end



