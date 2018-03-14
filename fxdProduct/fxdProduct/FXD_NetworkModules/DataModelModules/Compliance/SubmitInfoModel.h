//
//  SubmitInfoModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/12.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol InMapModel <NSObject>


@end

@interface SubmitInfoModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * RetCode;
@property(nonatomic,strong)NSString<Optional> * RetMessage;
@property(nonatomic,strong)NSString<Optional> * ServiceUrl;

@property(nonatomic,strong)NSDictionary<Optional> * InMap;

@end


@interface InMapModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * CardId;

@property(nonatomic,strong)NSString<Optional> * MerPriv;

@property(nonatomic,strong)NSString<Optional> * IdType;

@property(nonatomic,strong)NSString<Optional> * SmsSeq;

@property(nonatomic,strong)NSString<Optional> * UsrName;

@property(nonatomic,strong)NSString<Optional> * ProvId;

@property(nonatomic,strong)NSString<Optional> * AreaId;

@property(nonatomic,strong)NSString<Optional> * BgRetUrl;

@property(nonatomic,strong)NSString<Optional> * RetUrl;

@property(nonatomic,strong)NSString<Optional> * SmsCode;

@property(nonatomic,strong)NSString<Optional> * IdNo;

@property(nonatomic,strong)NSString<Optional> * MerCustId;

@property(nonatomic,strong)NSString<Optional> * PageType;

@property(nonatomic,strong)NSString<Optional> * BankId;

@property(nonatomic,strong)NSString<Optional> * CmdId;

@property(nonatomic,strong)NSString<Optional> * ChkValue;

//@property(nonatomic,strong)NSString<Optional> * UsrEmail;

@property(nonatomic,strong)NSString<Optional> * UsrId;

@property(nonatomic,strong)NSString<Optional> * UsrMp;

@property(nonatomic,strong)NSString<Optional> * Version;

@property(nonatomic,strong)NSString<Optional> * CharSet;
@end

