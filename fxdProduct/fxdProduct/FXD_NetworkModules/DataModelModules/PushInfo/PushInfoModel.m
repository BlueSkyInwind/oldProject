//
//  PushInfoModel.m
//  fxdProduct
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "PushInfoModel.h"

@implementation PushInfoModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"messageID"}];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.messageID = value;
    }
}



@end
