//
//  QryUserStatusModel.m
//  fxdProduct
//
//  Created by sxp on 17/5/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "QryUserStatusModel.h"

@implementation QryUserStatusModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[QryUserStatusResultModel class]};
}

@end

@implementation QryUserStatusResultModel


@end
