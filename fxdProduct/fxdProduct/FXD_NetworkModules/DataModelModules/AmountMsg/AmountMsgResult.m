//
//  AmountMsgResult.m
//
//  Created by dd  on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AmountMsgResult.h"


NSString *const kAmountMsgResultTypeStatus = @"typeStatus";


@interface AmountMsgResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AmountMsgResult

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
            self.typeStatus = [self objectOrNilForKey:kAmountMsgResultTypeStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.typeStatus forKey:kAmountMsgResultTypeStatus];

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

    self.typeStatus = [aDecoder decodeObjectForKey:kAmountMsgResultTypeStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_typeStatus forKey:kAmountMsgResultTypeStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    AmountMsgResult *copy = [[AmountMsgResult alloc] init];
    
    if (copy) {

        copy.typeStatus = [self.typeStatus copyWithZone:zone];
    }
    
    return copy;
}


@end
