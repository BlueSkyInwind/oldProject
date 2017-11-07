//
//  CareerParse.m
//  fxdProduct
//
//  Created by dd on 2017/2/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CareerParse.h"

@implementation CareerParse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ext":[CareerExt class],
             @"result":[CareerResult class]};
}

@end


@implementation CareerExt

@end

@implementation CareerResult

@end
