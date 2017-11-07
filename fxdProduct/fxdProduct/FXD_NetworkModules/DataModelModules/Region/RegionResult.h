//
//  RegionResult.h
//
//  Created by dd  on 16/3/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RegionResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *sub;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double type;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
