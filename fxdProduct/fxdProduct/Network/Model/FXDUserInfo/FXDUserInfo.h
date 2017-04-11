//
//  FXDUserInfo.h
//  fxdProduct
//
//  Created by dd on 2016/9/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Result,User_Info,User_Contacter;
@interface FXDUserInfo : NSObject

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, copy) NSString *id_number_;

@property (nonatomic, copy) NSString *mobile_;

@property (nonatomic, copy) NSString *customer_base_id_;

@property (nonatomic, strong) Result *result;


@end
/*
 {
 "flag": "0000",
 "result": {
 "user_info": {
 "education_": "2",
 "living_county_": "445103",
 "company_name_": "你的时候你们还",
 "living_city_": "445100",
 "company_address_": "啊据统计局天津啦",
 "company_county_": "445103",
 "living_address_": "哦哦啦啦啦啦啦啦",
 "annual_earnings_": "0.00",
 "company_telephone_": "021-5566339",
 "company_city_": "445100",
 "living_province_": "440000",
 "industry_": "5",
 "user_name_": "王旭东"
 },
 "user_contacter": [
 {
 "contacter_relation_": "4",
 "if_emergency_contacter_": "1",
 "contacter_name_": "啦啦",
 "contacter_moblie_phone_": "13699008633"
 },
 {
 "contacter_relation_": "4",
 "if_emergency_contacter_": "1",
 "contacter_name_": "啦啦",
 "contacter_moblie_phone_": "13699008633"
 },
 {
 "contacter_relation_": "1",
 "if_emergency_contacter_": "1",
 "contacter_name_": "涂抹我",
 "contacter_moblie_phone_": "13800072555"
 },
 {
 "contacter_relation_": "4",
 "if_emergency_contacter_": "1",
 "contacter_name_": "啦啦",
 "contacter_moblie_phone_": "13699008633"
 },
 {
 "contacter_relation_": "1",
 "if_emergency_contacter_": "1",
 "contacter_name_": "涂抹我",
 "contacter_moblie_phone_": "13800072555"
 },
 {
 "contacter_relation_": "1",
 "if_emergency_contacter_": "1",
 "contacter_name_": "涂抹我",
 "contacter_moblie_phone_": "13800072555"
 },
 {
 "contacter_relation_": "1",
 "if_emergency_contacter_": "1",
 "contacter_name_": "涂抹我",
 "contacter_moblie_phone_": "13800072555"
 },
 {
 "contacter_relation_": "4",
 "if_emergency_contacter_": "1",
 "contacter_name_": "啦啦",
 "contacter_moblie_phone_": "13699008633"
 },
 {
 "contacter_relation_": "1",
 "if_emergency_contacter_": "1",
 "contacter_name_": "涂抹我",
 "contacter_moblie_phone_": "13800072555"
 },
 {
 "contacter_relation_": "4",
 "if_emergency_contacter_": "1",
 "contacter_name_": "啦啦",
 "contacter_moblie_phone_": "13699008633"
 }
 ],
 "id_number_": "140621199212150059",
 "mobile_": "18624381230",
 "customer_base_id_": "6ca96fadd8774514abf3c62c2e733c00"
 }
 }
 */
