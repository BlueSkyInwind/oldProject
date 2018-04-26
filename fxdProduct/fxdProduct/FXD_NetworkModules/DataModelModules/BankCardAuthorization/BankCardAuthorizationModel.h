//
//  BankCardAuthorizationModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/25.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol BankCardAuthorizationAuthListModel <NSObject>

@end

@interface BankCardAuthorizationAuthListModel : JSONModel

//授权平台code
@property (nonatomic, strong)NSString<Optional> *authPlatCode;
//授权平台名称
@property (nonatomic, strong)NSString<Optional> *authPlatName;


@end

@interface BankCardAuthorizationModel : JSONModel

//需授权列表
@property (nonatomic, strong)NSArray<BankCardAuthorizationAuthListModel,Optional> *authList;
//需授权数量
@property (nonatomic, strong)NSString<Optional> *authCount;

@end
