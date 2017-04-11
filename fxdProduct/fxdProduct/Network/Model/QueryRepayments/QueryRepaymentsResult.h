//
//  QueryRepaymentsResult.h
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QueryRepaymentsResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) double voucherNumber;
@property (nonatomic, assign) double managerExpense;
@property (nonatomic, assign) double totalAmount;
@property (nonatomic, assign) double day;
@property (nonatomic, assign) double repaymentAmount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
