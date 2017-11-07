//
//  WeekPaySelectBaseClass.m
//
//  Created by dd  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "WeekPaySelectBaseClass.h"
#import "WeekPaySelectResult.h"


NSString *const kWeekPaySelectBaseClassResult = @"result";
NSString *const kWeekPaySelectBaseClassFlag = @"flag";
NSString *const kWeekPaySelectBaseClassMsg = @"msg";


@interface WeekPaySelectBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeekPaySelectBaseClass

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
            self.result = [WeekPaySelectResult modelObjectWithDictionary:[dict objectForKey:kWeekPaySelectBaseClassResult]];
            self.flag = [self objectOrNilForKey:kWeekPaySelectBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kWeekPaySelectBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kWeekPaySelectBaseClassResult];
    [mutableDict setValue:self.flag forKey:kWeekPaySelectBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kWeekPaySelectBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kWeekPaySelectBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kWeekPaySelectBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kWeekPaySelectBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kWeekPaySelectBaseClassResult];
    [aCoder encodeObject:_flag forKey:kWeekPaySelectBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kWeekPaySelectBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeekPaySelectBaseClass *copy = [[WeekPaySelectBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
