//
//  JXLParse.m
//  fxdProduct
//
//  Created by dd on 2017/2/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "JXLParse.h"

@implementation JXLParse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[JXLData class]};
}

@end


@implementation JXLData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"datasource":[KXLDataSource class]};
}

@end

@implementation KXLDataSource

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"update_time":[Update_time class],
             @"create_time":[Create_time class]};
}


+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"dataId":@"id"};
}

@end

@implementation Update_time



@end

@implementation Create_time



@end
