//
//  BankModel.m
//  fxdProduct
//
//  Created by dd on 7/11/16.
//  Copyright © 2016 dd. All rights reserved.
//

#import "BankModel.h"


@implementation BankModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : [BankList class]};
}

@end
