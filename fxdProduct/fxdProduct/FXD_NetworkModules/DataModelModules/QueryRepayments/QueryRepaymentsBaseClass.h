//
//  QueryRepaymentsBaseClass.h
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryRepaymentsResult.h"
#import "QueryRepaymentsData.h"
#import "QueryRepaymentsBaseClass.h"
#import "QueryRepaymentsLoanApplicant.h"

@class QueryRepaymentsResult;

@interface QueryRepaymentsBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) QueryRepaymentsResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
