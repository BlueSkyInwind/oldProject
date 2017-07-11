//
//  PayLoanChooseController.h
//  fxdProduct
//
//  Created by dd on 2017/2/6.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class UserStateModel,RateModel;

@interface PayLoanChooseController : BaseViewController

@property (nonatomic, strong) UserStateModel *userState;

@property (nonatomic, copy) NSString *product_id;

@property (nonatomic, strong) RateModel *rateModel;

@property (nonatomic, copy) NSString *is_know;

@property (nonatomic, copy) NSString *resultcode;

@property (nonatomic, copy) NSString *rulesid;


@end
