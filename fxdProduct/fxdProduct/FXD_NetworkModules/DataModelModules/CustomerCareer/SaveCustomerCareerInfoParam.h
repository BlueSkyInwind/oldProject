//
//  SaveCustomerCareerInfoParam.h
//  fxdProduct
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SaveCustomerCareerInfoParam : JSONModel

@property (nonatomic, strong) NSString<Optional> *organization_name_;
@property (nonatomic, strong) NSString<Optional> *organization_telephone_;
@property (nonatomic, strong) NSString<Optional> *industry_;
@property (nonatomic, strong) NSString<Optional> *province_;
@property (nonatomic, strong) NSString<Optional> *city_;
@property (nonatomic, strong) NSString<Optional> *country_;
@property (nonatomic, strong) NSString<Optional> *product_id_;
@property (nonatomic, strong) NSString<Optional> *organization_address_;

@end
