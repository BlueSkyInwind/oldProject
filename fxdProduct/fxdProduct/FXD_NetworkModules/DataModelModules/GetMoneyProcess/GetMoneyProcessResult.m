//
//  GetMoneyProcessResult.m
//
//  Created by dd  on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyProcessResult.h"
#import "GetMoneyProcessUserBean.h"


NSString *const kGetMoneyProcessResultStatus = @"status";
NSString *const kGetMoneyProcessResultSubmitDate = @"submitDate";
NSString *const kGetMoneyProcessResultApplyAmount = @"applyAmount";
NSString *const kGetMoneyProcessResultId = @"id";
NSString *const kGetMoneyProcessResultLoanAmount = @"loanAmount";
NSString *const kGetMoneyProcessResultAuditSuccessDate = @"auditSuccessDate";
NSString *const kGetMoneyProcessResultCreateDate = @"createDate";
NSString *const kGetMoneyProcessResultUserBean = @"userBean";
NSString *const kGetMoneyProcessResultLoanSuccessDate = @"loanSuccessDate";


@interface GetMoneyProcessResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyProcessResult

@synthesize status = _status;
@synthesize submitDate = _submitDate;
@synthesize applyAmount = _applyAmount;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize loanAmount = _loanAmount;
@synthesize auditSuccessDate = _auditSuccessDate;
@synthesize createDate = _createDate;
@synthesize userBean = _userBean;
@synthesize loanSuccessDate = _loanSuccessDate;


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
            self.status = [self objectOrNilForKey:kGetMoneyProcessResultStatus fromDictionary:dict];
            self.submitDate = [self objectOrNilForKey:kGetMoneyProcessResultSubmitDate fromDictionary:dict];
            self.applyAmount = [[self objectOrNilForKey:kGetMoneyProcessResultApplyAmount fromDictionary:dict] doubleValue];
            self.resultIdentifier = [[self objectOrNilForKey:kGetMoneyProcessResultId fromDictionary:dict] doubleValue];
            self.loanAmount = [self objectOrNilForKey:kGetMoneyProcessResultLoanAmount fromDictionary:dict];
            self.auditSuccessDate = [self objectOrNilForKey:kGetMoneyProcessResultAuditSuccessDate fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kGetMoneyProcessResultCreateDate fromDictionary:dict];
            self.userBean = [GetMoneyProcessUserBean modelObjectWithDictionary:[dict objectForKey:kGetMoneyProcessResultUserBean]];
            self.loanSuccessDate = [self objectOrNilForKey:kGetMoneyProcessResultLoanSuccessDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kGetMoneyProcessResultStatus];
    [mutableDict setValue:self.submitDate forKey:kGetMoneyProcessResultSubmitDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyAmount] forKey:kGetMoneyProcessResultApplyAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kGetMoneyProcessResultId];
    [mutableDict setValue:self.loanAmount forKey:kGetMoneyProcessResultLoanAmount];
    [mutableDict setValue:self.auditSuccessDate forKey:kGetMoneyProcessResultAuditSuccessDate];
    [mutableDict setValue:self.createDate forKey:kGetMoneyProcessResultCreateDate];
    [mutableDict setValue:[self.userBean dictionaryRepresentation] forKey:kGetMoneyProcessResultUserBean];
    [mutableDict setValue:self.loanSuccessDate forKey:kGetMoneyProcessResultLoanSuccessDate];

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

    self.status = [aDecoder decodeObjectForKey:kGetMoneyProcessResultStatus];
    self.submitDate = [aDecoder decodeObjectForKey:kGetMoneyProcessResultSubmitDate];
    self.applyAmount = [aDecoder decodeDoubleForKey:kGetMoneyProcessResultApplyAmount];
    self.resultIdentifier = [aDecoder decodeDoubleForKey:kGetMoneyProcessResultId];
    self.loanAmount = [aDecoder decodeObjectForKey:kGetMoneyProcessResultLoanAmount];
    self.auditSuccessDate = [aDecoder decodeObjectForKey:kGetMoneyProcessResultAuditSuccessDate];
    self.createDate = [aDecoder decodeObjectForKey:kGetMoneyProcessResultCreateDate];
    self.userBean = [aDecoder decodeObjectForKey:kGetMoneyProcessResultUserBean];
    self.loanSuccessDate = [aDecoder decodeObjectForKey:kGetMoneyProcessResultLoanSuccessDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kGetMoneyProcessResultStatus];
    [aCoder encodeObject:_submitDate forKey:kGetMoneyProcessResultSubmitDate];
    [aCoder encodeDouble:_applyAmount forKey:kGetMoneyProcessResultApplyAmount];
    [aCoder encodeDouble:_resultIdentifier forKey:kGetMoneyProcessResultId];
    [aCoder encodeObject:_loanAmount forKey:kGetMoneyProcessResultLoanAmount];
    [aCoder encodeObject:_auditSuccessDate forKey:kGetMoneyProcessResultAuditSuccessDate];
    [aCoder encodeObject:_createDate forKey:kGetMoneyProcessResultCreateDate];
    [aCoder encodeObject:_userBean forKey:kGetMoneyProcessResultUserBean];
    [aCoder encodeObject:_loanSuccessDate forKey:kGetMoneyProcessResultLoanSuccessDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyProcessResult *copy = [[GetMoneyProcessResult alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.submitDate = [self.submitDate copyWithZone:zone];
        copy.applyAmount = self.applyAmount;
        copy.resultIdentifier = self.resultIdentifier;
        copy.loanAmount = [self.loanAmount copyWithZone:zone];
        copy.auditSuccessDate = [self.auditSuccessDate copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.userBean = [self.userBean copyWithZone:zone];
        copy.loanSuccessDate = [self.loanSuccessDate copyWithZone:zone];
    }
    
    return copy;
}


@end
