//
//  UserStateBaseClass.m
//
//  Created by dd  on 15/12/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserStateBaseClass.h"
#import "UserStateResult.h"


NSString *const kUserStateBaseClassFlag = @"flag";
NSString *const kUserStateBaseClassMsg = @"msg";
NSString *const kUserStateBaseClassResult = @"result";


@interface UserStateBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserStateBaseClass

@synthesize flag = _flag;
@synthesize msg = _msg;
@synthesize result = _result;


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
            self.flag = [self objectOrNilForKey:kUserStateBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kUserStateBaseClassMsg fromDictionary:dict];
            self.result = [UserStateResult modelObjectWithDictionary:[dict objectForKey:kUserStateBaseClassResult]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kUserStateBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kUserStateBaseClassMsg];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kUserStateBaseClassResult];

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

    self.flag = [aDecoder decodeObjectForKey:kUserStateBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kUserStateBaseClassMsg];
    self.result = [aDecoder decodeObjectForKey:kUserStateBaseClassResult];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kUserStateBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kUserStateBaseClassMsg];
    [aCoder encodeObject:_result forKey:kUserStateBaseClassResult];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserStateBaseClass *copy = [[UserStateBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
    }
    
    return copy;
}


@end
