//
//  SaveCustomerCarrerViewModel.h
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface SaveCustomerCarrerViewModel : FXD_ViewModelBaseClass

/**
 保存用户职业信息
 
 @param organization_name_ 公司名
 @param organization_telephone_ 公司电话
 @param industry_ 行业
 @param province_ 省份
 @param city_ 城市
 @param country_ 县
 @param organization_address_ 详址
 @param product_id_
 */
- (void)saveCustomCarrerName:(NSString *)organization_name_
      organization_telephone:(NSString *)organization_telephone_
                    industry:(NSString *)industry_
                    province:(NSString *)province_
                        city:(NSString *)city_
                     country:(NSString *)country_
        organization_address:(NSString *)organization_address_
                  product_id:(NSString *)product_id_;

@end
