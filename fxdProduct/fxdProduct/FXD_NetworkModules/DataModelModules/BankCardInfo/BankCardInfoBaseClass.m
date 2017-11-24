//
//  BankCardInfoBaseClass.m
//
//  Created by dd  on 15/12/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BankCardInfoBaseClass.h"
#import "BankCardInfoResult.h"


NSString *const kBankCardInfoBaseClassResult = @"result";
NSString *const kBankCardInfoBaseClassFlag = @"flag";
NSString *const kBankCardInfoBaseClassMsg = @"msg";


@interface BankCardInfoBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BankCardInfoBaseClass

@synthesize result = _result;
@synthesize flag = _flag;
@synthesize msg = _msg;


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
            self.result = [BankCardInfoResult modelObjectWithDictionary:[dict objectForKey:kBankCardInfoBaseClassResult]];
            self.flag = [self objectOrNilForKey:kBankCardInfoBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kBankCardInfoBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kBankCardInfoBaseClassResult];
    [mutableDict setValue:self.flag forKey:kBankCardInfoBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kBankCardInfoBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kBankCardInfoBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kBankCardInfoBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kBankCardInfoBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kBankCardInfoBaseClassResult];
    [aCoder encodeObject:_flag forKey:kBankCardInfoBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kBankCardInfoBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    BankCardInfoBaseClass *copy = [[BankCardInfoBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
