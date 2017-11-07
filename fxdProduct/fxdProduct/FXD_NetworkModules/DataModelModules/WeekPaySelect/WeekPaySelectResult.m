//
//  WeekPaySelectResult.m
//
//  Created by dd  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "WeekPaySelectResult.h"


NSString *const kWeekPaySelectResultId = @"id";
NSString *const kWeekPaySelectResultPeriods = @"periods";
NSString *const kWeekPaySelectResultBeOverAmount = @"beOverAmount";
NSString *const kWeekPaySelectResultAmount = @"amount";
NSString *const kWeekPaySelectResultSocket = @"socket";
NSString *const kWeekPaySelectResultCreateDate = @"createDate";
NSString *const kWeekPaySelectResultCreateId = @"createId";
NSString *const kWeekPaySelectResultUpdateId = @"updateId";
NSString *const kWeekPaySelectResultLoanAmount = @"loanAmount";
NSString *const kWeekPaySelectResultLastRepayDate = @"lastRepayDate";
NSString *const kWeekPaySelectResultToken = @"token";
NSString *const kWeekPaySelectResultShouldAlsoAount = @"shouldAlsoAount";
NSString *const kWeekPaySelectResultIsValid = @"isValid";
NSString *const kWeekPaySelectResultInterest = @"interest";
NSString *const kWeekPaySelectResultLastUpdateDate = @"lastUpdateDate";


@interface WeekPaySelectResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeekPaySelectResult

@synthesize resultIdentifier = _resultIdentifier;
@synthesize periods = _periods;
@synthesize beOverAmount = _beOverAmount;
@synthesize amount = _amount;
@synthesize socket = _socket;
@synthesize createDate = _createDate;
@synthesize createId = _createId;
@synthesize updateId = _updateId;
@synthesize loanAmount = _loanAmount;
@synthesize lastRepayDate = _lastRepayDate;
@synthesize token = _token;
@synthesize shouldAlsoAount = _shouldAlsoAount;
@synthesize isValid = _isValid;
@synthesize interest = _interest;
@synthesize lastUpdateDate = _lastUpdateDate;


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
            self.resultIdentifier = [[self objectOrNilForKey:kWeekPaySelectResultId fromDictionary:dict] doubleValue];
            self.periods = [[self objectOrNilForKey:kWeekPaySelectResultPeriods fromDictionary:dict] doubleValue];
            self.beOverAmount = [[self objectOrNilForKey:kWeekPaySelectResultBeOverAmount fromDictionary:dict] doubleValue];
            self.amount = [[self objectOrNilForKey:kWeekPaySelectResultAmount fromDictionary:dict] doubleValue];
            self.socket = [self objectOrNilForKey:kWeekPaySelectResultSocket fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kWeekPaySelectResultCreateDate fromDictionary:dict];
            self.createId = [[self objectOrNilForKey:kWeekPaySelectResultCreateId fromDictionary:dict] doubleValue];
            self.updateId = [[self objectOrNilForKey:kWeekPaySelectResultUpdateId fromDictionary:dict] doubleValue];
            self.loanAmount = [[self objectOrNilForKey:kWeekPaySelectResultLoanAmount fromDictionary:dict] doubleValue];
            self.lastRepayDate = [self objectOrNilForKey:kWeekPaySelectResultLastRepayDate fromDictionary:dict];
            self.token = [self objectOrNilForKey:kWeekPaySelectResultToken fromDictionary:dict];
            self.shouldAlsoAount = [[self objectOrNilForKey:kWeekPaySelectResultShouldAlsoAount fromDictionary:dict] doubleValue];
            self.isValid = [self objectOrNilForKey:kWeekPaySelectResultIsValid fromDictionary:dict];
            self.interest = [[self objectOrNilForKey:kWeekPaySelectResultInterest fromDictionary:dict] doubleValue];
            self.lastUpdateDate = [self objectOrNilForKey:kWeekPaySelectResultLastUpdateDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kWeekPaySelectResultId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.periods] forKey:kWeekPaySelectResultPeriods];
    [mutableDict setValue:[NSNumber numberWithDouble:self.beOverAmount] forKey:kWeekPaySelectResultBeOverAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.amount] forKey:kWeekPaySelectResultAmount];
    [mutableDict setValue:self.socket forKey:kWeekPaySelectResultSocket];
    [mutableDict setValue:self.createDate forKey:kWeekPaySelectResultCreateDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createId] forKey:kWeekPaySelectResultCreateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateId] forKey:kWeekPaySelectResultUpdateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanAmount] forKey:kWeekPaySelectResultLoanAmount];
    [mutableDict setValue:self.lastRepayDate forKey:kWeekPaySelectResultLastRepayDate];
    [mutableDict setValue:self.token forKey:kWeekPaySelectResultToken];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shouldAlsoAount] forKey:kWeekPaySelectResultShouldAlsoAount];
    [mutableDict setValue:self.isValid forKey:kWeekPaySelectResultIsValid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.interest] forKey:kWeekPaySelectResultInterest];
    [mutableDict setValue:self.lastUpdateDate forKey:kWeekPaySelectResultLastUpdateDate];

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

    self.resultIdentifier = [aDecoder decodeDoubleForKey:kWeekPaySelectResultId];
    self.periods = [aDecoder decodeDoubleForKey:kWeekPaySelectResultPeriods];
    self.beOverAmount = [aDecoder decodeDoubleForKey:kWeekPaySelectResultBeOverAmount];
    self.amount = [aDecoder decodeDoubleForKey:kWeekPaySelectResultAmount];
    self.socket = [aDecoder decodeObjectForKey:kWeekPaySelectResultSocket];
    self.createDate = [aDecoder decodeObjectForKey:kWeekPaySelectResultCreateDate];
    self.createId = [aDecoder decodeDoubleForKey:kWeekPaySelectResultCreateId];
    self.updateId = [aDecoder decodeDoubleForKey:kWeekPaySelectResultUpdateId];
    self.loanAmount = [aDecoder decodeDoubleForKey:kWeekPaySelectResultLoanAmount];
    self.lastRepayDate = [aDecoder decodeObjectForKey:kWeekPaySelectResultLastRepayDate];
    self.token = [aDecoder decodeObjectForKey:kWeekPaySelectResultToken];
    self.shouldAlsoAount = [aDecoder decodeDoubleForKey:kWeekPaySelectResultShouldAlsoAount];
    self.isValid = [aDecoder decodeObjectForKey:kWeekPaySelectResultIsValid];
    self.interest = [aDecoder decodeDoubleForKey:kWeekPaySelectResultInterest];
    self.lastUpdateDate = [aDecoder decodeObjectForKey:kWeekPaySelectResultLastUpdateDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resultIdentifier forKey:kWeekPaySelectResultId];
    [aCoder encodeDouble:_periods forKey:kWeekPaySelectResultPeriods];
    [aCoder encodeDouble:_beOverAmount forKey:kWeekPaySelectResultBeOverAmount];
    [aCoder encodeDouble:_amount forKey:kWeekPaySelectResultAmount];
    [aCoder encodeObject:_socket forKey:kWeekPaySelectResultSocket];
    [aCoder encodeObject:_createDate forKey:kWeekPaySelectResultCreateDate];
    [aCoder encodeDouble:_createId forKey:kWeekPaySelectResultCreateId];
    [aCoder encodeDouble:_updateId forKey:kWeekPaySelectResultUpdateId];
    [aCoder encodeDouble:_loanAmount forKey:kWeekPaySelectResultLoanAmount];
    [aCoder encodeObject:_lastRepayDate forKey:kWeekPaySelectResultLastRepayDate];
    [aCoder encodeObject:_token forKey:kWeekPaySelectResultToken];
    [aCoder encodeDouble:_shouldAlsoAount forKey:kWeekPaySelectResultShouldAlsoAount];
    [aCoder encodeObject:_isValid forKey:kWeekPaySelectResultIsValid];
    [aCoder encodeDouble:_interest forKey:kWeekPaySelectResultInterest];
    [aCoder encodeObject:_lastUpdateDate forKey:kWeekPaySelectResultLastUpdateDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeekPaySelectResult *copy = [[WeekPaySelectResult alloc] init];
    
    if (copy) {

        copy.resultIdentifier = self.resultIdentifier;
        copy.periods = self.periods;
        copy.beOverAmount = self.beOverAmount;
        copy.amount = self.amount;
        copy.socket = [self.socket copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.createId = self.createId;
        copy.updateId = self.updateId;
        copy.loanAmount = self.loanAmount;
        copy.lastRepayDate = [self.lastRepayDate copyWithZone:zone];
        copy.token = [self.token copyWithZone:zone];
        copy.shouldAlsoAount = self.shouldAlsoAount;
        copy.isValid = [self.isValid copyWithZone:zone];
        copy.interest = self.interest;
        copy.lastUpdateDate = [self.lastUpdateDate copyWithZone:zone];
    }
    
    return copy;
}


@end
