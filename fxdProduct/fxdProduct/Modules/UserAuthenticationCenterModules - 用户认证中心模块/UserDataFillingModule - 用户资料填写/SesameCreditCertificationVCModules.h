//
//  SesameCreditCertificationVCModules.h
//  fxdProduct
//
//  Created by sxp on 17/5/4.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"

@interface SesameCreditCertificationVCModules : BaseViewController
//确认按钮
@property (weak, nonatomic) IBOutlet UIButton *immediateAuthorizationBtn;
//真是姓名
@property (weak, nonatomic) IBOutlet UITextField *realNameTextField;
//用户id
@property (weak, nonatomic) IBOutlet UITextField *userIDNumberTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeader;

@end
