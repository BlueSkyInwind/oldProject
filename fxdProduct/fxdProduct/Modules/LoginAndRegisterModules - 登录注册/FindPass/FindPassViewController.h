//
//  FindPassViewController.h
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "BaseIndexViewController.h"

@interface FindPassViewController : BaseViewController
//手机号码控件
@property (strong, nonatomic) IBOutlet UITextField *phoneNumField;
//验证码控件
@property (strong, nonatomic) IBOutlet UITextField *codeField;
//密码控件
@property (strong, nonatomic) IBOutlet UITextField *passField;
//验证码按钮
@property (strong, nonatomic) IBOutlet UIButton *sendCodeButton;
//手机号
@property (strong, nonatomic) NSString *telText;
//更改密码按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end
