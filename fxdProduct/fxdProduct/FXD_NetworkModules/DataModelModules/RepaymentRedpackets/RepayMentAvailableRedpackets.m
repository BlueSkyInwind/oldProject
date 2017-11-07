//
//  RepayMentAvailableRedpackets.m
//
//  Created by dd  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "RepayMentAvailableRedpackets.h"


NSString *const kRepayMentAvailableRedpacketsValidityPeriodTo = @"validity_period_to_";
NSString *const kRepayMentAvailableRedpacketsCreateDate = @"create_date_";
NSString *const kRepayMentAvailableRedpacketsType = @"type_";
NSString *const kRepayMentAvailableRedpacketsSource = @"source_";
NSString *const kRepayMentAvailableRedpacketsAccountBaseId = @"account_base_id_";
NSString *const kRepayMentAvailableRedpacketsId = @"id_";
NSString *const kRepayMentAvailableRedpacketsCreateBy = @"create_by_";
NSString *const kRepayMentAvailableRedpacketsValidityPeriodFrom = @"validity_period_from_";
NSString *const kRepayMentAvailableRedpacketsResidualAmount = @"residual_amount_";
NSString *const kRepayMentAvailableRedpacketsUseConditions = @"use_conditions_";
NSString *const kRepayMentAvailableRedpacketsIsSplitUse = @"is_split_use_";
NSString *const kRepayMentAvailableRedpacketsUsedAmount = @"used_amount_";
NSString *const kRepayMentAvailableRedpacketsTotalAmount = @"total_amount_";
NSString *const kRepayMentAvailableRedpacketsRedpacketName = @"redpacket_name_";
NSString *const kRepayMentAvailableRedpacketsIsUsing = @"is_using_";
NSString *const kRepayMentAvailableRedpacketsAvailableMeans = @"available_means_";
NSString *const kRepayMentAvailableRedpacketsGetDate = @"get_date_";


@interface RepayMentAvailableRedpackets ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RepayMentAvailableRedpackets

@synthesize validityPeriodTo = _validityPeriodTo;
@synthesize createDate = _createDate;
@synthesize type = _type;
@synthesize source = _source;
@synthesize accountBaseId = _accountBaseId;
@synthesize availableRedpacketsIdentifier = _availableRedpacketsIdentifier;
@synthesize createBy = _createBy;
@synthesize validityPeriodFrom = _validityPeriodFrom;
@synthesize residualAmount = _residualAmount;
@synthesize useConditions = _useConditions;
@synthesize isSplitUse = _isSplitUse;
@synthesize usedAmount = _usedAmount;
@synthesize totalAmount = _totalAmount;
@synthesize redpacketName = _redpacketName;
@synthesize isUsing = _isUsing;
@synthesize availableMeans = _availableMeans;
@synthesize getDate = _getDate;


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
            self.validityPeriodTo = [self objectOrNilForKey:kRepayMentAvailableRedpacketsValidityPeriodTo fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kRepayMentAvailableRedpacketsCreateDate fromDictionary:dict];
            self.type = [self objectOrNilForKey:kRepayMentAvailableRedpacketsType fromDictionary:dict];
            self.source = [self objectOrNilForKey:kRepayMentAvailableRedpacketsSource fromDictionary:dict];
            self.accountBaseId = [self objectOrNilForKey:kRepayMentAvailableRedpacketsAccountBaseId fromDictionary:dict];
            self.availableRedpacketsIdentifier = [self objectOrNilForKey:kRepayMentAvailableRedpacketsId fromDictionary:dict];
            self.createBy = [self objectOrNilForKey:kRepayMentAvailableRedpacketsCreateBy fromDictionary:dict];
            self.validityPeriodFrom = [self objectOrNilForKey:kRepayMentAvailableRedpacketsValidityPeriodFrom fromDictionary:dict];
            self.residualAmount = [[self objectOrNilForKey:kRepayMentAvailableRedpacketsResidualAmount fromDictionary:dict] doubleValue];
            self.useConditions = [self objectOrNilForKey:kRepayMentAvailableRedpacketsUseConditions fromDictionary:dict];
            self.isSplitUse = [self objectOrNilForKey:kRepayMentAvailableRedpacketsIsSplitUse fromDictionary:dict];
            self.usedAmount = [[self objectOrNilForKey:kRepayMentAvailableRedpacketsUsedAmount fromDictionary:dict] doubleValue];
            self.totalAmount = [[self objectOrNilForKey:kRepayMentAvailableRedpacketsTotalAmount fromDictionary:dict] doubleValue];
            self.redpacketName = [self objectOrNilForKey:kRepayMentAvailableRedpacketsRedpacketName fromDictionary:dict];
            self.isUsing = [[self objectOrNilForKey:kRepayMentAvailableRedpacketsIsUsing fromDictionary:dict] doubleValue];
            self.availableMeans = [self objectOrNilForKey:kRepayMentAvailableRedpacketsAvailableMeans fromDictionary:dict];
            self.getDate = [self objectOrNilForKey:kRepayMentAvailableRedpacketsGetDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.validityPeriodTo forKey:kRepayMentAvailableRedpacketsValidityPeriodTo];
    [mutableDict setValue:self.createDate forKey:kRepayMentAvailableRedpacketsCreateDate];
    [mutableDict setValue:self.type forKey:kRepayMentAvailableRedpacketsType];
    [mutableDict setValue:self.source forKey:kRepayMentAvailableRedpacketsSource];
    [mutableDict setValue:self.accountBaseId forKey:kRepayMentAvailableRedpacketsAccountBaseId];
    [mutableDict setValue:self.availableRedpacketsIdentifier forKey:kRepayMentAvailableRedpacketsId];
    [mutableDict setValue:self.createBy forKey:kRepayMentAvailableRedpacketsCreateBy];
    [mutableDict setValue:self.validityPeriodFrom forKey:kRepayMentAvailableRedpacketsValidityPeriodFrom];
    [mutableDict setValue:[NSNumber numberWithDouble:self.residualAmount] forKey:kRepayMentAvailableRedpacketsResidualAmount];
    [mutableDict setValue:self.useConditions forKey:kRepayMentAvailableRedpacketsUseConditions];
    [mutableDict setValue:self.isSplitUse forKey:kRepayMentAvailableRedpacketsIsSplitUse];
    [mutableDict setValue:[NSNumber numberWithDouble:self.usedAmount] forKey:kRepayMentAvailableRedpacketsUsedAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalAmount] forKey:kRepayMentAvailableRedpacketsTotalAmount];
    [mutableDict setValue:self.redpacketName forKey:kRepayMentAvailableRedpacketsRedpacketName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isUsing] forKey:kRepayMentAvailableRedpacketsIsUsing];
    [mutableDict setValue:self.availableMeans forKey:kRepayMentAvailableRedpacketsAvailableMeans];
    [mutableDict setValue:self.getDate forKey:kRepayMentAvailableRedpacketsGetDate];

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

    self.validityPeriodTo = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsValidityPeriodTo];
    self.createDate = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsCreateDate];
    self.type = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsType];
    self.source = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsSource];
    self.accountBaseId = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsAccountBaseId];
    self.availableRedpacketsIdentifier = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsId];
    self.createBy = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsCreateBy];
    self.validityPeriodFrom = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsValidityPeriodFrom];
    self.residualAmount = [aDecoder decodeDoubleForKey:kRepayMentAvailableRedpacketsResidualAmount];
    self.useConditions = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsUseConditions];
    self.isSplitUse = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsIsSplitUse];
    self.usedAmount = [aDecoder decodeDoubleForKey:kRepayMentAvailableRedpacketsUsedAmount];
    self.totalAmount = [aDecoder decodeDoubleForKey:kRepayMentAvailableRedpacketsTotalAmount];
    self.redpacketName = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsRedpacketName];
    self.isUsing = [aDecoder decodeDoubleForKey:kRepayMentAvailableRedpacketsIsUsing];
    self.availableMeans = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsAvailableMeans];
    self.getDate = [aDecoder decodeObjectForKey:kRepayMentAvailableRedpacketsGetDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_validityPeriodTo forKey:kRepayMentAvailableRedpacketsValidityPeriodTo];
    [aCoder encodeObject:_createDate forKey:kRepayMentAvailableRedpacketsCreateDate];
    [aCoder encodeObject:_type forKey:kRepayMentAvailableRedpacketsType];
    [aCoder encodeObject:_source forKey:kRepayMentAvailableRedpacketsSource];
    [aCoder encodeObject:_accountBaseId forKey:kRepayMentAvailableRedpacketsAccountBaseId];
    [aCoder encodeObject:_availableRedpacketsIdentifier forKey:kRepayMentAvailableRedpacketsId];
    [aCoder encodeObject:_createBy forKey:kRepayMentAvailableRedpacketsCreateBy];
    [aCoder encodeObject:_validityPeriodFrom forKey:kRepayMentAvailableRedpacketsValidityPeriodFrom];
    [aCoder encodeDouble:_residualAmount forKey:kRepayMentAvailableRedpacketsResidualAmount];
    [aCoder encodeObject:_useConditions forKey:kRepayMentAvailableRedpacketsUseConditions];
    [aCoder encodeObject:_isSplitUse forKey:kRepayMentAvailableRedpacketsIsSplitUse];
    [aCoder encodeDouble:_usedAmount forKey:kRepayMentAvailableRedpacketsUsedAmount];
    [aCoder encodeDouble:_totalAmount forKey:kRepayMentAvailableRedpacketsTotalAmount];
    [aCoder encodeObject:_redpacketName forKey:kRepayMentAvailableRedpacketsRedpacketName];
    [aCoder encodeDouble:_isUsing forKey:kRepayMentAvailableRedpacketsIsUsing];
    [aCoder encodeObject:_availableMeans forKey:kRepayMentAvailableRedpacketsAvailableMeans];
    [aCoder encodeObject:_getDate forKey:kRepayMentAvailableRedpacketsGetDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    RepayMentAvailableRedpackets *copy = [[RepayMentAvailableRedpackets alloc] init];
    
    if (copy) {

        copy.validityPeriodTo = [self.validityPeriodTo copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.source = [self.source copyWithZone:zone];
        copy.accountBaseId = [self.accountBaseId copyWithZone:zone];
        copy.availableRedpacketsIdentifier = [self.availableRedpacketsIdentifier copyWithZone:zone];
        copy.createBy = [self.createBy copyWithZone:zone];
        copy.validityPeriodFrom = [self.validityPeriodFrom copyWithZone:zone];
        copy.residualAmount = self.residualAmount;
        copy.useConditions = [self.useConditions copyWithZone:zone];
        copy.isSplitUse = [self.isSplitUse copyWithZone:zone];
        copy.usedAmount = self.usedAmount;
        copy.totalAmount = self.totalAmount;
        copy.redpacketName = [self.redpacketName copyWithZone:zone];
        copy.isUsing = self.isUsing;
        copy.availableMeans = [self.availableMeans copyWithZone:zone];
        copy.getDate = [self.getDate copyWithZone:zone];
    }
    
    return copy;
}


@end
