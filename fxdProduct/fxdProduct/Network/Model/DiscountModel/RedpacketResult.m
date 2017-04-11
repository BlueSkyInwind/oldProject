//
//  RedpacketResult.m
//
//  Created by dd  on 16/5/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RedpacketResult.h"


NSString *const kRedpacketResultValid = @"valid_";
NSString *const kRedpacketResultTotalAmount = @"total_amount_";
NSString *const kRedpacketResultId = @"id_";
NSString *const kRedpacketResultValidityPeriodFrom = @"validity_period_from_";
NSString *const kRedpacketResultRedpacketName = @"redpacket_name_";
NSString *const kRedpacketResultValidityPeriodTo = @"validity_period_to_";
NSString *const kRedpacketResultUseConditions = @"use_conditions_";
NSString *const kRedpacketResultResidualAmount = @"residual_amount_";


@interface RedpacketResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RedpacketResult

@synthesize valid = _valid;
@synthesize totalAmount = _totalAmount;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize validityPeriodFrom = _validityPeriodFrom;
@synthesize redpacketName = _redpacketName;
@synthesize validityPeriodTo = _validityPeriodTo;
@synthesize useConditions = _useConditions;
@synthesize residualAmount = _residualAmount;


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
            self.valid = [[self objectOrNilForKey:kRedpacketResultValid fromDictionary:dict] boolValue];
            self.totalAmount = [[self objectOrNilForKey:kRedpacketResultTotalAmount fromDictionary:dict] doubleValue];
            self.resultIdentifier = [self objectOrNilForKey:kRedpacketResultId fromDictionary:dict];
            self.validityPeriodFrom = [self objectOrNilForKey:kRedpacketResultValidityPeriodFrom fromDictionary:dict];
            self.redpacketName = [self objectOrNilForKey:kRedpacketResultRedpacketName fromDictionary:dict];
            self.validityPeriodTo = [self objectOrNilForKey:kRedpacketResultValidityPeriodTo fromDictionary:dict];
            self.useConditions = [self objectOrNilForKey:kRedpacketResultUseConditions fromDictionary:dict];
            self.residualAmount = [[self objectOrNilForKey:kRedpacketResultResidualAmount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.valid] forKey:kRedpacketResultValid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalAmount] forKey:kRedpacketResultTotalAmount];
    [mutableDict setValue:self.resultIdentifier forKey:kRedpacketResultId];
    [mutableDict setValue:self.validityPeriodFrom forKey:kRedpacketResultValidityPeriodFrom];
    [mutableDict setValue:self.redpacketName forKey:kRedpacketResultRedpacketName];
    [mutableDict setValue:self.validityPeriodTo forKey:kRedpacketResultValidityPeriodTo];
    [mutableDict setValue:self.useConditions forKey:kRedpacketResultUseConditions];
    [mutableDict setValue:[NSNumber numberWithDouble:self.residualAmount] forKey:kRedpacketResultResidualAmount];

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

    self.valid = [aDecoder decodeBoolForKey:kRedpacketResultValid];
    self.totalAmount = [aDecoder decodeDoubleForKey:kRedpacketResultTotalAmount];
    self.resultIdentifier = [aDecoder decodeObjectForKey:kRedpacketResultId];
    self.validityPeriodFrom = [aDecoder decodeObjectForKey:kRedpacketResultValidityPeriodFrom];
    self.redpacketName = [aDecoder decodeObjectForKey:kRedpacketResultRedpacketName];
    self.validityPeriodTo = [aDecoder decodeObjectForKey:kRedpacketResultValidityPeriodTo];
    self.useConditions = [aDecoder decodeObjectForKey:kRedpacketResultUseConditions];
    self.residualAmount = [aDecoder decodeDoubleForKey:kRedpacketResultResidualAmount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_valid forKey:kRedpacketResultValid];
    [aCoder encodeDouble:_totalAmount forKey:kRedpacketResultTotalAmount];
    [aCoder encodeObject:_resultIdentifier forKey:kRedpacketResultId];
    [aCoder encodeObject:_validityPeriodFrom forKey:kRedpacketResultValidityPeriodFrom];
    [aCoder encodeObject:_redpacketName forKey:kRedpacketResultRedpacketName];
    [aCoder encodeObject:_validityPeriodTo forKey:kRedpacketResultValidityPeriodTo];
    [aCoder encodeObject:_useConditions forKey:kRedpacketResultUseConditions];
    [aCoder encodeDouble:_residualAmount forKey:kRedpacketResultResidualAmount];
}

- (id)copyWithZone:(NSZone *)zone
{
    RedpacketResult *copy = [[RedpacketResult alloc] init];
    
    if (copy) {

        copy.valid = self.valid;
        copy.totalAmount = self.totalAmount;
        copy.resultIdentifier = [self.resultIdentifier copyWithZone:zone];
        copy.validityPeriodFrom = [self.validityPeriodFrom copyWithZone:zone];
        copy.redpacketName = [self.redpacketName copyWithZone:zone];
        copy.validityPeriodTo = [self.validityPeriodTo copyWithZone:zone];
        copy.useConditions = [self.useConditions copyWithZone:zone];
        copy.residualAmount = self.residualAmount;
    }
    
    return copy;
}


@end
