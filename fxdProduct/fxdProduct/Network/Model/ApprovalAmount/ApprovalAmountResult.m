//
//  ApprovalAmountResult.m
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ApprovalAmountResult.h"

NSString *const kApprovalAmountResultApprovalAmount = @"approval_amount_";
NSString *const kApprovalAmountResultLoanStagingAmount = @"loan_staging_amount_";
NSString *const kApprovalAmountResultLoanStagingDuration = @"loan_staging_duration_";
NSString *const kApprovalAmountResultContractId = @"contract_id_";
NSString *const kApprovalAmountResultFirstRepayDate = @"first_repay_date_";

@interface ApprovalAmountResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ApprovalAmountResult

@synthesize approvalAmount = _approvalAmount;
@synthesize loanStagingAmount = _loanStagingAmount;
@synthesize loanStagingDuration = _loanStagingDuration;
@synthesize contractId = _contractId;
@synthesize firstRepayDate = _firstRepayDate;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.approvalAmount = [[self objectOrNilForKey:kApprovalAmountResultApprovalAmount fromDictionary:dict] doubleValue];
            self.loanStagingAmount = [[self objectOrNilForKey:kApprovalAmountResultLoanStagingAmount fromDictionary:dict] doubleValue];
            self.loanStagingDuration = [self objectOrNilForKey:kApprovalAmountResultLoanStagingDuration fromDictionary:dict];
            self.contractId = [self objectOrNilForKey:kApprovalAmountResultContractId fromDictionary:dict];
            self.firstRepayDate = [self objectOrNilForKey:kApprovalAmountResultFirstRepayDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.approvalAmount] forKey:kApprovalAmountResultApprovalAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanStagingAmount] forKey:kApprovalAmountResultLoanStagingAmount];
    [mutableDict setValue:self.loanStagingDuration forKey:kApprovalAmountResultLoanStagingDuration];
    [mutableDict setValue:self.contractId forKey:kApprovalAmountResultContractId];
    [mutableDict setValue:self.firstRepayDate forKey:kApprovalAmountResultFirstRepayDate];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.approvalAmount = [aDecoder decodeDoubleForKey:kApprovalAmountResultApprovalAmount];
    self.loanStagingAmount = [aDecoder decodeDoubleForKey:kApprovalAmountResultLoanStagingAmount];
    self.loanStagingDuration = [aDecoder decodeObjectForKey:kApprovalAmountResultLoanStagingDuration];
    self.contractId = [aDecoder decodeObjectForKey:kApprovalAmountResultContractId];
    self.firstRepayDate = [aDecoder decodeObjectForKey:kApprovalAmountResultFirstRepayDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_approvalAmount forKey:kApprovalAmountResultApprovalAmount];
    [aCoder encodeDouble:_loanStagingAmount forKey:kApprovalAmountResultLoanStagingAmount];
    [aCoder encodeObject:_loanStagingDuration forKey:kApprovalAmountResultLoanStagingDuration];
    [aCoder encodeObject:_contractId forKey:kApprovalAmountResultContractId];
    [aCoder encodeObject:_firstRepayDate forKey:kApprovalAmountResultFirstRepayDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    ApprovalAmountResult *copy = [[ApprovalAmountResult alloc] init];
    
    if (copy) {

        copy.approvalAmount = self.approvalAmount;
        copy.loanStagingAmount = self.loanStagingAmount;
        copy.loanStagingDuration = [self.loanStagingDuration copyWithZone:zone];
        copy.contractId = [self.contractId copyWithZone:zone];
        copy.firstRepayDate = [self.firstRepayDate copyWithZone:zone];
    }
    
    return copy;
}


@end
