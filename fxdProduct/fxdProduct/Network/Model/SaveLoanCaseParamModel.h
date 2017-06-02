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

@end
