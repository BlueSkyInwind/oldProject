//
//  ApprovalAmountResult.h
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ApprovalAmountResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double approvalAmount;
@property (nonatomic, assign) double loanStagingAmount;
@property (nonatomic, strong) NSString *loanStagingDuration;
@property (nonatomic, strong) NSString *contractId;
@property (nonatomic, strong) NSString *firstRepayDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
