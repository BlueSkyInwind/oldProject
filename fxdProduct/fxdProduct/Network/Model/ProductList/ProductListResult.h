//
//  ProductListResult.h
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProductListResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *stagingDuration;
@property (nonatomic, assign) double stagingTop;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *resultIdentifier;
@property (nonatomic, assign) double dayServiceFeeRate;
@property (nonatomic, assign) double liquidatedDamages;
@property (nonatomic, assign) double stagingBottom;
@property (nonatomic, assign) double principalBottom;
@property (nonatomic, assign) double principalTop;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
