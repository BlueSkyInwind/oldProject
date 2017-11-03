//
//  Result.m
//
//  Created by dd  on 2017/3/1
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Custom_BaseInfoResult.h"
#import "ContactBean.h"


NSString *const kResultCreateDate = @"create_date_";
NSString *const kResultValidDate = @"valid_date_";
NSString *const kResultModifyBy = @"modify_by_";
NSString *const kResultCountyName = @"county_name_";
NSString *const kResultBirthdate = @"birthdate_";
NSString *const kResultHomeAddress = @"home_address_";
NSString *const kResultSex = @"sex_";
NSString *const kResultIssuedBy = @"issued_by";
NSString *const kResultOcrStatus = @"ocr_status_";
NSString *const kResultAccountBaseId = @"account_base_id_";
NSString *const kResultCustomerName = @"customer_name_";
NSString *const kResultVerifyStatus = @"verify_status_";
NSString *const kResultIdCode = @"id_code_";
NSString *const kResultIdType = @"id_type_";
NSString *const kResultBindingMobilephone = @"binding_mobilephone_";
NSString *const kResultEducationLevel = @"education_level_";
NSString *const kResultHouseholdRegisterAddress = @"household_register_address_";
NSString *const kResultProvinceName = @"province_name_";
NSString *const kResultCounty = @"county_";
NSString *const kResultCity = @"city_";
NSString *const kResultId = @"id_";
NSString *const kResultProvince = @"province_";
NSString *const kResultCityName = @"city_name_";
NSString *const kResultNation = @"nation_";
NSString *const kResultContactBean = @"contactBean";
NSString *const kResultAuthenticateStatus = @"authenticate_status_";
NSString *const kResultCreateBy = @"create_by_";
NSString *const kResultModifyDate = @"modify_date_";


@interface Custom_BaseInfoResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Custom_BaseInfoResult

@synthesize createDate = _createDate;
@synthesize validDate = _validDate;
@synthesize modifyBy = _modifyBy;
@synthesize countyName = _countyName;
@synthesize birthdate = _birthdate;
@synthesize homeAddress = _homeAddress;
@synthesize sex = _sex;
@synthesize issuedBy = _issuedBy;
@synthesize ocrStatus = _ocrStatus;
@synthesize accountBaseId = _accountBaseId;
@synthesize customerName = _customerName;
@synthesize verifyStatus = _verifyStatus;
@synthesize idCode = _idCode;
@synthesize idType = _idType;
@synthesize bindingMobilephone = _bindingMobilephone;
@synthesize educationLevel = _educationLevel;
@synthesize householdRegisterAddress = _householdRegisterAddress;
@synthesize provinceName = _provinceName;
@synthesize county = _county;
@synthesize city = _city;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize province = _province;
@synthesize cityName = _cityName;
@synthesize nation = _nation;
@synthesize contactBean = _contactBean;
@synthesize authenticateStatus = _authenticateStatus;
@synthesize createBy = _createBy;
@synthesize modifyDate = _modifyDate;


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
            self.createDate = [self objectOrNilForKey:kResultCreateDate fromDictionary:dict];
            self.validDate = [self objectOrNilForKey:kResultValidDate fromDictionary:dict];
            self.modifyBy = [self objectOrNilForKey:kResultModifyBy fromDictionary:dict];
            self.countyName = [self objectOrNilForKey:kResultCountyName fromDictionary:dict];
            self.birthdate = [self objectOrNilForKey:kResultBirthdate fromDictionary:dict];
            self.homeAddress = [self objectOrNilForKey:kResultHomeAddress fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kResultSex fromDictionary:dict] doubleValue];
            self.issuedBy = [self objectOrNilForKey:kResultIssuedBy fromDictionary:dict];
            self.ocrStatus = [[self objectOrNilForKey:kResultOcrStatus fromDictionary:dict] doubleValue];
            self.accountBaseId = [self objectOrNilForKey:kResultAccountBaseId fromDictionary:dict];
            self.customerName = [self objectOrNilForKey:kResultCustomerName fromDictionary:dict];
            self.verifyStatus = [[self objectOrNilForKey:kResultVerifyStatus fromDictionary:dict] doubleValue];
            self.idCode = [self objectOrNilForKey:kResultIdCode fromDictionary:dict];
            self.idType = [self objectOrNilForKey:kResultIdType fromDictionary:dict];
            self.bindingMobilephone = [self objectOrNilForKey:kResultBindingMobilephone fromDictionary:dict];
            self.educationLevel = [self objectOrNilForKey:kResultEducationLevel fromDictionary:dict];
            self.householdRegisterAddress = [self objectOrNilForKey:kResultHouseholdRegisterAddress fromDictionary:dict];
            self.provinceName = [self objectOrNilForKey:kResultProvinceName fromDictionary:dict];
            self.county = [self objectOrNilForKey:kResultCounty fromDictionary:dict];
            self.city = [self objectOrNilForKey:kResultCity fromDictionary:dict];
            self.resultIdentifier = [self objectOrNilForKey:kResultId fromDictionary:dict];
            self.province = [self objectOrNilForKey:kResultProvince fromDictionary:dict];
            self.cityName = [self objectOrNilForKey:kResultCityName fromDictionary:dict];
            self.nation = [self objectOrNilForKey:kResultNation fromDictionary:dict];
    NSObject *receivedContactBean = [dict objectForKey:kResultContactBean];
    NSMutableArray *parsedContactBean = [NSMutableArray array];
    if ([receivedContactBean isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedContactBean) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedContactBean addObject:[ContactBean modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedContactBean isKindOfClass:[NSDictionary class]]) {
       [parsedContactBean addObject:[ContactBean modelObjectWithDictionary:(NSDictionary *)receivedContactBean]];
    }

    self.contactBean = [NSArray arrayWithArray:parsedContactBean];
            self.authenticateStatus = [self objectOrNilForKey:kResultAuthenticateStatus fromDictionary:dict];
            self.createBy = [self objectOrNilForKey:kResultCreateBy fromDictionary:dict];
            self.modifyDate = [self objectOrNilForKey:kResultModifyDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createDate forKey:kResultCreateDate];
    [mutableDict setValue:self.validDate forKey:kResultValidDate];
    [mutableDict setValue:self.modifyBy forKey:kResultModifyBy];
    [mutableDict setValue:self.countyName forKey:kResultCountyName];
    [mutableDict setValue:self.birthdate forKey:kResultBirthdate];
    [mutableDict setValue:self.homeAddress forKey:kResultHomeAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kResultSex];
    [mutableDict setValue:self.issuedBy forKey:kResultIssuedBy];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ocrStatus] forKey:kResultOcrStatus];
    [mutableDict setValue:self.accountBaseId forKey:kResultAccountBaseId];
    [mutableDict setValue:self.customerName forKey:kResultCustomerName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.verifyStatus] forKey:kResultVerifyStatus];
    [mutableDict setValue:self.idCode forKey:kResultIdCode];
    [mutableDict setValue:self.idType forKey:kResultIdType];
    [mutableDict setValue:self.bindingMobilephone forKey:kResultBindingMobilephone];
    [mutableDict setValue:self.educationLevel forKey:kResultEducationLevel];
    [mutableDict setValue:self.householdRegisterAddress forKey:kResultHouseholdRegisterAddress];
    [mutableDict setValue:self.provinceName forKey:kResultProvinceName];
    [mutableDict setValue:self.county forKey:kResultCounty];
    [mutableDict setValue:self.city forKey:kResultCity];
    [mutableDict setValue:self.resultIdentifier forKey:kResultId];
    [mutableDict setValue:self.province forKey:kResultProvince];
    [mutableDict setValue:self.cityName forKey:kResultCityName];
    [mutableDict setValue:self.nation forKey:kResultNation];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForContactBean] forKey:kResultContactBean];
    [mutableDict setValue:self.authenticateStatus forKey:kResultAuthenticateStatus];
    [mutableDict setValue:self.createBy forKey:kResultCreateBy];
    [mutableDict setValue:self.modifyDate forKey:kResultModifyDate];

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

    self.createDate = [aDecoder decodeObjectForKey:kResultCreateDate];
    self.validDate = [aDecoder decodeObjectForKey:kResultValidDate];
    self.modifyBy = [aDecoder decodeObjectForKey:kResultModifyBy];
    self.countyName = [aDecoder decodeObjectForKey:kResultCountyName];
    self.birthdate = [aDecoder decodeObjectForKey:kResultBirthdate];
    self.homeAddress = [aDecoder decodeObjectForKey:kResultHomeAddress];
    self.sex = [aDecoder decodeDoubleForKey:kResultSex];
    self.issuedBy = [aDecoder decodeObjectForKey:kResultIssuedBy];
    self.ocrStatus = [aDecoder decodeDoubleForKey:kResultOcrStatus];
    self.accountBaseId = [aDecoder decodeObjectForKey:kResultAccountBaseId];
    self.customerName = [aDecoder decodeObjectForKey:kResultCustomerName];
    self.verifyStatus = [aDecoder decodeDoubleForKey:kResultVerifyStatus];
    self.idCode = [aDecoder decodeObjectForKey:kResultIdCode];
    self.idType = [aDecoder decodeObjectForKey:kResultIdType];
    self.bindingMobilephone = [aDecoder decodeObjectForKey:kResultBindingMobilephone];
    self.educationLevel = [aDecoder decodeObjectForKey:kResultEducationLevel];
    self.householdRegisterAddress = [aDecoder decodeObjectForKey:kResultHouseholdRegisterAddress];
    self.provinceName = [aDecoder decodeObjectForKey:kResultProvinceName];
    self.county = [aDecoder decodeObjectForKey:kResultCounty];
    self.city = [aDecoder decodeObjectForKey:kResultCity];
    self.resultIdentifier = [aDecoder decodeObjectForKey:kResultId];
    self.province = [aDecoder decodeObjectForKey:kResultProvince];
    self.cityName = [aDecoder decodeObjectForKey:kResultCityName];
    self.nation = [aDecoder decodeObjectForKey:kResultNation];
    self.contactBean = [aDecoder decodeObjectForKey:kResultContactBean];
    self.authenticateStatus = [aDecoder decodeObjectForKey:kResultAuthenticateStatus];
    self.createBy = [aDecoder decodeObjectForKey:kResultCreateBy];
    self.modifyDate = [aDecoder decodeObjectForKey:kResultModifyDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createDate forKey:kResultCreateDate];
    [aCoder encodeObject:_validDate forKey:kResultValidDate];
    [aCoder encodeObject:_modifyBy forKey:kResultModifyBy];
    [aCoder encodeObject:_countyName forKey:kResultCountyName];
    [aCoder encodeObject:_birthdate forKey:kResultBirthdate];
    [aCoder encodeObject:_homeAddress forKey:kResultHomeAddress];
    [aCoder encodeDouble:_sex forKey:kResultSex];
    [aCoder encodeObject:_issuedBy forKey:kResultIssuedBy];
    [aCoder encodeDouble:_ocrStatus forKey:kResultOcrStatus];
    [aCoder encodeObject:_accountBaseId forKey:kResultAccountBaseId];
    [aCoder encodeObject:_customerName forKey:kResultCustomerName];
    [aCoder encodeDouble:_verifyStatus forKey:kResultVerifyStatus];
    [aCoder encodeObject:_idCode forKey:kResultIdCode];
    [aCoder encodeObject:_idType forKey:kResultIdType];
    [aCoder encodeObject:_bindingMobilephone forKey:kResultBindingMobilephone];
    [aCoder encodeObject:_educationLevel forKey:kResultEducationLevel];
    [aCoder encodeObject:_householdRegisterAddress forKey:kResultHouseholdRegisterAddress];
    [aCoder encodeObject:_provinceName forKey:kResultProvinceName];
    [aCoder encodeObject:_county forKey:kResultCounty];
    [aCoder encodeObject:_city forKey:kResultCity];
    [aCoder encodeObject:_resultIdentifier forKey:kResultId];
    [aCoder encodeObject:_province forKey:kResultProvince];
    [aCoder encodeObject:_cityName forKey:kResultCityName];
    [aCoder encodeObject:_nation forKey:kResultNation];
    [aCoder encodeObject:_contactBean forKey:kResultContactBean];
    [aCoder encodeObject:_authenticateStatus forKey:kResultAuthenticateStatus];
    [aCoder encodeObject:_createBy forKey:kResultCreateBy];
    [aCoder encodeObject:_modifyDate forKey:kResultModifyDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    Custom_BaseInfoResult *copy = [[Custom_BaseInfoResult alloc] init];
    
    if (copy) {

        copy.createDate = [self.createDate copyWithZone:zone];
        copy.validDate = [self.validDate copyWithZone:zone];
        copy.modifyBy = [self.modifyBy copyWithZone:zone];
        copy.countyName = [self.countyName copyWithZone:zone];
        copy.birthdate = [self.birthdate copyWithZone:zone];
        copy.homeAddress = [self.homeAddress copyWithZone:zone];
        copy.sex = self.sex;
        copy.issuedBy = [self.issuedBy copyWithZone:zone];
        copy.ocrStatus = self.ocrStatus;
        copy.accountBaseId = [self.accountBaseId copyWithZone:zone];
        copy.customerName = [self.customerName copyWithZone:zone];
        copy.verifyStatus = self.verifyStatus;
        copy.idCode = [self.idCode copyWithZone:zone];
        copy.idType = [self.idType copyWithZone:zone];
        copy.bindingMobilephone = [self.bindingMobilephone copyWithZone:zone];
        copy.educationLevel = [self.educationLevel copyWithZone:zone];
        copy.householdRegisterAddress = [self.householdRegisterAddress copyWithZone:zone];
        copy.provinceName = [self.provinceName copyWithZone:zone];
        copy.county = [self.county copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.resultIdentifier = [self.resultIdentifier copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
        copy.cityName = [self.cityName copyWithZone:zone];
        copy.nation = [self.nation copyWithZone:zone];
        copy.contactBean = [self.contactBean copyWithZone:zone];
        copy.authenticateStatus = [self.authenticateStatus copyWithZone:zone];
        copy.createBy = [self.createBy copyWithZone:zone];
        copy.modifyDate = [self.modifyDate copyWithZone:zone];
    }
    
    return copy;
}


@end
