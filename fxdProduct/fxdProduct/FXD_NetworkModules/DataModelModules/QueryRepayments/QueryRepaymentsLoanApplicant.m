//
//  QueryRepaymentsLoanApplicant.m
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "QueryRepaymentsLoanApplicant.h"


NSString *const kQueryRepaymentsLoanApplicantApplyAmount = @"applyAmount";
NSString *const kQueryRepaymentsLoanApplicantId = @"id";
NSString *const kQueryRepaymentsLoanApplicantPeriods = @"periods";
NSString *const kQueryRepaymentsLoanApplicantLoanAmount = @"loanAmount";
NSString *const kQueryRepaymentsLoanApplicantBankCardId = @"bankCardId";
NSString *const kQueryRepaymentsLoanApplicantCreateDate = @"createDate";
NSString *const kQueryRepaymentsLoanApplicantInterest = @"interest";


@interface QueryRepaymentsLoanApplicant ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QueryRepaymentsLoanApplicant

@synthesize applyAmount = _applyAmount;
@synthesize loanApplicantIdentifier = _loanApplicantIdentifier;
@synthesize periods = _periods;
@synthesize loanAmount = _loanAmount;
@synthesize bankCardId = _bankCardId;
@synthesize createDate = _createDate;
@synthesize interest = _interest;


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
            self.applyAmount = [[self objectOrNilForKey:kQueryRepaymentsLoanApplicantApplyAmount fromDictionary:dict] doubleValue];
            self.loanApplicantIdentifier = [[self objectOrNilForKey:kQueryRepaymentsLoanApplicantId fromDictionary:dict] doubleValue];
            self.periods = [[self objectOrNilForKey:kQueryRepaymentsLoanApplicantPeriods fromDictionary:dict] doubleValue];
            self.loanAmount = [[self objectOrNilForKey:kQueryRepaymentsLoanApplicantLoanAmount fromDictionary:dict] doubleValue];
            self.bankCardId = [[self objectOrNilForKey:kQueryRepaymentsLoanApplicantBankCardId fromDictionary:dict] doubleValue];
            self.createDate = [self objectOrNilForKey:kQueryRepaymentsLoanApplicantCreateDate fromDictionary:dict];
            self.interest = [[self objectOrNilForKey:kQueryRepaymentsLoanApplicantInterest fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyAmount] forKey:kQueryRepaymentsLoanApplicantApplyAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanApplicantIdentifier] forKey:kQueryRepaymentsLoanApplicantId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.periods] forKey:kQueryRepaymentsLoanApplicantPeriods];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanAmount] forKey:kQueryRepaymentsLoanApplicantLoanAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bankCardId] forKey:kQueryRepaymentsLoanApplicantBankCardId];
    [mutableDict setValue:self.createDate forKey:kQueryRepaymentsLoanApplicantCreateDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.interest] forKey:kQueryRepaymentsLoanApplicantInterest];

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

    self.applyAmount = [aDecoder decodeDoubleForKey:kQueryRepaymentsLoanApplicantApplyAmount];
    self.loanApplicantIdentifier = [aDecoder decodeDoubleForKey:kQueryRepaymentsLoanApplicantId];
    self.periods = [aDecoder decodeDoubleForKey:kQueryRepaymentsLoanApplicantPeriods];
    self.loanAmount = [aDecoder decodeDoubleForKey:kQueryRepaymentsLoanApplicantLoanAmount];
    self.bankCardId = [aDecoder decodeDoubleForKey:kQueryRepaymentsLoanApplicantBankCardId];
    self.createDate = [aDecoder decodeObjectForKey:kQueryRepaymentsLoanApplicantCreateDate];
    self.interest = [aDecoder decodeDoubleForKey:kQueryRepaymentsLoanApplicantInterest];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_applyAmount forKey:kQueryRepaymentsLoanApplicantApplyAmount];
    [aCoder encodeDouble:_loanApplicantIdentifier forKey:kQueryRepaymentsLoanApplicantId];
    [aCoder encodeDouble:_periods forKey:kQueryRepaymentsLoanApplicantPeriods];
    [aCoder encodeDouble:_loanAmount forKey:kQueryRepaymentsLoanApplicantLoanAmount];
    [aCoder encodeDouble:_bankCardId forKey:kQueryRepaymentsLoanApplicantBankCardId];
    [aCoder encodeObject:_createDate forKey:kQueryRepaymentsLoanApplicantCreateDate];
    [aCoder encodeDouble:_interest forKey:kQueryRepaymentsLoanApplicantInterest];
}

- (id)copyWithZone:(NSZone *)zone
{
    QueryRepaymentsLoanApplicant *copy = [[QueryRepaymentsLoanApplicant alloc] init];
    
    if (copy) {

        copy.applyAmount = self.applyAmount;
        copy.loanApplicantIdentifier = self.loanApplicantIdentifier;
        copy.periods = self.periods;
        copy.loanAmount = self.loanAmount;
        copy.bankCardId = self.bankCardId;
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.interest = self.interest;
    }
    
    return copy;
}


@end
