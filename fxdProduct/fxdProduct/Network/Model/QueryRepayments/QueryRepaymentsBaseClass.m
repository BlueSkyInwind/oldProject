//
//  QueryRepaymentsBaseClass.m
//
//  Created by dd  on 15/10/10
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "QueryRepaymentsBaseClass.h"
#import "QueryRepaymentsResult.h"


NSString *const kQueryRepaymentsBaseClassResult = @"result";
NSString *const kQueryRepaymentsBaseClassFlag = @"flag";
NSString *const kQueryRepaymentsBaseClassMsg = @"msg";


@interface QueryRepaymentsBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation QueryRepaymentsBaseClass

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
            self.result = [QueryRepaymentsResult modelObjectWithDictionary:[dict objectForKey:kQueryRepaymentsBaseClassResult]];
            self.flag = [self objectOrNilForKey:kQueryRepaymentsBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kQueryRepaymentsBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kQueryRepaymentsBaseClassResult];
    [mutableDict setValue:self.flag forKey:kQueryRepaymentsBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kQueryRepaymentsBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kQueryRepaymentsBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kQueryRepaymentsBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kQueryRepaymentsBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kQueryRepaymentsBaseClassResult];
    [aCoder encodeObject:_flag forKey:kQueryRepaymentsBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kQueryRepaymentsBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    QueryRepaymentsBaseClass *copy = [[QueryRepaymentsBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
