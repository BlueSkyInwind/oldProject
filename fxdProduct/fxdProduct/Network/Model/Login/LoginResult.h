//
//  LoginResult.h
//
//  Created by dd  on 16/3/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *company;
@property (nonatomic, assign) double integral;
@property (nonatomic, assign) double resultIdentifier;
@property (nonatomic, strong) NSString *holdIdentityPhonePath;
@property (nonatomic, strong) NSString *creditBankNo;
@property (nonatomic, strong) NSString *headPortraitPath;
@property (nonatomic, strong) NSString *contactPhone2;
@property (nonatomic, strong) NSString *soundRecordingPath;
@property (nonatomic, strong) NSString *equipmentNum;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *lastUpdateDate;
@property (nonatomic, strong) NSString *contactName2;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, assign) double updateId;
@property (nonatomic, strong) NSString *unitTelephone;
@property (nonatomic, strong) NSString *lastLoginIp;
@property (nonatomic, strong) NSString *creditCardNo;
@property (nonatomic, strong) NSString *registerPlatformSource;
@property (nonatomic, strong) NSString *contactRelationship;
@property (nonatomic, strong) NSString *debitCardNo;
@property (nonatomic, strong) NSString *identityId;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double creditLine;
@property (nonatomic, strong) NSString *lastLoginDate;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *phontNum;
@property (nonatomic, strong) NSString *platformSource;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *debitBankName;
@property (nonatomic, strong) NSString *creditBankName;
@property (nonatomic, strong) NSString *unitAddress;
@property (nonatomic, strong) NSString *identityCounterPath;
@property (nonatomic, strong) NSString *contactRelationship2;
@property (nonatomic, strong) NSString *career;
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *degree;
@property (nonatomic, strong) NSString *bankNo;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *identityPositivePath;
@property (nonatomic, strong) NSString *creditLev;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
