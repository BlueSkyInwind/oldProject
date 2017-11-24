//
//  RegionBaseClass.h
//
//  Created by dd  on 16/3/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionResult.h"
#import "RegionExt.h"
#import "RegionSub.h"
#import "RegionBaseClass.h"

@class RegionExt;

@interface RegionBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) RegionExt *ext;
@property (nonatomic, strong) NSArray *result;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
