//
//  CustomerContactsInfoViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CustomerContactsInfoViewModel.h"
#import "CustomerContactsInfoParam.h"

@implementation CustomerContactsInfoViewModel


/**
 保存用户的联系人

 @param relationship_ 第一个联系人
 @param contact_name_ 第一个联系人姓名
 @param contact_phone_ 第一个联系人手机号
 @param relationship1_ 第二个联系人
 @param contact_name1_ 第二个联系人姓名
 @param contact_phone1_ 第二个联系人手机号
 */
-(void)saveCustomerContactsInfoRelationship:(NSString *)relationship_
                               contact_name:(NSString *)contact_name_
                              contact_phone:(NSString *)contact_phone_
                              Relationship1:(NSString *)relationship1_
                              contact_name1:(NSString *)contact_name1_
                             contact_phone1:(NSString *)contact_phone1_{
    
    CustomerContactsInfoParam * customerContactsInfoP = [[CustomerContactsInfoParam alloc]init];
    customerContactsInfoP.relationship_ = relationship_;
    customerContactsInfoP.contact_name_ = contact_name_;
    customerContactsInfoP.contact_phone_ = contact_phone_;
    customerContactsInfoP.relationship1_ = relationship1_;
    customerContactsInfoP.contact_name1_ = contact_name1_;
    customerContactsInfoP.contact_phone1_ = contact_phone1_;
    
    NSDictionary * paramDic = [customerContactsInfoP toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_customerContact_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

/**
 上传联系人

 @param array 数据
 */
-(void)uploadUserContacts:(NSArray *)array{
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *paramDic = @{@"userContactsBaseBean":jsonStr};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_saveUserContacts_jhtml] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
