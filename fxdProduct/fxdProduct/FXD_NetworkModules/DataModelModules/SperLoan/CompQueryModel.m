//
//  CompQueryModel.m
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "CompQueryModel.h"

@implementation CompQueryModel

@end

@implementation RowsModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id_":@"id"}];
}

@end


