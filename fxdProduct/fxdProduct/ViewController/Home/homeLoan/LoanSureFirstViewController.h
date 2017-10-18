//
//  LoanSureFirstViewController.h
//  fxdProduct
//
//  Created by dd on 2017/1/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class UserStateModel;
@class HomeProductList;

@interface LoanSureFirstViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *productLogo;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UILabel *specialLabel;

@property (nonatomic, copy) NSString *if_family_know;
@property (nonatomic, strong) UserStateModel *model;
@property (nonatomic, strong) HomeProductList *homeModel;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *rulesId;
@property (nonatomic, copy) NSString *resultCode;
@property (nonatomic, copy) NSString *req_loan_amt;
@property (weak, nonatomic) IBOutlet UILabel *agreementLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewTop;

@end
