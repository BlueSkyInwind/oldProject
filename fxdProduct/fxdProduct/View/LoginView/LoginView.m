//
//  LoginView.m
//  fxdProduct
//
//  Created by admin on 2017/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoginView.h"
//#import "LoginViewController.h"
#import "UIImage+Color.h"

@interface LoginView (){
    
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    
}

@end

@implementation LoginView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self configureView];
}

#pragma mark - 师徒布局
-(void)configureView{
    
    _countdown = 60;
    [Tool setCorner:self.userIDView borderColor:UI_MAIN_COLOR];
    [Tool setCorner:self.passView borderColor:UI_MAIN_COLOR];
    [Tool setCorner:self.codeView borderColor:UI_MAIN_COLOR];
    [Tool setCorner:self.loginBtn borderColor:UI_MAIN_COLOR];
    self.moblieIcon.image = [[UIImage imageNamed:@"1_Signin_icon_01"] imageWithTintColor:UI_MAIN_COLOR];
    self.passIcon.image = [[UIImage imageNamed:@"1_Signin_icon_03"] imageWithTintColor:UI_MAIN_COLOR];
    self.smsIcon.image = [[UIImage imageNamed:@"1_Signin_icon_02"] imageWithTintColor:UI_MAIN_COLOR];

    for (UIImageView *imageView in _lines) {
        imageView.image = [[UIImage imageNamed:@"login_line"] imageWithTintColor:UI_MAIN_COLOR];
    }
    [self adaptive];
    
    [self.userNameField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.veriyCodeField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    
}
/**
 适配
 */
-(void)adaptive{
    if (UI_IS_IPHONE4) {
        self.headerViewHeight.constant = 300;
    }
}


/**
 限制账号、验证码位数
 */
-(void)changeTextField:(UITextField *)textField{

    if (textField == self.userNameField) {
        if (textField.text.length>11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.veriyCodeField) {
        if (textField.text.length>6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}

/**
 设置信号量
 */
- (void)setUISignal
{
    RACSignal *validUserNameSignal = [self.userNameField.rac_textSignal map:^id(NSString *value) {
        return @([Tool isMobileNumber:value]);
    }];
    
    RACSignal *validPassFieldSignal = [self.passField.rac_textSignal map:^id(NSString *value) {
        return @([self isValidPassword:value]);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUserNameSignal,validPassFieldSignal] reduce:^id(NSNumber *usernameValid ,NSNumber *passwordValid){
        return @(usernameValid.boolValue && passwordValid.boolValue);
    }];
    
    RAC(self.loginBtn,enabled) = [signUpActiveSignal map:^id(NSNumber *signupActive) {
        return signupActive;
    }];
}

- (BOOL)isValidPassword:(NSString *)passWord
{
    return passWord.length > 3;
}

/**
 登录动画
 */
-(void)loginAnimation{
    self.codeView.hidden = YES;

    [UIView animateWithDuration:1 animations:^{
        self.logoImage.alpha = 0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.logoImage.alpha = 1;
        }];
    }];
    
    self.loginBtn.alpha = 0;
    const CGFloat offset = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGPoint accountCenter = self.userIDView.center;
    CGPoint passwordCenter = self.passView.center;
    
    CGPoint startAccountCenter = CGPointMake(self.userIDView.center.x - offset, self.userIDView.center.y);
    CGPoint startPsdCenter = CGPointMake(self.passView.center.x - offset, self.passView.center.y);
    
    self.userIDView.center = startAccountCenter;
    self.passView.center = startPsdCenter;
    
    [UIView animateWithDuration: 0.5 animations: ^{
        self.userIDView.center = accountCenter;
    } completion: nil];
    
    [UIView animateWithDuration:0.5 delay:0.3 options:0 animations:^{
        self.passView.center = passwordCenter;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
            self.loginBtn.alpha = 1;
            CGPoint center = self.loginBtn.center;
            center.y -= 100;
            self.loginBtn.center = center;
            self.loginBtnTop.constant = 30;
            [self.loginBtn layoutIfNeeded];
            [self.loginBtn updateConstraints];
        } completion:nil];
    }];

}
-(void)initialLoginButtonState{
    
    self.loginBtnTop.constant = 130;
    [self.loginBtn layoutIfNeeded];
    [self.loginBtn updateConstraints];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
#pragma mark - 点击事件
- (IBAction)loginCommit:(id)sender {
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginCommitMoblieNumber:screct:code:)]) {
        [self.delegate loginCommitMoblieNumber:self.userNameField.text screct:self.passField.text code:self.veriyCodeField.text];
    }
}

- (IBAction)snsCodeCountdownBtnClick:(id)sender {
    [self endEditing:YES];
    if ([Tool isMobileNumber:self.userNameField.text]) {
        self.sendCodeButton.userInteractionEnabled = NO;
        self.sendCodeButton.alpha = 0.4;
        [self.sendCodeButton setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(snsCodeCountdownBtnClicMoblieNumber:)]) {
            [self.delegate snsCodeCountdownBtnClicMoblieNumber:self.userNameField.text];
        }
        
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"请输入有效的手机号码"];
    }

}

- (IBAction)forgetPass:(id)sender {
    
    self.passField.text = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(forgetPassMoblieNumber:)]) {
        [self.delegate forgetPassMoblieNumber:self.userNameField.text];
    }
    
}

- (IBAction)regAction:(id)sender {
    self.userNameField.text = nil;
    self.passField.text = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(regAction)]) {
        [self.delegate regAction];
    }
    
}

- (void)closeGetVerifyButtonUser
{
    _countdown = _countdown-1;
    self.sendCodeButton.userInteractionEnabled = NO;
    self.sendCodeButton.alpha = 0.4;
    [self.sendCodeButton setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        self.sendCodeButton.userInteractionEnabled = YES;
        [self.sendCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.sendCodeButton.alpha = 1.0;
        _countdown = 60;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
