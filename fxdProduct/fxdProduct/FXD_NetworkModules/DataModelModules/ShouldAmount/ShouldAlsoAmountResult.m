//
//  ShouldAlsoAmountResult.m
//
//  Created by dd  on 15/10/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ShouldAlsoAmountResult.h"


NSString *const kShouldAlsoAmountResultId = @"id";
NSString *const kShouldAlsoAmountResultCreateDate = @"createDate";
NSString *const kShouldAlsoAmountResultUpdateId = @"updateId";
NSString *const kShouldAlsoAmountResultShouldAlsoAount = @"shouldAlsoAount";
NSString *const kShouldAlsoAmountResultToken = @"token";


@interface ShouldAlsoAmountResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShouldAlsoAmountResult

@synthesize resultIdentifier = _resultIdentifier;
@synthesize createDate = _createDate;
@synthesize updateId = _updateId;
@synthesize shouldAlsoAount = _shouldAlsoAount;
@synthesize token = _token;


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
            self.resultIdentifier = [[self objectOrNilForKey:kShouldAlsoAmountResultId fromDictionary:dict] doubleValue];
            self.createDate = [self objectOrNilForKey:kShouldAlsoAmountResultCreateDate fromDictionary:dict];
            self.updateId = [[self objectOrNilForKey:kShouldAlsoAmountResultUpdateId fromDictionary:dict] doubleValue];
            self.shouldAlsoAount = [[self objectOrNilForKey:kShouldAlsoAmountResultShouldAlsoAount fromDictionary:dict] doubleValue];
            self.token = [self objectOrNilForKey:kShouldAlsoAmountResultToken fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kShouldAlsoAmountResultId];
    [mutableDict setValue:self.createDate forKey:kShouldAlsoAmountResultCreateDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateId] forKey:kShouldAlsoAmountResultUpdateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shouldAlsoAount] forKey:kShouldAlsoAmountResultShouldAlsoAount];
    [mutableDict setValue:self.token forKey:kShouldAlsoAmountResultToken];

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

    self.resultIdentifier = [aDecoder decodeDoubleForKey:kShouldAlsoAmountResultId];
    self.createDate = [aDecoder decodeObjectForKey:kShouldAlsoAmountResultCreateDate];
    self.updateId = [aDecoder decodeDoubleForKey:kShouldAlsoAmountResultUpdateId];
    self.shouldAlsoAount = [aDecoder decodeDoubleForKey:kShouldAlsoAmountResultShouldAlsoAount];
    self.token = [aDecoder decodeObjectForKey:kShouldAlsoAmountResultToken];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resultIdentifier forKey:kShouldAlsoAmountResultId];
    [aCoder encodeObject:_createDate forKey:kShouldAlsoAmountResultCreateDate];
    [aCoder encodeDouble:_updateId forKey:kShouldAlsoAmountResultUpdateId];
    [aCoder encodeDouble:_shouldAlsoAount forKey:kShouldAlsoAmountResultShouldAlsoAount];
    [aCoder encodeObject:_token forKey:kShouldAlsoAmountResultToken];
}

- (id)copyWithZone:(NSZone *)zone
{
    ShouldAlsoAmountResult *copy = [[ShouldAlsoAmountResult alloc] init];
    
    if (copy) {

        copy.resultIdentifier = self.resultIdentifier;
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.updateId = self.updateId;
        copy.shouldAlsoAount = self.shouldAlsoAount;
        copy.token = [self.token copyWithZone:zone];
    }
    
    return copy;
}


@end
