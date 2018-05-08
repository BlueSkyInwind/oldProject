//
//  EditCardsController.m
//  fxdProduct
//
//  Created by zy on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "EditCardsController.h"
#import "BankCardNameVCModules.h"
#import "WTCameraViewController.h"
#import "ReturnMsgBaseClass.h"
#import "SMSViewModel.h"
#import <MGBaseKit/MGBaseKit.h>
#import <MGBankCard/MGBankCard.h>
#import "UnbundlingBankCardViewModel.h"
#import "CheckViewModel.h"
#import "YX_BankCardScanManager.h"
#import "YXBankCardModel.h"

@interface EditCardsController ()<UITableViewDataSource,UITableViewDelegate,BankTableViewSelectDelegate,WTCameraDelegate,UITextFieldDelegate>
{
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    NSMutableArray *markAry;
    ReturnMsgBaseClass *_codeParse;
    NSArray *_dataArray;
    NSArray *_dataInfoArray;
    //    NSDictionary *_createBankDict;
    //原卡号
    NSString *_currentCardNum;
    //截止时间
    NSString *_cutOffDate;
    //安全码
    NSString *_securityCode;
    NSInteger _cardFlag;
    NSMutableArray * supportBankListArr;
    BOOL _btnStatus;
    
}
/**<#Description#>*/
@property (nonatomic,strong)ChooseCreditDateView  * chooseCreditDateView;
@end

@implementation EditCardsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackItem];
    _countdown = 60;
    [FXD_Tool setCorner:self.btnSaveInfo borderColor:UI_MAIN_COLOR];
    _currentCardNum=self.cardNum;
    self.cardNum=[self changeStr:self.cardNum];
    self.verCode=@"";
    self.title=@"信用卡认证";
    supportBankListArr = [NSMutableArray array];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.0001)];
    [self.tableView registerClass:[ContentTableViewCell class] forCellReuseIdentifier:@"ContentTableViewCell"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    if (UI_IS_IPHONEX) {
        self.headerViewHeader.constant = 88;
    }
    _cardFlag = 100;
    _btnStatus = false;
    UITapGestureRecognizer *tapSecory = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicksecry)];
    self.userReadLabel.userInteractionEnabled=YES;
    [self.userReadLabel addGestureRecognizer:tapSecory];
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
    [self fatchCardInfo];
}

- (void)addBackItem
{
    if (@available(iOS 11.0, *)) {
        UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(disMiss)];
        //initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
        self.navigationItem.leftBarButtonItem = aBarbi;
        return;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *img = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
//    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
}

- (void)disMiss
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clicksecry
{
    if([self.cardCode isEqualToString:@""] || self.cardCode == nil)
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择银行卡类型"];
        return;
    }
    if([self.cardNum isEqualToString:@""])
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的卡号"];
        return;
    }
    [self obtainTransferAuth:self.cardCode cardNo:self.cardNum];
}

- (IBAction)agreeClick:(UIButton *)sender {
    if (!_btnStatus) {
        [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"tricked"] forState:UIControlStateNormal];
    } else {
        [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
    }
    _btnStatus = !_btnStatus;
}

- (BOOL)isValidCode:(NSString *)passWord
{
    return passWord.length > 5;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
    if (!cell) {
        cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
    }
        if(indexPath.row==0)
    {
        cell.contentTextField.enabled=false;
        cell.contentTextField.text=self.cardName;
        cell.titleLabel.text=@"开户银行";
    }
    else if(indexPath.row==1)
    {
        cell.contentTextField.tag=1001;
        cell.contentTextField.delegate=self;
        cell.contentTextField.text=self.cardNum;
        cell.contentTextField.keyboardType=UIKeyboardTypeNumberPad;
        cell.titleLabel.text=@"信用卡号";
        [cell.arrowsImageBtn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
        [cell updateScanCardImageBtnLayout];
        __weak typeof (self) weakSelf = self;
        cell.btnClick = ^(UIButton * button) {
            [weakSelf GetNum];
        };
    } else if(indexPath.row== 2)
    {
        cell.contentTextField.tag=1004;
        cell.contentTextField.delegate=self;
        cell.contentTextField.keyboardType=UIKeyboardTypeNumberPad;
        cell.contentTextField.text = _securityCode != nil ? _cutOffDate : @"";
        cell.titleLabel.text=@"信用卡安全码";
        cell.arrowsImageBtn.hidden = YES;
    } else if(indexPath.row== 3)
    {
        cell.contentTextField.enabled=false;
        cell.titleLabel.text=@"信用卡截止日期";
        cell.contentTextField.text = _cutOffDate != nil ? _cutOffDate : @"";
        [cell.arrowsImageBtn setBackgroundImage:[UIImage imageNamed:@"application_Explication_Image"] forState:UIControlStateNormal];
        [cell updateScanCardImageBtnLayout];
        [cell updateTitleLabelLayout];
        __weak typeof (self) weakSelf = self;
        cell.btnClick = ^(UIButton * button) {
            
        };
    }
    else if(indexPath.row==4)
    {
        cell.contentTextField.tag=1002;
        cell.contentTextField.delegate=self;
        cell.titleLabel.text=@"预留手机号";
        cell.contentTextField.text = self.reservedTel != nil ? self.reservedTel : @"";
        cell.contentTextField.keyboardType=UIKeyboardTypeNumberPad;
        cell.arrowsImageBtn.hidden = YES;
    }
    else
    {
        cell.contentTextField.tag=1003;
        cell.contentTextField.delegate=self;
        cell.titleLabel.text=@"验证码";
        cell.contentTextField.delegate=self;
        cell.arrowsImageBtn.tag=1111;
        [cell.arrowsImageBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [cell updateVerfiyCodeImageBtnLayout];
        cell.contentTextField.keyboardType=UIKeyboardTypeNumberPad;
        __weak typeof (self) weakSelf = self;
        cell.btnClick = ^(UIButton * button) {
            [weakSelf getSecory];
        };
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self bankChoose];
    }else if (indexPath.row == 3){
        [self popChooseDateView];
    }
}

- (void)closeGetVerifyButtonUser
{
    UIButton *btn=(UIButton*)[self.view viewWithTag:1111];
    _countdown -= 1;
    [btn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        btn.userInteractionEnabled = YES;
        btn.alpha = 1;
        [btn setTitle:@"重新获取" forState:UIControlStateNormal];
        _countdown = 60;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}

#pragma mark BtnClick
-(void)popChooseDateView
{
    if (_chooseCreditDateView) {
        return;
    }
    __weak typeof (self) weakSelf = self;
    _chooseCreditDateView = [[ChooseCreditDateView alloc] init:self.view];
    [_chooseCreditDateView show];
    _chooseCreditDateView.sureChooseDate = ^(NSString * date) {
        _cutOffDate = date;
        [weakSelf.tableView reloadData];
        [weakSelf.chooseCreditDateView dismiss];
        weakSelf.chooseCreditDateView = nil;
    };
    _chooseCreditDateView.cancelChooseDate = ^{
        [weakSelf.chooseCreditDateView dismiss];
        weakSelf.chooseCreditDateView = nil;
    };
}

-(void)bankChoose
{
    BankCardNameVCModules *bankType=[BankCardNameVCModules new];
    bankType.cardTag = [self.cardCode integerValue];
    //    bankType.bankFlag = 100;
    bankType.delegate=self;
    bankType.cardTag = _cardFlag;
    bankType.bankArray = supportBankListArr;
    [self.navigationController pushViewController:bankType animated:YES];
}

/**
 扫描银行卡
 */
-(void)GetNum
{
    [self startBankCamera];
    DLog(@"银行卡扫描");
}
/**
 开始银行卡扫描  author wangyongxin  2017.4.17
*/
- (void)startBankCamera
{
    [YX_BankCardScanManager shareInstance].isPush = false;
    [YX_BankCardScanManager shareInstance].backImageName = @"return";
    [YX_BankCardScanManager shareInstance].nagavigationVC.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [[YX_BankCardScanManager shareInstance] CardStart:self finish:^(YXBankCardModel * _Nullable result) {
        if ([self isContainCurrentScan:result.bankName]) {
            self.cardName = result.bankName;
            self.cardNum = result.bankNumber;
            [self.tableView reloadData];
        }
        //结果出来释放一下
        [YX_BankCardScanManager relaseSelf];
    }];
}

-(BOOL)isContainCurrentScan:(NSString *)bankname{
    if (supportBankListArr.count > 0) {
        for (int i = 0; i < supportBankListArr.count; i++) {
            SupportBankList * bankList = supportBankListArr[i];
            if ([bankList.bank_name_ isEqualToString:bankname]) {
                self.cardCode = bankList.bank_code_;
                _cardFlag = i;
                return true;
            }
        }
    }
    return false;
}

#pragma  mark Delegate
- (void)BankSelect:(SupportBankList *)bankInfo andSectionRow:(NSInteger)sectionRow
{
    self.cardName = bankInfo.bank_name_;//银行名字
    self.cardCode = bankInfo.bank_code_;//银行编码
    self.cardLogogram = bankInfo.bank_short_name_; //银行缩写
    _cardFlag = sectionRow;
    DLog(@"%@ %@",self.cardName,self.cardCode);
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)didReceiveMemoryWarning {
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

- (IBAction)btnSave:(id)sender {
    self.intNum = [self.cardNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([_currentCardNum isEqualToString:self.intNum])
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您没有更换银行卡无需保存"];
        return;
    }
    if([self.cardCode isEqualToString:@""] || self.cardCode == nil)
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择银行卡类型"];
    }
    else if([self.cardNum isEqualToString:@""])
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的卡号"];
    }
    else if([self.reservedTel isEqualToString:@""])
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入手机号"];
    }
    else if([self.verCode isEqualToString:@""])
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入验证码"];
    }else if (!_btnStatus) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请同意转账授权书"];
    }
    else
    {
        NSMutableArray *paramArray = [self getParamArray];
        UnbundlingBankCardViewModel *unbundlingBankCardViewModel = [[UnbundlingBankCardViewModel alloc]init];
        [unbundlingBankCardViewModel setBlockWithReturnBlock:^(id returnValue) {
            BaseResultModel *baseRM  = returnValue;
            if ([baseRM.errCode  isEqualToString:@"0"]) {
                if (self.popOrdiss == true) {
                    [self.navigationController popViewControllerAnimated:true];
                }else{
                    [self dismissViewControllerAnimated:YES completion:^{
                        self.addCarSuccess();
                    }];
                }
            }
            else
            {
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:baseRM.friendErrMsg];
            }
        } WithFaileBlock:^{
            
        }];
        [unbundlingBankCardViewModel saveAccountBankCard:paramArray];
    }
}
-(void)getSecory
{
    if([FXD_Tool isMobileNumber:self.reservedTel]){
        UIButton *btn=(UIButton*)[self.view viewWithTag:1111];
        btn.userInteractionEnabled=NO;
        btn.alpha = 0.4;
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
        
        SMSViewModel *smsViewModel = [[SMSViewModel alloc]init];
        [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
            BaseResultModel * baseRM = returnValue;
            if ([baseRM.errCode isEqualToString:@"0"]) {
                
            }else{
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
            }
        } WithFaileBlock:^{
        }];
        [smsViewModel fatchRequestSMSParamPhoneNumber:self.reservedTel verifyCodeType:ADDCARD_CODE];
        DLog(@"发送验证码");
    }
    else
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的手机号"];
    }
}
/**
 获取更换银行卡参数数组
 */
-(NSMutableArray *)getParamArray{

    NSMutableArray *array = [NSMutableArray array];
    [array addObject:self.cardCode];
    [array addObject:@"2"];
    [array addObject:self.intNum];
    [array addObject:self.reservedTel];
    [array addObject:self.verCode];
    [array addObject:_securityCode];
    [array addObject:_cutOffDate];
    [array addObject:@"请求类型"];
    return array;
}

-(void)obtainTransferAuth:(NSString *)cardBank cardNo:(NSString *)cardNo{
    CommonViewModel * commonVM = [[CommonViewModel alloc]init];
    [commonVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = returnValue;
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            NSDictionary * dic = (NSDictionary *)baseResultM.data;
            FXDWebViewController * fxdwebVC = [[FXDWebViewController alloc]init];
            fxdwebVC.urlStr =  [dic objectForKey:@"productProURL"];
            [self.navigationController pushViewController:fxdwebVC animated:YES];
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [commonVM obtainTransferAuthProtocolType:EliteLoan typeCode:@"1" cardBankCode:cardBank cardNo:cardNo stagingType:nil];
}

- (void)fatchCardInfo
{
    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = returnValue;
        if ([baseResult.errCode isEqualToString:@"0"]) {
            NSArray * array  = (NSArray *)baseResult.data;
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [supportBankListArr addObject:bankList];
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getSupportBankListInfo:@"2"];
}
#pragma mark TextfileDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1001) {
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
        self.cardNum=newString;
        if (newString.length >= 24) {
            return NO;
        }
        [textField setText:newString];
        return NO;
        
    }
    else if(textField.tag==1002)
    {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>11) {
            self.reservedTel=textField.text;
            return NO;
        }
        self.reservedTel=stringLength;
    }
    else if(textField.tag==1003)
    {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([stringLength length]>6) {
            self.verCode=textField.text;
            return NO;
        }
        self.verCode=stringLength;
    }
    return YES;
}
@end
