//
//  MobilePhoneOperatorParamModel.h
//  fxdProduct
//
//  Created by admin on 2017/6/26.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MobilePhoneOperatorParamModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * mobile_phone_;
@property (nonatomic,strong)NSString<Optional> * service_password_;
@property (nonatomic,strong)NSString<Optional> * verify_code_;

@end

@interface TCMobilePhoneOperatorParamModel : JSONModel

@property (nonatomic,strong)NSString<Optional> * mobile_phone_;
@property (nonatomic,strong)NSString<Optional> * service_password_;
@property (nonatomic,strong)NSString<Optional> * smsCode;
@property (nonatomic,strong)NSString<Optional> * picCode;


@end
