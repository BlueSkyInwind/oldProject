//
//  ProductListExt.m
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ProductListExt.h"


NSString *const kProductListExtMobilePhone = @"mobile_phone_";


@interface ProductListExt ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductListExt

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
            self.mobilePhone = [self objectOrNilForKey:kProductListExtMobilePhone fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobilePhone forKey:kProductListExtMobilePhone];

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

    self.mobilePhone = [aDecoder decodeObjectForKey:kProductListExtMobilePhone];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobilePhone forKey:kProductListExtMobilePhone];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductListExt *copy = [[ProductListExt alloc] init];
    
    if (copy) {

        copy.mobilePhone = [self.mobilePhone copyWithZone:zone];
    }
    
    return copy;
}


@end
