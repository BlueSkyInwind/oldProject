//
//  RepayHistoryBaseClass.m
//
//  Created by dd  on 15/10/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RepayHistoryBaseClass.h"
#import "RepayHistoryResult.h"


NSString *const kRepayHistoryBaseClassResult = @"result";
NSString *const kRepayHistoryBaseClassFlag = @"flag";
NSString *const kRepayHistoryBaseClassMsg = @"msg";


@interface RepayHistoryBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RepayHistoryBaseClass

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
            self.result = [RepayHistoryResult modelObjectWithDictionary:[dict objectForKey:kRepayHistoryBaseClassResult]];
            self.flag = [self objectOrNilForKey:kRepayHistoryBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kRepayHistoryBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kRepayHistoryBaseClassResult];
    [mutableDict setValue:self.flag forKey:kRepayHistoryBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kRepayHistoryBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kRepayHistoryBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kRepayHistoryBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kRepayHistoryBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kRepayHistoryBaseClassResult];
    [aCoder encodeObject:_flag forKey:kRepayHistoryBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kRepayHistoryBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    RepayHistoryBaseClass *copy = [[RepayHistoryBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
