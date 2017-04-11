//
//  RepaySuccessResult.m
//
//  Created by dd  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RepaySuccessResult.h"


NSString *const kRepaySuccessResultResult = @"result";
NSString *const kRepaySuccessResultIsLoanSettlement = @"isLoanSettlement";
NSString *const kRepaySuccessResultVoucherIds = @"voucherIds";
NSString *const kRepaySuccessResultUserId = @"userId";
NSString *const kRepaySuccessResultActualRepayAmount = @"actualRepayAmount";
NSString *const kRepaySuccessResultIsFullRepay = @"isFullRepay";
NSString *const kRepaySuccessResultBankCarId = @"bankCarId";
NSString *const kRepaySuccessResultRedIds = @"redIds";
NSString *const kRepaySuccessResultRedActualAmount = @"redActualAmount";


@interface RepaySuccessResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RepaySuccessResult

@synthesize result = _result;
@synthesize isLoanSettlement = _isLoanSettlement;
@synthesize voucherIds = _voucherIds;
@synthesize userId = _userId;
@synthesize actualRepayAmount = _actualRepayAmount;
@synthesize isFullRepay = _isFullRepay;
@synthesize bankCarId = _bankCarId;
@synthesize redIds = _redIds;
@synthesize redActualAmount = _redActualAmount;


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
            self.result = [[self objectOrNilForKey:kRepaySuccessResultResult fromDictionary:dict] doubleValue];
            self.isLoanSettlement = [[self objectOrNilForKey:kRepaySuccessResultIsLoanSettlement fromDictionary:dict] doubleValue];
            self.voucherIds = [self objectOrNilForKey:kRepaySuccessResultVoucherIds fromDictionary:dict];
            self.userId = [[self objectOrNilForKey:kRepaySuccessResultUserId fromDictionary:dict] doubleValue];
            self.actualRepayAmount = [[self objectOrNilForKey:kRepaySuccessResultActualRepayAmount fromDictionary:dict] doubleValue];
            self.isFullRepay = [[self objectOrNilForKey:kRepaySuccessResultIsFullRepay fromDictionary:dict] doubleValue];
            self.bankCarId = [[self objectOrNilForKey:kRepaySuccessResultBankCarId fromDictionary:dict] doubleValue];
            self.redIds = [self objectOrNilForKey:kRepaySuccessResultRedIds fromDictionary:dict];
            self.redActualAmount = [[self objectOrNilForKey:kRepaySuccessResultRedActualAmount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kRepaySuccessResultResult];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isLoanSettlement] forKey:kRepaySuccessResultIsLoanSettlement];
    [mutableDict setValue:self.voucherIds forKey:kRepaySuccessResultVoucherIds];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kRepaySuccessResultUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.actualRepayAmount] forKey:kRepaySuccessResultActualRepayAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isFullRepay] forKey:kRepaySuccessResultIsFullRepay];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bankCarId] forKey:kRepaySuccessResultBankCarId];
    [mutableDict setValue:self.redIds forKey:kRepaySuccessResultRedIds];
    [mutableDict setValue:[NSNumber numberWithDouble:self.redActualAmount] forKey:kRepaySuccessResultRedActualAmount];

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

    self.result = [aDecoder decodeDoubleForKey:kRepaySuccessResultResult];
    self.isLoanSettlement = [aDecoder decodeDoubleForKey:kRepaySuccessResultIsLoanSettlement];
    self.voucherIds = [aDecoder decodeObjectForKey:kRepaySuccessResultVoucherIds];
    self.userId = [aDecoder decodeDoubleForKey:kRepaySuccessResultUserId];
    self.actualRepayAmount = [aDecoder decodeDoubleForKey:kRepaySuccessResultActualRepayAmount];
    self.isFullRepay = [aDecoder decodeDoubleForKey:kRepaySuccessResultIsFullRepay];
    self.bankCarId = [aDecoder decodeDoubleForKey:kRepaySuccessResultBankCarId];
    self.redIds = [aDecoder decodeObjectForKey:kRepaySuccessResultRedIds];
    self.redActualAmount = [aDecoder decodeDoubleForKey:kRepaySuccessResultRedActualAmount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kRepaySuccessResultResult];
    [aCoder encodeDouble:_isLoanSettlement forKey:kRepaySuccessResultIsLoanSettlement];
    [aCoder encodeObject:_voucherIds forKey:kRepaySuccessResultVoucherIds];
    [aCoder encodeDouble:_userId forKey:kRepaySuccessResultUserId];
    [aCoder encodeDouble:_actualRepayAmount forKey:kRepaySuccessResultActualRepayAmount];
    [aCoder encodeDouble:_isFullRepay forKey:kRepaySuccessResultIsFullRepay];
    [aCoder encodeDouble:_bankCarId forKey:kRepaySuccessResultBankCarId];
    [aCoder encodeObject:_redIds forKey:kRepaySuccessResultRedIds];
    [aCoder encodeDouble:_redActualAmount forKey:kRepaySuccessResultRedActualAmount];
}

- (id)copyWithZone:(NSZone *)zone
{
    RepaySuccessResult *copy = [[RepaySuccessResult alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.isLoanSettlement = self.isLoanSettlement;
        copy.voucherIds = [self.voucherIds copyWithZone:zone];
        copy.userId = self.userId;
        copy.actualRepayAmount = self.actualRepayAmount;
        copy.isFullRepay = self.isFullRepay;
        copy.bankCarId = self.bankCarId;
        copy.redIds = [self.redIds copyWithZone:zone];
        copy.redActualAmount = self.redActualAmount;
    }
    
    return copy;
}


@end
