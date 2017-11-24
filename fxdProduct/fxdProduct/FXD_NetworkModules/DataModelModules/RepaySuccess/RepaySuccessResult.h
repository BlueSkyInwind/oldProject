//
//  RepaySuccessResult.h
//
//  Created by dd  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepaySuccessResult.h"
#import "RepaySuccessBaseClass.h"


@interface RepaySuccessResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double result;
@property (nonatomic, assign) double isLoanSettlement;
@property (nonatomic, strong) NSString *voucherIds;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double actualRepayAmount;
@property (nonatomic, assign) double isFullRepay;
@property (nonatomic, assign) double bankCarId;
@property (nonatomic, strong) NSString *redIds;
@property (nonatomic, assign) double redActualAmount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
