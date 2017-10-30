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

    //短信序列号
    NSString *_sms_seq;
    //短信验证码
    NSString *_sms_code;
    //验证码按钮
    UIButton *_backTimeBtn;
    //验证码倒计时时间
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
    self.bankTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.0001)];
    [self.sureBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bankTable registerClass:[ContentTableViewCell class] forCellReuseIdentifier:@"ContentTableViewCell"];
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
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
    if (!cell) {
        cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
    }
    
        cell.contentTextField.tag = indexPath.row + 100;
        cell.contentTextField.delegate = self;
    if ([_queryCardInfo.result.UsrCardInfolist.BankId isEqualToString:@""]) {
        
      if (indexPath.row == 0) {
            [cell.arrowsImageBtn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
            cell.arrowsImageBtn.tag = indexPath.row + 200;
            cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.contentTextField.text = _queryCardInfo.result.UsrCardInfolist.CardId;
            cell.titleLabel.text = @"银行卡号";
            cell.contentTextField.enabled = NO;
            [cell updateScanCardImageBtnLayout];
  
        }else if (indexPath.row == 2){
            cell.arrowsImageBtn.tag = 203;
            cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
            [cell.contentTextField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            cell.titleLabel.text = @"验证码";
            cell.contentTextField.enabled = YES;
            cell.contentTextField.tag = 103;
            [cell.arrowsImageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            [cell updateVerfiyCodeImageBtnLayout];
            __weak typeof (self) weakSelf = self;
            cell.btnClick = ^(UIButton * button) {
                [weakSelf senderBtn:button];
            };
            
        }else if (indexPath.row == 1){
            cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.arrowsImageBtn.hidden = YES;
            cell.titleLabel.text = @"手机号";
            cell.contentTextField.tag = 102;
            [cell.contentTextField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            if (_queryCardInfo.result.UsrCardInfolist.BindMobile!=nil) {
                
                cell.contentTextField.enabled = NO;
                cell.contentTextField.text = _queryCardInfo.result.UsrCardInfolist.BindMobile;
                _mobile = cell.contentTextField.text;
                
            }else{
                
                cell.contentTextField.enabled = YES;
                cell.contentTextField.text = @"";
            }
        }
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
    
        if (indexPath.row == 0) {
            
            cell.contentTextField.enabled = NO;
            cell.contentTextField.text = _queryCardInfo.result.UsrCardInfolist.bankName;
            cell.titleLabel.text = @"银行名称";

        }else if (indexPath.row == 1) {
            [cell.arrowsImageBtn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
            cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.contentTextField.text = _queryCardInfo.result.UsrCardInfolist.CardId;
            cell.titleLabel.text = @"银行卡号";
            cell.contentTextField.enabled = NO;
            [cell updateScanCardImageBtnLayout];

        }else if (indexPath.row == 3){
            cell.arrowsImageBtn.tag = 203;
            cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
            [cell.contentTextField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            cell.titleLabel.text = @"验证码";
            cell.contentTextField.enabled = YES;
            cell.contentTextField.tag = 103;
            [cell.arrowsImageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            [cell updateVerfiyCodeImageBtnLayout];
            __weak typeof (self) weakSelf = self;
            cell.btnClick = ^(UIButton * button) {
                
                [weakSelf senderBtn:button];
            };
        }else if (indexPath.row == 2){
            cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.arrowsImageBtn.hidden = YES;
            cell.titleLabel.text = @"手机号";
            cell.contentTextField.tag = 102;
            [cell.contentTextField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            if (_queryCardInfo.result.UsrCardInfolist.BindMobile!=nil) {
                
                cell.contentTextField.enabled = NO;
                cell.contentTextField.text = _queryCardInfo.result.UsrCardInfolist.BindMobile;
                _mobile = cell.contentTextField.text;
                
            }else{
                
                cell.contentTextField.enabled = YES;
                cell.contentTextField.text = @"";
            }
        }
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
//    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButton) userInfo:nil repeats:YES];
    NSString *bankNo = _queryCardInfo.result.UsrCardInfolist.CardId;
    UnbundlingBankCardViewModel *unbundlingBankCardViewModel = [[UnbundlingBankCardViewModel alloc]init];
    [unbundlingBankCardViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        SendSmsModel *model = [SendSmsModel yy_modelWithJSON:returnValue];
        if ([model.result.appcode isEqualToString:@"1"]) {
            sender.userInteractionEnabled = NO;
            sender.alpha = 0.4;
            [sender setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
             _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButton) userInfo:nil repeats:YES];
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

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    _backTimeBtn.userInteractionEnabled = YES;
    [_backTimeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    _backTimeBtn.alpha = 1.0;
    _countdown = 60;
    [_countdownTimer invalidate];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

#pragma mark 处理手机位数
-(void)changeTextField:(UITextField *)textField{

    if (textField.tag ==102) {
        
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        _mobile = textField.text;
    }else if(textField.tag == 103){
        
        if (textField.text.length >6) {
            textField.text = [textField.text substringToIndex:6];
        }
        _sms_code = textField.text;
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag == 103)
    {
        
        NSLog(@"===%@",textField.text);
        if ([textField.text isEqualToString:@""]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
            
        }else{
            _sms_code = textField.text;
        }
    }
    
}

#pragma mark 点击确认按钮
-(void)clickBtn{

    if (_sms_code == nil ||[_sms_code isEqualToString:@""]) {
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
