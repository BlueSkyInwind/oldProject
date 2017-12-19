//
//  UpdateDevIDViewController.m
//  fxdProduct
//
//  Created by dd on 15/10/13.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "UpdateDevIDViewController.h"
#import "ReturnMsgBaseClass.h"
#import "LoginViewController.h"
#import "BaseNavigationViewController.h"
#import "AppDelegate.h"
#import "DataBaseManager.h"
#import "SMSViewModel.h"
#import "LoginViewModel.h"
#import "DES3Util.h"


@interface UpdateDevIDViewController ()<UITextFieldDelegate>
{
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    ReturnMsgBaseClass *_updateParse;
    BaseResultModel *_loginResultModel;
}

@property (strong, nonatomic) IBOutlet UIView *userIDView;

@property (strong, nonatomic) IBOutlet UIView *passView;

@end

@implementation UpdateDevIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [FXD_Tool setCorner:self.userIDView borderColor:RGBColor(0, 170, 238, 1)];
    [FXD_Tool setCorner:self.passView borderColor:RGBColor(0, 170, 238, 1)];
    [FXD_Tool setCorner:self.updateBtn borderColor:UI_MAIN_COLOR];
    self.phoneNumText.text = self.phoneStr;
    self.phoneNumText.userInteractionEnabled=NO;
    _countdown = 60;
    self.navigationItem.title = @"重新验证";
    [self setNav];
    if([self.pushWayFlag isEqualToString:@"1"])
    {
        [self addBackItemTwo];
    }
    else {
        [self addBackItem];
    }
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    
    self.verCodeText.delegate = self;
    [self.verCodeText addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    
}


-(void)changeTextField:(UITextField *)textField{

    if (textField == self.verCodeText) {
        if (textField.text.length>6) {
            self.verCodeText.text = [textField.text substringToIndex:6];
        }
    }
}
- (void)addBackItemTwo
{
    if (@available(iOS 11.0, *)) {
        UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popBackTwo)];
        //initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
        self.navigationItem.leftBarButtonItem = aBarbi;
        return;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *img = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(popBackTwo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
}

- (void)popBackTwo
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (IBAction)snsCodeCountdownBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (![FXD_Tool isMobileNumber:self.phoneNumText.text]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入有效的手机号码"];
        return;
    }
    
    if (![FXD_Utility sharedUtility].networkState) {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"似乎没有连接到网络"];
        return;
    }
    
    SMSViewModel *smsViewModel = [[SMSViewModel alloc] init];
    [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultM  = returnValue;
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            self.sendCodeButton.userInteractionEnabled = NO;
            self.sendCodeButton.alpha = 0.4;
            [self.sendCodeButton setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
            _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [smsViewModel fatchRequestSMSParamPhoneNumber:self.phoneNumText.text verifyCodeType:CHANGEDEVID_CODE];
}

- (void)closeGetVerifyButtonUser
{
    _countdown -= 1;
    [self.sendCodeButton setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        self.sendCodeButton.userInteractionEnabled = YES;
        self.sendCodeButton.alpha = 1;
        [self.sendCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        _countdown = 60;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}

//确认更改点击事件
- (IBAction)submitChange:(UIButton *)sender {
    [self.view endEditing:YES];
    
    LoginViewModel * loginVM = [[LoginViewModel alloc]init];
    [loginVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * resultM = returnValue;
        if ([resultM.errCode  isEqualToString:@"0"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:_updateParse.msg];
            [self login];
        }else{
            [[FXD_AlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeTop leaveMode:HHAlertLeaveModeBottom disPlayMode:HHAlertViewModeError title:nil detail:_updateParse.msg cencelBtn:nil otherBtn:@[@"重试"] Onview:self.view];
            [[FXD_AlertViewCust sharedHHAlertView] removeAlertView];
        }
    } WithFaileBlock:^{
        
    }];
    [loginVM updateDeviceID:self.phoneNumText.text verify_code:self.verCodeText.text];
    
//    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_updateDevID_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
//        _updateParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
//        if ([_updateParse.flag isEqualToString:@"0000"]) {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:_updateParse.msg];
//            [self login];
//        } else {
//            [[FXD_AlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeTop leaveMode:HHAlertLeaveModeBottom disPlayMode:HHAlertViewModeError title:nil detail:_updateParse.msg cencelBtn:nil otherBtn:@[@"重试"] Onview:self.view];
//            [[FXD_AlertViewCust sharedHHAlertView] removeAlertView];
//        }
//    } failure:^(EnumServerStatus status, id object) {
//
//    }];
    
}
- (void)login
{
    if (![FXD_Utility sharedUtility].networkState) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"没有连接到网络"];
        return;
    }
    LoginViewModel *loginViewModel = [[LoginViewModel alloc] init];
    [loginViewModel setBlockWithReturnBlock:^(id returnValue) {
        _loginResultModel = returnValue;
        if ([_loginResultModel.errCode isEqualToString: @"0"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_loginResultModel.friendErrMsg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            });
        } else if ([_loginResultModel.errCode isEqualToString:@"5"]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[NSString stringWithFormat:@"%@",_loginResultModel.friendErrMsg]];
        }
    } WithFaileBlock:^{
        
    }];
    [loginViewModel fatchLoginMoblieNumber:self.phoneNumText.text password:self.passStr fingerPrint:nil verifyCode:nil];
}


- (NSDictionary *)getDicOfChange
{
    return @{@"mobile_phone_":self.phoneNumText.text,
             @"verify_code_":self.verCodeText.text,
             @"last_login_device_":[FXD_Utility sharedUtility].userInfo.uuidStr};
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 102) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>11) {
            return NO;
        }
    }
    
    if (textField.tag == 100) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>6) {
            return NO;
        }
    }
    return YES;
}


@end
