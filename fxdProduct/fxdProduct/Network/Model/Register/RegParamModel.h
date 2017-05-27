//
//  RegParamModel.h
//  fxdProduct
//
//  Created by admin on 2017/5/27.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegParamModel : JSONModel

@property(strong , nonatomic)NSString *mobile_phone_;
@property(strong , nonatomic)NSString *password_;
@property(strong , nonatomic)NSString *register_from_;
@property(strong , nonatomic)NSString *verify_code_;
@property(strong , nonatomic)NSString *register_ip_;
@property(strong , nonatomic)NSString *register_device_;
@property(strong , nonatomic)NSString *pic_verify_id_;
@property(strong , nonatomic)NSString *pic_verify_code_;
@property(strong , nonatomic)NSString *invitation_code;
@property(strong , nonatomic)NSString *third_tongd_code;


@end

