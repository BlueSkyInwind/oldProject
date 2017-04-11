//
//  SquareRepaymentAvailableRedpackets.m
//
//  Created by dd  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SquareRepaymentAvailableRedpackets.h"


NSString *const kSquareRepaymentAvailableRedpacketsAvailableMeans = @"available_means_";
NSString *const kSquareRepaymentAvailableRedpacketsCreateDate = @"create_date_";
NSString *const kSquareRepaymentAvailableRedpacketsType = @"type_";
NSString *const kSquareRepaymentAvailableRedpacketsSource = @"source_";
NSString *const kSquareRepaymentAvailableRedpacketsAccountBaseId = @"account_base_id_";
NSString *const kSquareRepaymentAvailableRedpacketsId = @"id_";
NSString *const kSquareRepaymentAvailableRedpacketsGetDate = @"get_date_";
NSString *const kSquareRepaymentAvailableRedpacketsValidityPeriodFrom = @"validity_period_from_";
NSString *const kSquareRepaymentAvailableRedpacketsResidualAmount = @"residual_amount_";
NSString *const kSquareRepaymentAvailableRedpacketsUseConditions = @"use_conditions_";
NSString *const kSquareRepaymentAvailableRedpacketsIsSplitUse = @"is_split_use_";
NSString *const kSquareRepaymentAvailableRedpacketsUsedAmount = @"used_amount_";
NSString *const kSquareRepaymentAvailableRedpacketsTotalAmount = @"total_amount_";
NSString *const kSquareRepaymentAvailableRedpacketsRedpacketName = @"redpacket_name_";
NSString *const kSquareRepaymentAvailableRedpacketsIsUsing = @"is_using_";
NSString *const kSquareRepaymentAvailableRedpacketsValidityPeriodTo = @"validity_period_to_";
NSString *const kSquareRepaymentAvailableRedpacketsCreateBy = @"create_by_";


@interface SquareRepaymentAvailableRedpackets ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareRepaymentAvailableRedpackets

@synthesize availableMeans = _availableMeans;
@synthesize createDate = _createDate;
@synthesize type = _type;
@synthesize source = _source;
@synthesize accountBaseId = _accountBaseId;
@synthesize availableRedpacketsIdentifier = _availableRedpacketsIdentifier;
@synthesize getDate = _getDate;
@synthesize validityPeriodFrom = _validityPeriodFrom;
@synthesize residualAmount = _residualAmount;
@synthesize useConditions = _useConditions;
@synthesize isSplitUse = _isSplitUse;
@synthesize usedAmount = _usedAmount;
@synthesize totalAmount = _totalAmount;
@synthesize redpacketName = _redpacketName;
@synthesize isUsing = _isUsing;
@synthesize validityPeriodTo = _validityPeriodTo;
@synthesize createBy = _createBy;


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
            self.availableMeans = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsAvailableMeans fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsCreateDate fromDictionary:dict];
            self.type = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsType fromDictionary:dict];
            self.source = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsSource fromDictionary:dict];
            self.accountBaseId = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsAccountBaseId fromDictionary:dict];
            self.availableRedpacketsIdentifier = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsId fromDictionary:dict];
            self.getDate = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsGetDate fromDictionary:dict];
            self.validityPeriodFrom = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsValidityPeriodFrom fromDictionary:dict];
            self.residualAmount = [[self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsResidualAmount fromDictionary:dict] doubleValue];
            self.useConditions = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsUseConditions fromDictionary:dict];
            self.isSplitUse = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsIsSplitUse fromDictionary:dict];
            self.usedAmount = [[self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsUsedAmount fromDictionary:dict] doubleValue];
            self.totalAmount = [[self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsTotalAmount fromDictionary:dict] doubleValue];
            self.redpacketName = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsRedpacketName fromDictionary:dict];
            self.isUsing = [[self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsIsUsing fromDictionary:dict] doubleValue];
            self.validityPeriodTo = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsValidityPeriodTo fromDictionary:dict];
            self.createBy = [self objectOrNilForKey:kSquareRepaymentAvailableRedpacketsCreateBy fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.availableMeans forKey:kSquareRepaymentAvailableRedpacketsAvailableMeans];
    [mutableDict setValue:self.createDate forKey:kSquareRepaymentAvailableRedpacketsCreateDate];
    [mutableDict setValue:self.type forKey:kSquareRepaymentAvailableRedpacketsType];
    [mutableDict setValue:self.source forKey:kSquareRepaymentAvailableRedpacketsSource];
    [mutableDict setValue:self.accountBaseId forKey:kSquareRepaymentAvailableRedpacketsAccountBaseId];
    [mutableDict setValue:self.availableRedpacketsIdentifier forKey:kSquareRepaymentAvailableRedpacketsId];
    [mutableDict setValue:self.getDate forKey:kSquareRepaymentAvailableRedpacketsGetDate];
    [mutableDict setValue:self.validityPeriodFrom forKey:kSquareRepaymentAvailableRedpacketsValidityPeriodFrom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.residualAmount] forKey:kSquareRepaymentAvailableRedpacketsResidualAmount];
    [mutableDict setValue:self.useConditions forKey:kSquareRepaymentAvailableRedpacketsUseConditions];
    [mutableDict setValue:self.isSplitUse forKey:kSquareRepaymentAvailableRedpacketsIsSplitUse];
    [mutableDict setValue:[NSNumber numberWithDouble:self.usedAmount] forKey:kSquareRepaymentAvailableRedpacketsUsedAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalAmount] forKey:kSquareRepaymentAvailableRedpacketsTotalAmount];
    [mutableDict setValue:self.redpacketName forKey:kSquareRepaymentAvailableRedpacketsRedpacketName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isUsing] forKey:kSquareRepaymentAvailableRedpacketsIsUsing];
    [mutableDict setValue:self.validityPeriodTo forKey:kSquareRepaymentAvailableRedpacketsValidityPeriodTo];
    [mutableDict setValue:self.createBy forKey:kSquareRepaymentAvailableRedpacketsCreateBy];

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

    self.availableMeans = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsAvailableMeans];
    self.createDate = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsCreateDate];
    self.type = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsType];
    self.source = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsSource];
    self.accountBaseId = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsAccountBaseId];
    self.availableRedpacketsIdentifier = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsId];
    self.getDate = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsGetDate];
    self.validityPeriodFrom = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsValidityPeriodFrom];
    self.residualAmount = [aDecoder decodeDoubleForKey:kSquareRepaymentAvailableRedpacketsResidualAmount];
    self.useConditions = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsUseConditions];
    self.isSplitUse = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsIsSplitUse];
    self.usedAmount = [aDecoder decodeDoubleForKey:kSquareRepaymentAvailableRedpacketsUsedAmount];
    self.totalAmount = [aDecoder decodeDoubleForKey:kSquareRepaymentAvailableRedpacketsTotalAmount];
    self.redpacketName = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsRedpacketName];
    self.isUsing = [aDecoder decodeDoubleForKey:kSquareRepaymentAvailableRedpacketsIsUsing];
    self.validityPeriodTo = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsValidityPeriodTo];
    self.createBy = [aDecoder decodeObjectForKey:kSquareRepaymentAvailableRedpacketsCreateBy];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_availableMeans forKey:kSquareRepaymentAvailableRedpacketsAvailableMeans];
    [aCoder encodeObject:_createDate forKey:kSquareRepaymentAvailableRedpacketsCreateDate];
    [aCoder encodeObject:_type forKey:kSquareRepaymentAvailableRedpacketsType];
    [aCoder encodeObject:_source forKey:kSquareRepaymentAvailableRedpacketsSource];
    [aCoder encodeObject:_accountBaseId forKey:kSquareRepaymentAvailableRedpacketsAccountBaseId];
    [aCoder encodeObject:_availableRedpacketsIdentifier forKey:kSquareRepaymentAvailableRedpacketsId];
    [aCoder encodeObject:_getDate forKey:kSquareRepaymentAvailableRedpacketsGetDate];
    [aCoder encodeObject:_validityPeriodFrom forKey:kSquareRepaymentAvailableRedpacketsValidityPeriodFrom];
    [aCoder encodeDouble:_residualAmount forKey:kSquareRepaymentAvailableRedpacketsResidualAmount];
    [aCoder encodeObject:_useConditions forKey:kSquareRepaymentAvailableRedpacketsUseConditions];
    [aCoder encodeObject:_isSplitUse forKey:kSquareRepaymentAvailableRedpacketsIsSplitUse];
    [aCoder encodeDouble:_usedAmount forKey:kSquareRepaymentAvailableRedpacketsUsedAmount];
    [aCoder encodeDouble:_totalAmount forKey:kSquareRepaymentAvailableRedpacketsTotalAmount];
    [aCoder encodeObject:_redpacketName forKey:kSquareRepaymentAvailableRedpacketsRedpacketName];
    [aCoder encodeDouble:_isUsing forKey:kSquareRepaymentAvailableRedpacketsIsUsing];
    [aCoder encodeObject:_validityPeriodTo forKey:kSquareRepaymentAvailableRedpacketsValidityPeriodTo];
    [aCoder encodeObject:_createBy forKey:kSquareRepaymentAvailableRedpacketsCreateBy];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareRepaymentAvailableRedpackets *copy = [[SquareRepaymentAvailableRedpackets alloc] init];
    
    if (copy) {

        copy.availableMeans = [self.availableMeans copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.source = [self.source copyWithZone:zone];
        copy.accountBaseId = [self.accountBaseId copyWithZone:zone];
        copy.availableRedpacketsIdentifier = [self.availableRedpacketsIdentifier copyWithZone:zone];
        copy.getDate = [self.getDate copyWithZone:zone];
        copy.validityPeriodFrom = [self.validityPeriodFrom copyWithZone:zone];
        copy.residualAmount = self.residualAmount;
        copy.useConditions = [self.useConditions copyWithZone:zone];
        copy.isSplitUse = [self.isSplitUse copyWithZone:zone];
        copy.usedAmount = self.usedAmount;
        copy.totalAmount = self.totalAmount;
        copy.redpacketName = [self.redpacketName copyWithZone:zone];
        copy.isUsing = self.isUsing;
        copy.validityPeriodTo = [self.validityPeriodTo copyWithZone:zone];
        copy.createBy = [self.createBy copyWithZone:zone];
    }
    
    return copy;
}


@end
