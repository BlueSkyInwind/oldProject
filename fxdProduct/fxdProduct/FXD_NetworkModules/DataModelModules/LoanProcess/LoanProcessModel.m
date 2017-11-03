//
//  LoanProcessModel.m
//  fxdProduct
//
//  Created by dd on 2017/2/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanProcessModel.h"

@implementation LoanProcessModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ext":[LoanProcessExt class],
             @"result":[LoanProcessResult class]};
}

@end


@implementation LoanProcessExt

@end


@implementation LoanProcessResult

@end
