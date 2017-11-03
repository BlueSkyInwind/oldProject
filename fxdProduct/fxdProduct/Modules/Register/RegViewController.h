//
//  RegViewController.h
//  fxdProduct
//
//  Created by dd on 15/7/31.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "BaseIndexViewController.h"

@protocol RegDelegate <NSObject>

- (void)setUserName:(NSString *)str;

@end

@interface RegViewController : BaseIndexViewController

@property (strong, nonatomic) IBOutlet UITextField *phoneNumText;

@property (strong, nonatomic) IBOutlet UITextField *passText;

@property (strong, nonatomic) IBOutlet UITextField *verCodeText;

@property (weak, nonatomic) IBOutlet UITextField *picCodeText;


@property (strong, nonatomic) IBOutlet UITextField *surePassField;

@property (strong, nonatomic) IBOutlet UILabel *agreeOnLabel;

@property (weak, nonatomic) IBOutlet UILabel *regSecoryLabel;

@property (strong, nonatomic) IBOutlet UITextField *mobileServerNumLabel;

@property (weak, nonatomic) IBOutlet UITextField *invitationText;


@property (nonatomic, weak) id <RegDelegate>delegate;

@end
