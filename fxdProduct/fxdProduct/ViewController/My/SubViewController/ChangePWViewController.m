//
//  ChangePWViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/27.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "ChangePWViewController.h"
#import "ReturnMsgBaseClass.h"
#import "LoginViewController.h"
#import "BaseNavigationViewController.h"
#import "ChangePasswordViewModel.h"
@interface ChangePWViewController ()<UITextFieldDelegate>
{
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    ReturnMsgBaseClass *_codeParse;
    ReturnMsgBaseClass *_changeParse;
}



@property (strong, nonatomic) IBOutlet UIButton *sendCodeBtn;

@property (strong, nonatomic) IBOutlet UITextField *surePassField;


@end

@implementation ChangePWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _countdown = 60;
    self.phoneNumField.text = [Utility sharedUtility].userInfo.userName;
    self.phoneNumField.enabled = NO;
    [Tool setCorner:self.changeBtn borderColor:UI_MAIN_COLOR];
    self.navigationItem.title = @"更改密码";
    [self addBackItem];
}


- (IBAction)snsCodeCountdownBtnClick:(UIButton *)sender {
    self.sendCodeBtn.userInteractionEnabled = NO;
    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
    
    
    ChangePasswordViewModel *changePasswordViewModel = [[ChangePasswordViewModel alloc]init];
    [changePasswordViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        _codeParse = [ReturnMsgBaseClass modelObjectWithDictionary:returnValue];
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
        DLog(@"---%@",_codeParse.msg);
        
    } WithFaileBlock:^{
        
    }];
    [changePasswordViewModel changePasswordSendSMS];
    
//    NSDictionary *parDic = [self getDicOfParam];
//    if (parDic) {
//        
//        [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getCode_url] parameters:parDic finished:^(EnumServerStatus status, id object) {
//            _codeParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
//            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
//            DLog(@"%d,%@",status,object);
//            DLog(@"---%@",_codeParse.msg);
//        } failure:^(EnumServerStatus status, id object) {
//            
//        }];
//    }
}


- (void)closeGetVerifyButtonUser
{
    _countdown = _countdown-1;
    self.sendCodeBtn.userInteractionEnabled = NO;
    self.sendCodeBtn.alpha = 0.4;
    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        self.sendCodeBtn.userInteractionEnabled = YES;
        [self.sendCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.sendCodeBtn.alpha = 1.0;
        _countdown = 60;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}


////获取验证码参数
//- (NSDictionary *)getDicOfParam
//{
//    return @{@"token":[Utility sharedUtility].userInfo.tokenStr,
//             @"phone":[Utility sharedUtility].userInfo.userName,
//             @"type":CODE_CHANGEPASS,
//             };
//}

- (IBAction)changeCommit:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (![self.codeField.text isEqualToString:@""] && ![self.passwordField.text isEqualToString:@""] && ![self.surePassField.text isEqualToString:@""]) {
        if ([self.passwordField.text isEqualToString:self.surePassField.text]) {
            if (self.passwordField.text.length >= 6 && self.passwordField.text.length <= 16) {
                
                ChangePasswordViewModel *changePasswordViewModel = [[ChangePasswordViewModel alloc]init];
                [changePasswordViewModel setBlockWithReturnBlock:^(id returnValue) {
                    
                    _changeParse = [ReturnMsgBaseClass modelObjectWithDictionary:returnValue];
                    if ([_changeParse.flag isEqualToString:@"0001"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_changeParse.msg];
                    }
                    if ([_changeParse.flag isEqualToString:@"0000"]) {
                        [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeSuccess title:@"修改成功" detail:@"密码修改成功,请使用新密码登录!" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                            if (index == 1) {
                                LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                                BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
                                [self presentViewController:nav animated:YES completion:^{
                                    
                                }];
                            }
                        }];
                    }
                    
                } WithFaileBlock:^{
                    
                }];
                [changePasswordViewModel updatePasswordSmscode:self.codeField.text Password:self.passwordField.text];
                
//                NSDictionary *paramDic = [self getChangeParam];
//                if (paramDic) {
//                    
//                    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_CHANGEPASS_URL] parameters:paramDic finished:^(EnumServerStatus status, id object) {
//                        _changeParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
//                        if ([_changeParse.flag isEqualToString:@"0001"]) {
//                            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_changeParse.msg];
//                        }
//                        if ([_changeParse.flag isEqualToString:@"0000"]) {
//                            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeSuccess title:@"修改成功" detail:@"密码修改成功,请使用新密码登录!" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
//                                if (index == 1) {
//                                    LoginViewController *loginView = [LoginViewController new];
//                                    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
//                                    [self presentViewController:nav animated:YES completion:^{
//                                        
//                                    }];
//                                }
//                            }];
//                        }
//                    } failure:^(EnumServerStatus status, id object) {
//                        
//                    }];
//                }
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位之间"];
            }
            
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请确认两次密码输入一致"];
        }
    }else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请完整填写信息"];
    }
}

//- (NSDictionary *)getChangeParam
//{
//    if (![self.passwordField.text isEqualToString:@""] && ![self.codeField.text isEqualToString:@""]) {
//        return @{@"token":[Utility sharedUtility].userInfo.tokenStr,
//                 @"smscode":self.codeField.text,
//                 @"password":self.passwordField.text};
//    }
//    return nil;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)seeText:(UIButton *)sender {
    self.passwordField.secureTextEntry = !self.passwordField.secureTextEntry;
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
    if (textField.tag == 101) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>16) {
            return NO;
        }
        return [self validateTelPhoneNumber:string];
    }
    if (textField.tag == 103) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>16) {
            return NO;
        }
        return [self validateTelPhoneNumber:string];
    }
    
    if (textField.tag == 100) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>6) {
            return NO;
        }
    }
    return YES;
}

//判断方法手机服务密码
- (BOOL)validateTelPhoneNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
