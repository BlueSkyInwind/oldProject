//
//  QueryCardInfo.h
//  fxdProduct
//
//  Created by sxp on 17/5/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QueryCardInfoUsrCardInfolist,QueryCardInfoData;
@interface QueryCardInfo : NSObject

@property (nonatomic,copy)NSString *flag;
@property (nonatomic,strong)QueryCardInfoData *result;
@property (nonatomic,copy)NSString *msg;
@end

@interface QueryCardInfoData : NSObject


//开户银行账号   取现银行的账户号（银行卡号）
@property (nonatomic,copy)NSString *CardId;
//消息类型    此处为QueryCardInfo
@property (nonatomic,copy)NSString *CmdId;
//商户客户号   由汇付生成，商户的唯一性标识
@property (nonatomic,copy)NSString *MerCustId;
//应答返回码   000--调用成功其他返回码见“附件七：返回码表”
@property (nonatomic,copy)NSString *RespCode;
//应答描述    返回码的对应中文描述
@property (nonatomic,copy)NSString *RespDesc;
//用户银行卡信息列表
//@property (nonatomic,copy)NSArray *UsrCardInfolist;
@property (nonatomic,strong)QueryCardInfoUsrCardInfolist *UsrCardInfolist;
//用户客户号   由汇付生成，用户的唯一性标识
@property (nonatomic,copy)NSString *UsrCustId;
//账户银行卡id
@property (nonatomic,copy)NSString *accountCardId;

@end


@interface QueryCardInfoUsrCardInfolist : NSObject

@property (nonatomic,copy)NSString *MerCustId;

@property (nonatomic,copy)NSString *UsrCustId;

@property (nonatomic,copy)NSString *UsrName;

@property (nonatomic,copy)NSString *CertId;

@property (nonatomic,copy)NSString *BankId;

@property (nonatomic,copy)NSString *bankName;

@property (nonatomic,copy)NSString *bankCode;

@property (nonatomic,copy)NSString *CardId;

@property (nonatomic,copy)NSString *RealFlag;

@property (nonatomic,copy)NSString *UpdDateTime;

@property (nonatomic,copy)NSString *ProvId;

@property (nonatomic,copy)NSString *AreaId;

@property (nonatomic,copy)NSString *IsDefault;

@property (nonatomic,copy)NSString *BindMobile;

@end
