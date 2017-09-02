//
//  BankCardLlistModel.h
//  fxdProduct
//
//  Created by sxp on 2017/9/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BankCardLlistModel : JSONModel

//银行卡名称
@property (strong,nonatomic)NSString<Optional> * bankName;
//银行卡图标
@property (strong,nonatomic)NSString<Optional> * cardIcon;
//银行卡id
@property (strong,nonatomic)NSString<Optional> * cardId;
//银行卡号
@property (strong,nonatomic)NSString<Optional> * cardNo;
//银行卡缩写
@property (strong,nonatomic)NSString<Optional> * cardShortName;
//银行卡类型
@property (strong,nonatomic)NSString<Optional> * cardType;

@end
