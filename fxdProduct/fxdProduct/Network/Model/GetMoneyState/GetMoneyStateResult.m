//
//  GetMoneyStateResult.m
//
//  Created by dd  on 15/10/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyStateResult.h"
#import "GetMoneyStateUserBean.h"


NSString *const kGetMoneyStateResultStatus = @"status";
NSString *const kGetMoneyStateResultSubmitDate = @"submitDate";
NSString *const kGetMoneyStateResultAuditSuccessDate = @"auditSuccessDate";
NSString *const kGetMoneyStateResultId = @"id";
NSString *const kGetMoneyStateResultLoanAmount = @"loanAmount";
NSString *const kGetMoneyStateResultCreateDate = @"createDate";
NSString *const kGetMoneyStateResultUserBean = @"userBean";
NSString *const kGetMoneyStateResultLoanSuccessDate = @"loanSuccessDate";


@interface GetMoneyStateResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyStateResult

@synthesize status = _status;
@synthesize submitDate = _submitDate;
@synthesize auditSuccessDate = _auditSuccessDate;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize loanAmount = _loanAmount;
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
            self.status = [self objectOrNilForKey:kGetMoneyStateResultStatus fromDictionary:dict];
            self.submitDate = [self objectOrNilForKey:kGetMoneyStateResultSubmitDate fromDictionary:dict];
            self.auditSuccessDate = [self objectOrNilForKey:kGetMoneyStateResultAuditSuccessDate fromDictionary:dict];
            self.resultIdentifier = [[self objectOrNilForKey:kGetMoneyStateResultId fromDictionary:dict] doubleValue];
            self.loanAmount = [[self objectOrNilForKey:kGetMoneyStateResultLoanAmount fromDictionary:dict] doubleValue];
            self.createDate = [self objectOrNilForKey:kGetMoneyStateResultCreateDate fromDictionary:dict];
            self.userBean = [GetMoneyStateUserBean modelObjectWithDictionary:[dict objectForKey:kGetMoneyStateResultUserBean]];
            self.loanSuccessDate = [self objectOrNilForKey:kGetMoneyStateResultLoanSuccessDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kGetMoneyStateResultStatus];
    [mutableDict setValue:self.submitDate forKey:kGetMoneyStateResultSubmitDate];
    [mutableDict setValue:self.auditSuccessDate forKey:kGetMoneyStateResultAuditSuccessDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kGetMoneyStateResultId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanAmount] forKey:kGetMoneyStateResultLoanAmount];
    [mutableDict setValue:self.createDate forKey:kGetMoneyStateResultCreateDate];
    [mutableDict setValue:[self.userBean dictionaryRepresentation] forKey:kGetMoneyStateResultUserBean];
    [mutableDict setValue:self.loanSuccessDate forKey:kGetMoneyStateResultLoanSuccessDate];

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

    self.status = [aDecoder decodeObjectForKey:kGetMoneyStateResultStatus];
    self.submitDate = [aDecoder decodeObjectForKey:kGetMoneyStateResultSubmitDate];
    self.auditSuccessDate = [aDecoder decodeObjectForKey:kGetMoneyStateResultAuditSuccessDate];
    self.resultIdentifier = [aDecoder decodeDoubleForKey:kGetMoneyStateResultId];
    self.loanAmount = [aDecoder decodeDoubleForKey:kGetMoneyStateResultLoanAmount];
    self.createDate = [aDecoder decodeObjectForKey:kGetMoneyStateResultCreateDate];
    self.userBean = [aDecoder decodeObjectForKey:kGetMoneyStateResultUserBean];
    self.loanSuccessDate = [aDecoder decodeObjectForKey:kGetMoneyStateResultLoanSuccessDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kGetMoneyStateResultStatus];
    [aCoder encodeObject:_submitDate forKey:kGetMoneyStateResultSubmitDate];
    [aCoder encodeObject:_auditSuccessDate forKey:kGetMoneyStateResultAuditSuccessDate];
    [aCoder encodeDouble:_resultIdentifier forKey:kGetMoneyStateResultId];
    [aCoder encodeDouble:_loanAmount forKey:kGetMoneyStateResultLoanAmount];
    [aCoder encodeObject:_createDate forKey:kGetMoneyStateResultCreateDate];
    [aCoder encodeObject:_userBean forKey:kGetMoneyStateResultUserBean];
    [aCoder encodeObject:_loanSuccessDate forKey:kGetMoneyStateResultLoanSuccessDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyStateResult *copy = [[GetMoneyStateResult alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.submitDate = [self.submitDate copyWithZone:zone];
        copy.auditSuccessDate = [self.auditSuccessDate copyWithZone:zone];
        copy.resultIdentifier = self.resultIdentifier;
        copy.loanAmount = self.loanAmount;
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.userBean = [self.userBean copyWithZone:zone];
        copy.loanSuccessDate = [self.loanSuccessDate copyWithZone:zone];
    }
    
    return copy;
}


@end
