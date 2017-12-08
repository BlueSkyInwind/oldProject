//
//  CustomerContactsInfoViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface CustomerContactsInfoViewModel : FXD_ViewModelBaseClass

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
                             contact_phone1:(NSString *)contact_phone1_;

/**
 上传联系人
 
 @param array 数据
 */
-(void)uploadUserContacts:(NSArray *)array;
@end
