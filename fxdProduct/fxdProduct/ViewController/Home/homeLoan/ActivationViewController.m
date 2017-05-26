//
//  ActivationViewController.m
//  fxdProduct
//
//  Created by sxp on 17/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ActivationViewController.h"
#import "SendSmsModel.h"
#import "P2PViewController.h"
@interface ActivationViewController ()<UITextFieldDelegate>
{

    UIButton *_backTimeBtn;
    NSInteger _countdown;
    NSTimer * _countdownTimer;

}
@end

@implementation ActivationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"激活";
    [Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
    [self addBackItem];
    _countdown = 60;
    [self.sureBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    self.mobileTextField.delegate = self;
    [self.mobileTextField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    [self.codeBtn addTarget:self action:@selector(clickCode:) forControlEvents:UIControlEventTouchUpInside];
}



-(void)clickCode:(UIButton *)sender{

    _backTimeBtn = sender;
    sender.userInteractionEnabled = NO;
    sender.alpha = 0.4;
    
    [sender setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButton) userInfo:nil repeats:YES];
    [self sendSms];
}

#pragma mark 发送短信网络请求
-(void)sendSms{

    NSDictionary *paramDic = @{@"busi_type_":@"activation",@"card_number_":_carNum,@"mobile_":_mobile};
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_P2P_url,_sendSms_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        SendSmsModel *model = [SendSmsModel yy_modelWithJSON:object];
        if ([model.appcode isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.appmsg];
        }else{
        
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.appmsg];
        }
    } failure:^(EnumServerStatus status, id object) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"网络请求失败"];
    }];
}

#pragma mark 倒计时
-(void)closeGetVerifyButton
{
    _countdown -= 1;
    [_backTimeBtn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        _backTimeBtn.userInteractionEnabled = YES;
        [_backTimeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        _backTimeBtn.alpha = 1.0;
        _countdown = 60;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}


#pragma mark 限制手机位数
-(void)changeText:(UITextField *)textField{

    if (textField.text.length>11)
    {
        textField.text = [textField.text substringToIndex:11];
    }
}
#pragma mark 确认激活按钮
-(void)clickBtn{

    NSString *url = [NSString stringWithFormat:@"%@%@?mer_id_=%@&page_type=%@&ret_url=%@&user_id_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"",@"2",_bosAcctActivateRet_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    P2PViewController *p2pVC = [[P2PViewController alloc] init];
    p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.navigationController pushViewController:p2pVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
