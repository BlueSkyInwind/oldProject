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
@interface UnbundlingBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{

    NSString *_sms_seq;
    NSString *_sms_code;
    UIButton *_backTimeBtn;
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    QueryCardInfo *_queryCadModel;
    
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
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"abcef%ld",indexPath.row]];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil] lastObject];
        }
//        cell.textField.placeholder = placeArray3[indexPath.row];
        cell.textField.tag = indexPath.row + 100;
        cell.textField.delegate = self;
//        cell.textField.text = dataListAll3[indexPath.row];
    
        if (indexPath.row == 0) {
            [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
            cell.btn.hidden = NO;
            cell.btn.tag = indexPath.row + 200;
//            [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnSecory.hidden = YES;
            cell.textField.enabled = NO;
            
            
            cell.textField.text = [self bankName:_queryCadModel.data.UsrCardInfolist.BankId];
            
//            cell.textField.text = @"农行";
            
            
        }else if (indexPath.row == 1) {
            [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
            cell.btn.hidden = NO;
            cell.btn.tag = indexPath.row + 200;
//            [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnSecory.hidden = YES;
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.text = _queryCadModel.data.UsrCardInfolist.CardId;
            cell.textField.enabled = NO;
        }else if (indexPath.row == 3){
            cell.btn.hidden = YES;
            cell.btnSecory.hidden = NO;
            cell.btnSecory.tag = 203;
            [cell.btnSecory addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            cell.textField.enabled = YES;
            
        }else if (indexPath.row == 2){
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.btnSecory.hidden = YES;
            cell.btn.hidden = YES;
            [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
            cell.textField.enabled = NO;
            cell.textField.text = [Utility sharedUtility].userInfo.userMobilePhone;
        }
        [Tool setCorner:cell.bgView borderColor:UI_MAIN_COLOR];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;

    return nil;
}

#pragma mark  点击发送验证码
-(void)senderBtn:(UIButton *)sender{

    _backTimeBtn = sender;
    sender.userInteractionEnabled = NO;
    sender.alpha = 0.4;
    
    [sender setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButton) userInfo:nil repeats:YES];
    
    NSDictionary *paramDic = [self getParamDic];
    
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_P2P_url,_sendSms_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
       
        SendSmsModel *model = [SendSmsModel yy_modelWithJSON:object];
        if ([model.appcode isEqualToString:@"1"]) {
            
            _sms_seq = model.data.sms_seq_;
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


#pragma mark 获取验证码参数
-(NSDictionary *)getParamDic{

    _bankNum = @"622 822 93399 10450";
    NSString *bankNo =[_bankNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSDictionary *paramDic;
    
    paramDic = @{@"busi_type_":@"rebind",
                     @"card_number_":bankNo,
                     @"mobile_":[Utility sharedUtility].userInfo.userMobilePhone,
                     @"sms_type_":@"O",
                 @"from_mobile_":[Utility sharedUtility].userInfo.userMobilePhone
                 
                     };
    return paramDic;
  
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
        if ([textField.text length] !=6) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
            
        }else{
            _sms_code = textField.text;
        }
    }
    
}

#pragma mark 点击确认按钮
-(void)clickBtn{

    if (_sms_code.length <6) {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"请输入验证码"];
    }else{
    
        ChangeBankCardViewController *controller = [[ChangeBankCardViewController alloc]initWithNibName:@"ChangeBankCardViewController" bundle:nil];
        
        controller.ordsms_ext_ = [NSString stringWithFormat:@"%@%@",_sms_code,_sms_seq];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self getBankDetail];
}

#pragma mark 获取银行卡信息
-(void)getBankDetail{

    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_P2P_url,_queryCardInfo_url] parameters:@{@"from_mobile_":[Utility sharedUtility].userInfo.userMobilePhone} finished:^(EnumServerStatus status, id object) {
        
        _queryCadModel = [QueryCardInfo yy_modelWithJSON:object];
        [_bankTable reloadData];
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


#pragma mark 银行卡名字的转换
-(NSString *)bankName:(NSString *)bankCode{
    
    NSString *name = @"";
    if([bankCode isEqualToString:@"BC"]){
        
        name = @"中国银行";
        
    }else if ([bankCode isEqualToString:@"ICBC"]){
        
        name = @"中国工商银行";
    }else if ([bankCode isEqualToString:@"CCB"]){
        
        name = @"中国建设银行";
    }else if ([bankCode isEqualToString:@"ABC"]){
        
        name = @"中国农业银行";
    }else if ([bankCode isEqualToString:@"CNCB"]){
        
        name = @"中信银行";
    }else if ([bankCode isEqualToString:@"CIB"]){
        
        name = @"中国兴业银行";
    }else if ([bankCode isEqualToString:@"CEB"]){
        
        name = @"中国光大银行";
    }else if ([bankCode isEqualToString:@"PSBC"]){
        
        name = @"中国邮政";
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
