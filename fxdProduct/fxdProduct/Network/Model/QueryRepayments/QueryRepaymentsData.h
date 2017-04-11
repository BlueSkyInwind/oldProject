//
//  QueryRepaymentsData.h
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QueryRepaymentsLoanApplicant;

@interface QueryRepaymentsData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double principal;
@property (nonatomic, assign) double loanId;
@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, strong) NSString *repaymentEndDate;
@property (nonatomic, assign) double periodusNum;
@property (nonatomic, assign) double amount;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, assign) double manageExpense;
@property (nonatomic, strong) NSString *isBeOverdue;
@property (nonatomic, strong) NSString *isSettlement;
@property (nonatomic, strong) NSString *repaymentStartDate;
@property (nonatomic, strong) QueryRepaymentsLoanApplicant *loanApplicant;
@property (nonatomic, strong) NSArray *repaymentRecordsList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
