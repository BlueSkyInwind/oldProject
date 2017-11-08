//
//  RegViewController.m
//  fxdProduct
//
//  Created by dd on 15/7/31.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "RegViewController.h"
#import "ReturnMsgBaseClass.h"
#import "LoginViewController.h"
#import "SMSViewModel.h"
#import "LoginViewModel.h"
#import "LoginMsgBaseClass.h"
#import "DataBaseManager.h"
#import "DES3Util.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "FMDeviceManager.h"
#import "UIImage+Color.h"
#import "RegViewModel.h"
#import "FXDWebViewController.h"
@interface RegViewController ()<UITextFieldDelegate>

{
    //
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    ReturnMsgBaseClass *_codeParse;
    ReturnMsgBaseClass *_regParse;
    LoginMsgBaseClass *_loginParse;
    
    NSString *_currendId;
    NSString *_oldId;
    NSString *_pic_verify_url;
}

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *fieldView;

@property (strong, nonatomic) IBOutlet UIButton *agreeBtn;

@property (nonatomic, assign) BOOL btnStatus;

@property (weak, nonatomic) IBOutlet UIButton *picCodeBtn;

@property (strong, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (strong, nonatomic) IBOutlet UIButton *regSubmitBtn;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *moblieIcon;

@property (weak, nonatomic) IBOutlet UIImageView *picICodeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *smsIcon;
@property (weak, nonatomic) IBOutlet UIImageView *passIcon;
@property (weak, nonatomic) IBOutlet UIImageView *invIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *regBtnTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *regBtnHeightConstraint;

@end

@implementation RegViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _btnStatus = NO;
    [self setNav];
    [self addBackItem];
    for (UIView *view in self.fieldView) {
        [FXD_Tool setCorner:view borderColor:UI_MAIN_COLOR];
    }
    [FXD_Tool setCorner:self.regSubmitBtn borderColor:UI_MAIN_COLOR];
    _countdown = 60;
    self.navigationItem.title = @"注册";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
    for (UIImageView *imageView in _lineView) {
        imageView.image = [[UIImage imageNamed:@"login_line"] imageWithTintColor:UI_MAIN_COLOR];
    }
    self.moblieIcon.image = [[UIImage imageNamed:@"1_Signin_icon_01"] imageWithTintColor:UI_MAIN_COLOR];
    self.picICodeIcon.image = [[UIImage imageNamed:@"1_Signin_icon_02"] imageWithTintColor:UI_MAIN_COLOR];
    self.smsIcon.image = [[UIImage imageNamed:@"1_Signin_icon_02"] imageWithTintColor:UI_MAIN_COLOR];
    self.passIcon.image = [[UIImage imageNamed:@"1_Signin_icon_03"] imageWithTintColor:UI_MAIN_COLOR];
    self.invIcon.image = [[UIImage imageNamed:@"1_Signin_icon_07"] imageWithTintColor:UI_MAIN_COLOR];
    
    self.verCodeText.delegate = self;
    [self.verCodeText addTarget:self action:@selector(changTextField:) forControlEvents:UIControlEventEditingChanged];
    self.phoneNumText.delegate = self;
    [self.phoneNumText addTarget:self action:@selector(changTextField:) forControlEvents:UIControlEventEditingChanged];
    
    [self setPicVerifyCode];
    [self setLabel];
    [self setUISignal];
    
    if (UI_IS_IPHONEX) {
        self.headerViewHeader.constant = 95;
    }
    
}

#pragma mark 限制手机号，验证码位数
-(void)changTextField:(UITextField *)textField{

    if (textField == self.verCodeText) {
        if (textField.text.length>6) {
            self.verCodeText.text = [textField.text substringToIndex:6];
        }
    }
    if (textField == self.phoneNumText) {
        if (textField.text.length>11) {
            self.phoneNumText.text = [textField.text substringToIndex:11];
        }
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:NSStringFromClass([self class])];
    [super viewWillDisappear:animated];
    [_countdownTimer invalidate];
}

/**
 *  @author dd, 16-01-21 13:01:3
 *
 *  设置注册协议Label相关属性
 */
- (void)setLabel
{
    NSMutableAttributedString *att1=[[NSMutableAttributedString alloc] initWithString:self.agreeOnLabel.text];
    [att1 addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(0, self.agreeOnLabel.text.length)];
    self.agreeOnLabel.attributedText = att1;
    
    NSMutableAttributedString *att2=[[NSMutableAttributedString alloc] initWithString:self.regSecoryLabel.text];
    [att2 addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(0, self.regSecoryLabel.text.length)];
    self.regSecoryLabel.attributedText=att2;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickurl:)];
    self.agreeOnLabel.userInteractionEnabled=YES;
    [self.agreeOnLabel addGestureRecognizer:tapRecognizer];
    
    UITapGestureRecognizer *tapSecory = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicksecry)];
    self.regSecoryLabel.userInteractionEnabled=YES;
    [self.regSecoryLabel addGestureRecognizer:tapSecory];
}

#pragma mark 检查手机号
-(BOOL)checkMoblieNumber:(NSString *)number{
    
    NSString * numStr = @"^\\d{5,11}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numStr];
    
    if ([regextestmobile evaluateWithObject:number] == YES) {
        NSLog(@"sucess %@",number);
        return YES;
    }else{
        NSLog(@"false %@",number);
        return NO;
    }
}
/**
 *  @author dd, 16-01-21 13:01:21
 *
 *  设置UI信号
 */
- (void)setUISignal
{
    RACSignal *validUserNameSignal = [self.phoneNumText.rac_textSignal map:^id(NSString *value) {
//        return @([Tool isMobileNumber:value]);
        return @([self checkMoblieNumber:value]);
    }];
    
    RACSignal *validPicTextSignal = [self.picCodeText.rac_textSignal map:^id(NSString *value) {
        return @(value.length == 4);
    }];
    
    RACSignal *validSendCodeSignal = [RACSignal combineLatest:@[validUserNameSignal,validPicTextSignal] reduce:^id(NSNumber *usernameValid, NSNumber *picCodeValid){
        return @(usernameValid.boolValue && picCodeValid.boolValue);
    }];
    
    @weakify(self)
    RAC(self.sendCodeButton,enabled) = [validSendCodeSignal map:^id(NSNumber *sendCodeBtnActive) {
        @strongify(self)
        if (!sendCodeBtnActive.boolValue) {
            if (!self.sendCodeButton.userInteractionEnabled) {
                self.sendCodeButton.alpha = 0.4;
            }
        } else {
            if (self.sendCodeButton.userInteractionEnabled) {
                self.sendCodeButton.alpha = 1.0;
            }
        }
        return sendCodeBtnActive;
    }];
    
    RACSignal *validVerCodeSignal = [self.verCodeText.rac_textSignal map:^id(NSString *value) {
        return @(value.length >3);
    }];
    
    RACSignal *validPassWordSignal = [self.passText.rac_textSignal map:^id(NSString *value) {
        return @(value.length > 5);
    }];
    
    RACSignal *validRegActive = [RACSignal combineLatest:@[validUserNameSignal,validVerCodeSignal,validPassWordSignal] reduce:^id(NSNumber *userNameValid,NSNumber *verCodeValid,NSNumber *passValid){
        return @(userNameValid.boolValue && verCodeValid.boolValue && passValid.boolValue);
    }];
    
    RAC(self.regSubmitBtn,enabled) = [validRegActive map:^id(NSNumber *regActive) {
        return regActive;
    }];
}

#pragma mark 点击注册协议
-(void)clickurl:(id)sender
{
    DLog(@"注册协议");
    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = [NSString stringWithFormat:@"%@%@?title=%@&type=%@",_H5_url,_loanDetial_url,@"register",@"1"];
    [self.navigationController pushViewController:webVC animated:true];

}

#pragma mark 点击意思保密协议
-(void)clicksecry{
    
    DLog(@"隐私保密协议");
    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = [NSString stringWithFormat:@"%@%@?title=%@&type=%@",_H5_url,_loanDetial_url,@"secrecy",@"2"];
    [self.navigationController pushViewController:webVC animated:true];

}

#pragma mark 点击验证码按钮
- (IBAction)snsCodeCountdownBtnClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    [self setVerifyCode];
}


- (void)setSMSBtnInvalid
{
    self.sendCodeButton.userInteractionEnabled = NO;
    self.sendCodeButton.alpha = 0.4;
    [self.sendCodeButton setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
}

#pragma mark 验证码倒计时
- (void)closeGetVerifyButtonUser
{
    _countdown -= 1;
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

#pragma mark - 获取图片验证码
- (IBAction)picBtnClick:(UIButton *)sender {
    [self setPicVerifyCode];
}

#pragma mark 协议复选框按钮
- (IBAction)agreeBtnClick:(UIButton *)sender {
    if (!self.btnStatus) {
        [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"tricked"] forState:UIControlStateNormal];
    } else {
        [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
    }
    self.btnStatus = !self.btnStatus;
}
#pragma mark - 数据请求

- (void)setPicVerifyCode
{
    SMSViewModel *smsViewModel = [[SMSViewModel alloc]init];
    [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
        DLog(@"%@",returnValue);
        DLog(@"%@ --  %@",_currendId,_oldId);
        _pic_verify_url = [returnValue objectForKey:@"pic_verify_url_"];
        _oldId = _currendId;
        _currendId = [returnValue objectForKey:@"id_"];
        DLog(@"%@",[NSString stringWithFormat:@"%@%@?id_=%@&oldId_=%@",_ValidESB_url,[returnValue objectForKey:@"pic_verify_url_"],_currendId,_oldId]);
        [_picCodeBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?id_=%@&oldId_=%@",_ValidESB_url,[returnValue objectForKey:@"pic_verify_url_"],_currendId,_oldId]] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
        
    } WithFaileBlock:^{
        
    }];
    [smsViewModel postPicVerifyCode];
}

#pragma mark 点击验证码
-(void)setVerifyCode{
    
    if (![FXD_Tool isMobileNumber:self.phoneNumText.text]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入有效的手机号码"];
        return;
    }
    DLog(@"%@",_picCodeText.text);
    SMSViewModel * smsViewModel = [[SMSViewModel alloc]init];
    [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
        _codeParse = returnValue;
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
        if ([_codeParse.flag isEqualToString:@"0000"]) {
            [self setSMSBtnInvalid];
        }
        if ([_codeParse.flag isEqualToString:@"0017"]) {
            [self setPicVerifyCode];
        }
    } WithFaileBlock:^{
        
    }];
    [smsViewModel fatchRequestRegSMSParamPhoneNumber:self.phoneNumText.text picVerifyId:_currendId picVerifyCode:_picCodeText.text];
}
#pragma mark -确认注册
- (IBAction)clickReg:(UIButton *)sender {
    
    if (self.btnStatus && ![self.phoneNumText.text isEqualToString:@""] && ![self.passText.text isEqualToString:@""] && ![self.verCodeText.text isEqualToString:@""]) {
        
        if (!(self.passText.text.length<=16 && self.passText.text.length >=6)) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位之间"];
            return;
        }
        
        if (![FXD_Utility sharedUtility].networkState) {
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"似乎没有连接到网络"];
            return;
        }
        RegViewModel * regViewModel = [[RegViewModel alloc]init];
        [regViewModel setBlockWithReturnBlock:^(id returnValue) {
            
            _regParse = returnValue;
            DLog(@"%@",_regParse.msg);
            if ([_regParse.flag isEqualToString:@"0000"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_regParse.msg];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self login];
                });
            } else if ([_regParse.flag isEqualToString:@"0001"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_regParse.msg];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.delegate setUserName:self.phoneNumText.text];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_regParse.msg];
            }
        } WithFaileBlock:^{
            
        }];
        //发起请求
        [regViewModel fatchRegMoblieNumber:self.phoneNumText.text password:self.passText.text verifyCode:self.verCodeText.text invitationCode:_invitationText.text picVerifyId:_currendId picVerifyCode:_picCodeText.text];
        
    } else {
        
        if ([_phoneNumText.text length] != 11) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的手机号!"];
        }else if ([_verCodeText.text isEqualToString:@""]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码!"];
        }else if ([_passText.text length] < 6 || [_passText.text length] > 16){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入新设置密码!"];
        }else if (!self.btnStatus){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请同意协议"];
        }
    }
}


#pragma mark 登录
- (void)login
{
    if ([FXD_Utility sharedUtility].networkState == NO) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"没有连接到网络"];
        return;
    }
    
    LoginViewModel *loginViewModel = [[LoginViewModel alloc] init];
    [loginViewModel setBlockWithReturnBlock:^(id returnValue) {
        _loginParse = returnValue;
        if ([_loginParse.flag isEqualToString: @"0000"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_loginParse.msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            });
        } else {
            if ([_loginParse.flag isEqualToString:@"0005"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您当前的版本太低,为了您的使用体验请升级版本后再来体验^_^"];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"%@",_loginParse.msg]];
            }
        }
    } WithFaileBlock:^{
        
    }];
    [loginViewModel fatchLoginMoblieNumber:self.phoneNumText.text password:self.passText.text fingerPrint:nil verifyCode:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 是否隐藏密码
- (IBAction)seeText:(UIButton *)sender {
    self.passText.secureTextEntry = !self.passText.secureTextEntry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
