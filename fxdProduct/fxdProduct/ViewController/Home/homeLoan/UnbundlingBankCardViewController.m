//
//  UnbundlingBankCardViewController.m
//  fxdProduct
//
//  Created by sxp on 17/5/23.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UnbundlingBankCardViewController.h"
#import "LabelCell.h"
#import "SendSmsModel.h"
#import "ChangeBankCardViewController.h"
#import "QueryCardInfo.h"
#import "UnbundlingBankCardViewModel.h"
#import "CheckViewModel.h"
@interface UnbundlingBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{

    NSString *_sms_seq;
    NSString *_sms_code;
    UIButton *_backTimeBtn;
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    
}

@end

@implementation UnbundlingBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"解绑银行卡";
    [Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
     [self addBackItem];
    _countdown = 60;
    self.bankTable.delegate = self;
    self.bankTable.dataSource = self;
    self.bankTable.separatorStyle = NO;
    [self.sureBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        
}


#pragma mark ->UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_queryCardInfo.result.UsrCardInfolist.BankId isEqualToString:@""]) {
        return 3;
    }else{
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"abcef%ld",indexPath.row]];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil] lastObject];
        }
        cell.textField.tag = indexPath.row + 100;
        cell.textField.delegate = self;
    if ([_queryCardInfo.result.UsrCardInfolist.BankId isEqualToString:@""]) {
        
      if (indexPath.row == 0) {
            [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
            cell.btn.hidden = NO;
            cell.btn.tag = indexPath.row + 200;
            cell.btnSecory.hidden = YES;
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.text = _queryCardInfo.result.UsrCardInfolist.CardId;
            cell.textField.enabled = NO;
        }else if (indexPath.row == 2){
            cell.btn.hidden = YES;
            cell.btnSecory.hidden = NO;
            cell.btnSecory.tag = 203;
            [cell.btnSecory addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            cell.textField.placeholder = @"验证码";
            cell.textField.enabled = YES;
            cell.textField.tag = 103;
            
        }else if (indexPath.row == 1){
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.btnSecory.hidden = YES;
            cell.btn.hidden = YES;
            cell.textField.placeholder = @"手机号";
            cell.textField.tag = 102;
            [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            if (_queryCardInfo.result.UsrCardInfolist.BindMobile!=nil) {
                
                cell.textField.enabled = NO;
                cell.textField.text = _queryCardInfo.result.UsrCardInfolist.BindMobile;
                _mobile = cell.textField.text;
                
            }else{
                
                cell.textField.enabled = YES;
                cell.textField.text = @"";
            }
        }
        [Tool setCorner:cell.bgView borderColor:UI_MAIN_COLOR];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
    
        if (indexPath.row == 0) {
            [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
            cell.btn.hidden = NO;
            cell.btn.tag = indexPath.row + 200;
            cell.btnSecory.hidden = YES;
            cell.textField.enabled = NO;
            cell.textField.text = [self bankName:_queryCardInfo.result.UsrCardInfolist.BankId];
            
        }else if (indexPath.row == 1) {
            [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
            cell.btn.hidden = NO;
            cell.btn.tag = indexPath.row + 200;
            cell.btnSecory.hidden = YES;
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.text = _queryCardInfo.result.UsrCardInfolist.CardId;
            cell.textField.enabled = NO;
        }else if (indexPath.row == 3){
            cell.btn.hidden = YES;
            cell.btnSecory.hidden = NO;
            cell.btnSecory.tag = 203;
            [cell.btnSecory addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            cell.textField.placeholder = @"验证码";
            cell.textField.enabled = YES;
            cell.textField.tag = 103;
            
        }else if (indexPath.row == 2){
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.btnSecory.hidden = YES;
            cell.btn.hidden = YES;
            cell.textField.placeholder = @"手机号";
            cell.textField.tag = 102;
            [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            if (_queryCardInfo.result.UsrCardInfolist.BindMobile!=nil) {
                
                cell.textField.enabled = NO;
                cell.textField.text = _queryCardInfo.result.UsrCardInfolist.BindMobile;
                _mobile = cell.textField.text;
            }else{
                
                cell.textField.enabled = YES;
                cell.textField.text = @"";
            }
        }
        [Tool setCorner:cell.bgView borderColor:UI_MAIN_COLOR];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark  点击发送验证码
-(void)senderBtn:(UIButton *)sender{

    if (_mobile.length < 11 || ![Tool isMobileNumber:_mobile]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入有效手机号！"];
        return;
    }
    
    _backTimeBtn = sender;
    sender.userInteractionEnabled = NO;
    sender.alpha = 0.4;
    
    [sender setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButton) userInfo:nil repeats:YES];
    NSString *bankNo = _queryCardInfo.result.UsrCardInfolist.CardId;
    UnbundlingBankCardViewModel *unbundlingBankCardViewModel = [[UnbundlingBankCardViewModel alloc]init];
    [unbundlingBankCardViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        SendSmsModel *model = [SendSmsModel yy_modelWithJSON:returnValue];
        if ([model.result.appcode isEqualToString:@"1"]) {
            
            _sms_seq = model.result.sms_seq_;
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.result.appmsg];
        }else{
            
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.result.appmsg];
        }
        
    } WithFaileBlock:^{
        
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"网络请求失败"];
        
    }];
    
    [unbundlingBankCardViewModel sendSmsSHServiceBankNo:bankNo BusiType:@"rebind" SmsType:@"O" Mobile:_mobile];
    
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

#pragma mark 处理手机位数
-(void)changeTextField:(UITextField *)textField{

    if (textField.tag ==102) {
        
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        _mobile = textField.text;
    }else if(textField.tag == 103){
        _sms_code = textField.text;
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag == 103)
    {
        
        NSLog(@"===%@",textField.text);
        if ([textField.text length] !=4 || textField.text.length !=6) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
            
        }else{
            _sms_code = textField.text;
        }
    }
    
}

#pragma mark 点击确认按钮
-(void)clickBtn{

    if (_sms_code.length <4) {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"请输入验证码"];
    }else{
    
        ChangeBankCardViewController *controller = [[ChangeBankCardViewController alloc]initWithNibName:@"ChangeBankCardViewController" bundle:nil];
        
        controller.ordsms_ext_ = [NSString stringWithFormat:@"%@%@",_sms_code,_sms_seq];
        controller.isCheck = _isCheck;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}

#pragma mark 银行卡名字的转换
-(NSString *)bankName:(NSString *)bankCode{
    
    NSString *name = @"";
    if([bankCode isEqualToString:@"BOC"]){
        
        name = @"中国银行";
        
    }else if ([bankCode isEqualToString:@"ICBC"]){
        
        name = @"中国工商银行";
    }else if ([bankCode isEqualToString:@"CCB"]){
        
        name = @"中国建设银行";
    }else if ([bankCode isEqualToString:@"ABC"]){
        
        name = @"中国农业银行";
    }else if ([bankCode isEqualToString:@"CITIC"]){
        
        name = @"中信银行";
    }else if ([bankCode isEqualToString:@"CIB"]){
        
        name = @"兴业银行";
    }else if ([bankCode isEqualToString:@"CEB"]){
        
        name = @"中国光大银行";
    }else if ([bankCode isEqualToString:@"CMB"]){
    
        name = @"招商银行";
    }
    
    return name;
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
