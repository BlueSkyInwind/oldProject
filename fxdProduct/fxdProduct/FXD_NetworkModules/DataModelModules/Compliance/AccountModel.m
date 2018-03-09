//
//  AccountModel.m
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

@end

@implementation BankListModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id_":@"id"}];
}

@end
