//
//  QueryRepaymentsLoanApplicant.h
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QueryRepaymentsLoanApplicant : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double applyAmount;
@property (nonatomic, assign) double loanApplicantIdentifier;
@property (nonatomic, assign) double periods;
@property (nonatomic, assign) double loanAmount;
@property (nonatomic, assign) double bankCardId;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, assign) double interest;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
