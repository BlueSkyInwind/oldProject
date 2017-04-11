//
//  CustomerCareerBaseClass.h
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomerCareerExt.h"
#import "CustomerCareerResult.h"
#import "CustomerCareerBaseClass.h"

@class CustomerCareerExt, CustomerCareerResult;

@interface CustomerCareerBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) CustomerCareerExt *ext;
@property (nonatomic, strong) CustomerCareerResult *result;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
