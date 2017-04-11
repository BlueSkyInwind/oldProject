//
//  RepayHistoryResult.h
//
//  Created by dd  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RepayHistoryResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double capitalFlowCount;
@property (nonatomic, strong) NSArray *capitalFlowList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
