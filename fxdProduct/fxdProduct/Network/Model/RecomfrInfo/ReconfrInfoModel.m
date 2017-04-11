//
//  ReconfrInfoModel.m
//  fxdProduct
//
//  Created by dd on 2017/3/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ReconfrInfoModel.h"

@implementation ReconfrInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[ReconfrInfoModelResult class]};
}

@end


@implementation ReconfrInfoModelResult

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list":[ReconfrList class]};
}

@end

@implementation ReconfrList


@end
