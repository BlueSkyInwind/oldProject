//
//  LoginResult.m
//
//  Created by dd  on 16/3/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LoginResult.h"


NSString *const kLoginResultCompany = @"company";
NSString *const kLoginResultIntegral = @"integral";
NSString *const kLoginResultId = @"id";
NSString *const kLoginResultHoldIdentityPhonePath = @"holdIdentityPhonePath";
NSString *const kLoginResultCreditBankNo = @"creditBankNo";
NSString *const kLoginResultHeadPortraitPath = @"headPortraitPath";
NSString *const kLoginResultContactPhone2 = @"contactPhone2";
NSString *const kLoginResultSoundRecordingPath = @"soundRecordingPath";
NSString *const kLoginResultEquipmentNum = @"equipmentNum";
NSString *const kLoginResultAddress = @"address";
NSString *const kLoginResultLastUpdateDate = @"lastUpdateDate";
NSString *const kLoginResultContactName2 = @"contactName2";
NSString *const kLoginResultUuid = @"uuid";
NSString *const kLoginResultUpdateId = @"updateId";
NSString *const kLoginResultUnitTelephone = @"unitTelephone";
NSString *const kLoginResultLastLoginIp = @"lastLoginIp";
NSString *const kLoginResultCreditCardNo = @"creditCardNo";
NSString *const kLoginResultRegisterPlatformSource = @"registerPlatformSource";
NSString *const kLoginResultContactRelationship = @"contactRelationship";
NSString *const kLoginResultDebitCardNo = @"debitCardNo";
NSString *const kLoginResultIdentityId = @"identityId";
NSString *const kLoginResultRealName = @"realName";
NSString *const kLoginResultCreditLine = @"creditLine";
NSString *const kLoginResultLastLoginDate = @"lastLoginDate";
NSString *const kLoginResultIsValid = @"isValid";
NSString *const kLoginResultCreateDate = @"createDate";
NSString *const kLoginResultPhontNum = @"phontNum";
NSString *const kLoginResultPlatformSource = @"platformSource";
NSString *const kLoginResultContactPhone = @"contactPhone";
NSString *const kLoginResultDebitBankName = @"debitBankName";
NSString *const kLoginResultCreditBankName = @"creditBankName";
NSString *const kLoginResultUnitAddress = @"unitAddress";
NSString *const kLoginResultIdentityCounterPath = @"identityCounterPath";
NSString *const kLoginResultContactRelationship2 = @"contactRelationship2";
NSString *const kLoginResultCareer = @"career";
NSString *const kLoginResultClientId = @"clientId";
NSString *const kLoginResultDegree = @"degree";
NSString *const kLoginResultBankNo = @"bankNo";
NSString *const kLoginResultUserName = @"userName";
NSString *const kLoginResultContactName = @"contactName";
NSString *const kLoginResultIdentityPositivePath = @"identityPositivePath";
NSString *const kLoginResultCreditLev = @"creditLev";


@interface LoginResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginResult

@synthesize company = _company;
@synthesize integral = _integral;
@synthesize resultIdentifier = _resultIdentifier;
@synthesize holdIdentityPhonePath = _holdIdentityPhonePath;
@synthesize creditBankNo = _creditBankNo;
@synthesize headPortraitPath = _headPortraitPath;
@synthesize contactPhone2 = _contactPhone2;
@synthesize soundRecordingPath = _soundRecordingPath;
@synthesize equipmentNum = _equipmentNum;
@synthesize address = _address;
@synthesize lastUpdateDate = _lastUpdateDate;
@synthesize contactName2 = _contactName2;
@synthesize uuid = _uuid;
@synthesize updateId = _updateId;
@synthesize unitTelephone = _unitTelephone;
@synthesize lastLoginIp = _lastLoginIp;
@synthesize creditCardNo = _creditCardNo;
@synthesize registerPlatformSource = _registerPlatformSource;
@synthesize contactRelationship = _contactRelationship;
@synthesize debitCardNo = _debitCardNo;
@synthesize identityId = _identityId;
@synthesize realName = _realName;
@synthesize creditLine = _creditLine;
@synthesize lastLoginDate = _lastLoginDate;
@synthesize isValid = _isValid;
@synthesize createDate = _createDate;
@synthesize phontNum = _phontNum;
@synthesize platformSource = _platformSource;
@synthesize contactPhone = _contactPhone;
@synthesize debitBankName = _debitBankName;
@synthesize creditBankName = _creditBankName;
@synthesize unitAddress = _unitAddress;
@synthesize identityCounterPath = _identityCounterPath;
@synthesize contactRelationship2 = _contactRelationship2;
@synthesize career = _career;
@synthesize clientId = _clientId;
@synthesize degree = _degree;
@synthesize bankNo = _bankNo;
@synthesize userName = _userName;
@synthesize contactName = _contactName;
@synthesize identityPositivePath = _identityPositivePath;
@synthesize creditLev = _creditLev;


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
            self.company = [self objectOrNilForKey:kLoginResultCompany fromDictionary:dict];
            self.integral = [[self objectOrNilForKey:kLoginResultIntegral fromDictionary:dict] doubleValue];
            self.resultIdentifier = [[self objectOrNilForKey:kLoginResultId fromDictionary:dict] doubleValue];
            self.holdIdentityPhonePath = [self objectOrNilForKey:kLoginResultHoldIdentityPhonePath fromDictionary:dict];
            self.creditBankNo = [self objectOrNilForKey:kLoginResultCreditBankNo fromDictionary:dict];
            self.headPortraitPath = [self objectOrNilForKey:kLoginResultHeadPortraitPath fromDictionary:dict];
            self.contactPhone2 = [self objectOrNilForKey:kLoginResultContactPhone2 fromDictionary:dict];
            self.soundRecordingPath = [self objectOrNilForKey:kLoginResultSoundRecordingPath fromDictionary:dict];
            self.equipmentNum = [self objectOrNilForKey:kLoginResultEquipmentNum fromDictionary:dict];
            self.address = [self objectOrNilForKey:kLoginResultAddress fromDictionary:dict];
            self.lastUpdateDate = [self objectOrNilForKey:kLoginResultLastUpdateDate fromDictionary:dict];
            self.contactName2 = [self objectOrNilForKey:kLoginResultContactName2 fromDictionary:dict];
            self.uuid = [self objectOrNilForKey:kLoginResultUuid fromDictionary:dict];
            self.updateId = [[self objectOrNilForKey:kLoginResultUpdateId fromDictionary:dict] doubleValue];
            self.unitTelephone = [self objectOrNilForKey:kLoginResultUnitTelephone fromDictionary:dict];
            self.lastLoginIp = [self objectOrNilForKey:kLoginResultLastLoginIp fromDictionary:dict];
            self.creditCardNo = [self objectOrNilForKey:kLoginResultCreditCardNo fromDictionary:dict];
            self.registerPlatformSource = [self objectOrNilForKey:kLoginResultRegisterPlatformSource fromDictionary:dict];
            self.contactRelationship = [self objectOrNilForKey:kLoginResultContactRelationship fromDictionary:dict];
            self.debitCardNo = [self objectOrNilForKey:kLoginResultDebitCardNo fromDictionary:dict];
            self.identityId = [self objectOrNilForKey:kLoginResultIdentityId fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kLoginResultRealName fromDictionary:dict];
            self.creditLine = [[self objectOrNilForKey:kLoginResultCreditLine fromDictionary:dict] doubleValue];
            self.lastLoginDate = [self objectOrNilForKey:kLoginResultLastLoginDate fromDictionary:dict];
            self.isValid = [self objectOrNilForKey:kLoginResultIsValid fromDictionary:dict];
            self.createDate = [self objectOrNilForKey:kLoginResultCreateDate fromDictionary:dict];
            self.phontNum = [self objectOrNilForKey:kLoginResultPhontNum fromDictionary:dict];
            self.platformSource = [self objectOrNilForKey:kLoginResultPlatformSource fromDictionary:dict];
            self.contactPhone = [self objectOrNilForKey:kLoginResultContactPhone fromDictionary:dict];
            self.debitBankName = [self objectOrNilForKey:kLoginResultDebitBankName fromDictionary:dict];
            self.creditBankName = [self objectOrNilForKey:kLoginResultCreditBankName fromDictionary:dict];
            self.unitAddress = [self objectOrNilForKey:kLoginResultUnitAddress fromDictionary:dict];
            self.identityCounterPath = [self objectOrNilForKey:kLoginResultIdentityCounterPath fromDictionary:dict];
            self.contactRelationship2 = [self objectOrNilForKey:kLoginResultContactRelationship2 fromDictionary:dict];
            self.career = [self objectOrNilForKey:kLoginResultCareer fromDictionary:dict];
            self.clientId = [self objectOrNilForKey:kLoginResultClientId fromDictionary:dict];
            self.degree = [self objectOrNilForKey:kLoginResultDegree fromDictionary:dict];
            self.bankNo = [self objectOrNilForKey:kLoginResultBankNo fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kLoginResultUserName fromDictionary:dict];
            self.contactName = [self objectOrNilForKey:kLoginResultContactName fromDictionary:dict];
            self.identityPositivePath = [self objectOrNilForKey:kLoginResultIdentityPositivePath fromDictionary:dict];
            self.creditLev = [self objectOrNilForKey:kLoginResultCreditLev fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.company forKey:kLoginResultCompany];
    [mutableDict setValue:[NSNumber numberWithDouble:self.integral] forKey:kLoginResultIntegral];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultIdentifier] forKey:kLoginResultId];
    [mutableDict setValue:self.holdIdentityPhonePath forKey:kLoginResultHoldIdentityPhonePath];
    [mutableDict setValue:self.creditBankNo forKey:kLoginResultCreditBankNo];
    [mutableDict setValue:self.headPortraitPath forKey:kLoginResultHeadPortraitPath];
    [mutableDict setValue:self.contactPhone2 forKey:kLoginResultContactPhone2];
    [mutableDict setValue:self.soundRecordingPath forKey:kLoginResultSoundRecordingPath];
    [mutableDict setValue:self.equipmentNum forKey:kLoginResultEquipmentNum];
    [mutableDict setValue:self.address forKey:kLoginResultAddress];
    [mutableDict setValue:self.lastUpdateDate forKey:kLoginResultLastUpdateDate];
    [mutableDict setValue:self.contactName2 forKey:kLoginResultContactName2];
    [mutableDict setValue:self.uuid forKey:kLoginResultUuid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.updateId] forKey:kLoginResultUpdateId];
    [mutableDict setValue:self.unitTelephone forKey:kLoginResultUnitTelephone];
    [mutableDict setValue:self.lastLoginIp forKey:kLoginResultLastLoginIp];
    [mutableDict setValue:self.creditCardNo forKey:kLoginResultCreditCardNo];
    [mutableDict setValue:self.registerPlatformSource forKey:kLoginResultRegisterPlatformSource];
    [mutableDict setValue:self.contactRelationship forKey:kLoginResultContactRelationship];
    [mutableDict setValue:self.debitCardNo forKey:kLoginResultDebitCardNo];
    [mutableDict setValue:self.identityId forKey:kLoginResultIdentityId];
    [mutableDict setValue:self.realName forKey:kLoginResultRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.creditLine] forKey:kLoginResultCreditLine];
    [mutableDict setValue:self.lastLoginDate forKey:kLoginResultLastLoginDate];
    [mutableDict setValue:self.isValid forKey:kLoginResultIsValid];
    [mutableDict setValue:self.createDate forKey:kLoginResultCreateDate];
    [mutableDict setValue:self.phontNum forKey:kLoginResultPhontNum];
    [mutableDict setValue:self.platformSource forKey:kLoginResultPlatformSource];
    [mutableDict setValue:self.contactPhone forKey:kLoginResultContactPhone];
    [mutableDict setValue:self.debitBankName forKey:kLoginResultDebitBankName];
    [mutableDict setValue:self.creditBankName forKey:kLoginResultCreditBankName];
    [mutableDict setValue:self.unitAddress forKey:kLoginResultUnitAddress];
    [mutableDict setValue:self.identityCounterPath forKey:kLoginResultIdentityCounterPath];
    [mutableDict setValue:self.contactRelationship2 forKey:kLoginResultContactRelationship2];
    [mutableDict setValue:self.career forKey:kLoginResultCareer];
    [mutableDict setValue:self.clientId forKey:kLoginResultClientId];
    [mutableDict setValue:self.degree forKey:kLoginResultDegree];
    [mutableDict setValue:self.bankNo forKey:kLoginResultBankNo];
    [mutableDict setValue:self.userName forKey:kLoginResultUserName];
    [mutableDict setValue:self.contactName forKey:kLoginResultContactName];
    [mutableDict setValue:self.identityPositivePath forKey:kLoginResultIdentityPositivePath];
    [mutableDict setValue:self.creditLev forKey:kLoginResultCreditLev];

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

    self.company = [aDecoder decodeObjectForKey:kLoginResultCompany];
    self.integral = [aDecoder decodeDoubleForKey:kLoginResultIntegral];
    self.resultIdentifier = [aDecoder decodeDoubleForKey:kLoginResultId];
    self.holdIdentityPhonePath = [aDecoder decodeObjectForKey:kLoginResultHoldIdentityPhonePath];
    self.creditBankNo = [aDecoder decodeObjectForKey:kLoginResultCreditBankNo];
    self.headPortraitPath = [aDecoder decodeObjectForKey:kLoginResultHeadPortraitPath];
    self.contactPhone2 = [aDecoder decodeObjectForKey:kLoginResultContactPhone2];
    self.soundRecordingPath = [aDecoder decodeObjectForKey:kLoginResultSoundRecordingPath];
    self.equipmentNum = [aDecoder decodeObjectForKey:kLoginResultEquipmentNum];
    self.address = [aDecoder decodeObjectForKey:kLoginResultAddress];
    self.lastUpdateDate = [aDecoder decodeObjectForKey:kLoginResultLastUpdateDate];
    self.contactName2 = [aDecoder decodeObjectForKey:kLoginResultContactName2];
    self.uuid = [aDecoder decodeObjectForKey:kLoginResultUuid];
    self.updateId = [aDecoder decodeDoubleForKey:kLoginResultUpdateId];
    self.unitTelephone = [aDecoder decodeObjectForKey:kLoginResultUnitTelephone];
    self.lastLoginIp = [aDecoder decodeObjectForKey:kLoginResultLastLoginIp];
    self.creditCardNo = [aDecoder decodeObjectForKey:kLoginResultCreditCardNo];
    self.registerPlatformSource = [aDecoder decodeObjectForKey:kLoginResultRegisterPlatformSource];
    self.contactRelationship = [aDecoder decodeObjectForKey:kLoginResultContactRelationship];
    self.debitCardNo = [aDecoder decodeObjectForKey:kLoginResultDebitCardNo];
    self.identityId = [aDecoder decodeObjectForKey:kLoginResultIdentityId];
    self.realName = [aDecoder decodeObjectForKey:kLoginResultRealName];
    self.creditLine = [aDecoder decodeDoubleForKey:kLoginResultCreditLine];
    self.lastLoginDate = [aDecoder decodeObjectForKey:kLoginResultLastLoginDate];
    self.isValid = [aDecoder decodeObjectForKey:kLoginResultIsValid];
    self.createDate = [aDecoder decodeObjectForKey:kLoginResultCreateDate];
    self.phontNum = [aDecoder decodeObjectForKey:kLoginResultPhontNum];
    self.platformSource = [aDecoder decodeObjectForKey:kLoginResultPlatformSource];
    self.contactPhone = [aDecoder decodeObjectForKey:kLoginResultContactPhone];
    self.debitBankName = [aDecoder decodeObjectForKey:kLoginResultDebitBankName];
    self.creditBankName = [aDecoder decodeObjectForKey:kLoginResultCreditBankName];
    self.unitAddress = [aDecoder decodeObjectForKey:kLoginResultUnitAddress];
    self.identityCounterPath = [aDecoder decodeObjectForKey:kLoginResultIdentityCounterPath];
    self.contactRelationship2 = [aDecoder decodeObjectForKey:kLoginResultContactRelationship2];
    self.career = [aDecoder decodeObjectForKey:kLoginResultCareer];
    self.clientId = [aDecoder decodeObjectForKey:kLoginResultClientId];
    self.degree = [aDecoder decodeObjectForKey:kLoginResultDegree];
    self.bankNo = [aDecoder decodeObjectForKey:kLoginResultBankNo];
    self.userName = [aDecoder decodeObjectForKey:kLoginResultUserName];
    self.contactName = [aDecoder decodeObjectForKey:kLoginResultContactName];
    self.identityPositivePath = [aDecoder decodeObjectForKey:kLoginResultIdentityPositivePath];
    self.creditLev = [aDecoder decodeObjectForKey:kLoginResultCreditLev];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_company forKey:kLoginResultCompany];
    [aCoder encodeDouble:_integral forKey:kLoginResultIntegral];
    [aCoder encodeDouble:_resultIdentifier forKey:kLoginResultId];
    [aCoder encodeObject:_holdIdentityPhonePath forKey:kLoginResultHoldIdentityPhonePath];
    [aCoder encodeObject:_creditBankNo forKey:kLoginResultCreditBankNo];
    [aCoder encodeObject:_headPortraitPath forKey:kLoginResultHeadPortraitPath];
    [aCoder encodeObject:_contactPhone2 forKey:kLoginResultContactPhone2];
    [aCoder encodeObject:_soundRecordingPath forKey:kLoginResultSoundRecordingPath];
    [aCoder encodeObject:_equipmentNum forKey:kLoginResultEquipmentNum];
    [aCoder encodeObject:_address forKey:kLoginResultAddress];
    [aCoder encodeObject:_lastUpdateDate forKey:kLoginResultLastUpdateDate];
    [aCoder encodeObject:_contactName2 forKey:kLoginResultContactName2];
    [aCoder encodeObject:_uuid forKey:kLoginResultUuid];
    [aCoder encodeDouble:_updateId forKey:kLoginResultUpdateId];
    [aCoder encodeObject:_unitTelephone forKey:kLoginResultUnitTelephone];
    [aCoder encodeObject:_lastLoginIp forKey:kLoginResultLastLoginIp];
    [aCoder encodeObject:_creditCardNo forKey:kLoginResultCreditCardNo];
    [aCoder encodeObject:_registerPlatformSource forKey:kLoginResultRegisterPlatformSource];
    [aCoder encodeObject:_contactRelationship forKey:kLoginResultContactRelationship];
    [aCoder encodeObject:_debitCardNo forKey:kLoginResultDebitCardNo];
    [aCoder encodeObject:_identityId forKey:kLoginResultIdentityId];
    [aCoder encodeObject:_realName forKey:kLoginResultRealName];
    [aCoder encodeDouble:_creditLine forKey:kLoginResultCreditLine];
    [aCoder encodeObject:_lastLoginDate forKey:kLoginResultLastLoginDate];
    [aCoder encodeObject:_isValid forKey:kLoginResultIsValid];
    [aCoder encodeObject:_createDate forKey:kLoginResultCreateDate];
    [aCoder encodeObject:_phontNum forKey:kLoginResultPhontNum];
    [aCoder encodeObject:_platformSource forKey:kLoginResultPlatformSource];
    [aCoder encodeObject:_contactPhone forKey:kLoginResultContactPhone];
    [aCoder encodeObject:_debitBankName forKey:kLoginResultDebitBankName];
    [aCoder encodeObject:_creditBankName forKey:kLoginResultCreditBankName];
    [aCoder encodeObject:_unitAddress forKey:kLoginResultUnitAddress];
    [aCoder encodeObject:_identityCounterPath forKey:kLoginResultIdentityCounterPath];
    [aCoder encodeObject:_contactRelationship2 forKey:kLoginResultContactRelationship2];
    [aCoder encodeObject:_career forKey:kLoginResultCareer];
    [aCoder encodeObject:_clientId forKey:kLoginResultClientId];
    [aCoder encodeObject:_degree forKey:kLoginResultDegree];
    [aCoder encodeObject:_bankNo forKey:kLoginResultBankNo];
    [aCoder encodeObject:_userName forKey:kLoginResultUserName];
    [aCoder encodeObject:_contactName forKey:kLoginResultContactName];
    [aCoder encodeObject:_identityPositivePath forKey:kLoginResultIdentityPositivePath];
    [aCoder encodeObject:_creditLev forKey:kLoginResultCreditLev];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginResult *copy = [[LoginResult alloc] init];
    
    if (copy) {

        copy.company = [self.company copyWithZone:zone];
        copy.integral = self.integral;
        copy.resultIdentifier = self.resultIdentifier;
        copy.holdIdentityPhonePath = [self.holdIdentityPhonePath copyWithZone:zone];
        copy.creditBankNo = [self.creditBankNo copyWithZone:zone];
        copy.headPortraitPath = [self.headPortraitPath copyWithZone:zone];
        copy.contactPhone2 = [self.contactPhone2 copyWithZone:zone];
        copy.soundRecordingPath = [self.soundRecordingPath copyWithZone:zone];
        copy.equipmentNum = [self.equipmentNum copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.lastUpdateDate = [self.lastUpdateDate copyWithZone:zone];
        copy.contactName2 = [self.contactName2 copyWithZone:zone];
        copy.uuid = [self.uuid copyWithZone:zone];
        copy.updateId = self.updateId;
        copy.unitTelephone = [self.unitTelephone copyWithZone:zone];
        copy.lastLoginIp = [self.lastLoginIp copyWithZone:zone];
        copy.creditCardNo = [self.creditCardNo copyWithZone:zone];
        copy.registerPlatformSource = [self.registerPlatformSource copyWithZone:zone];
        copy.contactRelationship = [self.contactRelationship copyWithZone:zone];
        copy.debitCardNo = [self.debitCardNo copyWithZone:zone];
        copy.identityId = [self.identityId copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.creditLine = self.creditLine;
        copy.lastLoginDate = [self.lastLoginDate copyWithZone:zone];
        copy.isValid = [self.isValid copyWithZone:zone];
        copy.createDate = [self.createDate copyWithZone:zone];
        copy.phontNum = [self.phontNum copyWithZone:zone];
        copy.platformSource = [self.platformSource copyWithZone:zone];
        copy.contactPhone = [self.contactPhone copyWithZone:zone];
        copy.debitBankName = [self.debitBankName copyWithZone:zone];
        copy.creditBankName = [self.creditBankName copyWithZone:zone];
        copy.unitAddress = [self.unitAddress copyWithZone:zone];
        copy.identityCounterPath = [self.identityCounterPath copyWithZone:zone];
        copy.contactRelationship2 = [self.contactRelationship2 copyWithZone:zone];
        copy.career = [self.career copyWithZone:zone];
        copy.clientId = [self.clientId copyWithZone:zone];
        copy.degree = [self.degree copyWithZone:zone];
        copy.bankNo = [self.bankNo copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.contactName = [self.contactName copyWithZone:zone];
        copy.identityPositivePath = [self.identityPositivePath copyWithZone:zone];
        copy.creditLev = [self.creditLev copyWithZone:zone];
    }
    
    return copy;
}


@end
