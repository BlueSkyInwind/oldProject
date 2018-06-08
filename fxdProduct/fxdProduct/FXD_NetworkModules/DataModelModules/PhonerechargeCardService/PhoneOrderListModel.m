//
//  PhoneOrderListModel.m
//  fxdProduct
//
//  Created by sxp on 2018/6/8.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "PhoneOrderListModel.h"

@implementation PhoneOrderListModel

@end

@implementation PhoneOrderDetailModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"orderID":@"id",@"allPwd":@"copyAll"}];
}
@end

@implementation PhoneCardInfoModel

@end

