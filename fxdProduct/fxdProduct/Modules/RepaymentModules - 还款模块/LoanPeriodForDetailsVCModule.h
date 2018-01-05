//
//  LoanPeriodForDetailsVCModule.h
//  fxdProduct
//
//  Created by dd on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class RepayListInfo,P2PBillDetail;

@interface LoanPeriodForDetailsVCModule : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIButton *selectAllBtn;

@property (weak, nonatomic) IBOutlet UIView *endView;


@property (weak, nonatomic) IBOutlet UILabel *payNumberLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payNumberTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payNumberBottom;

@property (weak, nonatomic) IBOutlet UILabel *saveUpLabel;


@property (nonatomic, strong) RepayListInfo *repayListModel;

@property (nonatomic, strong) P2PBillDetail *p2pBillDetail;

@property (nonatomic,strong)NSString * platform_type;
@property (nonatomic,strong)NSString * applicationId;
@property (nonatomic,strong)NSString * product_id;

@end
