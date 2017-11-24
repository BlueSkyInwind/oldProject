//
//  Ext.m
//
//  Created by dd  on 2017/3/1
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Custom_BaseInfoExt.h"


NSString *const kExtMobilePhone = @"mobile_phone_";


@interface Custom_BaseInfoExt ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Custom_BaseInfoExt

@synthesize mobilePhone = _mobilePhone;


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
            self.mobilePhone = [self objectOrNilForKey:kExtMobilePhone fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobilePhone forKey:kExtMobilePhone];

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

    self.mobilePhone = [aDecoder decodeObjectForKey:kExtMobilePhone];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobilePhone forKey:kExtMobilePhone];
}

- (id)copyWithZone:(NSZone *)zone
{
    Custom_BaseInfoExt *copy = [[Custom_BaseInfoExt alloc] init];
    
    if (copy) {

        copy.mobilePhone = [self.mobilePhone copyWithZone:zone];
    }
    
    return copy;
}


@end
