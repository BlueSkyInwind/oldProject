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

//新的api
@property (strong,nonatomic)NSString<Optional> * gathering;
@property (strong,nonatomic)NSString<Optional> * gatheringEdit;
@property (strong,nonatomic)NSString<Optional> * identity;
@property (strong,nonatomic)NSString<Optional> * identityEdit;
@property (strong,nonatomic)NSString<Optional> * others;
@property (strong,nonatomic)NSString<Optional> * person;
@property (strong,nonatomic)NSString<Optional> * personEdit;
@property (strong,nonatomic)NSString<Optional> * edit;
@property (strong,nonatomic)NSString<Optional> * test;
@property (strong,nonatomic)NSString<Optional> * faceIdentity;
@property (strong,nonatomic)NSString<Optional> * telephone;
@property (strong,nonatomic)NSString<Optional> * telephoneEdit;
@property (strong,nonatomic)NSString<Optional> * zmIdentity;
@property (strong,nonatomic)NSString<Optional> * zmIdentityEdit;


@end


@interface UserThirdPartCertificationModel : JSONModel

@property (strong,nonatomic)NSString<Optional> * faceIdentity;
@property (strong,nonatomic)NSString<Optional> * telephone;
@property (strong,nonatomic)NSString<Optional> * zmIdentity;

@end







