//
//  Result.h
//
//  Created by dd  on 2017/3/1
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Custom_BaseInfoResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *validDate;
@property (nonatomic, strong) NSString *modifyBy;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *birthdate;
@property (nonatomic, strong) NSString *homeAddress;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *issuedBy;
@property (nonatomic, assign) double ocrStatus;
@property (nonatomic, strong) NSString *accountBaseId;
@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, assign) double verifyStatus;
@property (nonatomic, strong) NSString *idCode;
@property (nonatomic, strong) NSString *idType;
@property (nonatomic, strong) NSString *bindingMobilephone;
@property (nonatomic, strong) NSString *educationLevel;
@property (nonatomic, strong) NSString *householdRegisterAddress;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *resultIdentifier;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *nation;
@property (nonatomic, strong) NSArray *contactBean;
@property (nonatomic, strong) NSString *authenticateStatus;
@property (nonatomic, strong) NSString *createBy;
@property (nonatomic, strong) NSString *modifyDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
