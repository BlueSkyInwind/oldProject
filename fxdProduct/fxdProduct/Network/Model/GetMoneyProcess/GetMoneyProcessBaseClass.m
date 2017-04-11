//
//  GetMoneyProcessBaseClass.m
//
//  Created by dd  on 15/11/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyProcessBaseClass.h"
#import "GetMoneyProcessResult.h"


NSString *const kGetMoneyProcessBaseClassResult = @"result";
NSString *const kGetMoneyProcessBaseClassFlag = @"flag";
NSString *const kGetMoneyProcessBaseClassMsg = @"msg";


@interface GetMoneyProcessBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyProcessBaseClass

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
            self.result = [GetMoneyProcessResult modelObjectWithDictionary:[dict objectForKey:kGetMoneyProcessBaseClassResult]];
            self.flag = [self objectOrNilForKey:kGetMoneyProcessBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kGetMoneyProcessBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kGetMoneyProcessBaseClassResult];
    [mutableDict setValue:self.flag forKey:kGetMoneyProcessBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kGetMoneyProcessBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kGetMoneyProcessBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kGetMoneyProcessBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kGetMoneyProcessBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kGetMoneyProcessBaseClassResult];
    [aCoder encodeObject:_flag forKey:kGetMoneyProcessBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kGetMoneyProcessBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyProcessBaseClass *copy = [[GetMoneyProcessBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
