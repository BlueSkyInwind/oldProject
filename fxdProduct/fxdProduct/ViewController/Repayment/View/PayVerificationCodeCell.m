//
//  PayVerificationCodeCell.m
//  fxdProduct
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "PayVerificationCodeCell.h"
#import "UnbundlingBankCardViewModel.h"
#import "SendSmsModel.h"

@interface PayVerificationCodeCell(){
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    
    NSString * _sms_seq_;
}




@end
@implementation PayVerificationCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _verfiyCodeTextField.delegate = self;
    _countdown = 60;
}

- (IBAction)cilckSendVerfiyCodeBtn:(id)sender {
    
    [self.sendVerfiyCodeBtn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
    
    [self sendVerfiyCode];
}
- (void)closeGetVerifyButtonUser
{
    _countdown = _countdown-1;
    self.sendVerfiyCodeBtn.userInteractionEnabled = NO;
    self.sendVerfiyCodeBtn.alpha = 0.4;
    [self.sendVerfiyCodeBtn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        self.sendVerfiyCodeBtn.userInteractionEnabled = YES;
        [self.sendVerfiyCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        self.sendVerfiyCodeBtn.alpha = 1.0;
        _countdown = 60;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}
-(void)sendVerfiyCode{
    
    UnbundlingBankCardViewModel *unbundlingBankCardViewModel = [[UnbundlingBankCardViewModel alloc]init];
    [unbundlingBankCardViewModel setBlockWithReturnBlock:^(id returnValue) {
        SendSmsModel *sendSmsModel = [SendSmsModel yy_modelWithJSON:returnValue];
        if ([sendSmsModel.result.appcode isEqualToString:@"1"]) {
            _sms_seq_ = sendSmsModel.result.sms_seq_;
            [[MBPAlertView sharedMBPTextView] showTextOnly:self message:sendSmsModel.result.appmsg];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self message:sendSmsModel.result.appmsg];
        }
    } WithFaileBlock:^{
        [[MBPAlertView sharedMBPTextView] showTextOnly:self message:@"网络请求失败"];
    }];
    [unbundlingBankCardViewModel sendSmsSHServiceBankNo:_cardNum BusiType:@"recharge" SmsType:nil Mobile:_phoneNum];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString * str = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str.length != 0) {
        if (self.userVerfiyCode) {
            self.userVerfiyCode(textField.text,_sms_seq_);
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
