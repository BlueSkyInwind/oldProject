//
//  SaveUserInfoParam.h
//  fxdProduct
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface SaveUserInfoParam : JSONModel

@property(nonatomic,strong)NSString<Optional> *customer_name_;
@property(nonatomic,strong)NSString<Optional> *id_code_;
@property(nonatomic,strong)NSString<Optional> *education_level_;
@property(nonatomic,strong)NSString<Optional> *home_address_;
@property(nonatomic,strong)NSString<Optional> *province_;
@property(nonatomic,strong)NSString<Optional> *city_;
@property(nonatomic,strong)NSString<Optional> *county_;


@end
