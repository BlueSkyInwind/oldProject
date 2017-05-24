//
//  LoginParamModel.h
//  fxdProduct
//
//  Created by admin on 2017/5/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginParamModel : JSONModel


@property (strong , nonatomic)NSString *mobile_phone_;
@property (strong , nonatomic)NSString *password_;
@property (strong , nonatomic)NSString *last_login_device_;
@property (strong , nonatomic)NSString *app_version_;
@property (strong , nonatomic)NSString *last_login_from_;
@property (strong , nonatomic)NSString *last_login_ip_;
@property (strong , nonatomic)NSString *platform_type_;
@property (strong , nonatomic)NSString<Optional> *BSFIT_DEVICEID;
@property (strong , nonatomic)NSString<Optional> * verify_code_;



@end
