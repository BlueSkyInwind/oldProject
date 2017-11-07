//
//  GetMoneyProcessUserBean.m
//
//  Created by dd  on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyProcessUserBean.h"


NSString *const kGetMoneyProcessUserBeanDebitBankName = @"debitBankName";
NSString *const kGetMoneyProcessUserBeanId = @"id";
NSString *const kGetMoneyProcessUserBeanBankNo = @"bankNo";
NSString *const kGetMoneyProcessUserBeanDebitCardNo = @"debitCardNo";


@interface GetMoneyProcessUserBean ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyProcessUserBean

@synthesize debitBankName = _debitBankName;
@synthesize userBeanIdentifier = _userBeanIdentifier;
@synthesize bankNo = _bankNo;
@synthesize debitCardNo = _debitCardNo;


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
            self.debitBankName = [self objectOrNilForKey:kGetMoneyProcessUserBeanDebitBankName fromDictionary:dict];
            self.userBeanIdentifier = [[self objectOrNilForKey:kGetMoneyProcessUserBeanId fromDictionary:dict] doubleValue];
            self.bankNo = [self objectOrNilForKey:kGetMoneyProcessUserBeanBankNo fromDictionary:dict];
            self.debitCardNo = [self objectOrNilForKey:kGetMoneyProcessUserBeanDebitCardNo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.debitBankName forKey:kGetMoneyProcessUserBeanDebitBankName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userBeanIdentifier] forKey:kGetMoneyProcessUserBeanId];
    [mutableDict setValue:self.bankNo forKey:kGetMoneyProcessUserBeanBankNo];
    [mutableDict setValue:self.debitCardNo forKey:kGetMoneyProcessUserBeanDebitCardNo];

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

    self.debitBankName = [aDecoder decodeObjectForKey:kGetMoneyProcessUserBeanDebitBankName];
    self.userBeanIdentifier = [aDecoder decodeDoubleForKey:kGetMoneyProcessUserBeanId];
    self.bankNo = [aDecoder decodeObjectForKey:kGetMoneyProcessUserBeanBankNo];
    self.debitCardNo = [aDecoder decodeObjectForKey:kGetMoneyProcessUserBeanDebitCardNo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_debitBankName forKey:kGetMoneyProcessUserBeanDebitBankName];
    [aCoder encodeDouble:_userBeanIdentifier forKey:kGetMoneyProcessUserBeanId];
    [aCoder encodeObject:_bankNo forKey:kGetMoneyProcessUserBeanBankNo];
    [aCoder encodeObject:_debitCardNo forKey:kGetMoneyProcessUserBeanDebitCardNo];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyProcessUserBean *copy = [[GetMoneyProcessUserBean alloc] init];
    
    if (copy) {

        copy.debitBankName = [self.debitBankName copyWithZone:zone];
        copy.userBeanIdentifier = self.userBeanIdentifier;
        copy.bankNo = [self.bankNo copyWithZone:zone];
        copy.debitCardNo = [self.debitCardNo copyWithZone:zone];
    }
    
    return copy;
}


@end
