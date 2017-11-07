//
//  SendSmsParam.h
//  fxdProduct
//
//  Created by sxp on 17/6/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SendSmsParam : JSONModel

@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *type;

@end
