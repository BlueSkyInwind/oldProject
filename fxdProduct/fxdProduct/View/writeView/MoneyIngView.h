//
//  MoneyIngView.h
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyIngView : UIView
//已到账
@property (weak, nonatomic) IBOutlet UILabel *labelProgress;
//描述
@property (weak, nonatomic) IBOutlet UILabel *labelDetail;
//借款金额
@property (weak, nonatomic) IBOutlet UILabel *labelLoan;
//z周期
@property (weak, nonatomic) IBOutlet UILabel *labelweek;
//周还款
@property (weak, nonatomic) IBOutlet UILabel *labelWeekmoney;
//总还款
@property (weak, nonatomic) IBOutlet UILabel *labelAllMoney;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *lableData;

@property (weak, nonatomic) IBOutlet UILabel *loanTimeTitle;

@property (weak, nonatomic) IBOutlet UILabel *payMoneyTitle;


@property (weak, nonatomic) IBOutlet UIView *agreeMentView;


@property (nonatomic, strong) YYLabel *agreeMentLabel;

@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet UIView *repayBtnView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *moneyImage;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *repayMoneyTime;
@property (weak, nonatomic) IBOutlet UIView *repayView;
@property (weak, nonatomic) IBOutlet UILabel *loanTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *stagingBtn;
@property (weak, nonatomic) IBOutlet UILabel *overdueFeeLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end
