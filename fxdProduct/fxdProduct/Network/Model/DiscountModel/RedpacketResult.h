//
//  RedpacketResult.h
//
//  Created by dd  on 16/5/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RedpacketResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL valid;
@property (nonatomic, assign) double totalAmount;
@property (nonatomic, strong) NSString *resultIdentifier;
@property (nonatomic, strong) NSString *validityPeriodFrom;
@property (nonatomic, strong) NSString *redpacketName;
@property (nonatomic, strong) NSString *validityPeriodTo;
@property (nonatomic, strong) NSString *useConditions;
@property (nonatomic, assign) double residualAmount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
