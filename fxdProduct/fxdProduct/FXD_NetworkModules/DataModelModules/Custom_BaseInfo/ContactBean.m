//
//  ContactBean.m
//
//  Created by dd  on 2017/3/1
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ContactBean.h"


NSString *const kContactBeanId = @"id_";
NSString *const kContactBeanCreateDate = @"create_date_";
NSString *const kContactBeanContactPhone = @"contact_phone_";
NSString *const kContactBeanRelationship = @"relationship_";
NSString *const kContactBeanContactName = @"contact_name_";
NSString *const kContactBeanCustomerBaseId = @"customer_base_id_";
NSString *const kContactBeanCreateBy = @"create_by_";
NSString *const kContactBeanIsDel = @"is_del_";
NSString *const kContactBeanIsEmergencyContact = @"is_emergency_contact_";


@interface ContactBean ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ContactBean

@synthesize contactBeanIdentifier = _contactBeanIdentifier;
@synthesize createDate = _createDate;
@synthesize contactPhone = _contactPhone;
@synthesize relationship = _relationship;
@synthesize contactName = _contactName;
@synthesize customerBaseId = _customerBaseId;
@synthesize createBy = _createBy;
@synthesize isDel = _isDel;
@synthesize isEmergencyContact = _isEmergencyContact;


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
            self.contactBeanIdentifier = [self objectOrNilForKey:kContactBeanId fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kContactBeanCreateDate fromDictionary:dict];
            self.contactPhone = [self objectOrNilForKey:kContactBeanContactPhone fromDictionary:dict];
            self.relationship = [self objectOrNilForKey:kContactBeanRelationship fromDictionary:dict];
            self.contactName = [self objectOrNilForKey:kContactBeanContactName fromDictionary:dict];
            self.customerBaseId = [self objectOrNilForKey:kContactBeanCustomerBaseId fromDictionary:dict];
            self.createBy = [self objectOrNilForKey:kContactBeanCreateBy fromDictionary:dict];
            self.isDel = [self objectOrNilForKey:kContactBeanIsDel fromDictionary:dict];
            self.isEmergencyContact = [self objectOrNilForKey:kContactBeanIsEmergencyContact fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.contactBeanIdentifier forKey:kContactBeanId];
    [mutableDict setValue:self.createDate forKey:kContactBeanCreateDate];
    [mutableDict setValue:self.contactPhone forKey:kContactBeanContactPhone];
    [mutableDict setValue:self.relationship forKey:kContactBeanRelationship];
    [mutableDict setValue:self.contactName forKey:kContactBeanContactName];
    [mutableDict setValue:self.customerBaseId forKey:kContactBeanCustomerBaseId];
    [mutableDict setValue:self.createBy forKey:kContactBeanCreateBy];
    [mutableDict setValue:self.isDel forKey:kContactBeanIsDel];
    [mutableDict setValue:self.isEmergencyContact forKey:kContactBeanIsEmergencyContact];

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

    self.contactBeanIdentifier = [aDecoder decodeObjectForKey:kContactBeanId];
    self.createDate = [aDecoder decodeObjectForKey:kContactBeanCreateDate];
    self.contactPhone = [aDecoder decodeObjectForKey:kContactBeanContactPhone];
    self.relationship = [aDecoder decodeObjectForKey:kContactBeanRelationship];
    self.contactName = [aDecoder decodeObjectForKey:kContactBeanContactName];
    self.customerBaseId = [aDecoder decodeObjectForKey:kContactBeanCustomerBaseId];
    self.createBy = [aDecoder decodeObjectForKey:kContactBeanCreateBy];
    self.isDel = [aDecoder decodeObjectForKey:kContactBeanIsDel];
    self.isEmergencyContact = [aDecoder decodeObjectForKey:kContactBeanIsEmergencyContact];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_contactBeanIdentifier forKey:kContactBeanId];
    [aCoder encodeObject:_createDate forKey:kContactBeanCreateDate];
    [aCoder encodeObject:_contactPhone forKey:kContactBeanContactPhone];
    [aCoder encodeObject:_relationship forKey:kContactBeanRelationship];
    [aCoder encodeObject:_contactName forKey:kContactBeanContactName];
    [aCoder encodeObject:_customerBaseId forKey:kContactBeanCustomerBaseId];
    [aCoder encodeObject:_createBy forKey:kContactBeanCreateBy];
    [aCoder encodeObject:_isDel forKey:kContactBeanIsDel];
    [aCoder encodeObject:_isEmergencyContact forKey:kContactBeanIsEmergencyContact];
}

- (id)copyWithZone:(NSZone *)zone
{
    ContactBean *copy = [[ContactBean alloc] init];
    
    if (copy) {

        copy.contactBeanIdentifier = [self.contactBeanIdentifier copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.contactPhone = [self.contactPhone copyWithZone:zone];
        copy.relationship = [self.relationship copyWithZone:zone];
        copy.contactName = [self.contactName copyWithZone:zone];
        copy.customerBaseId = [self.customerBaseId copyWithZone:zone];
        copy.createBy = [self.createBy copyWithZone:zone];
        copy.isDel = [self.isDel copyWithZone:zone];
        copy.isEmergencyContact = [self.isEmergencyContact copyWithZone:zone];
    }
    
    return copy;
}


@end
