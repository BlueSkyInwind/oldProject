//
//  CheckViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "UserStateModel.h"
#import "QryUserStatusModel.h"
#import "GetCaseInfo.h"



@interface CheckViewController : BaseViewController
//状态
@property (nonatomic, strong) NSString *task_status;
@property (nonatomic, strong) UserStateModel *userStateModel;
@property (nonatomic, assign)BOOL isSecondFailed;
@property (nonatomic, strong)NSString * product_id;
//@property (nonatomic, strong) QryUserStatusModel *qryUserStatusModel;
//@property (nonatomic, strong) GetCaseInfo *caseInfo;
@end
