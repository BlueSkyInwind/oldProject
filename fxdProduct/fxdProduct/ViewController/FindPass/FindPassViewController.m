//
//  FindPassViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "FindPassViewController.h"
#import "ReturnMsgBaseClass.h"
#import "SMSViewModel.h"
#import "FindPassViewModel.h"
#import "DES3Util.h"

@interface FindPassViewController ()<UITextFieldDelegate>
{
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    ReturnMsgBaseClass *_codeParse;
    ReturnMsgBaseClass *_findParse;
}

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *fieldView;



@end

@implementation FindPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    for (UIView *view in self.fieldView) {
        [Tool setCorner:view borderColor:UI_MAIN_COLOR];
    }
    if (_telText) {
         _phoneNumField.text = _telText;
    }
    _countdown = 60;
    
    [Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
    
    [self.phoneNumField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.codeField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    
    [self setSome];
}



/**
 手机号、验证码位数限制
 */

-(void)changeTextField:(UITextField *)textField{


    if (textField == self.phoneNumField) {
        if (textField.text.length>11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }else if (textField == self.codeField){
    
        if (textField.text.length>6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}
- (void)setSome
{
    self.navigationItem.title = @"找回密码";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
}

- (IBAction)snsCodeCountdownBtnClick:(UIButton *)sender {
    
    if([Tool isMobileNumber:self.phoneNumField.text]) {
        if ([Utility sharedUtility].networkState) {
            self.sendCodeButton.userInteractionEnabled = NO;
            self.sendCodeButton.alpha = 0.4;
            [self.sendCodeButton setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
            _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];

                SMSViewModel *smsViewModel = [[SMSViewModel alloc] init];
                [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
                    _codeParse = returnValue;
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
                } WithFaileBlock:^{
                    
                }];
                [smsViewModel fatchRequestSMSParamPhoneNumber:self.phoneNumField.text verifyCodeType:FINDPASS_CODE];
        }
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入有效的手机号码"];
    }
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

#pragma mark - 确认找回

- (IBAction)commitClick:(UIButton *)sender {
    
    if (![self.phoneNumField.text isEqualToString:@""] && ![self.passField.text isEqualToString:@""] && ![self.codeField.text isEqualToString:@""]) {
            if (self.passField.text.length >=6 && self.passField.text.length <=16) {
                NSDictionary *regParam = [self getFindPass];
                
                FindPassViewModel *finPassViewModel = [[FindPassViewModel alloc] init];
                [finPassViewModel setBlockWithReturnBlock:^(id returnValue) {
                    _findParse = returnValue;
                    if ([_findParse.flag isEqualToString:@"0000"]) {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_findParse.msg];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_findParse.msg];
                    }
                } WithFaileBlock:^{
                    
                }];
                [finPassViewModel fatchFindPass:regParam];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位"];
            }
    } else {
        if ([_phoneNumField.text length] != 11) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的手机号!"];
        }else if ([_codeField.text isEqualToString:@""]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码!"];
        }else if ([_passField.text length] < 6 || [_passField.text length] > 16){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的新设置密码!"];
        }
    }
}

- (NSDictionary *)getFindPass
{
    return @{@"password_":[DES3Util encrypt:self.passField.text],
             @"mobile_phone_":self.phoneNumField.text,
             @"verify_code_":self.codeField.text
             };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNav];
    [self addBackItem];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)seeText:(UIButton *)sender {
    self.passField.secureTextEntry = !self.passField.secureTextEntry;
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
    
    if (textField.tag == 100) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>6) {
            return NO;
        }
    }
    
    if (textField.tag == 103) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>16) {
            return NO;
        }
        return [self validateTelPhoneNumber:string];
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
