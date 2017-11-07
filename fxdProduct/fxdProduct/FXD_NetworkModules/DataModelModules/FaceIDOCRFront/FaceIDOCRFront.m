//
//  FaceIDOCRFront.m
//  fxdProduct
//
//  Created by dd on 2017/2/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FaceIDOCRFront.h"

@implementation FaceIDOCRFront

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"head_rect":[HeadRect class],
             @"birthday":[Birthday class],
             @"legality":[FaceIDOCRFrontLegality class]};
}

@end

@implementation FaceIDOCRFrontLegality

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"iD_Photo":@"ID Photo",
             @"temporary_ID_Photo":@"Temporary ID Photo"};
}

@end

@implementation HeadRect

@end

@implementation Birthday

@end

@implementation Lt

@end

@implementation Lb

@end

@implementation Rt

@end

@implementation Rb

@end
