//
//  UserDataResult.h
//  fxdProduct
//
//  Created by sxp on 2017/9/12.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserDataResult : JSONModel

//评测状态   00:未测评;10:测评中;20:测评不通过;30:测评通过
@property (strong,nonatomic)NSString<Optional> * rc_status;

@end

@interface UserDataMeatureParam: JSONModel

@property (strong,nonatomic)NSString<Optional> * product_id;
@property (strong,nonatomic)NSString<Optional> * service_platform_flag;   //新增字段：新版本必传，老版本非必传(线下及其老版本:1010;线上:2020)

@end



