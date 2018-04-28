//
//  HotRecommendModel.m
//  fxdProduct
//
//  Created by sxp on 2018/4/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "HotRecommendModel.h"

@implementation HotRecommendModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id_":@"id"}];
}
@end
