//
//  ActivationViewController.h
//  fxdProduct
//
//  Created by sxp on 17/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>

@interface ActivationViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (nonatomic,copy)NSString *carNum;
@property (nonatomic,copy)NSString *mobile;

@end
