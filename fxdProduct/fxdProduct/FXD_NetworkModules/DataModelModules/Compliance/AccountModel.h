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


@end

@interface AccountModel : JSONModel
//默认银行名称
@property (nonatomic, strong)NSString<Optional> *bankName;
//银行卡号
@property (nonatomic, strong)NSString<Optional> *bankNum;
//身份证号码
@property (nonatomic, strong)NSString<Optional> *idCode;
//姓名
@property (nonatomic, strong)NSString<Optional> *name;
//银行预留手机号
@property (nonatomic, strong)NSString<Optional> *telephone;
//支持银行列表
@property(nonatomic,strong)NSArray<BankListModel,Optional> * bankList;

@end



