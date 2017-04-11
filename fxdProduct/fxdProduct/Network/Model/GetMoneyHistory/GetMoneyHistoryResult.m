//
//  GetMoneyHistoryResult.m
//
//  Created by dd  on 15/12/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyHistoryResult.h"


NSString *const kGetMoneyHistoryResultStatus = @"status";
NSString *const kGetMoneyHistoryResultSubmitDate = @"submitDate";
NSString *const kGetMoneyHistoryResultApplyAmount = @"applyAmount";
NSString *const kGetMoneyHistoryResultId = @"id";
NSString *const kGetMoneyHistoryResultPeriods = @"periods";
NSString *const kGetMoneyHistoryResultLoanAmount = @"loanAmount";
NSString *const kGetMoneyHistoryResultCreateDate = @"createDate";
NSString *const kGetMoneyHistoryResultInterest = @"interest";


@interface GetMoneyHistoryResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyHistoryResult

@synthesize status = _status;
@synthesize submitDate = _submitDate;
@synthesize applyAmount = _applyAmount;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize periods = _periods;
@synthesize loanAmount = _loanAmount;
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
            self.status = [self objectOrNilForKey:kGetMoneyHistoryResultStatus fromDictionary:dict];
            self.submitDate = [self objectOrNilForKey:kGetMoneyHistoryResultSubmitDate fromDictionary:dict];
            self.applyAmount = [[self objectOrNilForKey:kGetMoneyHistoryResultApplyAmount fromDictionary:dict] doubleValue];
            self.resultIdentifier = [[self objectOrNilForKey:kGetMoneyHistoryResultId fromDictionary:dict] doubleValue];
            self.periods = [[self objectOrNilForKey:kGetMoneyHistoryResultPeriods fromDictionary:dict] doubleValue];
            self.loanAmount = [[self objectOrNilForKey:kGetMoneyHistoryResultLoanAmount fromDictionary:dict] doubleValue];
            self.createDate = [self objectOrNilForKey:kGetMoneyHistoryResultCreateDate fromDictionary:dict];
            self.interest = [[self objectOrNilForKey:kGetMoneyHistoryResultInterest fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kGetMoneyHistoryResultStatus];
    [mutableDict setValue:self.submitDate forKey:kGetMoneyHistoryResultSubmitDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyAmount] forKey:kGetMoneyHistoryResultApplyAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kGetMoneyHistoryResultId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.periods] forKey:kGetMoneyHistoryResultPeriods];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanAmount] forKey:kGetMoneyHistoryResultLoanAmount];
    [mutableDict setValue:self.createDate forKey:kGetMoneyHistoryResultCreateDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.interest] forKey:kGetMoneyHistoryResultInterest];

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

    self.status = [aDecoder decodeObjectForKey:kGetMoneyHistoryResultStatus];
    self.submitDate = [aDecoder decodeObjectForKey:kGetMoneyHistoryResultSubmitDate];
    self.applyAmount = [aDecoder decodeDoubleForKey:kGetMoneyHistoryResultApplyAmount];
    self.resultIdentifier = [aDecoder decodeDoubleForKey:kGetMoneyHistoryResultId];
    self.periods = [aDecoder decodeDoubleForKey:kGetMoneyHistoryResultPeriods];
    self.loanAmount = [aDecoder decodeDoubleForKey:kGetMoneyHistoryResultLoanAmount];
    self.createDate = [aDecoder decodeObjectForKey:kGetMoneyHistoryResultCreateDate];
    self.interest = [aDecoder decodeDoubleForKey:kGetMoneyHistoryResultInterest];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kGetMoneyHistoryResultStatus];
    [aCoder encodeObject:_submitDate forKey:kGetMoneyHistoryResultSubmitDate];
    [aCoder encodeDouble:_applyAmount forKey:kGetMoneyHistoryResultApplyAmount];
    [aCoder encodeDouble:_resultIdentifier forKey:kGetMoneyHistoryResultId];
    [aCoder encodeDouble:_periods forKey:kGetMoneyHistoryResultPeriods];
    [aCoder encodeDouble:_loanAmount forKey:kGetMoneyHistoryResultLoanAmount];
    [aCoder encodeObject:_createDate forKey:kGetMoneyHistoryResultCreateDate];
    [aCoder encodeDouble:_interest forKey:kGetMoneyHistoryResultInterest];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyHistoryResult *copy = [[GetMoneyHistoryResult alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.submitDate = [self.submitDate copyWithZone:zone];
        copy.applyAmount = self.applyAmount;
        copy.resultIdentifier = self.resultIdentifier;
        copy.periods = self.periods;
        copy.loanAmount = self.loanAmount;
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.interest = self.interest;
    }
    
    return copy;
}


@end
