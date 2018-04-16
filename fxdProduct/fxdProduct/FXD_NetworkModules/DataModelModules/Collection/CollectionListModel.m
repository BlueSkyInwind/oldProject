//
//  CollectionListModel.m
//  fxdProduct
//
//  Created by sxp on 2018/4/12.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "CollectionListModel.h"

@implementation CollectionListModel

@end

@implementation CollectionListRowsModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id_":@"id"}];
}

@end
