//
//  BankCardInfoResult.m
//
//  Created by dd  on 15/12/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BankCardInfoResult.h"


NSString *const kBankCardInfoResultBankNo = @"bankNo";
NSString *const kBankCardInfoResultCreditBankNo = @"creditBankNo";
NSString *const kBankCardInfoResultId = @"id";
NSString *const kBankCardInfoResultDebitBankName = @"debitBankName";
NSString *const kBankCardInfoResultDebitCardNo = @"debitCardNo";
NSString *const kBankCardInfoResultCreditBankName = @"creditBankName";
NSString *const kBankCardInfoResultCreditCardNo = @"creditCardNo";


@interface BankCardInfoResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BankCardInfoResult

@synthesize bankNo = _bankNo;
@synthesize creditBankNo = _creditBankNo;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize debitBankName = _debitBankName;
@synthesize debitCardNo = _debitCardNo;
@synthesize creditBankName = _creditBankName;
@synthesize creditCardNo = _creditCardNo;


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
            self.bankNo = [self objectOrNilForKey:kBankCardInfoResultBankNo fromDictionary:dict];
            self.creditBankNo = [self objectOrNilForKey:kBankCardInfoResultCreditBankNo fromDictionary:dict];
            self.resultIdentifier = [[self objectOrNilForKey:kBankCardInfoResultId fromDictionary:dict] doubleValue];
            self.debitBankName = [self objectOrNilForKey:kBankCardInfoResultDebitBankName fromDictionary:dict];
            self.debitCardNo = [self objectOrNilForKey:kBankCardInfoResultDebitCardNo fromDictionary:dict];
            self.creditBankName = [self objectOrNilForKey:kBankCardInfoResultCreditBankName fromDictionary:dict];
            self.creditCardNo = [self objectOrNilForKey:kBankCardInfoResultCreditCardNo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.bankNo forKey:kBankCardInfoResultBankNo];
    [mutableDict setValue:self.creditBankNo forKey:kBankCardInfoResultCreditBankNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kBankCardInfoResultId];
    [mutableDict setValue:self.debitBankName forKey:kBankCardInfoResultDebitBankName];
    [mutableDict setValue:self.debitCardNo forKey:kBankCardInfoResultDebitCardNo];
    [mutableDict setValue:self.creditBankName forKey:kBankCardInfoResultCreditBankName];
    [mutableDict setValue:self.creditCardNo forKey:kBankCardInfoResultCreditCardNo];

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

    self.bankNo = [aDecoder decodeObjectForKey:kBankCardInfoResultBankNo];
    self.creditBankNo = [aDecoder decodeObjectForKey:kBankCardInfoResultCreditBankNo];
    self.resultIdentifier = [aDecoder decodeDoubleForKey:kBankCardInfoResultId];
    self.debitBankName = [aDecoder decodeObjectForKey:kBankCardInfoResultDebitBankName];
    self.debitCardNo = [aDecoder decodeObjectForKey:kBankCardInfoResultDebitCardNo];
    self.creditBankName = [aDecoder decodeObjectForKey:kBankCardInfoResultCreditBankName];
    self.creditCardNo = [aDecoder decodeObjectForKey:kBankCardInfoResultCreditCardNo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_bankNo forKey:kBankCardInfoResultBankNo];
    [aCoder encodeObject:_creditBankNo forKey:kBankCardInfoResultCreditBankNo];
    [aCoder encodeDouble:_resultIdentifier forKey:kBankCardInfoResultId];
    [aCoder encodeObject:_debitBankName forKey:kBankCardInfoResultDebitBankName];
    [aCoder encodeObject:_debitCardNo forKey:kBankCardInfoResultDebitCardNo];
    [aCoder encodeObject:_creditBankName forKey:kBankCardInfoResultCreditBankName];
    [aCoder encodeObject:_creditCardNo forKey:kBankCardInfoResultCreditCardNo];
}

- (id)copyWithZone:(NSZone *)zone
{
    BankCardInfoResult *copy = [[BankCardInfoResult alloc] init];
    
    if (copy) {

        copy.bankNo = [self.bankNo copyWithZone:zone];
        copy.creditBankNo = [self.creditBankNo copyWithZone:zone];
        copy.resultIdentifier = self.resultIdentifier;
        copy.debitBankName = [self.debitBankName copyWithZone:zone];
        copy.debitCardNo = [self.debitCardNo copyWithZone:zone];
        copy.creditBankName = [self.creditBankName copyWithZone:zone];
        copy.creditCardNo = [self.creditCardNo copyWithZone:zone];
    }
    
    return copy;
}


@end
