//
//  SquareRepaymentExt.m
//
//  Created by dd  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SquareRepaymentExt.h"


NSString *const kSquareRepaymentExtMobilePhone = @"mobile_phone_";


@interface SquareRepaymentExt ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareRepaymentExt

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
            self.mobilePhone = [self objectOrNilForKey:kSquareRepaymentExtMobilePhone fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobilePhone forKey:kSquareRepaymentExtMobilePhone];

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

    self.mobilePhone = [aDecoder decodeObjectForKey:kSquareRepaymentExtMobilePhone];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobilePhone forKey:kSquareRepaymentExtMobilePhone];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareRepaymentExt *copy = [[SquareRepaymentExt alloc] init];
    
    if (copy) {

        copy.mobilePhone = [self.mobilePhone copyWithZone:zone];
    }
    
    return copy;
}


@end
