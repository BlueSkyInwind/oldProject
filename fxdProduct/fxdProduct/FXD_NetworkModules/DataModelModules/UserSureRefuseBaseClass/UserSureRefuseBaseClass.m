//
//  UserSureRefuseBaseClass.m
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserSureRefuseBaseClass.h"
#import "UserSureRefuseResult.h"


NSString *const kUserSureRefuseBaseClassResult = @"result";
NSString *const kUserSureRefuseBaseClassFlag = @"flag";
NSString *const kUserSureRefuseBaseClassMsg = @"msg";


@interface UserSureRefuseBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSureRefuseBaseClass

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
            self.result = [UserSureRefuseResult modelObjectWithDictionary:[dict objectForKey:kUserSureRefuseBaseClassResult]];
            self.flag = [self objectOrNilForKey:kUserSureRefuseBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kUserSureRefuseBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kUserSureRefuseBaseClassResult];
    [mutableDict setValue:self.flag forKey:kUserSureRefuseBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kUserSureRefuseBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kUserSureRefuseBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kUserSureRefuseBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kUserSureRefuseBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kUserSureRefuseBaseClassResult];
    [aCoder encodeObject:_flag forKey:kUserSureRefuseBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kUserSureRefuseBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSureRefuseBaseClass *copy = [[UserSureRefuseBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
