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
    return @{@"data":[HomeProductListData class]};
}

@end


@implementation HomeProductListData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"bannerList":[HomeBannerList class],
             @"popList":[HomePopList class],
             @"productList":[HomeProductsList class]
             };
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

@implementation HomeBannerList

@end

@implementation HomePaidList



@end

@implementation HomePopList


@end

@implementation HomeProductsList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"products":[HomeProductListProducts class]};
}

@end
