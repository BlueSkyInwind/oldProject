//
//  ActiveModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/15.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ActiveInMapModel <NSObject>


@end

@interface ActiveModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * RetCode;
@property(nonatomic,strong)NSString<Optional> * RetMessage;
@property(nonatomic,strong)NSString<Optional> * ServiceUrl;

@property(nonatomic,strong)NSDictionary<Optional> * InMap;

@end

@interface ActiveInMapModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * UsrCustId;

@property(nonatomic,strong)NSString<Optional> * Version;

@property(nonatomic,strong)NSString<Optional> * MerCustId;

@property(nonatomic,strong)NSString<Optional> * OrdId;

@property(nonatomic,strong)NSString<Optional> * RetUrl;

@property(nonatomic,strong)NSString<Optional> * ChkValue;

@property(nonatomic,strong)NSString<Optional> * CmdId;

@property(nonatomic,strong)NSString<Optional> * OrdDate;

@property(nonatomic,strong)NSString<Optional> * PageType;

@property(nonatomic,strong)NSString<Optional> * BgRetUrl;

@end
