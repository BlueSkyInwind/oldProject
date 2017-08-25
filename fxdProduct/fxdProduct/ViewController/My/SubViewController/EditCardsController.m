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
#import "UnbundlingBankCardViewModel.h"
#import "CheckViewModel.h"
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
    NSMutableArray * supportBankListArr;
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
    supportBankListArr = [NSMutableArray array];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.0001)];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.tableView registerClass:[ContentTableViewCell class] forCellReuseIdentifier:@"ContentTableViewCell"];

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
    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResult.flag isEqualToString:@"0000"]) {
            NSArray * array  = (NSArray *)baseResult.result;
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [supportBankListArr addObject:bankList];
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getSupportBankListInfo:@"2"];
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
    [self.navigationController popViewControllerAnimated:YES];
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
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
    if (!cell) {
        cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"ContentTableViewCell%ld%ld",indexPath.row,indexPath.section]];
    }
    
    cell.contentTextField.textColor=UI_MAIN_COLOR;
    if(indexPath.row==0)
    {
        cell.contentTextField.enabled=false;
        cell.contentTextField.text=self.cardName;
        cell.titleLabel.text=@"银行卡类型";
    }
    else if(indexPath.row==1)
    {
        
        cell.contentTextField.tag=1001;
        cell.contentTextField.delegate=self;
        cell.contentTextField.text=self.cardNum;
        cell.contentTextField.keyboardType=UIKeyboardTypeNumberPad;
        cell.titleLabel.text=@"银行卡号";
        [cell.arrowsImageBtn setBackgroundImage:[UIImage imageNamed:@"3_lc_icon_26"] forState:UIControlStateNormal];
        [cell updateScanCardImageBtnLayout];
        __weak typeof (self) weakSelf = self;
        cell.btnClick = ^(UIButton * button) {
            [weakSelf GetNum];
        };
    }
    else if(indexPath.row==2)
    {
        cell.contentTextField.tag=1002;
        cell.contentTextField.delegate=self;
        cell.titleLabel.text=@"预留手机号";
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
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self bankChoose];
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
            [smsViewModel fatchRequestSMSParamPhoneNumber:self.reservedTel verifyCodeType:ADDCARD_CODE];
            
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

- (void)BankSelect:(SupportBankList *)bankInfo andSectionRow:(NSInteger)sectionRow
{
    self.cardName = bankInfo.bank_name_;//银行名字
    self.cardCode = bankInfo.bank_code_;//银行编码
    self.cardLogogram = bankInfo.bank_short_name_; //银行缩写
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
            
            NSMutableArray *paramArray = [self getParamArray];
            UnbundlingBankCardViewModel *unbundlingBankCardViewModel = [[UnbundlingBankCardViewModel alloc]init];
            [unbundlingBankCardViewModel setBlockWithReturnBlock:^(id returnValue) {
                
                if ([[returnValue objectForKey:@"flag"]  isEqual: @"0000"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:[returnValue objectForKey:@"msg"]];
                    //                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [self dismissViewControllerAnimated:YES completion:^{
                        self.addCarSuccess();
                    }];
                }
                else
                {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
                }
                
            } WithFaileBlock:^{
                
            }];
            [unbundlingBankCardViewModel saveAccountBankCard:paramArray];

        }
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
    return array;
    
}
@end
