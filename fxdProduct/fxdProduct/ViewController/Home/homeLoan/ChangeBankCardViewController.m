//
//  ChangeBankCardViewController.m
//  fxdProduct
//
//  Created by sxp on 17/5/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ChangeBankCardViewController.h"
#import "BankModel.h"
#import "LabelCell.h"
#import "HomeBankCardViewController.h"
#import "SendSmsModel.h"
#import <MGBaseKit/MGBaseKit.h>
#import <MGBankCard/MGBankCard.h>
#import "BankCardsModel.h"
#import "WTCameraViewController.h"

@interface ChangeBankCardViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WTCameraDelegate,BankTableViewSelectDelegate>
{

        NSArray *placeArray3;
        NSMutableArray *dataListAll3;
        NSMutableArray *dataColorAll3;
        NSString *_bankCode;
        NSInteger _countdown;
        NSTimer * _countdownTimer;
        BankModel *_bankModel;
        UIButton *_backTimeBtn;
        NSString *_sms_seq;
        NSString *sms_code;
}
@end

@implementation ChangeBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"更换银行卡";
    [Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
    [self addBackItem];
    _countdown = 60;
    placeArray3 = @[@"接受到账的银行卡",@"卡号",@"预留手机号",@"验证码"];
    dataListAll3 = [NSMutableArray new];
    dataColorAll3 = [NSMutableArray new];
    for (int i=0; i<10; i++) {
        [dataListAll3 addObject:@""];
        [dataColorAll3 addObject:UI_MAIN_COLOR];
    }

    [dataListAll3 replaceObjectAtIndex:5 withObject:@"100"];
    [self getBankList];
    self.changTab.delegate = self;
    self.changTab.dataSource = self;
    self.changTab.separatorStyle = NO;
    [self.sureBtn addTarget:self action:@selector(changeBank) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ->UItableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return placeArray3.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"abcef%ld",indexPath.row]];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil] lastObject];
    }
    cell.textField.placeholder = placeArray3[indexPath.row];
    cell.textField.tag = indexPath.row + 100;
    cell.textField.delegate = self;
    cell.textField.text = dataListAll3[indexPath.row];

    if (indexPath.row == 0) {
        [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
        cell.btn.hidden = NO;
        cell.btn.tag = indexPath.row + 200;
        [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnSecory.hidden = YES;
    }else if (indexPath.row == 1) {
        [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
        cell.btn.hidden = NO;
        cell.btn.tag = indexPath.row + 200;
        [cell.btn addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnSecory.hidden = YES;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }else if (indexPath.row == 3){
        cell.btn.hidden = YES;
        cell.btnSecory.hidden = NO;
        cell.btnSecory.tag = 203;
        [cell.btnSecory addTarget:self action:@selector(senderBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];

    }else if (indexPath.row == 2){
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.btnSecory.hidden = YES;
        cell.btn.hidden = YES;
        [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];

    }
    [Tool setCorner:cell.bgView borderColor:UI_MAIN_COLOR];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;

    return nil;
}



-(void)senderBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:
        {
            DLog(@"%@",placeArray3[0]);
            DLog(@"%@",_bankModel);
            HomeBankCardViewController *homebankVC = [HomeBankCardViewController new];
            homebankVC.bankModel = _bankModel;
            homebankVC.delegate = self;
            homebankVC.cardTag = [dataListAll3[5] integerValue];
            //            homebankVC.bankFlag = 100;
            [self.navigationController pushViewController:homebankVC animated:YES];
        }
            break;
        case 201:
        {
            DLog(@"%@",placeArray3[1]);
            [self startBankCamera];

        }
            break;
        case 203:
        {
            DLog(@"%@",placeArray3[3]);

            _backTimeBtn = sender;
            if ([dataListAll3[0] length] < 1) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择银行卡"];
            }else if ([_bankCode length] < 1 || _bankCode == nil){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择银行卡类型"];
            }else if ([dataListAll3[1] length]<16){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的卡号"];
            }else if (![Tool isMobileNumber:dataListAll3[2]]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的手机号"];
            }else{
                sender.userInteractionEnabled = NO;
                sender.alpha = 0.4;

                [sender setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
                _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButton) userInfo:nil repeats:YES];

                [self senderSms];

            }
        }
            break;
        default:
            break;
    }

}

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

#pragma mark  点击发送验证码网络请求
-(void)senderSms{

    NSDictionary *paramDic = [self getParamDic];
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_P2P_url,_sendSms_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {

        SendSmsModel *model = [SendSmsModel yy_modelWithJSON:object];
        if ([model.appcode isEqualToString:@"1"]) {
            [_sureBtn setEnabled:YES];
            _sms_seq = model.data.sms_seq_;
            [dataListAll3 replaceObjectAtIndex:7 withObject:@"10"];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.appmsg];
        }else{

            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.appmsg];
        }
    } failure:^(EnumServerStatus status, id object) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"网络请求失败"];
    }];

}

#pragma  mark 获取验证码的参数
-(NSDictionary *)getParamDic{

     NSString *bankNo =[dataListAll3[1] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDictionary *paramDic;
    paramDic = @{@"busi_type_":@"rebind",
                 @"card_number_":bankNo,
                 @"mobile_":dataListAll3[2],
                 @"sms_type_":@"N"
                 };
    return paramDic;

}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}


#pragma mark 限制手机位数
-(void)changeTextField:(UITextField *)textField{
    if (textField.tag == 102) {

        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }else if (textField.tag == 103){

        sms_code = textField.text;

    }
}


#pragma mark->textFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 100)
    {
        return NO;
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 101) {
        NSString *text = [textField text];

        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }

        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];

        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }

        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        if (newString.length >= 24) {
            return NO;
        }
        //        NSMutableArray * array=[NSMutableArray arrayWithArray:[newString   componentsSeparatedByString:@" "]];
        //        NSLog(@"%@",array);
        //        NSString *ns=[array componentsJoinedByString:@""];
        [dataListAll3 replaceObjectAtIndex:1 withObject:newString];
        [textField setText:newString];
        return NO;

    }
    if (textField.tag == 103) {
        NSString *stringlength = [NSString stringWithFormat:@"%@%@",textField.text,string];

        if ([stringlength length] > 6) {

            return NO;
        }
    }

    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 100)
    {
        if ([textField.text length]<1) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的银行卡"];
            //                [dataColorAll3 replaceObjectAtIndex:0 withObject:redColor];
        }else{
            [dataListAll3 replaceObjectAtIndex:0 withObject:textField.text];
            [dataColorAll3 replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
        }

    }

    if (textField.tag == 101)
    {
        if ([textField.text length]<19) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"银行卡位数不对"];
            //                [dataColorAll3 replaceObjectAtIndex:1 withObject:redColor];
        }else{
            [dataListAll3 replaceObjectAtIndex:1 withObject:textField.text];
            [dataColorAll3 replaceObjectAtIndex:1 withObject:UI_MAIN_COLOR];
        }

    }
    if (textField.tag == 103)
    {
        if ([textField.text length] !=6) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
            //                [dataColorAll3 replaceObjectAtIndex:3 withObject:redColor];
        }else{
            [dataListAll3 replaceObjectAtIndex:3 withObject:textField.text];
            [dataColorAll3 replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }

    }
}


- (void)BankSelect:(BankList *)bankInfo andSectionRow:(NSInteger)sectionRow
{
    [dataListAll3 replaceObjectAtIndex:0 withObject:bankInfo.desc];//银行名字
    //    [dataListAll3 replaceObjectAtIndex:4 withObject:bankNum];//银行代码
    _bankCode = bankInfo.code;
    [dataListAll3 replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%ld",(long)sectionRow]];
    [dataColorAll3 replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
    [_changTab reloadData];
}
#pragma mark - 银行卡扫描
/**
 扫描银行卡
 */
- (void)startBankCamera
{
    //    WTCameraViewController *cameraVC = [[WTCameraViewController alloc]init];
    //    cameraVC.delegate = self;
    //    cameraVC.devcode = Devcode; //开发码
    //    self.navigationController.navigationBarHidden = YES;
    //    [self.navigationController pushViewController:cameraVC animated:YES];

    BOOL bankcard = [MGBankCardManager getLicense];

    if (!bankcard) {

        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"SDK授权失败，请检查"];

        return;
    }

    __unsafe_unretained ChangeBankCardViewController * weakSelf = self;
    MGBankCardManager *cardManager = [[MGBankCardManager alloc] init];
    [cardManager setDebug:YES];
    [cardManager CardStart:self finish:^(MGBankCardModel * _Nullable result) {
        //        weakSelf.bankImageView.image = result.image;
        //        weakSelf.bankNumView.text = result.bankCardNumber;

        //        _bankCodeNUm = result.bankCardNumber;
        //        _bankCodeNUm = [_bankCodeNUm stringByReplacingOccurrencesOfString:@" " withString:@""];
        //        _bankCodeNUm = [self changeStr:_bankCodeNUm];
        NSString *_bankNum;
        _bankNum = result.bankCardNumber;
        _bankNum = [_bankNum stringByReplacingOccurrencesOfString:@" " withString:@""];
        _bankNum = [self changeStr:_bankNum];
        [dataListAll3 replaceObjectAtIndex:1 withObject:_bankNum];
        DLog(@"银行卡扫描可信度 -- %@",[NSString stringWithFormat:@"confidence:%.2f", result.bankCardconfidence]);
        [weakSelf.changTab reloadData];

    }];
}

//银行卡修改显示格式
-(NSString*)changeStr:(NSString*)str
{
    NSString *newString=@"";
    while (str.length > 0) {
        NSString *subString = [str substringToIndex:MIN(str.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        str = [str substringFromIndex:MIN(str.length, 4)];
    }

    return newString;
}

#pragma mark 获取银行卡列表

-(void)getBankList{

    NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        BankModel *bankModel = [BankModel yy_modelWithJSON:object];
        if ([bankModel.flag isEqualToString:@"0000"]) {
            _bankModel = bankModel;
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:bankModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

#pragma mark 点击确定按钮，更换银行卡
-(void)changeBank{

    NSDictionary *paramDic = [self changeBankParamDic];
    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_P2P_url,_bankCards_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        BankCardsModel *model = [BankCardsModel yy_modelWithJSON:object];
        if ([model.appcode isEqualToString:@"1"]) {

        }

    } failure:^(EnumServerStatus status, id object) {

    }];

}

#pragma mark 更换银行卡参数
-(NSDictionary *)changeBankParamDic{

    NSDictionary *paramDic = @{@"bank_code_":_bankCode,
                               @"card_number_":dataListAll3[1],
                               @"from_mobile_":[Utility sharedUtility].userInfo.userMobilePhone,
                               @"mobile_":dataListAll3[2],
                               @"ordsms_ext_":_ordsms_ext_,
                               @"sms_code_":dataListAll3[3],
                               @"sms_seq_":_sms_seq,
                               @"trade_type_":@"REBIND",
                               };
    return paramDic;
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
