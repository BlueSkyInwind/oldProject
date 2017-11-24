//
//  RegionBaseClass.m
//
//  Created by dd  on 16/3/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RegionBaseClass.h"
#import "RegionExt.h"
#import "RegionResult.h"


NSString *const kRegionBaseClassFlag = @"flag";
NSString *const kRegionBaseClassExt = @"ext";
NSString *const kRegionBaseClassResult = @"result";
NSString *const kRegionBaseClassMsg = @"msg";


@interface RegionBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RegionBaseClass

@synthesize flag = _flag;
@synthesize ext = _ext;
@synthesize result = _result;
@synthesize msg = _msg;


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
            self.flag = [self objectOrNilForKey:kRegionBaseClassFlag fromDictionary:dict];
            self.ext = [RegionExt modelObjectWithDictionary:[dict objectForKey:kRegionBaseClassExt]];
    NSObject *receivedRegionResult = [dict objectForKey:kRegionBaseClassResult];
    NSMutableArray *parsedRegionResult = [NSMutableArray array];
    if ([receivedRegionResult isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRegionResult) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRegionResult addObject:[RegionResult modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRegionResult isKindOfClass:[NSDictionary class]]) {
       [parsedRegionResult addObject:[RegionResult modelObjectWithDictionary:(NSDictionary *)receivedRegionResult]];
    }

    self.result = [NSArray arrayWithArray:parsedRegionResult];
            self.msg = [self objectOrNilForKey:kRegionBaseClassMsg fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kRegionBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kRegionBaseClassExt];
    NSMutableArray *tempArrayForResult = [NSMutableArray array];
    for (NSObject *subArrayObject in self.result) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResult addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResult addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResult] forKey:kRegionBaseClassResult];
    [mutableDict setValue:self.msg forKey:kRegionBaseClassMsg];

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

    self.flag = [aDecoder decodeObjectForKey:kRegionBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kRegionBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kRegionBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kRegionBaseClassMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kRegionBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kRegionBaseClassExt];
    [aCoder encodeObject:_result forKey:kRegionBaseClassResult];
    [aCoder encodeObject:_msg forKey:kRegionBaseClassMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    RegionBaseClass *copy = [[RegionBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
