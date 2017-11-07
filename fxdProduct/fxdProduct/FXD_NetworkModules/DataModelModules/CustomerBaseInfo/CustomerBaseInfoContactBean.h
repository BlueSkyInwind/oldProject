//
//  CustomerBaseInfoContactBean.h
//
//  Created by dd  on 16/4/11
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CustomerBaseInfoContactBean : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *contactBeanIdentifier;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *relationship;
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *customerBaseId;
@property (nonatomic, strong) NSString *caseInfoId;
@property (nonatomic, strong) NSString *isDel;
@property (nonatomic, strong) NSString *isEmergencyContact;
@property (nonatomic, strong) NSString *createBy;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
