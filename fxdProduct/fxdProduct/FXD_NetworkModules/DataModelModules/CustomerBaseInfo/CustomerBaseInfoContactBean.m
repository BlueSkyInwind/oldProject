//
//  CustomerBaseInfoContactBean.m
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CustomerBaseInfoContactBean.h"


NSString *const kCustomerBaseInfoContactBeanId = @"id_";
NSString *const kCustomerBaseInfoContactBeanCreateDate = @"create_date_";
NSString *const kCustomerBaseInfoContactBeanContactPhone = @"contact_phone_";
NSString *const kCustomerBaseInfoContactBeanRelationship = @"relationship_";
NSString *const kCustomerBaseInfoContactBeanContactName = @"contact_name_";
NSString *const kCustomerBaseInfoContactBeanCustomerBaseId = @"customer_base_id_";
NSString *const kCustomerBaseInfoContactBeanCaseInfoId = @"case_info_id_";
NSString *const kCustomerBaseInfoContactBeanIsDel = @"is_del_";
NSString *const kCustomerBaseInfoContactBeanIsEmergencyContact = @"is_emergency_contact_";
NSString *const kCustomerBaseInfoContactBeanCreateBy = @"create_by_";


@interface CustomerBaseInfoContactBean ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CustomerBaseInfoContactBean

@synthesize contactBeanIdentifier = _contactBeanIdentifier;
@synthesize createDate = _createDate;
@synthesize contactPhone = _contactPhone;
@synthesize relationship = _relationship;
@synthesize contactName = _contactName;
@synthesize customerBaseId = _customerBaseId;
@synthesize caseInfoId = _caseInfoId;
@synthesize isDel = _isDel;
@synthesize isEmergencyContact = _isEmergencyContact;
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
            self.contactBeanIdentifier = [self objectOrNilForKey:kCustomerBaseInfoContactBeanId fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kCustomerBaseInfoContactBeanCreateDate fromDictionary:dict];
            self.contactPhone = [self objectOrNilForKey:kCustomerBaseInfoContactBeanContactPhone fromDictionary:dict];
            self.relationship = [self objectOrNilForKey:kCustomerBaseInfoContactBeanRelationship fromDictionary:dict];
            self.contactName = [self objectOrNilForKey:kCustomerBaseInfoContactBeanContactName fromDictionary:dict];
            self.customerBaseId = [self objectOrNilForKey:kCustomerBaseInfoContactBeanCustomerBaseId fromDictionary:dict];
            self.caseInfoId = [self objectOrNilForKey:kCustomerBaseInfoContactBeanCaseInfoId fromDictionary:dict];
            self.isDel = [self objectOrNilForKey:kCustomerBaseInfoContactBeanIsDel fromDictionary:dict];
            self.isEmergencyContact = [self objectOrNilForKey:kCustomerBaseInfoContactBeanIsEmergencyContact fromDictionary:dict];
            self.createBy = [self objectOrNilForKey:kCustomerBaseInfoContactBeanCreateBy fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.contactBeanIdentifier forKey:kCustomerBaseInfoContactBeanId];
    [mutableDict setValue:self.createDate forKey:kCustomerBaseInfoContactBeanCreateDate];
    [mutableDict setValue:self.contactPhone forKey:kCustomerBaseInfoContactBeanContactPhone];
    [mutableDict setValue:self.relationship forKey:kCustomerBaseInfoContactBeanRelationship];
    [mutableDict setValue:self.contactName forKey:kCustomerBaseInfoContactBeanContactName];
    [mutableDict setValue:self.customerBaseId forKey:kCustomerBaseInfoContactBeanCustomerBaseId];
    [mutableDict setValue:self.caseInfoId forKey:kCustomerBaseInfoContactBeanCaseInfoId];
    [mutableDict setValue:self.isDel forKey:kCustomerBaseInfoContactBeanIsDel];
    [mutableDict setValue:self.isEmergencyContact forKey:kCustomerBaseInfoContactBeanIsEmergencyContact];
    [mutableDict setValue:self.createBy forKey:kCustomerBaseInfoContactBeanCreateBy];

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

    self.contactBeanIdentifier = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanId];
    self.createDate = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanCreateDate];
    self.contactPhone = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanContactPhone];
    self.relationship = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanRelationship];
    self.contactName = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanContactName];
    self.customerBaseId = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanCustomerBaseId];
    self.caseInfoId = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanCaseInfoId];
    self.isDel = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanIsDel];
    self.isEmergencyContact = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanIsEmergencyContact];
    self.createBy = [aDecoder decodeObjectForKey:kCustomerBaseInfoContactBeanCreateBy];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_contactBeanIdentifier forKey:kCustomerBaseInfoContactBeanId];
    [aCoder encodeObject:_createDate forKey:kCustomerBaseInfoContactBeanCreateDate];
    [aCoder encodeObject:_contactPhone forKey:kCustomerBaseInfoContactBeanContactPhone];
    [aCoder encodeObject:_relationship forKey:kCustomerBaseInfoContactBeanRelationship];
    [aCoder encodeObject:_contactName forKey:kCustomerBaseInfoContactBeanContactName];
    [aCoder encodeObject:_customerBaseId forKey:kCustomerBaseInfoContactBeanCustomerBaseId];
    [aCoder encodeObject:_caseInfoId forKey:kCustomerBaseInfoContactBeanCaseInfoId];
    [aCoder encodeObject:_isDel forKey:kCustomerBaseInfoContactBeanIsDel];
    [aCoder encodeObject:_isEmergencyContact forKey:kCustomerBaseInfoContactBeanIsEmergencyContact];
    [aCoder encodeObject:_createBy forKey:kCustomerBaseInfoContactBeanCreateBy];
}

- (id)copyWithZone:(NSZone *)zone
{
    CustomerBaseInfoContactBean *copy = [[CustomerBaseInfoContactBean alloc] init];
    
    if (copy) {

        copy.contactBeanIdentifier = [self.contactBeanIdentifier copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.contactPhone = [self.contactPhone copyWithZone:zone];
        copy.relationship = [self.relationship copyWithZone:zone];
        copy.contactName = [self.contactName copyWithZone:zone];
        copy.customerBaseId = [self.customerBaseId copyWithZone:zone];
        copy.caseInfoId = [self.caseInfoId copyWithZone:zone];
        copy.isDel = [self.isDel copyWithZone:zone];
        copy.isEmergencyContact = [self.isEmergencyContact copyWithZone:zone];
        copy.createBy = [self.createBy copyWithZone:zone];
    }
    
    return copy;
}


@end
