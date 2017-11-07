//
//  LivenessIdentity.m
//
//  Created by dd  on 16/3/31
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LivenessIdentity.h"


NSString *const kLivenessIdentityValidity = @"validity";
NSString *const kLivenessIdentityPhotoId = @"photo_id";


@interface LivenessIdentity ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LivenessIdentity

@synthesize validity = _validity;
@synthesize photoId = _photoId;


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
            self.validity = [[self objectOrNilForKey:kLivenessIdentityValidity fromDictionary:dict] boolValue];
            self.photoId = [self objectOrNilForKey:kLivenessIdentityPhotoId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.validity] forKey:kLivenessIdentityValidity];
    [mutableDict setValue:self.photoId forKey:kLivenessIdentityPhotoId];

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

    self.validity = [aDecoder decodeBoolForKey:kLivenessIdentityValidity];
    self.photoId = [aDecoder decodeObjectForKey:kLivenessIdentityPhotoId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_validity forKey:kLivenessIdentityValidity];
    [aCoder encodeObject:_photoId forKey:kLivenessIdentityPhotoId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LivenessIdentity *copy = [[LivenessIdentity alloc] init];
    
    if (copy) {

        copy.validity = self.validity;
        copy.photoId = [self.photoId copyWithZone:zone];
    }
    
    return copy;
}


@end
