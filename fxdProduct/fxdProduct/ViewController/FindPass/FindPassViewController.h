//
//  FindPassViewController.h
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "BaseIndexViewController.h"

@interface FindPassViewController : BaseIndexViewController

@property (strong, nonatomic) IBOutlet UITextField *phoneNumField;

@property (strong, nonatomic) IBOutlet UITextField *codeField;

@property (strong, nonatomic) IBOutlet UITextField *passField;

@property (strong, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (strong, nonatomic) NSString *telText;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end
