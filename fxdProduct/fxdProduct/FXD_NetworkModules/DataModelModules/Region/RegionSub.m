//
//  RegionSub.m
//
//  Created by dd  on 16/3/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RegionSub.h"


NSString *const kRegionSubSub = @"sub";
NSString *const kRegionSubName = @"name";
NSString *const kRegionSubType = @"type";


@interface RegionSub ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RegionSub

@synthesize sub = _sub;
@synthesize name = _name;
@synthesize type = _type;


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
            self.sub = [self objectOrNilForKey:kRegionSubSub fromDictionary:dict];
            self.name = [self objectOrNilForKey:kRegionSubName fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kRegionSubType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSub = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sub) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSub addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSub addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSub] forKey:kRegionSubSub];
    [mutableDict setValue:self.name forKey:kRegionSubName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kRegionSubType];

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

    self.sub = [aDecoder decodeObjectForKey:kRegionSubSub];
    self.name = [aDecoder decodeObjectForKey:kRegionSubName];
    self.type = [aDecoder decodeDoubleForKey:kRegionSubType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sub forKey:kRegionSubSub];
    [aCoder encodeObject:_name forKey:kRegionSubName];
    [aCoder encodeDouble:_type forKey:kRegionSubType];
}

- (id)copyWithZone:(NSZone *)zone
{
    RegionSub *copy = [[RegionSub alloc] init];
    
    if (copy) {

        copy.sub = [self.sub copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.type = self.type;
    }
    
    return copy;
}


@end
