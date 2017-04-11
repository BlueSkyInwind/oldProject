//
//  ShouldAlsoAmountBaseClass.m
//
//  Created by dd  on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ShouldAlsoAmountBaseClass.h"
#import "ShouldAlsoAmountResult.h"


NSString *const kShouldAlsoAmountBaseClassResult = @"result";
NSString *const kShouldAlsoAmountBaseClassFlag = @"flag";
NSString *const kShouldAlsoAmountBaseClassMsg = @"msg";


@interface ShouldAlsoAmountBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShouldAlsoAmountBaseClass

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
            self.result = [ShouldAlsoAmountResult modelObjectWithDictionary:[dict objectForKey:kShouldAlsoAmountBaseClassResult]];
            self.flag = [self objectOrNilForKey:kShouldAlsoAmountBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kShouldAlsoAmountBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kShouldAlsoAmountBaseClassResult];
    [mutableDict setValue:self.flag forKey:kShouldAlsoAmountBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kShouldAlsoAmountBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kShouldAlsoAmountBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kShouldAlsoAmountBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kShouldAlsoAmountBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kShouldAlsoAmountBaseClassResult];
    [aCoder encodeObject:_flag forKey:kShouldAlsoAmountBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kShouldAlsoAmountBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    ShouldAlsoAmountBaseClass *copy = [[ShouldAlsoAmountBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
