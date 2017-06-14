//
//  LoanMoneyViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class UserStateModel;

@interface LoanMoneyViewController : BaseViewController

@property (nonatomic, assign) NSInteger intStautes;

@property (nonatomic, strong) UserStateModel *userStateModel;

@property (nonatomic, assign) BOOL popAlert;


@end
