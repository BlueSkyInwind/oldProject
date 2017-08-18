//
//  HomeProductList.m
//  fxdProduct
//
//  Created by sxp on 17/4/26.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "HomeProductList.h"

@implementation HomeProductList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[HomeProductListResult class]};
}

@end


@implementation HomeProductListResult

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"products":[HomeProductListProducts class]};
}


@end

@implementation HomeProductListProducts

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ext_attr_":[HomeProductLisTextAttr class]};
}
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"id_":@"id"};
}

@end

@implementation HomeProductLisTextAttr


@end
