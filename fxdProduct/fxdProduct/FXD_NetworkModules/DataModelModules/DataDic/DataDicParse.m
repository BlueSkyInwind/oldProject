//
//  DataDicParse.m
//  fxdProduct
//
//  Created by dd on 2017/3/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "DataDicParse.h"

@implementation DataDicParse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[DataDicResult class],
             @"ext":[DataDicExt class]};
}

@end


@implementation DataDicResult

@end

@implementation DataDicExt

@end
