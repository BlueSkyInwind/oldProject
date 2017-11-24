//
//  CashResult.m
//
//  Created by dd  on 15/10/20
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CashResult.h"


NSString *const kCashResultAmount = @"amount";
NSString *const kCashResultId = @"id";
NSString *const kCashResultVouchersStatus = @"vouchersStatus";
NSString *const kCashResultVoucherType = @"voucherType";
NSString *const kCashResultGrantEndDate = @"grantEndDate";


@interface CashResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CashResult

@synthesize amount = _amount;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize vouchersStatus = _vouchersStatus;
@synthesize voucherType = _voucherType;
@synthesize grantEndDate = _grantEndDate;


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
            self.amount = [[self objectOrNilForKey:kCashResultAmount fromDictionary:dict] doubleValue];
            self.resultIdentifier = [[self objectOrNilForKey:kCashResultId fromDictionary:dict] doubleValue];
            self.vouchersStatus = [self objectOrNilForKey:kCashResultVouchersStatus fromDictionary:dict];
            self.voucherType = [self objectOrNilForKey:kCashResultVoucherType fromDictionary:dict];
            self.grantEndDate = [self objectOrNilForKey:kCashResultGrantEndDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.amount] forKey:kCashResultAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kCashResultId];
    [mutableDict setValue:self.vouchersStatus forKey:kCashResultVouchersStatus];
    [mutableDict setValue:self.voucherType forKey:kCashResultVoucherType];
    [mutableDict setValue:self.grantEndDate forKey:kCashResultGrantEndDate];

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

    self.amount = [aDecoder decodeDoubleForKey:kCashResultAmount];
    self.resultIdentifier = [aDecoder decodeDoubleForKey:kCashResultId];
    self.vouchersStatus = [aDecoder decodeObjectForKey:kCashResultVouchersStatus];
    self.voucherType = [aDecoder decodeObjectForKey:kCashResultVoucherType];
    self.grantEndDate = [aDecoder decodeObjectForKey:kCashResultGrantEndDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_amount forKey:kCashResultAmount];
    [aCoder encodeDouble:_resultIdentifier forKey:kCashResultId];
    [aCoder encodeObject:_vouchersStatus forKey:kCashResultVouchersStatus];
    [aCoder encodeObject:_voucherType forKey:kCashResultVoucherType];
    [aCoder encodeObject:_grantEndDate forKey:kCashResultGrantEndDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    CashResult *copy = [[CashResult alloc] init];
    
    if (copy) {

        copy.amount = self.amount;
        copy.resultIdentifier = self.resultIdentifier;
        copy.vouchersStatus = [self.vouchersStatus copyWithZone:zone];
        copy.voucherType = [self.voucherType copyWithZone:zone];
        copy.grantEndDate = [self.grantEndDate copyWithZone:zone];
    }
    
    return copy;
}


@end
