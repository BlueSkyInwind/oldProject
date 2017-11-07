//
//  LoginView.h
//  fxdProduct
//
//  Created by admin on 2017/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>


-(void)loginCommitMoblieNumber:(NSString *)number screct:(NSString *)serect code:(NSString *)code;
-(void)snsCodeCountdownBtnClicMoblieNumber:(NSString *)number;
-(void)forgetPassMoblieNumber:(NSString *)number;
-(void)regAction;


@end


@interface LoginView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeader;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (weak, nonatomic) IBOutlet UIView *userIDView;

@property (weak, nonatomic) IBOutlet UIView *passView;

@property (weak, nonatomic) IBOutlet UIView *codeView;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;

@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UITextField *veriyCodeField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *lines;

@property (weak, nonatomic) IBOutlet UIImageView *moblieIcon;

@property (weak, nonatomic) IBOutlet UIImageView *passIcon;

@property (weak, nonatomic) IBOutlet UIImageView *smsIcon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;



@property (assign, nonatomic)id<LoginViewDelegate>delegate;

/**
 登录动画
 */
-(void)loginAnimation;
/**
 登录按钮恢复初始状态
 */
-(void)initialLoginButtonState;




@end
