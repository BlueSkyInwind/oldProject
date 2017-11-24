//
//  SaveLoanCaseParamModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SaveLoanCaseParamModel : JSONModel

/*申请件id*/
@property (nonatomic,copy)NSString *case_id_;
/*用户(10:激活; 20新用户; 30二次续贷)*/
@property (nonatomic,copy)NSString *type_;
/*前端平台来源  1、IOS 2、安卓 3、微信 4、PC 5、其他*/
@property (nonatomic,copy)NSString *client_;
/*用户描述*/
@property (nonatomic,copy)NSString *description_;
/*借款周期*/
@property (nonatomic,copy)NSString *period_;

@end
