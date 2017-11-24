//
//  ProductListResult.m
//
//  Created by dd  on 16/3/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ProductListResult.h"


NSString *const kProductListResultStagingDuration = @"staging_duration_";
NSString *const kProductListResultStagingTop = @"staging_top_";
NSString *const kProductListResultName = @"name_";
NSString *const kProductListResultId = @"id";
NSString *const kProductListResultDayServiceFeeRate = @"day_service_fee_rate_";
NSString *const kProductListResultLiquidatedDamages = @"liquidated_damages_";
NSString *const kProductListResultStagingBottom = @"staging_bottom_";
NSString *const kProductListResultPrincipalBottom = @"principal_bottom_";
NSString *const kProductListResultPrincipalTop = @"principal_top_";


@interface ProductListResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductListResult

@synthesize stagingDuration = _stagingDuration;
@synthesize stagingTop = _stagingTop;
@synthesize name = _name;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize dayServiceFeeRate = _dayServiceFeeRate;
@synthesize liquidatedDamages = _liquidatedDamages;
@synthesize stagingBottom = _stagingBottom;
@synthesize principalBottom = _principalBottom;
@synthesize principalTop = _principalTop;


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
            self.stagingDuration = [self objectOrNilForKey:kProductListResultStagingDuration fromDictionary:dict];
            self.stagingTop = [[self objectOrNilForKey:kProductListResultStagingTop fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kProductListResultName fromDictionary:dict];
            self.resultIdentifier = [self objectOrNilForKey:kProductListResultId fromDictionary:dict];
            self.dayServiceFeeRate = [[self objectOrNilForKey:kProductListResultDayServiceFeeRate fromDictionary:dict] doubleValue];
            self.liquidatedDamages = [[self objectOrNilForKey:kProductListResultLiquidatedDamages fromDictionary:dict] doubleValue];
            self.stagingBottom = [[self objectOrNilForKey:kProductListResultStagingBottom fromDictionary:dict] doubleValue];
            self.principalBottom = [[self objectOrNilForKey:kProductListResultPrincipalBottom fromDictionary:dict] doubleValue];
            self.principalTop = [[self objectOrNilForKey:kProductListResultPrincipalTop fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.stagingDuration forKey:kProductListResultStagingDuration];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stagingTop] forKey:kProductListResultStagingTop];
    [mutableDict setValue:self.name forKey:kProductListResultName];
    [mutableDict setValue:self.resultIdentifier forKey:kProductListResultId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dayServiceFeeRate] forKey:kProductListResultDayServiceFeeRate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.liquidatedDamages] forKey:kProductListResultLiquidatedDamages];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stagingBottom] forKey:kProductListResultStagingBottom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.principalBottom] forKey:kProductListResultPrincipalBottom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.principalTop] forKey:kProductListResultPrincipalTop];

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

    self.stagingDuration = [aDecoder decodeObjectForKey:kProductListResultStagingDuration];
    self.stagingTop = [aDecoder decodeDoubleForKey:kProductListResultStagingTop];
    self.name = [aDecoder decodeObjectForKey:kProductListResultName];
    self.resultIdentifier = [aDecoder decodeObjectForKey:kProductListResultId];
    self.dayServiceFeeRate = [aDecoder decodeDoubleForKey:kProductListResultDayServiceFeeRate];
    self.liquidatedDamages = [aDecoder decodeDoubleForKey:kProductListResultLiquidatedDamages];
    self.stagingBottom = [aDecoder decodeDoubleForKey:kProductListResultStagingBottom];
    self.principalBottom = [aDecoder decodeDoubleForKey:kProductListResultPrincipalBottom];
    self.principalTop = [aDecoder decodeDoubleForKey:kProductListResultPrincipalTop];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stagingDuration forKey:kProductListResultStagingDuration];
    [aCoder encodeDouble:_stagingTop forKey:kProductListResultStagingTop];
    [aCoder encodeObject:_name forKey:kProductListResultName];
    [aCoder encodeObject:_resultIdentifier forKey:kProductListResultId];
    [aCoder encodeDouble:_dayServiceFeeRate forKey:kProductListResultDayServiceFeeRate];
    [aCoder encodeDouble:_liquidatedDamages forKey:kProductListResultLiquidatedDamages];
    [aCoder encodeDouble:_stagingBottom forKey:kProductListResultStagingBottom];
    [aCoder encodeDouble:_principalBottom forKey:kProductListResultPrincipalBottom];
    [aCoder encodeDouble:_principalTop forKey:kProductListResultPrincipalTop];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductListResult *copy = [[ProductListResult alloc] init];
    
    if (copy) {

        copy.stagingDuration = [self.stagingDuration copyWithZone:zone];
        copy.stagingTop = self.stagingTop;
        copy.name = [self.name copyWithZone:zone];
        copy.resultIdentifier = [self.resultIdentifier copyWithZone:zone];
        copy.dayServiceFeeRate = self.dayServiceFeeRate;
        copy.liquidatedDamages = self.liquidatedDamages;
        copy.stagingBottom = self.stagingBottom;
        copy.principalBottom = self.principalBottom;
        copy.principalTop = self.principalTop;
    }
    
    return copy;
}


@end
