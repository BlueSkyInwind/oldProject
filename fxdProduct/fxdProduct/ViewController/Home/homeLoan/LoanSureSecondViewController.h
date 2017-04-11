//
//  LoanSureSecondViewController.h
//  fxdProduct
//
//  Created by dd on 2017/1/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class UserStateModel;

@interface LoanSureSecondViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *productLogo;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;

@property (weak, nonatomic) IBOutlet UIView *passView;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *helpBtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIView *explainView;

@property (weak, nonatomic) IBOutlet UIView *smsCodeView;

@property (weak, nonatomic) IBOutlet UITextField *smsField;

@property (nonatomic, strong) UserStateModel *model;

@property (weak, nonatomic) IBOutlet UIView *TopView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopViewBottom;

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *req_loan_amt;

@end
