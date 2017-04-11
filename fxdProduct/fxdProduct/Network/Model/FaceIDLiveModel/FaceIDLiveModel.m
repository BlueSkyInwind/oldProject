//
//  FaceIDLiveModel.m
//  fxdProduct
//
//  Created by dd on 2017/2/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FaceIDLiveModel.h"

@implementation FaceIDLiveModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"id_exceptions":[Id_exceptions class],
             @"result_faceid":[Result_faceid class],
             @"face_genuineness":[Face_genuineness class]};
}

@end


@implementation Id_exceptions



@end

@implementation Result_faceid

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"thresholds":[Thresholds class]};
}

@end

@implementation Face_genuineness



@end

@implementation Thresholds

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"e3":@"1e-3",
             @"e6":@"1e-6",
             @"e4":@"1e-4",
             @"e5":@"1e-5"};
}

@end
