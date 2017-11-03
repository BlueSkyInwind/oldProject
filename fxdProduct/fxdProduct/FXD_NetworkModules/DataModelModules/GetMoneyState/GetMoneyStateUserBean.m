//
//  GetMoneyStateUserBean.m
//
//  Created by dd  on 15/10/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyStateUserBean.h"


NSString *const kGetMoneyStateUserBeanId = @"id";
NSString *const kGetMoneyStateUserBeanDebitBankName = @"debitBankName";
NSString *const kGetMoneyStateUserBeanDebitCardNo = @"debitCardNo";


@interface GetMoneyStateUserBean ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyStateUserBean

@synthesize userBeanIdentifier = _userBeanIdentifier;
@synthesize debitBankName = _debitBankName;
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
            self.userBeanIdentifier = [[self objectOrNilForKey:kGetMoneyStateUserBeanId fromDictionary:dict] doubleValue];
            self.debitBankName = [self objectOrNilForKey:kGetMoneyStateUserBeanDebitBankName fromDictionary:dict];
            self.debitCardNo = [self objectOrNilForKey:kGetMoneyStateUserBeanDebitCardNo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userBeanIdentifier] forKey:kGetMoneyStateUserBeanId];
    [mutableDict setValue:self.debitBankName forKey:kGetMoneyStateUserBeanDebitBankName];
    [mutableDict setValue:self.debitCardNo forKey:kGetMoneyStateUserBeanDebitCardNo];

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

    self.userBeanIdentifier = [aDecoder decodeDoubleForKey:kGetMoneyStateUserBeanId];
    self.debitBankName = [aDecoder decodeObjectForKey:kGetMoneyStateUserBeanDebitBankName];
    self.debitCardNo = [aDecoder decodeObjectForKey:kGetMoneyStateUserBeanDebitCardNo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_userBeanIdentifier forKey:kGetMoneyStateUserBeanId];
    [aCoder encodeObject:_debitBankName forKey:kGetMoneyStateUserBeanDebitBankName];
    [aCoder encodeObject:_debitCardNo forKey:kGetMoneyStateUserBeanDebitCardNo];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyStateUserBean *copy = [[GetMoneyStateUserBean alloc] init];
    
    if (copy) {

        copy.userBeanIdentifier = self.userBeanIdentifier;
        copy.debitBankName = [self.debitBankName copyWithZone:zone];
        copy.debitCardNo = [self.debitCardNo copyWithZone:zone];
    }
    
    return copy;
}


@end
