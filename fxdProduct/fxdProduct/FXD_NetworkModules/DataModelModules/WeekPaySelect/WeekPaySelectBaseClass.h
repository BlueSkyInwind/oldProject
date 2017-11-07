//
//  WeekPaySelectBaseClass.h
//
//  Created by dd  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeekPaySelectResult.h"
#import "WeekPaySelectBaseClass.h"

@class WeekPaySelectResult;

@interface WeekPaySelectBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) WeekPaySelectResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
