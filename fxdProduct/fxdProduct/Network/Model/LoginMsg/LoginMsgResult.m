//
//  LoginMsgResult.m
//
//  Created by dd  on 16/3/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LoginMsgResult.h"


NSString *const kLoginMsgResultJuid = @"juid";


@interface LoginMsgResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginMsgResult

@synthesize juid = _juid;


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
            self.juid = [self objectOrNilForKey:kLoginMsgResultJuid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.juid forKey:kLoginMsgResultJuid];

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

    self.juid = [aDecoder decodeObjectForKey:kLoginMsgResultJuid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_juid forKey:kLoginMsgResultJuid];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginMsgResult *copy = [[LoginMsgResult alloc] init];
    
    if (copy) {

        copy.juid = [self.juid copyWithZone:zone];
    }
    
    return copy;
}


@end
