//
//  EditCardsController.m
//  fxdProduct
//
//  Created by zy on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "EditCardsController.h"
#import "LabelCell.h"
#import "HomeBankCardViewController.h"
#import "WTCameraViewController.h"
#import "ReturnMsgBaseClass.h"
#import "SMSViewModel.h"
#import "BankModel.h"
#import "ContactList.h"
#import "AuthorizationViewController.h"
#import <MGBaseKit/MGBaseKit.h>
#import <MGBankCard/MGBankCard.h>

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
    NSInteger _cardFlag;
    BankModel *_bankCardModel;
    BOOL _btnStatus;
}
@end

@implementation EditCardsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackItem];
    _countdown = 60;
    [Tool setCorner:self.btnSaveInfo borderColor:UI_MAIN_COLOR];
    _currentCardNum=self.cardNum;
    self.cardNum=[self changeStr:self.cardNum];
    self.reservedTel=@"";
    self.verCode=@"";
    if([self.typeFlag isEqualToString:@"0"])
    {
        self.title=@"添加银行卡";
    }
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"LabelCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    _cardFlag = 100;
    _btnStatus = false;
    UITapGestureRecognizer *tapSecory = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicksecry)];
    self.userReadLabel.userInteractionEnabled=YES;
    [self.userReadLabel addGestureRecognizer:tapSecory];
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"trick"] forState:UIControlStateNormal];
    [self fatchCardInfo];
}

- (void)fatchCardInfo
{
    NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        _bankCardModel = [BankModel yy_modelWithJSON:object];
        if ([_bankCardModel.flag isEqualToString:@"0000"]) {
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_bankCardModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

- (void)addBackItem
{
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
}


- (void)clicksecry
{
    AuthorizationViewController *authVC = [[AuthorizationViewController alloc] init];
    authVC.cardNum = self.cardNum;
    authVC.bankName = self.cardName;
    [self.navigationController pushViewController:authVC animated:YES];
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
    if([self.typeFlag isEqualToString:@"0"])
    {
        return 4;
    }
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LabelCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    [Tool setCorner:cell.bgView borderColor:UI_MAIN_COLOR];
    cell.textField.textColor=UI_MAIN_COLOR;
    if(indexPath.row==0)
    {
        cell.btnSecory.hidden=YES;
        cell.textField.enabled=false;
        cell.textField.text=self.cardName;
        cell.textField.placeholder=@"银行卡类型";
        [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_25"] forState:UIControlStateNormal];
        [cell.btn addTarget:self action:@selector(bankChoose) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(indexPath.row==1)
    {
        cell.btnSecory.hidden=YES;
        
        cell.textField.tag=1001;
        cell.textField.delegate=self;
        cell.textField.text=self.cardNum;
        cell.textField.keyboardType=UIKeyboardTypeNumberPad;
        cell.textField.placeholder=@"银行卡号";
        [cell.btn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
        [cell.btn addTarget:self action:@selector(GetNum) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(indexPath.row==2)
    {
        cell.textField.tag=1002;
        cell.textField.delegate=self;
        cell.textField.placeholder=@"预留手机号";
        cell.textField.keyboardType=UIKeyboardTypeNumberPad;
        cell.btnSecory.hidden=YES;
        cell.btn.hidden=YES;
    }
    else
    {
        cell.textField.tag=1003;
        cell.textField.delegate=self;
        cell.textField.placeholder=@"验证码";
        cell.textField.delegate=self;
        cell.btnSecory.tag=1111;
        cell.textField.keyboardType=UIKeyboardTypeNumberPad;
        cell.btn.hidden=YES;
        [cell.btnSecory addTarget:self action:@selector(getSecory) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
-(void)bankChoose
{
    HomeBankCardViewController *bankType=[HomeBankCardViewController new];
    bankType.cardTag = [self.cardCode integerValue];
    //    bankType.bankFlag = 100;
    bankType.delegate=self;
    bankType.cardTag = _cardFlag;
    //    if([self.typeFlag isEqualToString:@"0"])
    //    {
    //        bankType.bankFlag=99;
    //    }
    //    else
    //    {
    //        bankType.bankFlag=101;
    //    }
    bankType.bankModel = _bankCardModel;
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

-(void)getSecory
{
    //    UITextField *textField=(UITextField*)[self.view viewWithTag:1002];
    
    if([Tool isMobileNumber:self.reservedTel]){
        UIButton *btn=(UIButton*)[self.view viewWithTag:1111];
        btn.userInteractionEnabled=NO;
        btn.alpha = 0.4;
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
        
            SMSViewModel *smsViewModel = [[SMSViewModel alloc]init];
            [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
                _codeParse = returnValue;
                
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
                
                DLog(@"---%@",_codeParse.msg);
            } WithFaileBlock:^{
                
            }];
            [smsViewModel fatchRequestSMSParamPhoneNumber:self.reservedTel flag:CODE_ADDCARD];
            
            DLog(@"发送验证码");
    }
    else
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的手机号"];
    }
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
/**
 开始银行卡扫描  author wangyongxin  2017.4.17
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
    
    __unsafe_unretained EditCardsController * weakSelf = self;
    MGBankCardManager *cardManager = [[MGBankCardManager alloc] init];
    [cardManager setDebug:YES];
    [cardManager CardStart:self finish:^(MGBankCardModel * _Nullable result) {
        //        weakSelf.bankImageView.image = result.image;
        //        weakSelf.bankNumView.text = result.bankCardNumber;
        
        weakSelf.cardNum = result.bankCardNumber;
        weakSelf.cardNum = [self.cardNum stringByReplacingOccurrencesOfString:@" " withString:@""];
        weakSelf.cardNum=[self changeStr:self.cardNum];
        DLog(@"银行卡扫描可信度 -- %@",[NSString stringWithFormat:@"confidence:%.2f", result.bankCardconfidence]);
        [weakSelf.tableView reloadData];

    }];
    
}


#pragma  mark Delegate
//-(void)BankTableViewSelect:(NSString *)CurrentRow andBankInfoList:(NSString *)bankNum andSectionRow:(NSInteger)SectionRow
//{
//    self.cardName=CurrentRow;//银行名字
//    self.cardCode=bankNum;//银行编码
//    _cardFlag = SectionRow;
//    DLog(@"%@ %@",self.cardName,self.cardCode);
//    [self.tableView reloadData];
//}

- (void)BankSelect:(BankList *)bankInfo andSectionRow:(NSInteger)sectionRow
{
    self.cardName = bankInfo.desc;//银行名字
    self.cardCode = bankInfo.code;//银行编码
    _cardFlag = sectionRow;
    DLog(@"%@ %@",self.cardName,self.cardCode);
    [self.tableView reloadData];
}
/*
#pragma mark - CamaraDelegate
//银行卡识别核心初始化结果，判断核心是否初始化成功
- (void)initBankCardRecWithResult:(int)nInit{
    self.tabBarController.tabBar.hidden = YES;
    DLog(@"识别核心初始化结果nInit>>>%d<<<",nInit);
}
//拍照和识别成功后返回结果图片、识别字符串
- (void)cameraViewController:(WTCameraViewController *)cameraVC resultImage:(UIImage *)image resultDictionary:(NSDictionary *)resultDic{
    
    DLog(@"银行卡识别结果resultDic>>>%@<<<",resultDic);
    int isExistFlag=0;
//    NSArray *KeyArry=[_createBankDict allKeys];
    for (int i=0; i < _bankCardModel.result.count; i++) {
        
        for (BankList *banklist in _bankCardModel.result) {
            if ([banklist.desc isEqualToString:[resultDic objectForKey:@"bankName"]] || [banklist.desc containsString:[resultDic objectForKey:@"bankName"]] || [[resultDic objectForKey:@"bankName"] containsString:banklist.desc]) {
                self.cardCode = banklist.code;
                
                self.cardNum=resultDic[@"cardNumber"];
                self.cardNum = [self.cardNum stringByReplacingOccurrencesOfString:@" " withString:@""];
                self.cardNum=[self changeStr:self.cardNum];
                
                self.cardName=resultDic[@"bankName"];
                isExistFlag=1;
                break;
            }
        }
    }
    if(isExistFlag==0)
    {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"银行卡暂不支持"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}


//返回按钮被点击时回调此方法，返回相机视图控制器
- (void)backWithCameraViewController:(WTCameraViewController *)cameraVC{
    [cameraVC.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppearWithCameraViewController:(WTCameraViewController *)cameraVC
{
    [cameraVC.navigationController setNavigationBarHidden:YES];
}

//点击UIAlertView时返回相机视图控制器
- (void)clickAlertViewWithCameraViewController:(WTCameraViewController *)cameraVC{
    [cameraVC.navigationController popViewControllerAnimated:YES];
}
//相机视图将要消失时回调此方法，返回相机视图控制器
- (void)viewWillDisappearWithCameraViewController:(WTCameraViewController *)cameraVC
{
    cameraVC.navigationController.navigationBarHidden = NO;
}
*/
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
-(NSDictionary *)getEditDic
{
    return @{
//             @"card_id_":self.accountId,
//             @"reques_type_":@"3",
             @"card_bank_":self.cardCode,
             @"card_type_":@"2",
             @"card_no_":self.intNum,
             @"bank_reserve_phone_":self.reservedTel,
             @"verify_code_":self.verCode
             };
}

- (IBAction)btnSave:(id)sender {
    self.intNum = [self.cardNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([_currentCardNum isEqualToString:self.intNum])
    {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您没有更换银行卡无需保存"];
    }
    else
    {
        if([self.cardNum isEqualToString:@""])
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
            NSDictionary *dic=[self getEditDic];
            [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_BankNumCheck_url] parameters:dic finished:^(EnumServerStatus status, id object) {
                if ([[object objectForKey:@"flag"]  isEqual: @"0000"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:[object objectForKey:@"msg"]];
//                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [self dismissViewControllerAnimated:YES completion:^{
                        self.addCarSuccess();
                    }];
                }
                else
                {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
                }
                
            } failure:^(EnumServerStatus status, id object) {
                
            }];
        }
    }
}
@end
