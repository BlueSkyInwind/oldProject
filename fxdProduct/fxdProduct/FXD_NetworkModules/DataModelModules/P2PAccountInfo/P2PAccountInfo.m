//
//  P2PAccountInfo.m
//  fxdProduct
//
//  Created by dd on 2016/10/11.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "P2PAccountInfo.h"

@implementation P2PAccountInfo

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[P2PAccountData class]};
}

@end


@implementation P2PAccountData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"accountInfo":[AccountInfo class]};
}

@end

@implementation AccountInfo



@end
