//
//  GetMoneyResultBaseClass.m
//
//  Created by dd  on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyResultBaseClass.h"
#import "GetMoneyResultResult.h"


NSString *const kGetMoneyResultBaseClassResult = @"result";
NSString *const kGetMoneyResultBaseClassFlag = @"flag";
NSString *const kGetMoneyResultBaseClassMsg = @"msg";


@interface GetMoneyResultBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyResultBaseClass

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
            self.result = [GetMoneyResultResult modelObjectWithDictionary:[dict objectForKey:kGetMoneyResultBaseClassResult]];
            self.flag = [self objectOrNilForKey:kGetMoneyResultBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kGetMoneyResultBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kGetMoneyResultBaseClassResult];
    [mutableDict setValue:self.flag forKey:kGetMoneyResultBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kGetMoneyResultBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kGetMoneyResultBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kGetMoneyResultBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kGetMoneyResultBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kGetMoneyResultBaseClassResult];
    [aCoder encodeObject:_flag forKey:kGetMoneyResultBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kGetMoneyResultBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyResultBaseClass *copy = [[GetMoneyResultBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
