//
//  CustomerBaseInfoResult.m
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CustomerBaseInfoResult.h"
#import "CustomerBaseInfoContactBean.h"


NSString *const kCustomerBaseInfoResultCreateDate = @"create_date_";
NSString *const kCustomerBaseInfoResultModifyBy = @"modify_by_";
NSString *const kCustomerBaseInfoResultCountyName = @"county_name_";
NSString *const kCustomerBaseInfoResultHomeAddress = @"home_address_";
NSString *const kCustomerBaseInfoResultEducationLevel = @"education_level_";
NSString *const kCustomerBaseInfoResultAccountBaseId = @"account_base_id_";
NSString *const kCustomerBaseInfoResultCustomerName = @"customer_name_";
NSString *const kCustomerBaseInfoResultIdCode = @"id_code_";
NSString *const kCustomerBaseInfoResultIdType = @"id_type_";
NSString *const kCustomerBaseInfoResultBindingMobilephone = @"binding_mobilephone_";
NSString *const kCustomerBaseInfoResultProvinceName = @"province_name_";
NSString *const kCustomerBaseInfoResultCounty = @"county_";
NSString *const kCustomerBaseInfoResultCity = @"city_";
NSString *const kCustomerBaseInfoResultId = @"id_";
NSString *const kCustomerBaseInfoResultProvince = @"province_";
NSString *const kCustomerBaseInfoResultModifyDate = @"modify_date_";
NSString *const kCustomerBaseInfoResultCreateBy = @"create_by_";
NSString *const kCustomerBaseInfoResultContactBean = @"contactBean";
NSString *const kCustomerBaseInfoResultAuthenticateStatus = @"authenticate_status_";
NSString *const kCustomerBaseInfoResultCityName = @"city_name_";


@interface CustomerBaseInfoResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CustomerBaseInfoResult

@synthesize createDate = _createDate;
@synthesize modifyBy = _modifyBy;
@synthesize countyName = _countyName;
@synthesize homeAddress = _homeAddress;
@synthesize educationLevel = _educationLevel;
@synthesize accountBaseId = _accountBaseId;
@synthesize customerName = _customerName;
@synthesize idCode = _idCode;
@synthesize idType = _idType;
@synthesize bindingMobilephone = _bindingMobilephone;
@synthesize provinceName = _provinceName;
@synthesize county = _county;
@synthesize city = _city;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize province = _province;
@synthesize modifyDate = _modifyDate;
@synthesize createBy = _createBy;
@synthesize contactBean = _contactBean;
@synthesize authenticateStatus = _authenticateStatus;
@synthesize cityName = _cityName;


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
            self.createDate = [self objectOrNilForKey:kCustomerBaseInfoResultCreateDate fromDictionary:dict];
            self.modifyBy = [self objectOrNilForKey:kCustomerBaseInfoResultModifyBy fromDictionary:dict];
            self.countyName = [self objectOrNilForKey:kCustomerBaseInfoResultCountyName fromDictionary:dict];
            self.homeAddress = [self objectOrNilForKey:kCustomerBaseInfoResultHomeAddress fromDictionary:dict];
            self.educationLevel = [self objectOrNilForKey:kCustomerBaseInfoResultEducationLevel fromDictionary:dict];
            self.accountBaseId = [self objectOrNilForKey:kCustomerBaseInfoResultAccountBaseId fromDictionary:dict];
            self.customerName = [self objectOrNilForKey:kCustomerBaseInfoResultCustomerName fromDictionary:dict];
            self.idCode = [self objectOrNilForKey:kCustomerBaseInfoResultIdCode fromDictionary:dict];
            self.idType = [self objectOrNilForKey:kCustomerBaseInfoResultIdType fromDictionary:dict];
            self.bindingMobilephone = [self objectOrNilForKey:kCustomerBaseInfoResultBindingMobilephone fromDictionary:dict];
            self.provinceName = [self objectOrNilForKey:kCustomerBaseInfoResultProvinceName fromDictionary:dict];
            self.county = [self objectOrNilForKey:kCustomerBaseInfoResultCounty fromDictionary:dict];
            self.city = [self objectOrNilForKey:kCustomerBaseInfoResultCity fromDictionary:dict];
            self.resultIdentifier = [self objectOrNilForKey:kCustomerBaseInfoResultId fromDictionary:dict];
            self.province = [self objectOrNilForKey:kCustomerBaseInfoResultProvince fromDictionary:dict];
            self.modifyDate = [self objectOrNilForKey:kCustomerBaseInfoResultModifyDate fromDictionary:dict];
            self.createBy = [self objectOrNilForKey:kCustomerBaseInfoResultCreateBy fromDictionary:dict];
    NSObject *receivedCustomerBaseInfoContactBean = [dict objectForKey:kCustomerBaseInfoResultContactBean];
    NSMutableArray *parsedCustomerBaseInfoContactBean = [NSMutableArray array];
    if ([receivedCustomerBaseInfoContactBean isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCustomerBaseInfoContactBean) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCustomerBaseInfoContactBean addObject:[CustomerBaseInfoContactBean modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCustomerBaseInfoContactBean isKindOfClass:[NSDictionary class]]) {
       [parsedCustomerBaseInfoContactBean addObject:[CustomerBaseInfoContactBean modelObjectWithDictionary:(NSDictionary *)receivedCustomerBaseInfoContactBean]];
    }

    self.contactBean = [NSArray arrayWithArray:parsedCustomerBaseInfoContactBean];
            self.authenticateStatus = [self objectOrNilForKey:kCustomerBaseInfoResultAuthenticateStatus fromDictionary:dict];
            self.cityName = [self objectOrNilForKey:kCustomerBaseInfoResultCityName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createDate forKey:kCustomerBaseInfoResultCreateDate];
    [mutableDict setValue:self.modifyBy forKey:kCustomerBaseInfoResultModifyBy];
    [mutableDict setValue:self.countyName forKey:kCustomerBaseInfoResultCountyName];
    [mutableDict setValue:self.homeAddress forKey:kCustomerBaseInfoResultHomeAddress];
    [mutableDict setValue:self.educationLevel forKey:kCustomerBaseInfoResultEducationLevel];
    [mutableDict setValue:self.accountBaseId forKey:kCustomerBaseInfoResultAccountBaseId];
    [mutableDict setValue:self.customerName forKey:kCustomerBaseInfoResultCustomerName];
    [mutableDict setValue:self.idCode forKey:kCustomerBaseInfoResultIdCode];
    [mutableDict setValue:self.idType forKey:kCustomerBaseInfoResultIdType];
    [mutableDict setValue:self.bindingMobilephone forKey:kCustomerBaseInfoResultBindingMobilephone];
    [mutableDict setValue:self.provinceName forKey:kCustomerBaseInfoResultProvinceName];
    [mutableDict setValue:self.county forKey:kCustomerBaseInfoResultCounty];
    [mutableDict setValue:self.city forKey:kCustomerBaseInfoResultCity];
    [mutableDict setValue:self.resultIdentifier forKey:kCustomerBaseInfoResultId];
    [mutableDict setValue:self.province forKey:kCustomerBaseInfoResultProvince];
    [mutableDict setValue:self.modifyDate forKey:kCustomerBaseInfoResultModifyDate];
    [mutableDict setValue:self.createBy forKey:kCustomerBaseInfoResultCreateBy];
    NSMutableArray *tempArrayForContactBean = [NSMutableArray array];
    for (NSObject *subArrayObject in self.contactBean) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForContactBean addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForContactBean addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForContactBean] forKey:kCustomerBaseInfoResultContactBean];
    [mutableDict setValue:self.authenticateStatus forKey:kCustomerBaseInfoResultAuthenticateStatus];
    [mutableDict setValue:self.cityName forKey:kCustomerBaseInfoResultCityName];

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

    self.createDate = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultCreateDate];
    self.modifyBy = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultModifyBy];
    self.countyName = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultCountyName];
    self.homeAddress = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultHomeAddress];
    self.educationLevel = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultEducationLevel];
    self.accountBaseId = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultAccountBaseId];
    self.customerName = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultCustomerName];
    self.idCode = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultIdCode];
    self.idType = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultIdType];
    self.bindingMobilephone = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultBindingMobilephone];
    self.provinceName = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultProvinceName];
    self.county = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultCounty];
    self.city = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultCity];
    self.resultIdentifier = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultId];
    self.province = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultProvince];
    self.modifyDate = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultModifyDate];
    self.createBy = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultCreateBy];
    self.contactBean = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultContactBean];
    self.authenticateStatus = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultAuthenticateStatus];
    self.cityName = [aDecoder decodeObjectForKey:kCustomerBaseInfoResultCityName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createDate forKey:kCustomerBaseInfoResultCreateDate];
    [aCoder encodeObject:_modifyBy forKey:kCustomerBaseInfoResultModifyBy];
    [aCoder encodeObject:_countyName forKey:kCustomerBaseInfoResultCountyName];
    [aCoder encodeObject:_homeAddress forKey:kCustomerBaseInfoResultHomeAddress];
    [aCoder encodeObject:_educationLevel forKey:kCustomerBaseInfoResultEducationLevel];
    [aCoder encodeObject:_accountBaseId forKey:kCustomerBaseInfoResultAccountBaseId];
    [aCoder encodeObject:_customerName forKey:kCustomerBaseInfoResultCustomerName];
    [aCoder encodeObject:_idCode forKey:kCustomerBaseInfoResultIdCode];
    [aCoder encodeObject:_idType forKey:kCustomerBaseInfoResultIdType];
    [aCoder encodeObject:_bindingMobilephone forKey:kCustomerBaseInfoResultBindingMobilephone];
    [aCoder encodeObject:_provinceName forKey:kCustomerBaseInfoResultProvinceName];
    [aCoder encodeObject:_county forKey:kCustomerBaseInfoResultCounty];
    [aCoder encodeObject:_city forKey:kCustomerBaseInfoResultCity];
    [aCoder encodeObject:_resultIdentifier forKey:kCustomerBaseInfoResultId];
    [aCoder encodeObject:_province forKey:kCustomerBaseInfoResultProvince];
    [aCoder encodeObject:_modifyDate forKey:kCustomerBaseInfoResultModifyDate];
    [aCoder encodeObject:_createBy forKey:kCustomerBaseInfoResultCreateBy];
    [aCoder encodeObject:_contactBean forKey:kCustomerBaseInfoResultContactBean];
    [aCoder encodeObject:_authenticateStatus forKey:kCustomerBaseInfoResultAuthenticateStatus];
    [aCoder encodeObject:_cityName forKey:kCustomerBaseInfoResultCityName];
}

- (id)copyWithZone:(NSZone *)zone
{
    CustomerBaseInfoResult *copy = [[CustomerBaseInfoResult alloc] init];
    
    if (copy) {

        copy.createDate = [self.createDate copyWithZone:zone];
        copy.modifyBy = [self.modifyBy copyWithZone:zone];
        copy.countyName = [self.countyName copyWithZone:zone];
        copy.homeAddress = [self.homeAddress copyWithZone:zone];
        copy.educationLevel = [self.educationLevel copyWithZone:zone];
        copy.accountBaseId = [self.accountBaseId copyWithZone:zone];
        copy.customerName = [self.customerName copyWithZone:zone];
        copy.idCode = [self.idCode copyWithZone:zone];
        copy.idType = [self.idType copyWithZone:zone];
        copy.bindingMobilephone = [self.bindingMobilephone copyWithZone:zone];
        copy.provinceName = [self.provinceName copyWithZone:zone];
        copy.county = [self.county copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.resultIdentifier = [self.resultIdentifier copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
        copy.modifyDate = [self.modifyDate copyWithZone:zone];
        copy.createBy = [self.createBy copyWithZone:zone];
        copy.contactBean = [self.contactBean copyWithZone:zone];
        copy.authenticateStatus = [self.authenticateStatus copyWithZone:zone];
        copy.cityName = [self.cityName copyWithZone:zone];
    }
    
    return copy;
}


@end
