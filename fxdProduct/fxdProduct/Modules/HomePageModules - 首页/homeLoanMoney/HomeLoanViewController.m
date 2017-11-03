//
//  HomeLoanViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeLoanViewController.h"
#import "HomeKnowViewController.h"
#import "HomeIDCardViewController.h"

@interface HomeLoanViewController ()<UITextFieldDelegate>
{
    NSInteger week;
}
@end

@implementation HomeLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我要借款";
    [self addBackItem];
    
    self.moneyTextField.text = _totalMoney;
    
    if (_weekSel) {
        [_switchThird setOn:YES];
        [_switchFirth setOn:NO];
        week = 30;
    }else{
        [_switchThird setOn:NO];
        [_switchFirth setOn:YES];
        week = 50;
    }
    self.labelWeek.text = [NSString stringWithFormat:@"%.2f",[_totalMoney floatValue]/week +[_totalMoney floatValue]*0.021];
    self.labelTotalMoney.text =[NSString stringWithFormat:@"%.2f",([_totalMoney floatValue]/week +[_totalMoney floatValue]*0.021)*week];
    [_moneyTextField addTarget:self action:@selector(textfleldClik) forControlEvents:UIControlEventEditingChanged];
}

//-(BOOL)makeSureStatuse{
//    if ([_moneyTextField.text floatValue] <500 || [_moneyTextField.text floatValue] >3000) {
//        return NO;
//    }
//    if (_switchFirth.on && _switchThird.on) {
//        return NO;
//    }
//
//    return YES;
//}

#pragma ->UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *string1=[NSString stringWithFormat:@"%@%@",textField.text,string];
    if ([string1 length] == 1) {
        return [self validateNumber0:string];
    }
    if ([string1 length]>4) {
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    _moneyTextField.text = textField.text;
    return YES;
}

//判断第一位不为0
- (BOOL)validateNumber0:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
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

#pragma  ->button Action
-(void)textfleldClik{
//    _totalMoney= _moneyTextField.text;
    self.labelWeek.text = [NSString stringWithFormat:@"%.2f",[_moneyTextField.text floatValue]/week +[_moneyTextField.text floatValue]*0.021];
    _labelTotalMoney.text = [NSString stringWithFormat:@"%.2f",([_moneyTextField.text floatValue]/week +[_moneyTextField.text floatValue]*0.021)*week];
}

- (IBAction)sureBtn:(id)sender {
    if ([_moneyTextField.text floatValue] <500 || [_moneyTextField.text floatValue] >3000) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入贷款金额在5百~3千之间"];
    }else{
        [self setParamDic];
        HomeIDCardViewController *HIDcardVC = [HomeIDCardViewController new];
        [self.navigationController pushViewController:HIDcardVC animated:YES];
    }
}

- (void)setParamDic
{
    NSDictionary *dic = @{@"token":[Utility sharedUtility].userInfo.tokenStr,
                          @"applyAmount":_moneyTextField.text,
                          @"periods":[NSString stringWithFormat:@"%ld",week]};
    [[Utility sharedUtility].getMoneyParam addEntriesFromDictionary:dic];
}

- (IBAction)BtnIdea:(id)sender {
    HomeKnowViewController *homeVC = [HomeKnowViewController new];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)switchThird:(id)sender {
    if (_switchThird.on) {
        [_switchThird setOn:YES];
        [_switchFirth setOn:NO];
        week = 30;
    }else{
        [_switchThird setOn:NO];
        [_switchFirth setOn:YES];
        week = 50;
    }
    self.labelWeek.text = [NSString stringWithFormat:@"%.2f",[_moneyTextField.text floatValue]/week +[_moneyTextField.text floatValue]*0.021];
    self.labelTotalMoney.text =[NSString stringWithFormat:@"%.2f",([_moneyTextField.text floatValue]/week +[_moneyTextField.text floatValue]*0.021)*week];
}

- (IBAction)switchFirth:(id)sender {
    if (_switchFirth.on) {
        [_switchThird setOn:NO];
        [_switchFirth setOn:YES];
        week = 50;
    }else{
        [_switchThird setOn:YES];
        [_switchFirth setOn:NO];
        week = 30;
    }
    self.labelWeek.text = [NSString stringWithFormat:@"%.2f",[_moneyTextField.text floatValue]/week +[_moneyTextField.text floatValue]*0.021];
    self.labelTotalMoney.text =[NSString stringWithFormat:@"%.2f",([_moneyTextField.text floatValue]/week +[_moneyTextField.text floatValue]*0.021)*week];
}

//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([Utility sharedUtility].getMoneyParam == nil) {
        [Utility sharedUtility].getMoneyParam = [NSMutableDictionary dictionary];
    } else {
        [[Utility sharedUtility].getMoneyParam removeAllObjects];
    }
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
