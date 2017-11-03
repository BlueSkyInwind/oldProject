//
//  GetMoneyStateBaseClass.m
//
//  Created by dd  on 15/10/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyStateBaseClass.h"
#import "GetMoneyStateResult.h"


NSString *const kGetMoneyStateBaseClassResult = @"result";
NSString *const kGetMoneyStateBaseClassFlag = @"flag";
NSString *const kGetMoneyStateBaseClassMsg = @"msg";


@interface GetMoneyStateBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyStateBaseClass

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
            self.result = [GetMoneyStateResult modelObjectWithDictionary:[dict objectForKey:kGetMoneyStateBaseClassResult]];
            self.flag = [self objectOrNilForKey:kGetMoneyStateBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kGetMoneyStateBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kGetMoneyStateBaseClassResult];
    [mutableDict setValue:self.flag forKey:kGetMoneyStateBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kGetMoneyStateBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kGetMoneyStateBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kGetMoneyStateBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kGetMoneyStateBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kGetMoneyStateBaseClassResult];
    [aCoder encodeObject:_flag forKey:kGetMoneyStateBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kGetMoneyStateBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyStateBaseClass *copy = [[GetMoneyStateBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
