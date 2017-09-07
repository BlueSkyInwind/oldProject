//
//  LoanMoneyViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class UserStateModel,QryUserStatusModel,GetCaseInfo;



@interface LoanMoneyViewController : BaseViewController

//@property (nonatomic, assign) NSInteger intStautes;

//@property (nonatomic, strong) UserStateModel *userStateModel;
//@property (nonatomic, strong) QryUserStatusModel *qryUserStatusModel;
@property (nonatomic, assign) BOOL popAlert;
@property (nonatomic, assign) ApplicationStatus applicationStatus;

@end
