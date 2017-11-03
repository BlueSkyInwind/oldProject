//
//  QueryRepaymentsData.m
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "QueryRepaymentsData.h"
#import "QueryRepaymentsLoanApplicant.h"


NSString *const kQueryRepaymentsDataPrincipal = @"principal";
NSString *const kQueryRepaymentsDataLoanId = @"loanId";
NSString *const kQueryRepaymentsDataId = @"id";
NSString *const kQueryRepaymentsDataRepaymentEndDate = @"repaymentEndDate";
NSString *const kQueryRepaymentsDataPeriodusNum = @"periodusNum";
NSString *const kQueryRepaymentsDataAmount = @"amount";
NSString *const kQueryRepaymentsDataCreateDate = @"createDate";
NSString *const kQueryRepaymentsDataManageExpense = @"manageExpense";
NSString *const kQueryRepaymentsDataIsBeOverdue = @"isBeOverdue";
NSString *const kQueryRepaymentsDataIsSettlement = @"isSettlement";
NSString *const kQueryRepaymentsDataRepaymentStartDate = @"repaymentStartDate";
NSString *const kQueryRepaymentsDataLoanApplicant = @"loanApplicant";
NSString *const kQueryRepaymentsDataRepaymentRecordsList = @"repaymentRecordsList";


@interface QueryRepaymentsData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QueryRepaymentsData

@synthesize principal = _principal;
@synthesize loanId = _loanId;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize repaymentEndDate = _repaymentEndDate;
@synthesize periodusNum = _periodusNum;
@synthesize amount = _amount;
@synthesize createDate = _createDate;
@synthesize manageExpense = _manageExpense;
@synthesize isBeOverdue = _isBeOverdue;
@synthesize isSettlement = _isSettlement;
@synthesize repaymentStartDate = _repaymentStartDate;
@synthesize loanApplicant = _loanApplicant;
@synthesize repaymentRecordsList = _repaymentRecordsList;


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
            self.principal = [[self objectOrNilForKey:kQueryRepaymentsDataPrincipal fromDictionary:dict] doubleValue];
            self.loanId = [[self objectOrNilForKey:kQueryRepaymentsDataLoanId fromDictionary:dict] doubleValue];
            self.dataIdentifier = [[self objectOrNilForKey:kQueryRepaymentsDataId fromDictionary:dict] doubleValue];
            self.repaymentEndDate = [self objectOrNilForKey:kQueryRepaymentsDataRepaymentEndDate fromDictionary:dict];
            self.periodusNum = [[self objectOrNilForKey:kQueryRepaymentsDataPeriodusNum fromDictionary:dict] doubleValue];
            self.amount = [[self objectOrNilForKey:kQueryRepaymentsDataAmount fromDictionary:dict] doubleValue];
            self.createDate = [self objectOrNilForKey:kQueryRepaymentsDataCreateDate fromDictionary:dict];
            self.manageExpense = [[self objectOrNilForKey:kQueryRepaymentsDataManageExpense fromDictionary:dict] doubleValue];
            self.isBeOverdue = [self objectOrNilForKey:kQueryRepaymentsDataIsBeOverdue fromDictionary:dict];
            self.isSettlement = [self objectOrNilForKey:kQueryRepaymentsDataIsSettlement fromDictionary:dict];
            self.repaymentStartDate = [self objectOrNilForKey:kQueryRepaymentsDataRepaymentStartDate fromDictionary:dict];
            self.loanApplicant = [QueryRepaymentsLoanApplicant modelObjectWithDictionary:[dict objectForKey:kQueryRepaymentsDataLoanApplicant]];
            self.repaymentRecordsList = [self objectOrNilForKey:kQueryRepaymentsDataRepaymentRecordsList fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.principal] forKey:kQueryRepaymentsDataPrincipal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loanId] forKey:kQueryRepaymentsDataLoanId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kQueryRepaymentsDataId];
    [mutableDict setValue:self.repaymentEndDate forKey:kQueryRepaymentsDataRepaymentEndDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.periodusNum] forKey:kQueryRepaymentsDataPeriodusNum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.amount] forKey:kQueryRepaymentsDataAmount];
    [mutableDict setValue:self.createDate forKey:kQueryRepaymentsDataCreateDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.manageExpense] forKey:kQueryRepaymentsDataManageExpense];
    [mutableDict setValue:self.isBeOverdue forKey:kQueryRepaymentsDataIsBeOverdue];
    [mutableDict setValue:self.isSettlement forKey:kQueryRepaymentsDataIsSettlement];
    [mutableDict setValue:self.repaymentStartDate forKey:kQueryRepaymentsDataRepaymentStartDate];
    [mutableDict setValue:[self.loanApplicant dictionaryRepresentation] forKey:kQueryRepaymentsDataLoanApplicant];
    NSMutableArray *tempArrayForRepaymentRecordsList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.repaymentRecordsList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRepaymentRecordsList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRepaymentRecordsList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRepaymentRecordsList] forKey:kQueryRepaymentsDataRepaymentRecordsList];

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

    self.principal = [aDecoder decodeDoubleForKey:kQueryRepaymentsDataPrincipal];
    self.loanId = [aDecoder decodeDoubleForKey:kQueryRepaymentsDataLoanId];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kQueryRepaymentsDataId];
    self.repaymentEndDate = [aDecoder decodeObjectForKey:kQueryRepaymentsDataRepaymentEndDate];
    self.periodusNum = [aDecoder decodeDoubleForKey:kQueryRepaymentsDataPeriodusNum];
    self.amount = [aDecoder decodeDoubleForKey:kQueryRepaymentsDataAmount];
    self.createDate = [aDecoder decodeObjectForKey:kQueryRepaymentsDataCreateDate];
    self.manageExpense = [aDecoder decodeDoubleForKey:kQueryRepaymentsDataManageExpense];
    self.isBeOverdue = [aDecoder decodeObjectForKey:kQueryRepaymentsDataIsBeOverdue];
    self.isSettlement = [aDecoder decodeObjectForKey:kQueryRepaymentsDataIsSettlement];
    self.repaymentStartDate = [aDecoder decodeObjectForKey:kQueryRepaymentsDataRepaymentStartDate];
    self.loanApplicant = [aDecoder decodeObjectForKey:kQueryRepaymentsDataLoanApplicant];
    self.repaymentRecordsList = [aDecoder decodeObjectForKey:kQueryRepaymentsDataRepaymentRecordsList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_principal forKey:kQueryRepaymentsDataPrincipal];
    [aCoder encodeDouble:_loanId forKey:kQueryRepaymentsDataLoanId];
    [aCoder encodeDouble:_dataIdentifier forKey:kQueryRepaymentsDataId];
    [aCoder encodeObject:_repaymentEndDate forKey:kQueryRepaymentsDataRepaymentEndDate];
    [aCoder encodeDouble:_periodusNum forKey:kQueryRepaymentsDataPeriodusNum];
    [aCoder encodeDouble:_amount forKey:kQueryRepaymentsDataAmount];
    [aCoder encodeObject:_createDate forKey:kQueryRepaymentsDataCreateDate];
    [aCoder encodeDouble:_manageExpense forKey:kQueryRepaymentsDataManageExpense];
    [aCoder encodeObject:_isBeOverdue forKey:kQueryRepaymentsDataIsBeOverdue];
    [aCoder encodeObject:_isSettlement forKey:kQueryRepaymentsDataIsSettlement];
    [aCoder encodeObject:_repaymentStartDate forKey:kQueryRepaymentsDataRepaymentStartDate];
    [aCoder encodeObject:_loanApplicant forKey:kQueryRepaymentsDataLoanApplicant];
    [aCoder encodeObject:_repaymentRecordsList forKey:kQueryRepaymentsDataRepaymentRecordsList];
}

- (id)copyWithZone:(NSZone *)zone
{
    QueryRepaymentsData *copy = [[QueryRepaymentsData alloc] init];
    
    if (copy) {

        copy.principal = self.principal;
        copy.loanId = self.loanId;
        copy.dataIdentifier = self.dataIdentifier;
        copy.repaymentEndDate = [self.repaymentEndDate copyWithZone:zone];
        copy.periodusNum = self.periodusNum;
        copy.amount = self.amount;
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.manageExpense = self.manageExpense;
        copy.isBeOverdue = [self.isBeOverdue copyWithZone:zone];
        copy.isSettlement = [self.isSettlement copyWithZone:zone];
        copy.repaymentStartDate = [self.repaymentStartDate copyWithZone:zone];
        copy.loanApplicant = [self.loanApplicant copyWithZone:zone];
        copy.repaymentRecordsList = [self.repaymentRecordsList copyWithZone:zone];
    }
    
    return copy;
}


@end
