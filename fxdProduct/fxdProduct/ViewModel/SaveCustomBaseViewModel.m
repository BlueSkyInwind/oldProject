//
//  SaveCustomBaseViewModel.m
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "SaveCustomBaseViewModel.h"
#import "SaveUserInfoParam.h"
@implementation SaveCustomBaseViewModel

- (void)saveCustomBaseInfoName:(NSString *)customer_name
                      ID_code_:(NSString *)id_code_
                      EduLevel:(NSString *)education_level
                  home_address:(NSString *)home_address
                      province:(NSString *)province
                          city:(NSString *)city
                        county:(NSString *)county
{
    

    
    SaveUserInfoParam * saveUserInfoP = [[SaveUserInfoParam alloc]init];
    saveUserInfoP.customer_name_ = customer_name;
    saveUserInfoP.id_code_ = id_code_;
    saveUserInfoP.education_level_ = education_level;
    saveUserInfoP.home_address_ = home_address;
    saveUserInfoP.province_ = province;
    saveUserInfoP.city_ = city;
    saveUserInfoP.county_ = county;

    NSDictionary *paramDic = [saveUserInfoP toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_saveCustomerBase_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
