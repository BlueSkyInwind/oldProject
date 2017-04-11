//
//  CardListResult.m
//
//  Created by dd  on 15/10/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "CardListResult.h"


NSString *const kCardListResultId = @"id";
NSString *const kCardListResultCreateDate = @"createDate";
NSString *const kCardListResultBankName = @"bankName";
NSString *const kCardListResultUserId = @"userId";
NSString *const kCardListResultTheBank = @"theBank";
NSString *const kCardListResultBankNum = @"bankNum";


@interface CardListResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CardListResult

@synthesize resultIdentifier = _resultIdentifier;
@synthesize createDate = _createDate;
@synthesize bankName = _bankName;
@synthesize userId = _userId;
@synthesize theBank = _theBank;
@synthesize bankNum = _bankNum;


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
            self.resultIdentifier = [[self objectOrNilForKey:kCardListResultId fromDictionary:dict] doubleValue];
            self.createDate = [self objectOrNilForKey:kCardListResultCreateDate fromDictionary:dict];
            self.bankName = [self objectOrNilForKey:kCardListResultBankName fromDictionary:dict];
            self.userId = [[self objectOrNilForKey:kCardListResultUserId fromDictionary:dict] doubleValue];
            self.theBank = [self objectOrNilForKey:kCardListResultTheBank fromDictionary:dict];
            self.bankNum = [self objectOrNilForKey:kCardListResultBankNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kCardListResultId];
    [mutableDict setValue:self.createDate forKey:kCardListResultCreateDate];
    [mutableDict setValue:self.bankName forKey:kCardListResultBankName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kCardListResultUserId];
    [mutableDict setValue:self.theBank forKey:kCardListResultTheBank];
    [mutableDict setValue:self.bankNum forKey:kCardListResultBankNum];

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

    self.resultIdentifier = [aDecoder decodeDoubleForKey:kCardListResultId];
    self.createDate = [aDecoder decodeObjectForKey:kCardListResultCreateDate];
    self.bankName = [aDecoder decodeObjectForKey:kCardListResultBankName];
    self.userId = [aDecoder decodeDoubleForKey:kCardListResultUserId];
    self.theBank = [aDecoder decodeObjectForKey:kCardListResultTheBank];
    self.bankNum = [aDecoder decodeObjectForKey:kCardListResultBankNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resultIdentifier forKey:kCardListResultId];
    [aCoder encodeObject:_createDate forKey:kCardListResultCreateDate];
    [aCoder encodeObject:_bankName forKey:kCardListResultBankName];
    [aCoder encodeDouble:_userId forKey:kCardListResultUserId];
    [aCoder encodeObject:_theBank forKey:kCardListResultTheBank];
    [aCoder encodeObject:_bankNum forKey:kCardListResultBankNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    CardListResult *copy = [[CardListResult alloc] init];
    
    if (copy) {

        copy.resultIdentifier = self.resultIdentifier;
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.bankName = [self.bankName copyWithZone:zone];
        copy.userId = self.userId;
        copy.theBank = [self.theBank copyWithZone:zone];
        copy.bankNum = [self.bankNum copyWithZone:zone];
    }
    
    return copy;
}


@end
