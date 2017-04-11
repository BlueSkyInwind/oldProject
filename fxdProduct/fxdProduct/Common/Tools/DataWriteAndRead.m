//
//  WriteDataBenchmark.m
//  fxdProduct
//
//  Created by dd on 16/7/22.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "DataWriteAndRead.h"

@implementation DataWriteAndRead

+ (BOOL)writeDataWithkey:(NSString *)key value:(id)value
{
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    basePath = [basePath stringByAppendingPathComponent:@"FileCacheBenchmarkSmall"];
    YYKVStorage *yykvFile = [[YYKVStorage alloc] initWithPath:[basePath stringByAppendingPathComponent:@"yykvFile"] type:YYKVStorageTypeFile];
    return [yykvFile saveItemWithKey:key value:[NSKeyedArchiver archivedDataWithRootObject:value] filename:key extendedData:nil];
}

+ (id)readDataWithkey:(NSString *)key
{
     NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    basePath = [basePath stringByAppendingPathComponent:@"FileCacheBenchmarkSmall"];
    YYKVStorage *yykvFile = [[YYKVStorage alloc] initWithPath:[basePath stringByAppendingPathComponent:@"yykvFile"] type:YYKVStorageTypeFile];
    YYKVStorageItem *item = [yykvFile getItemForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:item.value];
}

@end
