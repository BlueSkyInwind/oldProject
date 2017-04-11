//
//  RepayListViewController.h
//  fxdProduct
//
//  Created by dd on 16/8/31.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class UserStateModel;

@interface RepayListViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *repayTableView;


//底部视图
@property (weak, nonatomic) IBOutlet UIView *endView;

@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;

//待还金额
@property (weak, nonatomic) IBOutlet UILabel *payNumberLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payNumberTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payNumberBottom;

//节省金额
@property (weak, nonatomic) IBOutlet UILabel *saveUpLabel;


@property(strong,nonatomic) UserStateModel *userStateParse;

@end
