//
//  RegionCodeBaseClass.h
//
//  Created by dd  on 16/4/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionCodeExt.h"
#import "RegionCodeResult.h"
#import "RegionCodeBaseClass.h"

@class RegionCodeExt, RegionCodeResult;

@interface RegionCodeBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) RegionCodeExt *ext;
@property (nonatomic, strong) RegionCodeResult *result;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
