//
//  QueryCardInfo.h
//  fxdProduct
//
//  Created by sxp on 17/5/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryCardInfo : NSObject

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
@property (nonatomic,copy)NSString *UsrCardInfolist;
//用户客户号   由汇付生成，用户的唯一性标识
@property (nonatomic,copy)NSString *UsrCustId;



@end
