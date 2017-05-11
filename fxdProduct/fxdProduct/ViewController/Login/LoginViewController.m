//
//  LoginViewController.m
//  fxdProduct
//
//  Created by dd on 15/7/31.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseTabBarViewController.h"
#import "LoginBaseClass.h"
#import "LoginParse.h"
#import "RegViewController.h"
#import "FindPassViewController.h"
#import "UpdateDevIDViewController.h"
#import "AppDelegate.h"
#import "PCCircleViewConst.h"
#import "LoginViewModel.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "SMSViewModel.h"
#import "ReturnMsgBaseClass.h"
#import "DES3Util.h"
#import "LunchViewController.h"
#import "BSFingerSDK.h"
#import "UIImage+Color.h"

@interface LoginViewController ()<UITextFieldDelegate,HHAlertViewDelegate,BMKLocationServiceDelegate,RegDelegate,BSFingerCallBack>
{
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    LoginParse *_loginParse;
    
    BMKLocationService *_locService;
    
    ReturnMsgBaseClass *_codeParse;
    
    double _latitude;
    double _longitude;
    
    NSString *_loginFlagCode;
    NSString *_vaildCodeFlag;
    
    NSString *_BSFIT_DEVICEID;
}


@property (strong, nonatomic) IBOutlet UIImageView *logoImage;

@property (strong, nonatomic) IBOutlet UIView *userIDView;

@property (strong, nonatomic) IBOutlet UIView *passView;

@property (strong, nonatomic) IBOutlet UIView *codeView;

@property (strong, nonatomic) IBOutlet UITextField *userNameField;

@property (strong, nonatomic) IBOutlet UITextField *passField;

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnTop;

@property (strong, nonatomic) IBOutlet UITextField *veriyCodeField;

@property (strong, nonatomic) IBOutlet UIButton *sendCodeButton;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *line;

@property (weak, nonatomic) IBOutlet UIImageView *moblielcon;

@property (weak, nonatomic) IBOutlet UIImageView *passIcon;
@property (weak, nonatomic) IBOutlet UIImageView *smsIcon;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    _countdown = 60;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [Tool setCorner:self.userIDView borderColor:UI_MAIN_COLOR];
    [Tool setCorner:self.passView borderColor:UI_MAIN_COLOR];
    [Tool setCorner:self.codeView borderColor:UI_MAIN_COLOR];
    
    self.moblielcon.image = [[UIImage imageNamed:@"1_Signin_icon_01"] imageWithTintColor:UI_MAIN_COLOR];
    self.passIcon.image = [[UIImage imageNamed:@"1_Signin_icon_03"] imageWithTintColor:UI_MAIN_COLOR];
    self.smsIcon.image = [[UIImage imageNamed:@"1_Signin_icon_02"] imageWithTintColor:UI_MAIN_COLOR];
    for (UIImageView *imageView in _line) {
        imageView.image = [[UIImage imageNamed:@"login_line"] imageWithTintColor:UI_MAIN_COLOR];
    }
    _locService = [[BMKLocationService alloc] init];
    _BSFIT_DEVICEID = @"";
    _locService.delegate = self;
    [_locService startUserLocationService];
    DLog(@"%d",[LunchViewController canShowNewFeature]);
    [[BSFingerSDK sharedInstance] getFingerPrint:self withKey:@"com.hfsj.fxd"];
    [self setUISignal];
    [self setNav];
}

#pragma mark
#pragma mark -- BSFinger
- (void)generateOnSuccess:(NSString *)fingerPrint andTraceId:(NSString *)traceId
{
    DLog(@"success -> %@",fingerPrint);
    DLog(@"TraceId -> %@",traceId);
    _BSFIT_DEVICEID = fingerPrint;
}

- (void)generateOnFailed:(NSError *)error
{
    DLog(@"error -> %@",[error localizedDescription]);
}

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    self.codeView.hidden = YES;
    
//    self.logoImage.alpha = 0;
//    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.logoImage.alpha = 1;
//    } completion:nil];
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     DLog(@"%@------->disAppear",NSStringFromClass([self class]));
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _loginParse = nil;
    self.loginBtnTop.constant = 130;
    [self.loginBtn layoutIfNeeded];
    [self.loginBtn updateConstraints];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 登录
- (IBAction)loginCommit:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (_loginParse && [_loginParse.flag isEqualToString:@"0005"]) {
        if (self.veriyCodeField.text && self.veriyCodeField.text.length >= 6) {
            [self startLogin];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.veriyCodeField message:@"请输入验证码"];
        }
    } else {
        [self startLogin];
    }
}

- (void)startLogin
{
    NSDictionary *paramDic = [self getParam];
    
    if (paramDic) {
        
        LoginViewModel *loginViewModel = [[LoginViewModel alloc] init];
        [loginViewModel setBlockWithReturnBlock:^(id returnValue) {
            _loginParse = returnValue;
            if ([_loginParse.flag isEqualToString: @"0000"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_loginParse.msg];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        _vaildCodeFlag = @"";
                        ((AppDelegate *)[UIApplication sharedApplication].delegate).btb.selectedIndex = 0;
                        if ([CLLocationManager locationServicesEnabled] &&
                            ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
                             || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
                                //定位功能可用，开始定位
                                NSDictionary *paramDic = @{@"last_longitude_":[NSString stringWithFormat:@"%f",_longitude],
                                                           @"last_latitude_":[NSString stringWithFormat:@"%f",_latitude]};
                                [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_updateLoginLatitude_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
                                    DLog(@"%@",object);
                                } failure:^(EnumServerStatus status, id object) {
                                    
                                }];
                            }
                        [_locService stopUserLocationService];
                    }];
                });
                
            } else {
                if ([_loginParse.flag isEqualToString:@"0004"]) {
                    
                    [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeTop leaveMode:HHAlertLeaveModeBottom disPlayMode:HHAlertViewModeWarning title:nil detail:@"您当前尝试在新设备上登录,确定要继续?" cencelBtn:@"取消" otherBtn:@[@"确定"] Onview:self.view compleBlock:^(NSInteger index) {
                        if (index == 1) {
                            UpdateDevIDViewController *updateView = [UpdateDevIDViewController new];
                            updateView.state = Push_Dis;
                            updateView.phoneStr = self.userNameField.text;
                            updateView.passStr = self.passField.text;
                            //                                DLog(@"%@   %@",updateView.phoneStr,updateView.passStr);
                            [self.navigationController pushViewController:updateView animated:YES];
                        }
                    }];
                } else if ([_loginParse.flag isEqualToString:@"0005"]) {
                    _vaildCodeFlag = _loginParse.flag;
                    //                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您当前的版本太低,为了您的使用体验请升级版本后再来体验^_^"];
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"%@",_loginParse.msg]];
                    self.codeView.hidden = NO;
                } else {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"%@",_loginParse.msg]];
                }
            }
        } WithFaileBlock:^{
            
        }];
        [loginViewModel fatchLogin:paramDic];
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"似乎没有连接到网络"];
    }
}


#pragma mark - 获取参数

- (NSDictionary *)getParam
{
    if (_loginParse) {
        if ([_loginParse.flag isEqualToString:@"0005"] || [_vaildCodeFlag isEqualToString:@"0005"]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self getBasicParam]];
            [dic addEntriesFromDictionary:@{@"verify_code_":self.veriyCodeField.text}];
            return dic;
        } else {
            return [self getBasicParam];
        }
    } else {
        return  [self getBasicParam];
    }
}

- (NSDictionary *)getBasicParam
{
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    DLog(@"uuid ----- %@",[Utility sharedUtility].userInfo.uuidStr);
    if ([Utility sharedUtility].userInfo.clientId && ![[Utility sharedUtility].userInfo.clientId isEqualToString:@""]) {
        return @{@"mobile_phone_":self.userNameField.text,
                 @"password_":[DES3Util encrypt:self.passField.text],
                 @"last_login_device_":[Utility sharedUtility].userInfo.uuidStr,
                 @"app_version_":app_Version,
                 @"last_login_from_":PLATFORM,
                 @"last_login_ip_":[[GetUserIP sharedUserIP] getIPAddress],
                 @"platform_type_":PLATFORM,
                 @"BSFIT_DEVICEID":_BSFIT_DEVICEID
                 };
    } else {
        return @{@"mobile_phone_":self.userNameField.text,
                 @"password_":[DES3Util encrypt:self.passField.text],
                 @"last_login_device_":[Utility sharedUtility].userInfo.uuidStr,
                 @"app_version_":app_Version,
                 @"last_login_from_":PLATFORM,
                 @"last_login_ip_":[[GetUserIP sharedUserIP] getIPAddress],
                 @"platform_type_":PLATFORM,
                 @"BSFIT_DEVICEID":_BSFIT_DEVICEID
                 };
    }
}


- (IBAction)snsCodeCountdownBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([Tool isMobileNumber:self.userNameField.text]) {
        self.sendCodeButton.userInteractionEnabled = NO;
        self.sendCodeButton.alpha = 0.4;
        [self.sendCodeButton setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
        NSDictionary *parDic = [self getVerifyCodeParam];
        if (parDic) {
            SMSViewModel *smsViewModel = [[SMSViewModel alloc]init];
            [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
                _codeParse = returnValue;
                
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
                
                DLog(@"---%@",_codeParse.msg);
            } WithFaileBlock:^{
                
            }];
            [smsViewModel fatchRequestSMS:parDic];
        }
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入有效的手机号码"];
    }
}

- (NSDictionary *)getVerifyCodeParam
{
    return @{@"mobile_phone_":self.userNameField.text,
             @"flag":CODE_LOGIN,
             };
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

#pragma mark - BMKLocaltionServiceDelegate

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    DLog(@"didUpdateUserLocation lat %f,long%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _latitude = userLocation.location.coordinate.latitude;
    _longitude = userLocation.location.coordinate.longitude;
}


#pragma mark - 忘记密码

- (IBAction)forgetPass:(UIButton *)sender {
    //    self.userNameField.text = nil;
    self.passField.text = nil;
    FindPassViewController *findpassView = [FindPassViewController new];
    findpassView.telText = _userNameField.text;
    [self.navigationController pushViewController:findpassView animated:YES];
}


#pragma mark - 注册

- (IBAction)regAction:(UIButton *)sender {
    self.userNameField.text = nil;
    self.passField.text = nil;
    RegViewController *regView = [RegViewController new];
    regView.delegate = self;
    [self.navigationController pushViewController:regView animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)setUserName:(NSString *)str
{
    self.userNameField.text = str;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
