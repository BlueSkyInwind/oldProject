//
//  ExperienceValueGradeModel.h
//  fxdProduct
//
//  Created by sxp on 2017/12/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ExperienceValueGradeModel : JSONModel

//等级Logo
@property (nonatomic, strong)NSString<Optional> *gradeLogo;
//等级名称
@property (nonatomic, strong)NSString<Optional> * gradeName;
//手机号
@property (nonatomic, strong)NSString<Optional> *mobilePhone;
//跳转页面url
@property (nonatomic, strong)NSString<Optional> *h5_url_;

@end
