//
//  UserDataInformationModel.h
//  fxdProduct
//
//  Created by admin on 2017/12/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ContactBeanModel <NSObject>


@end

@interface UserDataInformationModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *create_date_;
@property (nonatomic, strong) NSString<Optional> *valid_date_;
@property (nonatomic, strong) NSString<Optional> *modify_by_;
@property (nonatomic, strong) NSString<Optional> *county_name_;
@property (nonatomic, strong) NSString<Optional> *birthdate_;
@property (nonatomic, strong) NSString<Optional> *home_address_;
@property (nonatomic, assign) NSString<Optional> *sex_;
@property (nonatomic, strong) NSString<Optional> *issued_by;
@property (nonatomic, assign) NSString<Optional> *ocr_status_;
@property (nonatomic, strong) NSString<Optional> *account_base_id_;
@property (nonatomic, strong) NSString<Optional> *customer_name_;
@property (nonatomic, assign) NSString<Optional> *verifyStatus;
@property (nonatomic, strong) NSString<Optional> *id_code_;
@property (nonatomic, strong) NSString<Optional> *id_type_;
@property (nonatomic, strong) NSString<Optional> *binding_mobilephone_;
@property (nonatomic, strong) NSString<Optional> *education_level_;
@property (nonatomic, strong) NSString<Optional> *household_register_address_;
@property (nonatomic, strong) NSString<Optional> *province_name_;
@property (nonatomic, strong) NSString<Optional> *county_;
@property (nonatomic, strong) NSString<Optional> *city_;
@property (nonatomic, strong) NSString<Optional> *id_;
@property (nonatomic, strong) NSString<Optional> *province_;
@property (nonatomic, strong) NSString<Optional> *city_name_;
@property (nonatomic, strong) NSString<Optional> *nation_;
@property (nonatomic, strong) NSArray<ContactBeanModel,Optional> *contactBean;
@property (nonatomic, strong) NSString<Optional> *authenticate_status_;
@property (nonatomic, strong) NSString<Optional> *create_by_;
@property (nonatomic, strong) NSString<Optional> *modify_date_;
@property (nonatomic, strong) NSString<Optional> *service_platform_type_;


@end


@interface ContactBeanModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *id_;
@property (nonatomic, strong) NSString<Optional> *customer_base_id_;
@property (nonatomic, strong) NSString<Optional> *relationship_;
@property (nonatomic, strong) NSString<Optional> *contact_phone_;
@property (nonatomic, strong) NSString<Optional> *contact_name_;
@property (nonatomic, strong) NSString<Optional> *create_date_;
@property (nonatomic, strong) NSString<Optional> *create_by_;
@property (nonatomic, strong) NSString<Optional> *is_del_;
@property (nonatomic, strong) NSString<Optional> *is_emergency_contact_;

@end


