//
//  CheckViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import "UserStateModel.h"

@interface CheckViewController : BaseViewController
//状态
@property (nonatomic, assign) NSInteger homeStatues;
//loanmount
//@property (nonatomic, assign) double loanMountMoney;
@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *days;
@property (nonatomic, strong) NSString *apply_again_;
@property (nonatomic, strong) NSString *task_status;
@property (nonatomic, strong) UserStateModel *userStateModel;
@end
