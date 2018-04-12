//
//  ApplicationNewCreateModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/9.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ApplicationNewCreateModel : JSONModel

//进件平台类型
@property(nonatomic,strong)NSString<Optional> * platformType;
//状态 1:未开户 2：开户中 3:已开户 4:待激活
@property(nonatomic,strong)NSString<Optional> * userStatus;

@end
