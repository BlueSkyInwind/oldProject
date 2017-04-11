//
//  BankList.m
//  fxdProduct
//
//  Created by dd on 7/11/16.
//  Copyright © 2016 dd. All rights reserved.
//

#import "BankList.h"

@implementation BankList

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"desc":@"desc_",
             @"code":@"code_",
            };
}

@end
