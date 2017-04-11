//
//  WeekPaySelectResult.h
//
//  Created by dd  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WeekPaySelectResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, assign) double periods;
@property (nonatomic, assign) double beOverAmount;
@property (nonatomic, assign) double amount;
@property (nonatomic, strong) NSString *socket;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, assign) double createId;
@property (nonatomic, assign) double updateId;
@property (nonatomic, assign) double loanAmount;
@property (nonatomic, strong) NSString *lastRepayDate;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) double shouldAlsoAount;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, assign) double interest;
@property (nonatomic, strong) NSString *lastUpdateDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
