//
//  SaveCustomBaseViewModel.h
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface SaveCustomBaseViewModel : FXD_ViewModelBaseClass


/**
 保存用户基本信息

 @param customer_name 名字
 @param id_code_ 身份证号
 @param education_level 教育水平
 @param home_address 居住详址
 @param province 省份
 @param city 城市
 @param county 县
 */
- (void)saveCustomBaseInfoName:(NSString *)customer_name
                      ID_code_:(NSString *)id_code_
                      EduLevel:(NSString *)education_level
                  home_address:(NSString *)home_address
                      province:(NSString *)province
                          city:(NSString *)city
                        county:(NSString *)county;

@end
