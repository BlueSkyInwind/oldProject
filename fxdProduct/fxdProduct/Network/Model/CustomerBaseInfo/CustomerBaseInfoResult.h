//
//  CustomerBaseInfoResult.h
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CustomerBaseInfoResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *modifyBy;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *homeAddress;
@property (nonatomic, strong) NSString *educationLevel;
@property (nonatomic, strong) NSString *accountBaseId;
@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, strong) NSString *idCode;
@property (nonatomic, strong) NSString *idType;
@property (nonatomic, strong) NSString *bindingMobilephone;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *county;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *resultIdentifier;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *modifyDate;
@property (nonatomic, strong) NSString *createBy;
@property (nonatomic, strong) NSArray *contactBean;
@property (nonatomic, strong) NSString *authenticateStatus;
@property (nonatomic, strong) NSString *cityName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
