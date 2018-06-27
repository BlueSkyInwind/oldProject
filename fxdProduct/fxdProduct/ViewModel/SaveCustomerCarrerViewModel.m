//
//  SaveCustomerCarrerViewModel.m
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "SaveCustomerCarrerViewModel.h"
#import "SaveCustomerCareerInfoParam.h"

@implementation SaveCustomerCarrerViewModel

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
                  product_id:(NSString *)product_id_
{
    SaveCustomerCareerInfoParam * saveCustomerCareerInfoP = [[SaveCustomerCareerInfoParam alloc]init];
    
    saveCustomerCareerInfoP.organization_name_ = organization_name_;
    saveCustomerCareerInfoP.organization_telephone_ = organization_telephone_;
    saveCustomerCareerInfoP.industry_ = industry_;
    saveCustomerCareerInfoP.province_ = province_;
    saveCustomerCareerInfoP.city_ = city_;
    saveCustomerCareerInfoP.country_ = country_;
    saveCustomerCareerInfoP.organization_address_ = organization_address_;
    saveCustomerCareerInfoP.product_id_ = product_id_;
    NSDictionary * paramDic = [saveCustomerCareerInfoP toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_saveCustomerCarrer_jhtml] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseResultM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

@end
