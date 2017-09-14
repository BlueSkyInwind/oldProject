//
//  UserDataViewController.h
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
@class UserStateModel;

@interface UserDataViewController : BaseViewController

@property (nonatomic, copy) NSString *nextStep;

@property (nonatomic, copy) NSString *product_id;

@property (nonatomic, copy) NSString *req_loan_amt;

@property (nonatomic,assign) BOOL isMine;

@end
