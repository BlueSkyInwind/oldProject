//
//  P2PAgreeMentModel.m
//  fxdProduct
//
//  Created by dd on 2016/12/2.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "P2PAgreeMentModel.h"

@implementation P2PAgreeMentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[P2PAgreeMentModelData class]};
}

@end

@implementation P2PAgreeMentModelData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pactList":[Pact class]};
}

@end

@implementation Pact



@end
