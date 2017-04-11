//
//  UserSureRefuseResult.m
//
//  Created by   on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserSureRefuseResult.h"


NSString *const kUserSureRefuseResultTypeStatus = @"typeStatus";


@interface UserSureRefuseResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSureRefuseResult

@synthesize typeStatus = _typeStatus;


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
            self.typeStatus = [self objectOrNilForKey:kUserSureRefuseResultTypeStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.typeStatus forKey:kUserSureRefuseResultTypeStatus];

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

    self.typeStatus = [aDecoder decodeObjectForKey:kUserSureRefuseResultTypeStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_typeStatus forKey:kUserSureRefuseResultTypeStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSureRefuseResult *copy = [[UserSureRefuseResult alloc] init];
    
    if (copy) {

        copy.typeStatus = [self.typeStatus copyWithZone:zone];
    }
    
    return copy;
}


@end
