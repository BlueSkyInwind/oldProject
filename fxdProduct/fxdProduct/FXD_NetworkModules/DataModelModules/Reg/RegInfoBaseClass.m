//
//  RegInfoBaseClass.m
//
//  Created by dd  on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RegInfoBaseClass.h"


NSString *const kRegInfoBaseClassResult = @"result";
NSString *const kRegInfoBaseClassFlag = @"flag";
NSString *const kRegInfoBaseClassMsg = @"msg";


@interface RegInfoBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RegInfoBaseClass

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
            self.result = [self objectOrNilForKey:kRegInfoBaseClassResult fromDictionary:dict];
            self.flag = [self objectOrNilForKey:kRegInfoBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kRegInfoBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.result forKey:kRegInfoBaseClassResult];
    [mutableDict setValue:self.flag forKey:kRegInfoBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kRegInfoBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kRegInfoBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kRegInfoBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kRegInfoBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kRegInfoBaseClassResult];
    [aCoder encodeObject:_flag forKey:kRegInfoBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kRegInfoBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    RegInfoBaseClass *copy = [[RegInfoBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
