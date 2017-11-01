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
//提款按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
//放款时间
@property (weak, nonatomic) IBOutlet UILabel *lableData;
//借款周期标题
@property (weak, nonatomic) IBOutlet UILabel *loanTimeTitle;
//每周还款标题
@property (weak, nonatomic) IBOutlet UILabel *payMoneyTitle;
//协议View
@property (weak, nonatomic) IBOutlet UIView *agreeMentView;

@property (nonatomic, strong) YYLabel *agreeMentLabel;

@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet UIView *repayBtnView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIImageView *moneyImage;
//提示label
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
//急速贷还款金额
@property (weak, nonatomic) IBOutlet UILabel *repayMoneyLabel;
//急速贷还款时间
@property (weak, nonatomic) IBOutlet UILabel *repayMoneyTime;
//急速贷View
@property (weak, nonatomic) IBOutlet UIView *repayView;
//借款金额标题
@property (weak, nonatomic) IBOutlet UILabel *loanTitleLabel;
//续期按钮
@property (weak, nonatomic) IBOutlet UIButton *stagingBtn;
//逾期费用
@property (weak, nonatomic) IBOutlet UILabel *overdueFeeLabel;
//协议的复选框
@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
//续期View
@property (weak, nonatomic) IBOutlet UIView *stagingView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (weak, nonatomic) IBOutlet UIView *statusBottomView;
//合规协议按钮
@property (weak, nonatomic) IBOutlet UIButton *heguiBtn;
@property (weak, nonatomic) IBOutlet UIView *stagingBgView;

@end
