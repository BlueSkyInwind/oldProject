//
//  ReturnMsgBaseClass.m
//
//  Created by dd  on 15/9/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ReturnMsgBaseClass.h"


NSString *const kReturnMsgBaseClassResult = @"result";
NSString *const kReturnMsgBaseClassFlag = @"flag";
NSString *const kReturnMsgBaseClassMsg = @"msg";


@interface ReturnMsgBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ReturnMsgBaseClass

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
            self.result = [self objectOrNilForKey:kReturnMsgBaseClassResult fromDictionary:dict];
            self.flag = [self objectOrNilForKey:kReturnMsgBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kReturnMsgBaseClassMsg fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.result forKey:kReturnMsgBaseClassResult];
    [mutableDict setValue:self.flag forKey:kReturnMsgBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kReturnMsgBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kReturnMsgBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kReturnMsgBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kReturnMsgBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kReturnMsgBaseClassResult];
    [aCoder encodeObject:_flag forKey:kReturnMsgBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kReturnMsgBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    ReturnMsgBaseClass *copy = [[ReturnMsgBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
