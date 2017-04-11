//
//  ContactBean.h
//
//  Created by dd  on 2017/3/1
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ContactBean : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *contactBeanIdentifier;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *relationship;
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *customerBaseId;
@property (nonatomic, strong) NSString *createBy;
@property (nonatomic, strong) NSString *isDel;
@property (nonatomic, strong) NSString *isEmergencyContact;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
