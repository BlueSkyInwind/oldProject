//
//  HomeBannerModel.m
//  fxdProduct
//
//  Created by dd on 2017/3/3.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "HomeBannerModel.h"

@implementation HomeBannerModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[HomeBannerResult class]};
}

@end


@implementation HomeBannerResult

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"files_":[HomeBannerFiles class]};
}


@end

@implementation HomeBannerFiles



@end
