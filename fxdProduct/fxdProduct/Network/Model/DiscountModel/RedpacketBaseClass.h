//
//  RedpacketBaseClass.h
//
//  Created by dd  on 16/5/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedpacketExt.h"
#import "RedpacketResult.h"
#import "RedpacketBaseClass.h"

@class RedpacketExt;

@interface RedpacketBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) RedpacketExt *ext;
@property (nonatomic, strong) NSArray *result;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
