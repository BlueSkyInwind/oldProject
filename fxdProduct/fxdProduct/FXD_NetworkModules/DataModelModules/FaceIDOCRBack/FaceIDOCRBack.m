//
//  FaceIDOCRBack.m
//  fxdProduct
//
//  Created by dd on 2017/2/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FaceIDOCRBack.h"

@implementation FaceIDOCRBack

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"legality":[FaceIDOCRBackLegality class]};
}

@end


@implementation FaceIDOCRBackLegality

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"iD_Photo":@"ID Photo",
             @"temporary_ID_Photo":@"Temporary ID Photo"};
}

@end
