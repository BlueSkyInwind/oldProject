//
//  WriteDataBenchmark.h
//  fxdProduct
//
//  Created by dd on 16/7/22.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataWriteAndRead : NSObject

+ (BOOL)writeDataWithkey:(NSString *)key value:(id)value;

+ (id)readDataWithkey:(NSString *)key;

@end
