//
//  RateModel.m
//  fxdProduct
//
//  Created by dd on 2017/3/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "RateModel.h"

@implementation RateModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[RateModelResult class]};
}

@end

@implementation RateModelResult

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"id_":@"id"};
}

@end
