//
//  AmountMsgBaseClass.m
//
//  Created by dd  on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AmountMsgBaseClass.h"
#import "AmountMsgResult.h"


NSString *const kAmountMsgBaseClassResult = @"result";
NSString *const kAmountMsgBaseClassFlag = @"flag";
NSString *const kAmountMsgBaseClassMsg = @"msg";


@interface AmountMsgBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AmountMsgBaseClass

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
            self.result = [AmountMsgResult modelObjectWithDictionary:[dict objectForKey:kAmountMsgBaseClassResult]];
            self.flag = [self objectOrNilForKey:kAmountMsgBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kAmountMsgBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kAmountMsgBaseClassResult];
    [mutableDict setValue:self.flag forKey:kAmountMsgBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kAmountMsgBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kAmountMsgBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kAmountMsgBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kAmountMsgBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kAmountMsgBaseClassResult];
    [aCoder encodeObject:_flag forKey:kAmountMsgBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kAmountMsgBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    AmountMsgBaseClass *copy = [[AmountMsgBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
