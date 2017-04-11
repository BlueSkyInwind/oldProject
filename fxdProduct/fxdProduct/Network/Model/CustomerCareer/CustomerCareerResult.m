//
//  CustomerCareerResult.m
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CustomerCareerResult.h"


NSString *const kCustomerCareerResultCreateBy = @"create_by_";
NSString *const kCustomerCareerResultCreateDate = @"create_date_";
NSString *const kCustomerCareerResultModifyBy = @"modify_by_";
NSString *const kCustomerCareerResultId = @"id_";
NSString *const kCustomerCareerResultCity = @"city_";
NSString *const kCustomerCareerResultOrganizationTelephone = @"organization_telephone_";
NSString *const kCustomerCareerResultOrganizationAddress = @"organization_address_";
NSString *const kCustomerCareerResultCountry = @"country_";
NSString *const kCustomerCareerResultModifyDate = @"modify_date_";
NSString *const kCustomerCareerResultProvinceName = @"province_name_";
NSString *const kCustomerCareerResultOrganizationName = @"organization_name_";
NSString *const kCustomerCareerResultCustomerBaseId = @"customer_base_id_";
NSString *const kCustomerCareerResultCountryName = @"country_name_";
NSString *const kCustomerCareerResultProvince = @"province_";
NSString *const kCustomerCareerResultCityName = @"city_name_";
NSString *const kCustomerCareerResultIndustry = @"industry_";


@interface CustomerCareerResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CustomerCareerResult

@synthesize createBy = _createBy;
@synthesize createDate = _createDate;
@synthesize modifyBy = _modifyBy;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize city = _city;
@synthesize organizationTelephone = _organizationTelephone;
@synthesize organizationAddress = _organizationAddress;
@synthesize country = _country;
@synthesize modifyDate = _modifyDate;
@synthesize provinceName = _provinceName;
@synthesize organizationName = _organizationName;
@synthesize customerBaseId = _customerBaseId;
@synthesize countryName = _countryName;
@synthesize province = _province;
@synthesize cityName = _cityName;
@synthesize industry = _industry;


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
            self.createBy = [self objectOrNilForKey:kCustomerCareerResultCreateBy fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kCustomerCareerResultCreateDate fromDictionary:dict];
            self.modifyBy = [self objectOrNilForKey:kCustomerCareerResultModifyBy fromDictionary:dict];
            self.resultIdentifier = [self objectOrNilForKey:kCustomerCareerResultId fromDictionary:dict];
            self.city = [self objectOrNilForKey:kCustomerCareerResultCity fromDictionary:dict];
            self.organizationTelephone = [self objectOrNilForKey:kCustomerCareerResultOrganizationTelephone fromDictionary:dict];
            self.organizationAddress = [self objectOrNilForKey:kCustomerCareerResultOrganizationAddress fromDictionary:dict];
            self.country = [self objectOrNilForKey:kCustomerCareerResultCountry fromDictionary:dict];
            self.modifyDate = [self objectOrNilForKey:kCustomerCareerResultModifyDate fromDictionary:dict];
            self.provinceName = [self objectOrNilForKey:kCustomerCareerResultProvinceName fromDictionary:dict];
            self.organizationName = [self objectOrNilForKey:kCustomerCareerResultOrganizationName fromDictionary:dict];
            self.customerBaseId = [self objectOrNilForKey:kCustomerCareerResultCustomerBaseId fromDictionary:dict];
            self.countryName = [self objectOrNilForKey:kCustomerCareerResultCountryName fromDictionary:dict];
            self.province = [self objectOrNilForKey:kCustomerCareerResultProvince fromDictionary:dict];
            self.cityName = [self objectOrNilForKey:kCustomerCareerResultCityName fromDictionary:dict];
            self.industry = [self objectOrNilForKey:kCustomerCareerResultIndustry fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createBy forKey:kCustomerCareerResultCreateBy];
    [mutableDict setValue:self.createDate forKey:kCustomerCareerResultCreateDate];
    [mutableDict setValue:self.modifyBy forKey:kCustomerCareerResultModifyBy];
    [mutableDict setValue:self.resultIdentifier forKey:kCustomerCareerResultId];
    [mutableDict setValue:self.city forKey:kCustomerCareerResultCity];
    [mutableDict setValue:self.organizationTelephone forKey:kCustomerCareerResultOrganizationTelephone];
    [mutableDict setValue:self.organizationAddress forKey:kCustomerCareerResultOrganizationAddress];
    [mutableDict setValue:self.country forKey:kCustomerCareerResultCountry];
    [mutableDict setValue:self.modifyDate forKey:kCustomerCareerResultModifyDate];
    [mutableDict setValue:self.provinceName forKey:kCustomerCareerResultProvinceName];
    [mutableDict setValue:self.organizationName forKey:kCustomerCareerResultOrganizationName];
    [mutableDict setValue:self.customerBaseId forKey:kCustomerCareerResultCustomerBaseId];
    [mutableDict setValue:self.countryName forKey:kCustomerCareerResultCountryName];
    [mutableDict setValue:self.province forKey:kCustomerCareerResultProvince];
    [mutableDict setValue:self.cityName forKey:kCustomerCareerResultCityName];
    [mutableDict setValue:self.industry forKey:kCustomerCareerResultIndustry];

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

    self.createBy = [aDecoder decodeObjectForKey:kCustomerCareerResultCreateBy];
    self.createDate = [aDecoder decodeObjectForKey:kCustomerCareerResultCreateDate];
    self.modifyBy = [aDecoder decodeObjectForKey:kCustomerCareerResultModifyBy];
    self.resultIdentifier = [aDecoder decodeObjectForKey:kCustomerCareerResultId];
    self.city = [aDecoder decodeObjectForKey:kCustomerCareerResultCity];
    self.organizationTelephone = [aDecoder decodeObjectForKey:kCustomerCareerResultOrganizationTelephone];
    self.organizationAddress = [aDecoder decodeObjectForKey:kCustomerCareerResultOrganizationAddress];
    self.country = [aDecoder decodeObjectForKey:kCustomerCareerResultCountry];
    self.modifyDate = [aDecoder decodeObjectForKey:kCustomerCareerResultModifyDate];
    self.provinceName = [aDecoder decodeObjectForKey:kCustomerCareerResultProvinceName];
    self.organizationName = [aDecoder decodeObjectForKey:kCustomerCareerResultOrganizationName];
    self.customerBaseId = [aDecoder decodeObjectForKey:kCustomerCareerResultCustomerBaseId];
    self.countryName = [aDecoder decodeObjectForKey:kCustomerCareerResultCountryName];
    self.province = [aDecoder decodeObjectForKey:kCustomerCareerResultProvince];
    self.cityName = [aDecoder decodeObjectForKey:kCustomerCareerResultCityName];
    self.industry = [aDecoder decodeObjectForKey:kCustomerCareerResultIndustry];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createBy forKey:kCustomerCareerResultCreateBy];
    [aCoder encodeObject:_createDate forKey:kCustomerCareerResultCreateDate];
    [aCoder encodeObject:_modifyBy forKey:kCustomerCareerResultModifyBy];
    [aCoder encodeObject:_resultIdentifier forKey:kCustomerCareerResultId];
    [aCoder encodeObject:_city forKey:kCustomerCareerResultCity];
    [aCoder encodeObject:_organizationTelephone forKey:kCustomerCareerResultOrganizationTelephone];
    [aCoder encodeObject:_organizationAddress forKey:kCustomerCareerResultOrganizationAddress];
    [aCoder encodeObject:_country forKey:kCustomerCareerResultCountry];
    [aCoder encodeObject:_modifyDate forKey:kCustomerCareerResultModifyDate];
    [aCoder encodeObject:_provinceName forKey:kCustomerCareerResultProvinceName];
    [aCoder encodeObject:_organizationName forKey:kCustomerCareerResultOrganizationName];
    [aCoder encodeObject:_customerBaseId forKey:kCustomerCareerResultCustomerBaseId];
    [aCoder encodeObject:_countryName forKey:kCustomerCareerResultCountryName];
    [aCoder encodeObject:_province forKey:kCustomerCareerResultProvince];
    [aCoder encodeObject:_cityName forKey:kCustomerCareerResultCityName];
    [aCoder encodeObject:_industry forKey:kCustomerCareerResultIndustry];
}

- (id)copyWithZone:(NSZone *)zone
{
    CustomerCareerResult *copy = [[CustomerCareerResult alloc] init];
    
    if (copy) {

        copy.createBy = [self.createBy copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.modifyBy = [self.modifyBy copyWithZone:zone];
        copy.resultIdentifier = [self.resultIdentifier copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.organizationTelephone = [self.organizationTelephone copyWithZone:zone];
        copy.organizationAddress = [self.organizationAddress copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.modifyDate = [self.modifyDate copyWithZone:zone];
        copy.provinceName = [self.provinceName copyWithZone:zone];
        copy.organizationName = [self.organizationName copyWithZone:zone];
        copy.customerBaseId = [self.customerBaseId copyWithZone:zone];
        copy.countryName = [self.countryName copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
        copy.cityName = [self.cityName copyWithZone:zone];
        copy.industry = [self.industry copyWithZone:zone];
    }
    
    return copy;
}


@end
