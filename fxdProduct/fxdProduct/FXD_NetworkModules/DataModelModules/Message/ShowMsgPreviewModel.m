//
//  ShowMsgPreviewModel.m
//  fxdProduct
//
//  Created by sxp on 2017/12/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ShowMsgPreviewModel.h"

@implementation ShowMsgPreviewModel

@end

@implementation OperUserMassgeModel

+(JSONKeyMapper *)keyMapper{
    
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id_":@"id"}];

}

@end
