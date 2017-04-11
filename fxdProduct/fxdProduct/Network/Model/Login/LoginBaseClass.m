//
//  LoginBaseClass.m
//
//  Created by dd  on 16/3/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LoginBaseClass.h"
#import "LoginResult.h"


NSString *const kLoginBaseClassResult = @"result";
NSString *const kLoginBaseClassFlag = @"flag";
NSString *const kLoginBaseClassMsg = @"msg";


@interface LoginBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginBaseClass

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
            self.result = [LoginResult modelObjectWithDictionary:[dict objectForKey:kLoginBaseClassResult]];
            self.flag = [self objectOrNilForKey:kLoginBaseClassFlag fromDictionary:dict];
            self.msg = [self objectOrNilForKey:kLoginBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kLoginBaseClassResult];
    [mutableDict setValue:self.flag forKey:kLoginBaseClassFlag];
    [mutableDict setValue:self.msg forKey:kLoginBaseClassMsg];

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

    self.result = [aDecoder decodeObjectForKey:kLoginBaseClassResult];
    self.flag = [aDecoder decodeObjectForKey:kLoginBaseClassFlag];
    self.msg = [aDecoder decodeObjectForKey:kLoginBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kLoginBaseClassResult];
    [aCoder encodeObject:_flag forKey:kLoginBaseClassFlag];
    [aCoder encodeObject:_msg forKey:kLoginBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginBaseClass *copy = [[LoginBaseClass alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
