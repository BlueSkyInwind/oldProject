//
//  UserStateResult.m
//
//  Created by dd  on 15/12/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserStateResult.h"


NSString *const kUserStateResultId = @"id";
NSString *const kUserStateResultStatus = @"status";
NSString *const kUserStateResultBeOverAmount = @"beOverAmount";
NSString *const kUserStateResultSurplusRepayDay = @"surplusRepayDay";
NSString *const kUserStateResultCreateDate = @"createDate";
NSString *const kUserStateResultShouldAlsoAmount = @"shouldAlsoAmount";
NSString *const kUserStateResultLoanAmount = @"loanAmount";
NSString *const kUserStateResultManageExpense = @"manageExpense";
NSString *const kUserStateResultIdentifier = @"identifier";
NSString *const kUserStateResultIsSettlement = @"isSettlement";
NSString *const kUserStateResultShouldAlsoAount = @"shouldAlsoAount";
NSString *const kUserStateResultDays = @"days";
NSString *const kUserStateResultInterest = @"interest";
NSString *const kUserStateResultApplyAmount = @"applyAmount";
NSString *const kUserStateResultPeriods = @"periods";


@interface UserStateResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserStateResult

@synthesize resultIdentifier = _resultIdentifier;
@synthesize status = _status;
@synthesize beOverAmount = _beOverAmount;
@synthesize surplusRepayDay = _surplusRepayDay;
@synthesize createDate = _createDate;
@synthesize shouldAlsoAmount = _shouldAlsoAmount;
@synthesize loanAmount = _loanAmount;
@synthesize manageExpense = _manageExpense;
@synthesize identifier = _identifier;
@synthesize isSettlement = _isSettlement;
@synthesize shouldAlsoAount = _shouldAlsoAount;
@synthesize days = _days;
@synthesize interest = _interest;
@synthesize applyAmount = _applyAmount;
@synthesize periods = _periods;


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
            self.resultIdentifier = [[self objectOrNilForKey:kUserStateResultId fromDictionary:dict] doubleValue];
            self.status = [self objectOrNilForKey:kUserStateResultStatus fromDictionary:dict];
            self.beOverAmount = [[self objectOrNilForKey:kUserStateResultBeOverAmount fromDictionary:dict] doubleValue];
            self.surplusRepayDay = [self objectOrNilForKey:kUserStateResultSurplusRepayDay fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kUserStateResultCreateDate fromDictionary:dict];
            self.shouldAlsoAmount = [[self objectOrNilForKey:kUserStateResultShouldAlsoAmount fromDictionary:dict] doubleValue];
            self.loanAmount = [[self objectOrNilForKey:kUserStateResultLoanAmount fromDictionary:dict] doubleValue];
            self.manageExpense = [[self objectOrNilForKey:kUserStateResultManageExpense fromDictionary:dict] doubleValue];
            self.identifier = [[self objectOrNilForKey:kUserStateResultIdentifier fromDictionary:dict] boolValue];
            self.isSettlement = [self objectOrNilForKey:kUserStateResultIsSettlement fromDictionary:dict];
            self.shouldAlsoAount = [[self objectOrNilForKey:kUserStateResultShouldAlsoAount fromDictionary:dict] doubleValue];
            self.days = [self objectOrNilForKey:kUserStateResultDays fromDictionary:dict];
            self.interest = [[self objectOrNilForKey:kUserStateResultInterest fromDictionary:dict] doubleValue];
            self.applyAmount = [[self objectOrNilForKey:kUserStateResultApplyAmount fromDictionary:dict] doubleValue];
            self.periods = [[self objectOrNilForKey:kUserStateResultPeriods fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kUserStateResultId];
    [mutableDict setValue:self.status forKey:kUserStateResultStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.beOverAmount] forKey:kUserStateResultBeOverAmount];
    [mutableDict setValue:self.surplusRepayDay forKey:kUserStateResultSurplusRepayDay];
    [mutableDict setValue:self.createDate forKey:kUserStateResultCreateDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shouldAlsoAmount] forKey:kUserStateResultShouldAlsoAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanAmount] forKey:kUserStateResultLoanAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.manageExpense] forKey:kUserStateResultManageExpense];
    [mutableDict setValue:[NSNumber numberWithBool:self.identifier] forKey:kUserStateResultIdentifier];
    [mutableDict setValue:self.isSettlement forKey:kUserStateResultIsSettlement];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shouldAlsoAount] forKey:kUserStateResultShouldAlsoAount];
    [mutableDict setValue:self.days forKey:kUserStateResultDays];
    [mutableDict setValue:[NSNumber numberWithDouble:self.interest] forKey:kUserStateResultInterest];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyAmount] forKey:kUserStateResultApplyAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.periods] forKey:kUserStateResultPeriods];

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

    self.resultIdentifier = [aDecoder decodeDoubleForKey:kUserStateResultId];
    self.status = [aDecoder decodeObjectForKey:kUserStateResultStatus];
    self.beOverAmount = [aDecoder decodeDoubleForKey:kUserStateResultBeOverAmount];
    self.surplusRepayDay = [aDecoder decodeObjectForKey:kUserStateResultSurplusRepayDay];
    self.createDate = [aDecoder decodeObjectForKey:kUserStateResultCreateDate];
    self.shouldAlsoAmount = [aDecoder decodeDoubleForKey:kUserStateResultShouldAlsoAmount];
    self.loanAmount = [aDecoder decodeDoubleForKey:kUserStateResultLoanAmount];
    self.manageExpense = [aDecoder decodeDoubleForKey:kUserStateResultManageExpense];
    self.identifier = [aDecoder decodeBoolForKey:kUserStateResultIdentifier];
    self.isSettlement = [aDecoder decodeObjectForKey:kUserStateResultIsSettlement];
    self.shouldAlsoAount = [aDecoder decodeDoubleForKey:kUserStateResultShouldAlsoAount];
    self.days = [aDecoder decodeObjectForKey:kUserStateResultDays];
    self.interest = [aDecoder decodeDoubleForKey:kUserStateResultInterest];
    self.applyAmount = [aDecoder decodeDoubleForKey:kUserStateResultApplyAmount];
    self.periods = [aDecoder decodeDoubleForKey:kUserStateResultPeriods];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resultIdentifier forKey:kUserStateResultId];
    [aCoder encodeObject:_status forKey:kUserStateResultStatus];
    [aCoder encodeDouble:_beOverAmount forKey:kUserStateResultBeOverAmount];
    [aCoder encodeObject:_surplusRepayDay forKey:kUserStateResultSurplusRepayDay];
    [aCoder encodeObject:_createDate forKey:kUserStateResultCreateDate];
    [aCoder encodeDouble:_shouldAlsoAmount forKey:kUserStateResultShouldAlsoAmount];
    [aCoder encodeDouble:_loanAmount forKey:kUserStateResultLoanAmount];
    [aCoder encodeDouble:_manageExpense forKey:kUserStateResultManageExpense];
    [aCoder encodeBool:_identifier forKey:kUserStateResultIdentifier];
    [aCoder encodeObject:_isSettlement forKey:kUserStateResultIsSettlement];
    [aCoder encodeDouble:_shouldAlsoAount forKey:kUserStateResultShouldAlsoAount];
    [aCoder encodeObject:_days forKey:kUserStateResultDays];
    [aCoder encodeDouble:_interest forKey:kUserStateResultInterest];
    [aCoder encodeDouble:_applyAmount forKey:kUserStateResultApplyAmount];
    [aCoder encodeDouble:_periods forKey:kUserStateResultPeriods];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserStateResult *copy = [[UserStateResult alloc] init];
    
    if (copy) {

        copy.resultIdentifier = self.resultIdentifier;
        copy.status = [self.status copyWithZone:zone];
        copy.beOverAmount = self.beOverAmount;
        copy.surplusRepayDay = [self.surplusRepayDay copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.shouldAlsoAmount = self.shouldAlsoAmount;
        copy.loanAmount = self.loanAmount;
        copy.manageExpense = self.manageExpense;
        copy.identifier = self.identifier;
        copy.isSettlement = [self.isSettlement copyWithZone:zone];
        copy.shouldAlsoAount = self.shouldAlsoAount;
        copy.days = [self.days copyWithZone:zone];
        copy.interest = self.interest;
        copy.applyAmount = self.applyAmount;
        copy.periods = self.periods;
    }
    
    return copy;
}


@end
