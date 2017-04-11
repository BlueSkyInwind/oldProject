//
//  CustomerCareerResult.h
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CustomerCareerResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createBy;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *modifyBy;
@property (nonatomic, strong) NSString *resultIdentifier;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *organizationTelephone;
@property (nonatomic, strong) NSString *organizationAddress;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *modifyDate;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *organizationName;
@property (nonatomic, strong) NSString *customerBaseId;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *industry;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
