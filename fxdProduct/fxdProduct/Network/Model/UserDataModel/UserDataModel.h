//
//  UserDataModel.h
//  fxdProduct
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserDataModel : JSONModel

@property (strong,nonatomic)NSString<Optional> * nextStep;
@property (strong,nonatomic)NSString<Optional> * resultcode;
@property (strong,nonatomic)NSString<Optional> * rulesid;
@property (strong,nonatomic)NSString<Optional> * isMobileAuth;
@property (strong,nonatomic)NSString<Optional> * isZmxyAuth;  // 1 未认证    2 认证通过   3 认证未通过
@property (strong,nonatomic)NSString<Optional> * TRUCKS_;  // 手机认证通道 JXL 表示聚信立，TC 表示天创认证
@property (strong,nonatomic)NSString<Optional> * isInfoEditable;


@end
