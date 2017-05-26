//
//  QueryCardInfo.m
//  fxdProduct
//
//  Created by sxp on 17/5/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "QueryCardInfo.h"

@implementation QueryCardInfo

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[QueryCardInfoData class]};
}

@end


@implementation QueryCardInfoData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"UsrCardInfolist":[QueryCardInfoUsrCardInfolist class]};
}

@end
@implementation QueryCardInfoUsrCardInfolist



@end
