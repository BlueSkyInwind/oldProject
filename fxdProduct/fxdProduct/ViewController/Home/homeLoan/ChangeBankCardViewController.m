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
#import "CheckViewController.h"
#import "RTRootNavigationController.h"
#import "UnbundlingBankCardViewModel.h"
#import "RepayDetailViewController.h"
#import "CheckViewModel.h"
@interface ChangeBankCardViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WTCameraDelegate,BankTableViewSelectDelegate>
{

        NSArray *placeArray3;
        NSMutableArray *dataListAll3;
        NSMutableArray *dataColorAll3;
        NSString *_bankLogogram;
        NSInteger _countdown;
        NSTimer * _countdownTimer;
        BankModel *_bankModel;
        NSMutableArray * _supportBankListArr;
        UIButton *_backTimeBtn;
        NSString *_sms_seq;

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
    _supportBankListArr = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        [dataListAll3 addObject:@""];
        [dataColorAll3 addObject:UI_MAIN_COLOR];
    }

    [dataListAll3 replaceObjectAtIndex:5 withObject:@"100"];
    [self getBankListInfo];
    self.changTab.delegate = self;
    self.changTab.dataSource = self;
    self.changTab.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.0001)];
    [self.sureBtn addTarget:self action:@selector(changeBank) forControlEvents:UIControlEventTouchUpInside];
    
    [self.changTab registerClass:[ContentTableViewCell class] forCellReuseIdentifier:@"ContentTableViewCell"];

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

    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
    if (!cell) {
        cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
    }
    cell.titleLabel.text = placeArray3[indexPath.row];
    cell.contentTextField.tag = indexPath.row + 100;
    cell.contentTextField.delegate = self;
    cell.contentTextField.text = dataListAll3[indexPath.row];

    if (indexPath.row == 0) {
        cell.arrowsImageBtn.tag = indexPath.row + 200;
        cell.contentTextField.enabled=false;

    }else if (indexPath.row == 1) {
        [cell.arrowsImageBtn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
        cell.arrowsImageBtn.tag = indexPath.row + 200;
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
        [cell updateScanCardImageBtnLayout];
        __weak typeof (self) weakSelf = self;
        cell.btnClick = ^(UIButton * button) {
            [weakSelf senderBtn:button];
        };
    }else if (indexPath.row == 3){
        cell.arrowsImageBtn.tag = 203;
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.contentTextField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
        [cell.arrowsImageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [cell updateVerfiyCodeImageBtnLayout];
        __weak typeof (self) weakSelf = self;
        cell.btnClick = ^(UIButton * button) {
            [weakSelf senderBtn:button];
        };
    }else if (indexPath.row == 2){
        cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
        cell.arrowsImageBtn.hidden = YES;
        [cell.contentTextField addTarget:self action:@selector(changeTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;

    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HomeBankCardViewController *homebankVC = [HomeBankCardViewController new];
        homebankVC.bankArray = _supportBankListArr;
        homebankVC.delegate = self;
        homebankVC.cardTag = [dataListAll3[5] integerValue];
        //            homebankVC.bankFlag = 100;
        [self.navigationController pushViewController:homebankVC animated:YES];
    }
}

-(void)senderBtn:(UIButton *)sender
{
    switch (sender.tag) {

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
            }else if ([_bankLogogram length] < 1 || _bankLogogram == nil){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请重新选择银行卡类型"];
            }else if ([dataListAll3[1] length]<16){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的卡号"];
            }else if (![Tool isMobileNumber:dataListAll3[2]]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的手机号"];
            }else{
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
    
    NSString *bankNo =[dataListAll3[1] stringByReplacingOccurrencesOfString:@" " withString:@""];
    UnbundlingBankCardViewModel *unbundlingBankCardViewModel = [[UnbundlingBankCardViewModel alloc]init];
    [unbundlingBankCardViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        SendSmsModel *model = [SendSmsModel yy_modelWithJSON:returnValue];
        if ([model.result.appcode isEqualToString:@"1"]) {
            
            _backTimeBtn.userInteractionEnabled = NO;
            _backTimeBtn.alpha = 0.4;
            [_backTimeBtn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
            _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButton) userInfo:nil repeats:YES];
            [_sureBtn setEnabled:YES];
            _sms_seq = model.result.sms_seq_;
            [dataListAll3 replaceObjectAtIndex:7 withObject:@"10"];
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.result.appmsg];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:model.result.appmsg];
        }
        
    } WithFaileBlock:^{
        
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"网络请求失败"];
        
    }];
    [unbundlingBankCardViewModel sendSmsSHServiceBankNo:bankNo BusiType:@"rebind" SmsType:@"N" Mobile:dataListAll3[2]];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}


#pragma mark 限制手机位数
-(void)changeTextField:(UITextField *)textField{
    if (textField.tag == 102) {

        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
            
        }
        [dataListAll3 replaceObjectAtIndex:2 withObject:textField.text];
    }else if (textField.tag == 103){

        if (textField.text.length >6) {
            
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
        if ([textField.text isEqualToString:@""]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
            //                [dataColorAll3 replaceObjectAtIndex:3 withObject:redColor];
        }else{
            [dataListAll3 replaceObjectAtIndex:3 withObject:textField.text];
            [dataColorAll3 replaceObjectAtIndex:3 withObject:UI_MAIN_COLOR];
        }

    }
}


- (void)BankSelect:(SupportBankList *)bankInfo andSectionRow:(NSInteger)sectionRow
{
    [dataListAll3 replaceObjectAtIndex:0 withObject:bankInfo.bank_name_];//银行名字
    //    [dataListAll3 replaceObjectAtIndex:4 withObject:bankNum];//银行代码
    _bankLogogram = bankInfo.bank_short_name_;
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

#pragma mark 获取银行卡列表信息
-(void)getBankListInfo{

    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResult.flag isEqualToString:@"0000"]) {
            NSArray * array  = (NSArray *)baseResult.result;
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [_supportBankListArr addObject:bankList];
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getSupportBankListInfo:@"4"];
    
}

#pragma mark 点击确定按钮，更换银行卡
-(void)changeBank{

//    _ordsms_ext_ = @"666666AAAAAAAA";
//    _sms_seq = @"AAAAAAAA";
    if ([dataListAll3[3] isEqualToString:@""] || !_sms_seq) {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"请输入正确的验证码"];
        return;
    }
    
    NSString * bankNo =[dataListAll3[1] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * bankShortName = _bankLogogram;
    NSMutableArray * paramArray = [NSMutableArray array];
    [paramArray addObject:bankShortName];
    [paramArray addObject:bankNo];
    [paramArray addObject:[Utility sharedUtility].userInfo.userMobilePhone];
    [paramArray addObject:dataListAll3[2]];
    [paramArray addObject:_ordsms_ext_];
    [paramArray addObject:dataListAll3[3]];
    [paramArray addObject:_sms_seq];
    
    UnbundlingBankCardViewModel *unbundlingBankCardViewModel = [[UnbundlingBankCardViewModel alloc]init];
    [unbundlingBankCardViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        BankCardsModel *model = [BankCardsModel yy_modelWithJSON:returnValue];
        if ([model.result.appcode isEqualToString:@"1"]) {
            
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:model.result.appmsg];
            if (_isCheck) {
                for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
                    if ([vc isKindOfClass:[CheckViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }else{
                for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
                    if ([vc isKindOfClass:[RepayDetailViewController class]]) {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
            //  [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.appmsg];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.result.appmsg];
        }
    } WithFaileBlock:^{
        
    }];
    [unbundlingBankCardViewModel bankCardsSHServiceParamArray:paramArray];

}

#pragma mark 更改银行卡名称缩写
-(NSString *)bankName:(NSString *)bankCode{
    
    NSString *name = @"";
    NSInteger code = bankCode.integerValue;
    switch (code) {
        case 1:
            name = @"BOC";
            return name;
            break;
        case 2:
            name = @"ICBC";
            return name;
            break;
        case 3:
            name = @"CCB";
            return name;
            break;
        case 4:
            name = @"ABC";
            return name;
            break;
        case 8:
            name = @"CITIC";
            return name;
            break;
        case 9:
            name = @"CIB";
            return name;
            break;
        case 10:
            name = @"CEB";
            return name;
            break;
        default:
            break;
    }
    return name;
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
