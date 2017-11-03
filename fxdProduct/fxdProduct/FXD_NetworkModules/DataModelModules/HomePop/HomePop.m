//
//  HomePop.m
//  fxdProduct
//
//  Created by dd on 2016/11/30.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "HomePop.h"

@implementation HomePop

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[HomePopResult class]};
}

@end


@implementation HomePopResult

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"files_":[PicFileInfo class]};
}

@end

@implementation PicFileInfo



@end
