//
//  AuthStatus.h
//  fxdProduct
//
//  Created by dd on 2016/11/8.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AuthStatusResult;

@interface AuthStatus : NSObject

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) AuthStatusResult *result;


@end


@interface AuthStatusResult : NSObject

@property (nonatomic, copy) NSString *appcode;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *qq_status;

@property (nonatomic, copy) NSString *qq_dec;

@property (nonatomic, copy) NSString *alipay_status;

@property (nonatomic, copy) NSString *alipay_dec;


@end
