//
//  RegionResult.m
//
//  Created by dd  on 16/3/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RegionResult.h"
#import "RegionSub.h"


NSString *const kRegionResultSub = @"sub";
NSString *const kRegionResultName = @"name";
NSString *const kRegionResultType = @"type";


@interface RegionResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RegionResult

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
    NSObject *receivedRegionSub = [dict objectForKey:kRegionResultSub];
    NSMutableArray *parsedRegionSub = [NSMutableArray array];
    if ([receivedRegionSub isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRegionSub) {
            if ([item isKindOfClass:[NSDictionary class]]) {
//                [parsedRegionSub addObject:[RegionSub modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRegionSub isKindOfClass:[NSDictionary class]]) {
//       [parsedRegionSub addObject:[RegionSub modelObjectWithDictionary:(NSDictionary *)receivedRegionSub]];
    }

    self.sub = [NSArray arrayWithArray:parsedRegionSub];
            self.name = [self objectOrNilForKey:kRegionResultName fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kRegionResultType fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSub] forKey:kRegionResultSub];
    [mutableDict setValue:self.name forKey:kRegionResultName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kRegionResultType];

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

    self.sub = [aDecoder decodeObjectForKey:kRegionResultSub];
    self.name = [aDecoder decodeObjectForKey:kRegionResultName];
    self.type = [aDecoder decodeDoubleForKey:kRegionResultType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sub forKey:kRegionResultSub];
    [aCoder encodeObject:_name forKey:kRegionResultName];
    [aCoder encodeDouble:_type forKey:kRegionResultType];
}

- (id)copyWithZone:(NSZone *)zone
{
    RegionResult *copy = [[RegionResult alloc] init];
    
    if (copy) {

        copy.sub = [self.sub copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.type = self.type;
    }
    
    return copy;
}


@end
