//
//  HG_OpenAccountAddBankCardModules.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "HG_OpenAccountAddBankCardModules.h"
#import "LabelCell.h"
#import "BankCardNameVCModules.h"
#import "WTCameraViewController.h"
#import "LoanMoneyViewController.h"
#import "SMSViewModel.h"
#import "UserStateModel.h"
#import "DetailViewController.h"
#import <MGBaseKit/MGBaseKit.h>
#import <MGBankCard/MGBankCard.h>
#import "SendSmsModel.h"
#import "P2PViewController.h"
#import "UnbundlingBankCardViewModel.h"
#import "CheckViewModel.h"
#define redColor rgb(252, 0, 6)

@interface HG_OpenAccountAddBankCardModules ()<UITableViewDataSource,UITableViewDelegate,
UITextFieldDelegate,WTCameraDelegate,BankTableViewSelectDelegate>
{
    //左边标题数组
    NSArray *placeArray3;
    //右边内容数组
    NSMutableArray *dataListAll3;
    //颜色数组
    NSMutableArray *dataColorAll3;
    //验证码按钮
    UIButton *_backTimeBtn;
    //倒计时时间
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    //发送短信服务返回的数据
    ReturnMsgBaseClass *_codeParse;
    //银行卡code
    NSString *_bankCodeNUm;
    //bank_id_
    NSString *_bankLogogram;
    //银行卡账号
    NSString *_bankNum;
    //选中银行卡列表的index
    NSInteger defaultBankIndex;
    //授权同意书的状态
    BOOL _btnStatus;
    //短信序列号
    NSString *_sms_seq;
    //短信验证码
    NSString *_sms_code_;
}
@end

@implementation HG_OpenAccountAddBankCardModules

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackItem];
    [FXD_Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
    _bankCodeNUm = @"";
    _bankNum = @"";
    defaultBankIndex = -1;
    self.navigationItem.title =@"银行卡";
    placeArray3 = @[@"接受到账的银行卡",@"卡号",@"预留手机号",@"验证码"];
    dataListAll3 = [NSMutableArray new];
    dataColorAll3 = [NSMutableArray new];
    _countdown = 60;
    _btnStatus = false;
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
    for (int i=0; i<10; i++) {
        [dataListAll3 addObject:@""];
        [dataColorAll3 addObject:UI_MAIN_COLOR];
    }    
    UITapGestureRecognizer *tapSecory = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicksecry)];
    self.authorLabel.userInteractionEnabled=YES;
    [self.authorLabel addGestureRecognizer:tapSecory];
    
    [dataListAll3 replaceObjectAtIndex:5 withObject:@"100"];
        
    if (_bankMobile) {
        [dataListAll3 replaceObjectAtIndex:2 withObject:_bankMobile];
    }
}

#pragma mark 点击协议复选框
- (IBAction)agreeBtnClick:(UIButton *)sender {
    if (!_btnStatus) {
        [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"tricked"] forState:UIControlStateNormal];
    } else {
        [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
    }
    _btnStatus = !_btnStatus;
}


#pragma mark 点击协议按钮获取协议内容
- (void)clicksecry
{

    NSDictionary *paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                               @"product_id_":_drawingsInfoModel.productId,
                               @"protocol_type_":@"1",
                               @"card_no_":[dataListAll3 objectAtIndex:1],
                               @"card_bank_":_bankCodeNUm};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_ProductProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            detailVC.content = [[object objectForKey:@"result"] objectForKey:@"protocol_content_"];
            [self.navigationController pushViewController:detailVC animated:YES];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
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
    if (indexPath.row == 4) {
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"abc"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"abc"];
        }
        cell.detailTextLabel.text = @"";
        cell.detailTextLabel.textColor = rgb(165, 165, 165);
        cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
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
            [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_31"] forState:UIControlStateNormal];
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
            cell.textField.tag = 203;
            [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
        }else if (indexPath.row == 2){
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.btnSecory.hidden = YES;
            cell.btn.hidden = YES;
            cell.textField.tag = 202;
            [cell.textField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
        }
        [FXD_Tool setCorner:cell.bgView borderColor:dataColorAll3[indexPath.row]];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(void)changeTextField:(UITextField *)textField
{
    if(textField.tag==202){
    
        if ([textField.text length] ==11) {
            [self.view endEditing:YES];
            [dataListAll3 replaceObjectAtIndex:2 withObject:textField.text];
        }
        if (textField.text.length>11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }else if (textField.tag == 203){
    
        if (textField.text.length>6) {
            textField.text = [textField.text substringToIndex:6];
            
        }
        [dataListAll3 replaceObjectAtIndex:3 withObject:textField.text];
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

        }else{
            [dataListAll3 replaceObjectAtIndex:0 withObject:textField.text];
            [dataColorAll3 replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
        }
        
    }
    
    if (textField.tag == 101)
    {
        if ([textField.text length]<19) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"银行卡位数不对"];

        }else{
            [dataListAll3 replaceObjectAtIndex:1 withObject:textField.text];
            [dataColorAll3 replaceObjectAtIndex:1 withObject:UI_MAIN_COLOR];
        }
        
    }
    if (textField.tag == 103)
    {
        
        NSLog(@"===%@",textField.text);
        if ([textField.text isEqualToString:@""]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];

        }else{
            [dataListAll3 replaceObjectAtIndex:3 withObject:textField.text];
            [dataColorAll3 replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }
    }
}

#pragma mark ->BankTableViewSelectDelegate

- (void)BankSelect:(SupportBankList *)bankInfo andSectionRow:(NSInteger)sectionRow
{
    [dataListAll3 replaceObjectAtIndex:0 withObject:bankInfo.bank_name_];//银行名字
    _bankNum = bankInfo.bank_code_;
    _bankCodeNUm = bankInfo.bank_code_;
    _bankLogogram = bankInfo.bank_short_name_;
    [dataListAll3 replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%ld",(long)sectionRow]];
    [dataColorAll3 replaceObjectAtIndex:0 withObject:UI_MAIN_COLOR];
    [_tableView reloadData];
}
#pragma mark - 银行卡扫描
/**
 扫描银行卡
 */
- (void)startBankCamera
{

    BOOL bankcard = [MGBankCardManager getLicense];
    if (!bankcard) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"SDK授权失败，请检查"];
        return;
    }
    __unsafe_unretained HG_OpenAccountAddBankCardModules * weakSelf = self;
    MGBankCardManager *cardManager = [[MGBankCardManager alloc] init];
    [cardManager setDebug:YES];
    cardManager.viewType = MGBankCardViewCardBox;
    [cardManager CardStart:self finish:^(MGBankCardModel * _Nullable result) {

        _bankNum = result.bankCardNumber;
        _bankNum = [_bankNum stringByReplacingOccurrencesOfString:@" " withString:@""];
        _bankNum = [self changeStr:_bankNum];
        [dataListAll3 replaceObjectAtIndex:1 withObject:_bankNum];
        DLog(@"银行卡扫描可信度 -- %@",[NSString stringWithFormat:@"confidence:%.2f", result.bankCardconfidence]);
        [weakSelf.tableView reloadData];
        
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

#pragma mark cell点击事件
-(void)senderBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:
        {
            DLog(@"%@",placeArray3[0]);
            BankCardNameVCModules *homebankVC = [BankCardNameVCModules new];
            homebankVC.bankArray = _bankArray;
            homebankVC.isP2P = true;
            homebankVC.delegate = self;
            homebankVC.cardTag = [dataListAll3[5] integerValue];
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
            }else if ([_bankCodeNUm length] < 1 || _bankCodeNUm == nil){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择银行卡类型"];
            }else if ([dataListAll3[1] length]<16){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的卡号"];
            }else if (![FXD_Tool isMobileNumber:dataListAll3[2]]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的手机号"];
            }else{
                sender.userInteractionEnabled = NO;
                sender.alpha = 0.4;
                
                [sender setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
                _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButton) userInfo:nil repeats:YES];
                [self p2p];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark P2P短信发送
-(void)p2p{

    NSString *bankNo =[dataListAll3[1] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    UnbundlingBankCardViewModel *unbundlingBankCardViewModel = [[UnbundlingBankCardViewModel alloc]init];
    [unbundlingBankCardViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        SendSmsModel *sendSmsModel = [SendSmsModel yy_modelWithJSON:returnValue];
        
        if ([sendSmsModel.result.appcode isEqualToString:@"1"]) {
            [_sureBtn setEnabled:YES];
            [dataListAll3 replaceObjectAtIndex:7 withObject:@"10"];
            _sms_seq = sendSmsModel.result.sms_seq_;
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:sendSmsModel.result.appmsg];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:sendSmsModel.result.appmsg];
        }
        
    } WithFaileBlock:^{
        
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"网络请求失败"];
    }];
    [unbundlingBankCardViewModel sendSmsSHServiceBankNo:bankNo BusiType:@"user_register" SmsType:nil Mobile:dataListAll3[2]];

}

#pragma mark 发薪贷的短信发送
-(void)sms{

    NSDictionary *parDic = @{@"mobile_phone_":dataListAll3[2],
                             @"flag":CODE_DRAW,
                             };
    if (parDic) {
        
        SMSViewModel *smsViewModel = [[SMSViewModel alloc] init];
        [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
            _codeParse = returnValue;
            [_sureBtn setEnabled:YES];
            [dataListAll3 replaceObjectAtIndex:7 withObject:@"10"];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
            DLog(@"---%@",_codeParse.msg);
        } WithFaileBlock:^{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"网络请求失败"];
        }];
        [smsViewModel fatchRequestSMSParamPhoneNumber:dataListAll3[2] verifyCodeType:DRAW_CODE];
    }
}

//验证码倒计时
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

#pragma mark 点击确认按钮
- (IBAction)sureBtn:(id)sender {
    if ([dataListAll3[0] length] < 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择银行卡"];
    }else if ([_bankCodeNUm length] < 1 || _bankCodeNUm == nil){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择银行卡类型"];
    }else if ([dataListAll3[1] length]<16){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的卡号"];
    }else if (![FXD_Tool isMobileNumber:dataListAll3[2]]){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的手机号"];
    }else if ([dataListAll3[3] isEqualToString:@""] ){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的验证码"];
    }else if (!_btnStatus) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请同意授权书"];
    }else{
        [self openAccount];
    }
}

//获取进件信息参数
-(NSDictionary *)getSubmitInfo
{
    NSString *bankNo =[dataListAll3[1] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSDictionary *paramDic;
    if ([_drawingsInfoModel.productId isEqualToString:RapidLoan] || [_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
        paramDic = @{@"card_no_":bankNo,
                   @"card_bank_":_bankCodeNUm,
                   @"bank_reserve_phone_":[dataListAll3 objectAtIndex:2],
                   @"periods_":@2,
                   @"loan_for_":_purposeSelect,
                   @"verify_code_":dataListAll3[3],
                   @"drawing_amount_":_drawAmount};
    }
    if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]||[_drawingsInfoModel.productId isEqualToString:WhiteCollarLoan]) {
        paramDic = @{@"card_no_":bankNo,
                     @"card_bank_":_bankCodeNUm,
                     @"bank_reserve_phone_":[dataListAll3 objectAtIndex:2],
                     @"periods_":@(_periodSelect),
                     @"loan_for_":_purposeSelect,
                     @"verify_code_":dataListAll3[3],
                     @"drawing_amount_":_drawAmount};
    }
    
    return paramDic;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 开户
-(void)openAccount{

    NSString *bankName = _bankLogogram;
//    NSString *_sms_seq = @"AAAAAAAA";
    NSString *bankNo =[dataListAll3[1] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //效验验证码序列号
    if (!_sms_seq) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的验证码"];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@?from_mobile_=%@&id_number_=%@&user_name_=%@&PageType=1&ret_url_=%@&bank_id_=%@&card_number_=%@&sms_code_=%@&sms_seq_=%@&mobile_=%@",_P2P_url,_huifu_url,[FXD_Utility sharedUtility].userInfo.userMobilePhone,[FXD_Utility sharedUtility].userInfo.userIDNumber,[FXD_Utility sharedUtility].userInfo.realName,_transition_url,bankName,bankNo,dataListAll3[3],_sms_seq,dataListAll3[2]];
    NSLog(@"%@",url);
    P2PViewController *p2pVC = [[P2PViewController alloc] init];
    p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    p2pVC.bankCodeNUm = _bankCodeNUm;
    p2pVC.drawAmount= _drawAmount;
    p2pVC.product_id = _drawingsInfoModel.productId;
    p2pVC.periodSelect = _periodSelect;
    p2pVC.dataArray = dataListAll3;
    p2pVC.isCheck = YES;
    p2pVC.purposeSelect = _purposeSelect;
    p2pVC.applicationId = self.drawingsInfoModel.applicationId;
    [self.navigationController pushViewController:p2pVC animated:YES];
}




@end
