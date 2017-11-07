//
//  LoanRecordParse.m
//  fxdProduct
//
//  Created by dd on 2017/2/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanRecordParse.h"

@implementation LoanRecordParse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ext":[LoanRecordExt class],
             @"result":[LoanRecordResult class]};
}

@end

@implementation LoanRecordExt

@end

@implementation LoanRecordResult

@end
