//
//  GetMoneyResultAuditRecordBean.m
//
//  Created by dd  on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyResultAuditRecordBean.h"


NSString *const kGetMoneyResultAuditRecordBeanTrialStatus = @"trialStatus";
NSString *const kGetMoneyResultAuditRecordBeanSubmitTime = @"submitTime";
NSString *const kGetMoneyResultAuditRecordBeanId = @"id";
NSString *const kGetMoneyResultAuditRecordBeanLastCompleteTime = @"lastCompleteTime";
NSString *const kGetMoneyResultAuditRecordBeanAuditTime = @"auditTime";
NSString *const kGetMoneyResultAuditRecordBeanCreateDate = @"createDate";
NSString *const kGetMoneyResultAuditRecordBeanCashWithdrawalId = @"cashWithdrawalId";
NSString *const kGetMoneyResultAuditRecordBeanCreateId = @"createId";


@interface GetMoneyResultAuditRecordBean ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyResultAuditRecordBean

@synthesize trialStatus = _trialStatus;
@synthesize submitTime = _submitTime;
@synthesize auditRecordBeanIdentifier = _auditRecordBeanIdentifier;
@synthesize lastCompleteTime = _lastCompleteTime;
@synthesize auditTime = _auditTime;
@synthesize createDate = _createDate;
@synthesize cashWithdrawalId = _cashWithdrawalId;
@synthesize createId = _createId;


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
            self.trialStatus = [self objectOrNilForKey:kGetMoneyResultAuditRecordBeanTrialStatus fromDictionary:dict];
            self.submitTime = [self objectOrNilForKey:kGetMoneyResultAuditRecordBeanSubmitTime fromDictionary:dict];
            self.auditRecordBeanIdentifier = [[self objectOrNilForKey:kGetMoneyResultAuditRecordBeanId fromDictionary:dict] doubleValue];
            self.lastCompleteTime = [self objectOrNilForKey:kGetMoneyResultAuditRecordBeanLastCompleteTime fromDictionary:dict];
            self.auditTime = [self objectOrNilForKey:kGetMoneyResultAuditRecordBeanAuditTime fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kGetMoneyResultAuditRecordBeanCreateDate fromDictionary:dict];
            self.cashWithdrawalId = [[self objectOrNilForKey:kGetMoneyResultAuditRecordBeanCashWithdrawalId fromDictionary:dict] doubleValue];
            self.createId = [[self objectOrNilForKey:kGetMoneyResultAuditRecordBeanCreateId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.trialStatus forKey:kGetMoneyResultAuditRecordBeanTrialStatus];
    [mutableDict setValue:self.submitTime forKey:kGetMoneyResultAuditRecordBeanSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.auditRecordBeanIdentifier] forKey:kGetMoneyResultAuditRecordBeanId];
    [mutableDict setValue:self.lastCompleteTime forKey:kGetMoneyResultAuditRecordBeanLastCompleteTime];
    [mutableDict setValue:self.auditTime forKey:kGetMoneyResultAuditRecordBeanAuditTime];
    [mutableDict setValue:self.createDate forKey:kGetMoneyResultAuditRecordBeanCreateDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cashWithdrawalId] forKey:kGetMoneyResultAuditRecordBeanCashWithdrawalId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createId] forKey:kGetMoneyResultAuditRecordBeanCreateId];

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

    self.trialStatus = [aDecoder decodeObjectForKey:kGetMoneyResultAuditRecordBeanTrialStatus];
    self.submitTime = [aDecoder decodeObjectForKey:kGetMoneyResultAuditRecordBeanSubmitTime];
    self.auditRecordBeanIdentifier = [aDecoder decodeDoubleForKey:kGetMoneyResultAuditRecordBeanId];
    self.lastCompleteTime = [aDecoder decodeObjectForKey:kGetMoneyResultAuditRecordBeanLastCompleteTime];
    self.auditTime = [aDecoder decodeObjectForKey:kGetMoneyResultAuditRecordBeanAuditTime];
    self.createDate = [aDecoder decodeObjectForKey:kGetMoneyResultAuditRecordBeanCreateDate];
    self.cashWithdrawalId = [aDecoder decodeDoubleForKey:kGetMoneyResultAuditRecordBeanCashWithdrawalId];
    self.createId = [aDecoder decodeDoubleForKey:kGetMoneyResultAuditRecordBeanCreateId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_trialStatus forKey:kGetMoneyResultAuditRecordBeanTrialStatus];
    [aCoder encodeObject:_submitTime forKey:kGetMoneyResultAuditRecordBeanSubmitTime];
    [aCoder encodeDouble:_auditRecordBeanIdentifier forKey:kGetMoneyResultAuditRecordBeanId];
    [aCoder encodeObject:_lastCompleteTime forKey:kGetMoneyResultAuditRecordBeanLastCompleteTime];
    [aCoder encodeObject:_auditTime forKey:kGetMoneyResultAuditRecordBeanAuditTime];
    [aCoder encodeObject:_createDate forKey:kGetMoneyResultAuditRecordBeanCreateDate];
    [aCoder encodeDouble:_cashWithdrawalId forKey:kGetMoneyResultAuditRecordBeanCashWithdrawalId];
    [aCoder encodeDouble:_createId forKey:kGetMoneyResultAuditRecordBeanCreateId];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyResultAuditRecordBean *copy = [[GetMoneyResultAuditRecordBean alloc] init];
    
    if (copy) {

        copy.trialStatus = [self.trialStatus copyWithZone:zone];
        copy.submitTime = [self.submitTime copyWithZone:zone];
        copy.auditRecordBeanIdentifier = self.auditRecordBeanIdentifier;
        copy.lastCompleteTime = [self.lastCompleteTime copyWithZone:zone];
        copy.auditTime = [self.auditTime copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.cashWithdrawalId = self.cashWithdrawalId;
        copy.createId = self.createId;
    }
    
    return copy;
}


@end
