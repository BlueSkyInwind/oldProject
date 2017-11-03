//
//  ChangePasswordParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ChangePasswordParamModel : JSONModel

@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *smscode;
@property (nonatomic,copy)NSString *password;
@end
