//
//  ShouldAlsoAmountResult.h
//
//  Created by dd  on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ShouldAlsoAmountResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, assign) double updateId;
@property (nonatomic, assign) double shouldAlsoAount;
@property (nonatomic, strong) NSString *token;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
