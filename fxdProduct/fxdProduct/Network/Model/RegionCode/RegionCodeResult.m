//
//  RegionCodeResult.m
//
//  Created by dd  on 16/4/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RegionCodeResult.h"


NSString *const kRegionCodeResultProvinceCode = @"provinceCode";
NSString *const kRegionCodeResultCityCode = @"cityCode";
NSString *const kRegionCodeResultDistrictCode = @"districtCode";


@interface RegionCodeResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RegionCodeResult

@synthesize provinceCode = _provinceCode;
@synthesize cityCode = _cityCode;
@synthesize districtCode = _districtCode;


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
            self.provinceCode = [self objectOrNilForKey:kRegionCodeResultProvinceCode fromDictionary:dict];
            self.cityCode = [self objectOrNilForKey:kRegionCodeResultCityCode fromDictionary:dict];
            self.districtCode = [self objectOrNilForKey:kRegionCodeResultDistrictCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.provinceCode forKey:kRegionCodeResultProvinceCode];
    [mutableDict setValue:self.cityCode forKey:kRegionCodeResultCityCode];
    [mutableDict setValue:self.districtCode forKey:kRegionCodeResultDistrictCode];

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

    self.provinceCode = [aDecoder decodeObjectForKey:kRegionCodeResultProvinceCode];
    self.cityCode = [aDecoder decodeObjectForKey:kRegionCodeResultCityCode];
    self.districtCode = [aDecoder decodeObjectForKey:kRegionCodeResultDistrictCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_provinceCode forKey:kRegionCodeResultProvinceCode];
    [aCoder encodeObject:_cityCode forKey:kRegionCodeResultCityCode];
    [aCoder encodeObject:_districtCode forKey:kRegionCodeResultDistrictCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    RegionCodeResult *copy = [[RegionCodeResult alloc] init];
    
    if (copy) {

        copy.provinceCode = [self.provinceCode copyWithZone:zone];
        copy.cityCode = [self.cityCode copyWithZone:zone];
        copy.districtCode = [self.districtCode copyWithZone:zone];
    }
    
    return copy;
}


@end
