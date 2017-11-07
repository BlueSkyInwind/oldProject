//
//  AuthStatus.m
//  fxdProduct
//
//  Created by dd on 2016/11/8.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "AuthStatus.h"

@implementation AuthStatus

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[AuthStatusResult class]};
}


@end

@implementation AuthStatusResult

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"qq_status":@"qq_status_",
             @"alipay_status":@"alipay_status_"};
}

@end
