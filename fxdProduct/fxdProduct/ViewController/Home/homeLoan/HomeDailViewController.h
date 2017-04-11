//
//  HomeDailViewController.h
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/29.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class CustomerBaseInfoBaseClass;

@interface HomeDailViewController : BaseViewController

@property (nonatomic, strong) CustomerBaseInfoBaseClass *userBaseInfo;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, assign) CGFloat fee_rate;

@property (nonatomic, copy) NSString *first_repay_date;

@property (nonatomic, copy) NSString *loan_staging_amount;

@end
