//
//  RegionCodeBaseClass.m
//
//  Created by dd  on 16/4/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RegionCodeBaseClass.h"
#import "RegionCodeExt.h"
#import "RegionCodeResult.h"


NSString *const kRegionCodeBaseClassFlag = @"flag";
NSString *const kRegionCodeBaseClassExt = @"ext";
NSString *const kRegionCodeBaseClassResult = @"result";


@interface RegionCodeBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RegionCodeBaseClass

@synthesize flag = _flag;
@synthesize ext = _ext;
@synthesize result = _result;


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
            self.flag = [self objectOrNilForKey:kRegionCodeBaseClassFlag fromDictionary:dict];
            self.ext = [RegionCodeExt modelObjectWithDictionary:[dict objectForKey:kRegionCodeBaseClassExt]];
//            self.result = [RegionCodeResult modelObjectWithDictionary:[dict objectForKey:kRegionCodeBaseClassResult]];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.flag forKey:kRegionCodeBaseClassFlag];
    [mutableDict setValue:[self.ext dictionaryRepresentation] forKey:kRegionCodeBaseClassExt];
//    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kRegionCodeBaseClassResult];

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

    self.flag = [aDecoder decodeObjectForKey:kRegionCodeBaseClassFlag];
    self.ext = [aDecoder decodeObjectForKey:kRegionCodeBaseClassExt];
    self.result = [aDecoder decodeObjectForKey:kRegionCodeBaseClassResult];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_flag forKey:kRegionCodeBaseClassFlag];
    [aCoder encodeObject:_ext forKey:kRegionCodeBaseClassExt];
    [aCoder encodeObject:_result forKey:kRegionCodeBaseClassResult];
}

- (id)copyWithZone:(NSZone *)zone
{
    RegionCodeBaseClass *copy = [[RegionCodeBaseClass alloc] init];
    
    if (copy) {

        copy.flag = [self.flag copyWithZone:zone];
        copy.ext = [self.ext copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
    }
    
    return copy;
}


@end
