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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.ID = value;
}
@end

@implementation HomeProductLisTextAttr


@end
