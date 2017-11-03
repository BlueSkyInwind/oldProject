//
//  CardListResult.h
//
//  Created by dd  on 15/10/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CardListResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *theBank;
@property (nonatomic, strong) NSString *bankNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
