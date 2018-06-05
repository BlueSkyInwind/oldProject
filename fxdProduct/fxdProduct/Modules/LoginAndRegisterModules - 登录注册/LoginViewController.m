//
//  LoginViewController.m
//  fxdProduct
//
//  Created by admin on 2017/5/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoginViewController.h"
#import "FXDBaseTabBarVCModule.h"
#import "RegViewController.h"
#import "FindPassViewController.h"
#import "UpdateDevIDViewController.h"
#import "AppDelegate.h"
#import "LoginViewModel.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "SMSViewModel.h"
#import "ReturnMsgBaseClass.h"
#import "DES3Util.h"
#import "LunchVCModules.h"
#import "UIImage+Color.h"
#import "LoginView.h"

@interface LoginViewController ()<UITextFieldDelegate,HHAlertViewDelegate,BMKLocationServiceDelegate,RegDelegate,LoginViewDelegate>
{
    //倒计时时间
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    BaseResultModel * _loginResultM;
    
    ReturnMsgBaseClass *_codeParse;
    
    NSString *_vaildCodeFlag;
    //设备指纹
    NSString *_BSFIT_DEVICEID;
    LoginView * _loginView;
    //用户手机号
    NSString * mobliePhone;
    //用户密码
    NSString * userPassword;
    //图片验证码
    NSString * veriyCode;
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    [self addBackItem];

    //视图加载
    _loginView =  [[NSBundle mainBundle ]loadNibNamed:@"LoginView" owner:self options:nil].lastObject;
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    DLog(@"%d",[LunchVCModules canShowNewFeature]);
    //设备指纹
    _BSFIT_DEVICEID = @"";
    
//    [self setNav];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    [_loginView loginAnimation];
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
    _loginResultM = nil;
    [_loginView initialLoginButtonState];
}
- (void)popBack
{
    [self dismissViewControllerAnimated:YES completion:^{
        _vaildCodeFlag = @"";
        ((AppDelegate *)[UIApplication sharedApplication].delegate).btb.selectedIndex = 0;
    }];
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

#pragma mark - 开始登录
- (void)startLogin
{
    LoginViewModel *loginViewModel = [[LoginViewModel alloc] init];
    [loginViewModel setBlockWithReturnBlock:^(id returnValue) {
        _loginResultM = returnValue;
        if ([_loginResultM.errCode isEqualToString: @"0"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_loginResultM.friendErrMsg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                    _vaildCodeFlag = @"";
                    [FXD_Utility sharedUtility].isObtainUserLocation = YES;
                    ((AppDelegate *)[UIApplication sharedApplication].delegate).btb.selectedIndex = 0;
                }];
            });
       } else {
            if ([_loginResultM.errCode isEqualToString:@"4"]) {
                
                [[FXD_AlertViewCust sharedHHAlertView]showFXDAlertViewTitle:nil content:@"您当前尝试在新设备上登录,确定要继续?" attributeDic:nil TextAlignment:NSTextAlignmentCenter cancelTitle:@"取消" sureTitle:@"确定" compleBlock:^(NSInteger index) {
                    if (index == 1) {
                        UpdateDevIDViewController *updateView = [UpdateDevIDViewController new];
                        updateView.state = Push_Dis;
                        updateView.phoneStr = _loginView.userNameField.text;
                        updateView.passStr = _loginView.passField.text;
                        //                                DLog(@"%@   %@",updateView.phoneStr,updateView.passStr);
                        [self.navigationController pushViewController:updateView animated:YES];
                    }
                }];
            } else if ([_loginResultM.errCode isEqualToString:@"5"]) {
                _vaildCodeFlag = _loginResultM.errCode;
                //                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您当前的版本太低,为了您的使用体验请升级版本后再来体验^_^"];
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"%@",_loginResultM.friendErrMsg]];
                _loginView.codeView.hidden = NO;
                _loginView.forgetBtnTopCons.constant = 71;
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"%@",_loginResultM.friendErrMsg]];
            }
        }
    } WithFaileBlock:^{
        
    }];
    [self postLoginRequest:loginViewModel];
 }

/**
 发起登录请求

 @param loginViewModel 请求类
 */
- (void)postLoginRequest:(LoginViewModel*)loginViewModel
{
    if (_loginResultM) {
        if ([_loginResultM.errCode isEqualToString:@"5"] || [_vaildCodeFlag isEqualToString:@"5"]) {
            [loginViewModel fatchLoginMoblieNumber:mobliePhone password:userPassword fingerPrint:_BSFIT_DEVICEID verifyCode:veriyCode];
        } else {
            [loginViewModel fatchLoginMoblieNumber:mobliePhone password:userPassword fingerPrint:_BSFIT_DEVICEID verifyCode:nil];
        }
    } else {
        [loginViewModel fatchLoginMoblieNumber:mobliePhone password:userPassword fingerPrint:_BSFIT_DEVICEID verifyCode:nil];
    }
}

#pragma mark -  LoginViewDelegate
-(void)loginCommitMoblieNumber:(NSString *)number screct:(NSString *)serect code:(NSString *)code{
    //登录信息取值
    mobliePhone = number;
    userPassword = serect;
    veriyCode = code;
    
    if (_loginResultM && [_loginResultM.errCode isEqualToString:@"5"]) {
        if (code && (![code isEqualToString:@""] ||code ==nil)) {
            [self startLogin];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入验证码"];
        }
    } else {
        [self startLogin];
    }
}

#pragma mark 获取验证码
-(void)snsCodeCountdownBtnClicMoblieNumber:(NSString *)number{
    SMSViewModel *smsViewModel = [[SMSViewModel alloc]init];
    [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseM = returnValue;
        if ([baseM.errCode isEqualToString:@"0"]) {
                 
         }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [smsViewModel fatchRequestSMSParamPhoneNumber:number verifyCodeType:LOGIN_CODE];
}

#pragma mark 忘记密码
-(void)forgetPassMoblieNumber:(NSString *)number{
    
    FindPassViewController *findpassView = [FindPassViewController new];
    findpassView.telText = number;
    [self.navigationController pushViewController:findpassView animated:YES];
    
}

#pragma mark 用户注册
-(void)regAction{
    
    RegViewController *regView = [RegViewController new];
    regView.delegate = self;
    [self.navigationController pushViewController:regView animated:YES];
    
}

- (void)setUserName:(NSString *)str
{
    _loginView.userNameField.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
