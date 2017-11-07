//
//  LivenessSelfie.m
//
//  Created by dd  on 16/3/31
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LivenessSelfie.h"


NSString *const kLivenessSelfieImageId = @"image_id";


@interface LivenessSelfie ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LivenessSelfie

@synthesize imageId = _imageId;


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
            self.imageId = [self objectOrNilForKey:kLivenessSelfieImageId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageId forKey:kLivenessSelfieImageId];

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

    self.imageId = [aDecoder decodeObjectForKey:kLivenessSelfieImageId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageId forKey:kLivenessSelfieImageId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LivenessSelfie *copy = [[LivenessSelfie alloc] init];
    
    if (copy) {

        copy.imageId = [self.imageId copyWithZone:zone];
    }
    
    return copy;
}


@end
