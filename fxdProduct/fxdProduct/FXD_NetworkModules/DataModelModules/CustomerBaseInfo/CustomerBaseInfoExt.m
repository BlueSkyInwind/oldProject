//
//  CustomerBaseInfoExt.m
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CustomerBaseInfoExt.h"


NSString *const kCustomerBaseInfoExtMobilePhone = @"mobile_phone_";


@interface CustomerBaseInfoExt ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CustomerBaseInfoExt

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
            self.mobilePhone = [self objectOrNilForKey:kCustomerBaseInfoExtMobilePhone fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobilePhone forKey:kCustomerBaseInfoExtMobilePhone];

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

    self.mobilePhone = [aDecoder decodeObjectForKey:kCustomerBaseInfoExtMobilePhone];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobilePhone forKey:kCustomerBaseInfoExtMobilePhone];
}

- (id)copyWithZone:(NSZone *)zone
{
    CustomerBaseInfoExt *copy = [[CustomerBaseInfoExt alloc] init];
    
    if (copy) {

        copy.mobilePhone = [self.mobilePhone copyWithZone:zone];
    }
    
    return copy;
}


@end
