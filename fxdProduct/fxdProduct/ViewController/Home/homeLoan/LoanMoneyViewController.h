//
//  LoanMoneyViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class UserStateModel,QryUserStatusModel,GetCaseInfo;

typedef NS_ENUM(NSUInteger, ApplicationStatus) {
    InLoan = 1,      //放款中
    Repayment,       //还款中
    Staging,         //续期中
    OpenAccountStatus,     //开户处理中
    Activation,      //激活处理中
    RepaymentNormal,  //正常还款
//    ComplianceInProcess,   //合规处理中
    
};

@interface LoanMoneyViewController : BaseViewController

@property (nonatomic, assign) NSInteger intStautes;

@property (nonatomic, strong) UserStateModel *userStateModel;
@property (nonatomic, strong) QryUserStatusModel *qryUserStatusModel;
@property (nonatomic, assign) BOOL popAlert;
@property (nonatomic, assign) ApplicationStatus applicationStatus;

@end
