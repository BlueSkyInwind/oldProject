//
//  GetMoneyHistoryBaseClass.m
//
//  Created by dd  on 15/12/18
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetMoneyHistoryBaseClass.h"
#import "GetMoneyHistoryResult.h"


NSString *const kGetMoneyHistoryBaseClassResult = @"result";
NSString *const kGetMoneyHistoryBaseClassFlag = @"flag";
NSString *const kGetMoneyHistoryBaseClassMsg = @"msg";


@interface GetMoneyHistoryBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetMoneyHistoryBaseClass

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
    NSObject *receivedGetMoneyHistoryResult = [dict objectForKey:kGetMoneyHistoryBaseClassResult];
    NSMutableArray *parsedGetMoneyHistoryResult = [NSMutableArray array];
    if ([receivedGetMoneyHistoryResult isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGetMoneyHistoryResult) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGetMoneyHistoryResult addObject:[GetMoneyHistoryResult modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGetMoneyHistoryResult isKindOfClass:[NSDictionary class]]) {
       [parsedGetMoneyHistoryResult addObject:[GetMoneyHistoryResult modelObjectWithDictionary:(NSDictionary *)receivedGetMoneyHistoryResult]];
    }

    self.result = [NSArray arrayWithArray:parsedGetMoneyHistoryResult];
            self.flag = [self objectOrNilForKey:kGetMoneyHistoryBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kGetMoneyHistoryBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForResult = [NSMutableArray array];
    for (NSObject *subArrayObject in self.result) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResult addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResult addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResult] forKey:kGetMoneyHistoryBaseClassResult];
    [mutableDict setValue:self.flag forKey:kGetMoneyHistoryBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kGetMoneyHistoryBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kGetMoneyHistoryBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kGetMoneyHistoryBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kGetMoneyHistoryBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kGetMoneyHistoryBaseClassResult];
    [aCoder encodeObject:_flag forKey:kGetMoneyHistoryBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kGetMoneyHistoryBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    GetMoneyHistoryBaseClass *copy = [[GetMoneyHistoryBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
