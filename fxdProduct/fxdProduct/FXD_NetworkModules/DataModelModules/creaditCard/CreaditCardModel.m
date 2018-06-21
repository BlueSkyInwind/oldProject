//
//  CreaditCardModel.m
//  fxdProduct
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "CreaditCardModel.h"

@implementation CreaditCardModel

@end

@implementation CreaditCardBanksListModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"_id":@"id"}];
}
@end

@implementation CreaditCardListModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"_id":@"id"}];
}
@end

@implementation CreaditCardLevelModel

@end


@implementation CreaditCardConditionParam

@end

