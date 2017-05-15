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
#import "RegDetailViewController.h"
#import "RegSecoryViewController.h"
#import "SMSViewModel.h"
#import "LoginViewModel.h"
#import "LoginMsgBaseClass.h"
#import "DataBaseManager.h"
#import "DES3Util.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "FMDeviceManager.h"
#import "FMDeviceManager.h"
#import "UIImage+Color.h"


@interface RegViewController ()<UITextFieldDelegate>

{
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
        [Tool setCorner:view borderColor:UI_MAIN_COLOR];
    }
    [Tool setCorner:self.regSubmitBtn borderColor:UI_MAIN_COLOR];
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
    

    [self setPicCode];
    [self setLabel];
    [self setUISignal];
}

- (void)setPicCode
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getPicCode_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        DLog(@"%@ --  %@",_currendId,_oldId);
        _pic_verify_url = [object objectForKey:@"pic_verify_url_"];
        _oldId = _currendId;
        _currendId = [object objectForKey:@"id_"];
        DLog(@"%@",[NSString stringWithFormat:@"%@%@?id_=%@&oldId_=%@",_ValidESB_url,[object objectForKey:@"pic_verify_url_"],_currendId,_oldId]);
        [_picCodeBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?id_=%@&oldId_=%@",_ValidESB_url,[object objectForKey:@"pic_verify_url_"],_currendId,_oldId]] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

/**
 *  @author dd, 16-01-21 13:01:34
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

/**
 *  @author dd, 16-01-21 13:01:21
 *
 *  设置UI信号
 */
- (void)setUISignal
{
    RACSignal *validUserNameSignal = [self.phoneNumText.rac_textSignal map:^id(NSString *value) {
        return @([Tool isMobileNumber:value]);
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
        return @(value.length >5);
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


-(void)clickurl:(id)sender
{
    RegDetailViewController *regDetail = [RegDetailViewController new];
    [self.navigationController pushViewController:regDetail animated:YES];
}

-(void)clicksecry{
    
    RegSecoryViewController *regSeVc = [RegSecoryViewController new];
    [self.navigationController pushViewController:regSeVc animated:YES];
}

- (IBAction)snsCodeCountdownBtnClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if ([Tool isMobileNumber:self.phoneNumText.text]) {
        
        DLog(@"%@",_picCodeText.text);
        NSDictionary *parDic = [self getDicOfParam];
        if (parDic) {
            [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_regCode_url] parameters:parDic finished:^(EnumServerStatus status, id object) {
                ReturnMsgBaseClass *returnModel = [ReturnMsgBaseClass modelObjectWithDictionary:object];
                _codeParse = returnModel;
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
                if ([_codeParse.flag isEqualToString:@"0000"]) {
                    [self setSMSBtnInvalid];
                }
                if ([_codeParse.flag isEqualToString:@"0017"]) {
                    [self setPicCode];
                }
                
            } failure:^(EnumServerStatus status, id object) {
                
            }];
            
            //            SMSViewModel *smsViewModel = [[SMSViewModel alloc]init];
            //            [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
            //                _codeParse = returnValue;
            //
            //                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
            //
            //                DLog(@"---%@",_codeParse.msg);
            //            } WithFaileBlock:^{
            //
            //            }];
            //            [smsViewModel fatchRequestSMS:parDic];
        }
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入有效的手机号码"];
    }
}

- (void)setSMSBtnInvalid
{
    self.sendCodeButton.userInteractionEnabled = NO;
    self.sendCodeButton.alpha = 0.4;
    [self.sendCodeButton setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
}

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

- (IBAction)picBtnClick:(UIButton *)sender {
    [self setPicCode];
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

//获取验证码参数
- (NSDictionary *)getDicOfParam
{
    return @{@"mobile_phone_":self.phoneNumText.text,
             @"flag":CODE_REG,
             @"pic_verify_id_":_currendId,
             @"pic_verify_code_":_picCodeText.text
             };
}

- (IBAction)agreeBtnClick:(UIButton *)sender {
    if (!self.btnStatus) {
        [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"tricked"] forState:UIControlStateNormal];
    } else {
        [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
    }
    self.btnStatus = !self.btnStatus;
}

#pragma mark -确认注册
- (IBAction)clickReg:(UIButton *)sender {
    
    if (self.btnStatus && ![self.phoneNumText.text isEqualToString:@""] && ![self.passText.text isEqualToString:@""] && ![self.verCodeText.text isEqualToString:@""]) {
        if (self.passText.text.length<=16 && self.passText.text.length >=6) {
            if ([Utility sharedUtility].networkState) {
                NSDictionary *regParam = [self getRegParam];
                [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_reg_url] parameters:regParam finished:^(EnumServerStatus status, id object) {
                    _regParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
                    DLog(@"%@",_regParse.msg);
                    if ([_regParse.flag isEqualToString:@"0000"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_regParse.msg];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            //                                LoginViewController *loginView = [LoginViewController new];
                            //                            [self.navigationController popViewControllerAnimated:YES];
                            //                            [self dismissViewControllerAnimated:YES completion:nil];
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
                } failure:^(EnumServerStatus status, id object) {
                    
                }];
            } else {
                [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"似乎没有连接到网络"];
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位之间"];
        }
    } else {
        if ([_phoneNumText.text length] != 11) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的手机号!"];
        }else if ([_verCodeText.text length] != 6){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码!"];
        }else if ([_passText.text length] < 6 || [_passText.text length] > 16){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入新设置密码!"];
        }
        //        else if ([_surePassField.text length] < 6 || [_surePassField.text length] > 16){
        //            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两次输入密码不同,请重试!"];
        //        }
        else if (!self.btnStatus){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请同意协议"];
        }
    }
}

- (NSDictionary *)getRegParam
{
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    NSString *blackBox = manager->getDeviceInfo();
    DLog(@"%@",blackBox);
    return @{@"password_":[DES3Util encrypt:self.passText.text],
             @"mobile_phone_":self.phoneNumText.text,
             @"register_from_":PLATFORM,
             @"verify_code_":self.verCodeText.text,
             @"register_ip_":[[GetUserIP sharedUserIP] getIPAddress],
             @"register_device_":@"",
             @"pic_verify_id_":_currendId,
             @"pic_verify_code_":_picCodeText.text,
             @"invitation_code":_invitationText.text,
             @"third_tongd_code":blackBox};
}

- (NSDictionary *)getLoginParam
{
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    DLog(@"uuid ----- %@",[Utility sharedUtility].userInfo.uuidStr);
    if ([Utility sharedUtility].userInfo.clientId && ![[Utility sharedUtility].userInfo.clientId isEqualToString:@""]) {
        return @{@"mobile_phone_":self.phoneNumText.text,
                 @"password_":[DES3Util encrypt:self.passText.text],
                 @"last_login_device_":[Utility sharedUtility].userInfo.uuidStr,
                 @"app_version_":app_Version,
                 @"last_login_from_":PLATFORM,
                 @"last_login_ip_":[[GetUserIP sharedUserIP] getIPAddress],
                 @"platform_type_":PLATFORM
                 };
    } else {
        return @{@"mobile_phone_":self.phoneNumText.text,
                 @"password_":[DES3Util encrypt:self.passText.text],
                 @"last_login_device_":[Utility sharedUtility].userInfo.uuidStr,
                 @"app_version_":app_Version,
                 @"last_login_from_":PLATFORM,
                 @"last_login_ip_":[[GetUserIP sharedUserIP] getIPAddress],
                 @"platform_type_":PLATFORM
                 };
    }
}

- (void)login
{
    if ([Utility sharedUtility].networkState) {
        NSDictionary *paramDic = [self getLoginParam];
        
        if (paramDic) {
            
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
            [loginViewModel fatchLogin:paramDic];
        }
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"似乎没有连接到网络"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)seeText:(UIButton *)sender {
    self.passText.secureTextEntry = !self.passText.secureTextEntry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
