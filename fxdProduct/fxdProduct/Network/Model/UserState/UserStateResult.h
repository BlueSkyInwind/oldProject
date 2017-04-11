//
//  UserStateResult.h
//
//  Created by dd  on 15/12/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserStateResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) double beOverAmount;
@property (nonatomic, strong) NSString *surplusRepayDay;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, assign) double shouldAlsoAmount;
@property (nonatomic, assign) double loanAmount;
@property (nonatomic, assign) double manageExpense;
@property (nonatomic, assign) BOOL identifier;
@property (nonatomic, strong) NSString *isSettlement;
@property (nonatomic, assign) double shouldAlsoAount;
@property (nonatomic, strong) NSString *days;
@property (nonatomic, assign) double interest;
@property (nonatomic, assign) double applyAmount;
@property (nonatomic, assign) double periods;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
