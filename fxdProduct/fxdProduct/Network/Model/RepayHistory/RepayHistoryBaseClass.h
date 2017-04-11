//
//  RepayHistoryBaseClass.h
//
//  Created by dd  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepayHistoryResult.h"
#import "RepayHistoryBaseClass.h"
#import "RepayHistoryCapitalFlowList.h"

@class RepayHistoryResult;

@interface RepayHistoryBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) RepayHistoryResult *result;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
