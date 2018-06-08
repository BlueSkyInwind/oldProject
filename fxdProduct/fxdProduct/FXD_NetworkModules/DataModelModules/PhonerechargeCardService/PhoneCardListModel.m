//
//  PhoneCardListModel.m
//  fxdProduct
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "PhoneCardListModel.h"

@implementation PhoneCardListModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id":@"cardid"}];
}


@end

@implementation PhoneCardOrderModel



@end
