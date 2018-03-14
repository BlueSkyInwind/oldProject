//
//  SmsCodeModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/12.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SmsCodeModel : JSONModel

@property (nonatomic, strong)NSString<Optional> *BusiType;

@property (nonatomic, strong)NSString<Optional> *ChkValue;

@property (nonatomic, strong)NSString<Optional> *CmdId;

@property (nonatomic, strong)NSString<Optional> *DepoBankSeq;

@property (nonatomic, strong)NSString<Optional> *MerCustId;

@property (nonatomic, strong)NSString<Optional> *RespCode;

@property (nonatomic, strong)NSString<Optional> *RespDesc;

@property (nonatomic, strong)NSString<Optional> *SmsSeq;

@property (nonatomic, strong)NSString<Optional> *UsrCustId;

@end
