//
//  GetMoneyResultResult.m
//
//  Created by dd  on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyResultResult.h"
#import "GetMoneyResultAuditRecordBean.h"


NSString *const kGetMoneyResultResultId = @"id";
NSString *const kGetMoneyResultResultIsExport = @"isExport";
NSString *const kGetMoneyResultResultCreateId = @"createId";
NSString *const kGetMoneyResultResultApplicantId = @"applicantId";
NSString *const kGetMoneyResultResultCreateDate = @"createDate";
NSString *const kGetMoneyResultResultBankCardId = @"bankCardId";
NSString *const kGetMoneyResultResultAuditRecordBean = @"auditRecordBean";
NSString *const kGetMoneyResultResultIsSettlement = @"isSettlement";
NSString *const kGetMoneyResultResultToken = @"token";
NSString *const kGetMoneyResultResultIsLoan = @"isLoan";
NSString *const kGetMoneyResultResultApplyAmount = @"applyAmount";
NSString *const kGetMoneyResultResultInterest = @"interest";
NSString *const kGetMoneyResultResultPeriods = @"periods";


@interface GetMoneyResultResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyResultResult

@synthesize resultIdentifier = _resultIdentifier;
@synthesize isExport = _isExport;
@synthesize createId = _createId;
@synthesize applicantId = _applicantId;
@synthesize createDate = _createDate;
@synthesize bankCardId = _bankCardId;
@synthesize auditRecordBean = _auditRecordBean;
@synthesize isSettlement = _isSettlement;
@synthesize token = _token;
@synthesize isLoan = _isLoan;
@synthesize applyAmount = _applyAmount;
@synthesize interest = _interest;
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
            self.resultIdentifier = [[self objectOrNilForKey:kGetMoneyResultResultId fromDictionary:dict] doubleValue];
            self.isExport = [self objectOrNilForKey:kGetMoneyResultResultIsExport fromDictionary:dict];
            self.createId = [[self objectOrNilForKey:kGetMoneyResultResultCreateId fromDictionary:dict] doubleValue];
            self.applicantId = [[self objectOrNilForKey:kGetMoneyResultResultApplicantId fromDictionary:dict] doubleValue];
            self.createDate = [self objectOrNilForKey:kGetMoneyResultResultCreateDate fromDictionary:dict];
            self.bankCardId = [[self objectOrNilForKey:kGetMoneyResultResultBankCardId fromDictionary:dict] doubleValue];
            self.auditRecordBean = [GetMoneyResultAuditRecordBean modelObjectWithDictionary:[dict objectForKey:kGetMoneyResultResultAuditRecordBean]];
            self.isSettlement = [self objectOrNilForKey:kGetMoneyResultResultIsSettlement fromDictionary:dict];
            self.token = [self objectOrNilForKey:kGetMoneyResultResultToken fromDictionary:dict];
            self.isLoan = [self objectOrNilForKey:kGetMoneyResultResultIsLoan fromDictionary:dict];
            self.applyAmount = [[self objectOrNilForKey:kGetMoneyResultResultApplyAmount fromDictionary:dict] doubleValue];
            self.interest = [[self objectOrNilForKey:kGetMoneyResultResultInterest fromDictionary:dict] doubleValue];
            self.periods = [[self objectOrNilForKey:kGetMoneyResultResultPeriods fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kGetMoneyResultResultId];
    [mutableDict setValue:self.isExport forKey:kGetMoneyResultResultIsExport];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createId] forKey:kGetMoneyResultResultCreateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applicantId] forKey:kGetMoneyResultResultApplicantId];
    [mutableDict setValue:self.createDate forKey:kGetMoneyResultResultCreateDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bankCardId] forKey:kGetMoneyResultResultBankCardId];
    [mutableDict setValue:[self.auditRecordBean dictionaryRepresentation] forKey:kGetMoneyResultResultAuditRecordBean];
    [mutableDict setValue:self.isSettlement forKey:kGetMoneyResultResultIsSettlement];
    [mutableDict setValue:self.token forKey:kGetMoneyResultResultToken];
    [mutableDict setValue:self.isLoan forKey:kGetMoneyResultResultIsLoan];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyAmount] forKey:kGetMoneyResultResultApplyAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.interest] forKey:kGetMoneyResultResultInterest];
    [mutableDict setValue:[NSNumber numberWithDouble:self.periods] forKey:kGetMoneyResultResultPeriods];

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

    self.resultIdentifier = [aDecoder decodeDoubleForKey:kGetMoneyResultResultId];
    self.isExport = [aDecoder decodeObjectForKey:kGetMoneyResultResultIsExport];
    self.createId = [aDecoder decodeDoubleForKey:kGetMoneyResultResultCreateId];
    self.applicantId = [aDecoder decodeDoubleForKey:kGetMoneyResultResultApplicantId];
    self.createDate = [aDecoder decodeObjectForKey:kGetMoneyResultResultCreateDate];
    self.bankCardId = [aDecoder decodeDoubleForKey:kGetMoneyResultResultBankCardId];
    self.auditRecordBean = [aDecoder decodeObjectForKey:kGetMoneyResultResultAuditRecordBean];
    self.isSettlement = [aDecoder decodeObjectForKey:kGetMoneyResultResultIsSettlement];
    self.token = [aDecoder decodeObjectForKey:kGetMoneyResultResultToken];
    self.isLoan = [aDecoder decodeObjectForKey:kGetMoneyResultResultIsLoan];
    self.applyAmount = [aDecoder decodeDoubleForKey:kGetMoneyResultResultApplyAmount];
    self.interest = [aDecoder decodeDoubleForKey:kGetMoneyResultResultInterest];
    self.periods = [aDecoder decodeDoubleForKey:kGetMoneyResultResultPeriods];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resultIdentifier forKey:kGetMoneyResultResultId];
    [aCoder encodeObject:_isExport forKey:kGetMoneyResultResultIsExport];
    [aCoder encodeDouble:_createId forKey:kGetMoneyResultResultCreateId];
    [aCoder encodeDouble:_applicantId forKey:kGetMoneyResultResultApplicantId];
    [aCoder encodeObject:_createDate forKey:kGetMoneyResultResultCreateDate];
    [aCoder encodeDouble:_bankCardId forKey:kGetMoneyResultResultBankCardId];
    [aCoder encodeObject:_auditRecordBean forKey:kGetMoneyResultResultAuditRecordBean];
    [aCoder encodeObject:_isSettlement forKey:kGetMoneyResultResultIsSettlement];
    [aCoder encodeObject:_token forKey:kGetMoneyResultResultToken];
    [aCoder encodeObject:_isLoan forKey:kGetMoneyResultResultIsLoan];
    [aCoder encodeDouble:_applyAmount forKey:kGetMoneyResultResultApplyAmount];
    [aCoder encodeDouble:_interest forKey:kGetMoneyResultResultInterest];
    [aCoder encodeDouble:_periods forKey:kGetMoneyResultResultPeriods];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyResultResult *copy = [[GetMoneyResultResult alloc] init];
    
    if (copy) {

        copy.resultIdentifier = self.resultIdentifier;
        copy.isExport = [self.isExport copyWithZone:zone];
        copy.createId = self.createId;
        copy.applicantId = self.applicantId;
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.bankCardId = self.bankCardId;
        copy.auditRecordBean = [self.auditRecordBean copyWithZone:zone];
        copy.isSettlement = [self.isSettlement copyWithZone:zone];
        copy.token = [self.token copyWithZone:zone];
        copy.isLoan = [self.isLoan copyWithZone:zone];
        copy.applyAmount = self.applyAmount;
        copy.interest = self.interest;
        copy.periods = self.periods;
    }
    
    return copy;
}


@end
