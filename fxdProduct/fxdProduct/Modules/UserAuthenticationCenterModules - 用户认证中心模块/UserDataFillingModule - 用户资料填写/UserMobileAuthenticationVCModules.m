//
//  UserMobileAuthenticationVCModules.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserMobileAuthenticationVCModules.h"
#import "MobileCell.h"
#import <MGLivenessDetection/MGLivenessDetection.h>
#import "MGLiveViewController.h"
#import "BaseNavigationViewController.h"
#import "FXDWebViewController.h"
#import "AuthenticationViewModel.h"

typedef enum {
    
    DeafultViewType,
    VerifyCodeViewType,
    PicCodeViewType,
    verifyCodeAndPicCodeViewType,

}CurrentDisplayType;

@interface UserMobileAuthenticationVCModules ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,LiveDeteDelgate>
{

    BOOL _captchaHidenDisplay;
    BOOL _picCodeHidenDisplay;
    
    NSMutableArray <NSString *>*_mobileRequArr;
    
    UIImage * picCodeImage;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL btnStatus;

@property (nonatomic,assign)CurrentDisplayType  currentDisplayType;

@end

@implementation UserMobileAuthenticationVCModules

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = false;
    _captchaHidenDisplay = true;
    _picCodeHidenDisplay= true;
    _currentDisplayType = DeafultViewType;
    _mobileRequArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"手机运营商认证";
    _btnStatus = YES;
    [self addBackItem];
    [self configTableView];
    [self fatchMobileOpera];
}

- (void)configTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MobileCell class]) bundle:nil] forCellReuseIdentifier:@"MobileCell"];
}

#pragma mark - TableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MobileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MobileCell"];
    //协议
    cell.AgreementImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreementImage:)];
    [cell.AgreementImage addGestureRecognizer:tap];
    NSString *str = cell.AgreementLabel.text;
    NSMutableAttributedString *ssa = [[NSMutableAttributedString alloc] initWithString:str];
    [ssa addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3,13)];
    cell.AgreementLabel.attributedText = ssa;
    cell.AgreementLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreement)];
    [cell.AgreementLabel addGestureRecognizer:tap1];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.passwordField.delegate = self;
    cell.veritifyCodeField.delegate = self;
    cell.picCodeTextField.delegate = self;
    [FXD_Tool setCorner:cell.mobileBtn borderColor:[UIColor clearColor]];
    if (![_isMobileAuth isEqualToString:@"2"]) {
        if ([self isCanEnable]) {
            [cell.mobileBtn setBackgroundColor:UI_MAIN_COLOR];
            cell.mobileBtn.enabled = true;
            [cell.mobileBtn addTarget:self action:@selector(mobileCheck) forControlEvents:UIControlEventTouchUpInside];
        }else {
            [cell.mobileBtn setBackgroundColor:rgb(139, 140, 143)];
            cell.mobileBtn.enabled = false;
        }
    } else {
        [cell.mobileBtn setBackgroundColor:rgb(139, 140, 143)];
        cell.passwordField.enabled = false;
        [cell.mobileBtn setTitle:@"已认证" forState:UIControlStateNormal];
        cell.mobileBtn.enabled = false;
    }
    //初始化UI
    cell.mobileLabel.text = _mobileRequArr[0];
    cell.operatorLabel.text = _mobileRequArr[1];
    cell.passwordField.text = _mobileRequArr[2];
    cell.passwordField.tag = 1;
    cell.veritifyCodeField.text = _mobileRequArr[3];
    cell.veritifyCodeField.tag = 2;
    [cell.mobileHelpBtn addTarget:self action:@selector(showMobileHelp) forControlEvents:UIControlEventTouchUpInside];
    //图片验证码
    cell.picCodeTextField.text = _mobileRequArr[4];
    cell.picCodeTextField.tag = 3;
    
    switch (_currentDisplayType) {
        case DeafultViewType:{
            cell.picCodeView.hidden = YES;
            cell.smsCodeView.hidden = YES;
            cell.agreementTopConstraint.constant = 5;
            cell.moblieBtnTopConstraint.constant = 30;
        }
            break;
        case VerifyCodeViewType:{
            cell.picCodeView.hidden = YES;
            cell.smsCodeView.hidden = NO;
            cell.agreementTopConstraint.constant = 51;
            cell.moblieBtnTopConstraint.constant = 76;
        }
            break;
        case PicCodeViewType:{
            cell.picCodeView.hidden = NO;
            cell.smsCodeView.hidden = YES;
            cell.picCodeViewTopConstraint.constant = 5;
            cell.agreementTopConstraint.constant = 51;
            cell.moblieBtnTopConstraint.constant = 76;
            [cell.picCodeBtn setBackgroundImage:picCodeImage forState:UIControlStateNormal];
        }
            break;
        case verifyCodeAndPicCodeViewType:{
            cell.picCodeView.hidden = NO;
            cell.smsCodeView.hidden = NO;
            cell.picCodeViewTopConstraint.constant = 51;
            cell.agreementTopConstraint.constant = 97;
            cell.moblieBtnTopConstraint.constant = 111;
            [cell.picCodeBtn setBackgroundImage:picCodeImage forState:UIControlStateNormal];
        }
            break;
        default:             break;
    }
    return cell;
}

//认证button是否能点击
- (BOOL)isCanEnable
{
    if (_currentDisplayType == DeafultViewType) {
        if (_mobileRequArr[2].length > 5) {
            return true;
        } else {
            return false;
        }
    }else if (_currentDisplayType == VerifyCodeViewType){
        if (_mobileRequArr[2].length > 5 && _mobileRequArr[3].length > 3) {
            return true;
        } else {
            return false;
        }
    }else if (_currentDisplayType == PicCodeViewType){
        if (_mobileRequArr[2].length > 5 && _mobileRequArr[4].length > 3) {
            return true;
        } else {
            return false;
        }
    }else if (_currentDisplayType == verifyCodeAndPicCodeViewType){
        if (_mobileRequArr[2].length > 5 && _mobileRequArr[4].length > 3 && _mobileRequArr[3].length > 3) {
            return true;
        } else {
            return false;
        }
    }
    return false;
}

- (void)showMobileHelp{
    
    [self obtainUseHelp];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        if (textField.text.length < 5) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的运营商服务密码"];
            [_mobileRequArr replaceObjectAtIndex:2 withObject:@""];
        } else {
            [_mobileRequArr replaceObjectAtIndex:2 withObject:textField.text];
        }
    }
    if (textField.tag == 2) {
        if (textField.text.length < 3) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
            [_mobileRequArr replaceObjectAtIndex:3 withObject:@""];
        } else {
            [_mobileRequArr replaceObjectAtIndex:3 withObject:textField.text];
        }
    }
    if (textField.tag == 3) {
        if (textField.text.length < 3) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
            [_mobileRequArr replaceObjectAtIndex:4 withObject:@""];
        }else{
            [_mobileRequArr replaceObjectAtIndex:4 withObject:textField.text];
        }
    }
    [_tableView reloadData];
}
#pragma mark - 认证Btn点击
- (void)mobileCheck
{
    if (!_btnStatus) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"需同意授权协议，才可进行认证"];
        return;
    }
    if (_whetherPhoneAuth) {
        [self saveMobileAuth:@"1"];
    }else {
       if([self.phoneAuthChannel isEqualToString:@"TC"]){
            //手机号认证  （天创）
            [self TCmobileAuth];
        }else{
            [self TCmobileAuth];
        }
    }
}
#pragma mark - 天创手机号认证

-(void)TCmobileAuth{
    
    NSString *mobileStr = [_mobileRequArr[0] stringByReplacingOccurrencesOfString:@" " withString:@""];

    AuthenticationViewModel * authenticationViewModel = [[AuthenticationViewModel alloc]init];
    [authenticationViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]){
//            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
            [self saveMobileAuth:@"1"];
        }else if ([baseRM.errCode isEqualToString:@"19"]){
            //需要图片验证码
            picCodeImage = [self returnPicCodeImage:[[returnValue objectForKey:@"result"] objectForKey:@"picContent"]];
            _currentDisplayType = PicCodeViewType;
            [_tableView reloadData];
        }else if ([baseRM.errCode isEqualToString:@"20"]){
            //需要图片和手机验证码
            picCodeImage = [self returnPicCodeImage:[[returnValue objectForKey:@"result"] objectForKey:@"picContent"]];
            _currentDisplayType = verifyCodeAndPicCodeViewType;
            [_tableView reloadData];
        }else if ([baseRM.errCode isEqualToString:@"6"]){
            //需要手机验证码
            _currentDisplayType = VerifyCodeViewType; //错误时 验证码显示
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
            [_tableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
            [self saveMobileAuth:@"-1"];
        }
    } WithFaileBlock:^{
        
    }];
    [authenticationViewModel TCphoneAuthenticationPhoneNum:mobileStr password:_mobileRequArr[2] smsCode:_mobileRequArr[3] picCode:_mobileRequArr[4]];
}
-(UIImage *)returnPicCodeImage:(NSString *)imageStr{
    
    NSData *decodedImageData   = [[NSData alloc]initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *  image = [UIImage imageWithData:decodedImageData];
    return image;
}

- (void)saveMobileAuth:(NSString *)authCode
{
    __weak UserMobileAuthenticationVCModules *weakself = self;
    AuthenticationViewModel * authenticationViewModel = [[AuthenticationViewModel alloc]init];
    [authenticationViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRm = returnValue;
        if ([baseRm.errCode isEqualToString:@"0"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"认证成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:baseRm.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [authenticationViewModel SaveMobileAuth:authCode];
}

#pragma mark - 获取手机运营商
- (void)fatchMobileOpera
{
    AuthenticationViewModel * authenticationViewModel = [[AuthenticationViewModel alloc]init];
    [authenticationViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            NSString *telNum = [FXD_Utility sharedUtility].userInfo.userMobilePhone;
            [_mobileRequArr replaceObjectAtIndex:0 withObject:[self formatString:telNum]];
            NSString *result = (NSString *)baseRM.data;
            [_mobileRequArr replaceObjectAtIndex:1 withObject:result];
            [_tableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [authenticationViewModel obtainUserPhoneCarrierName];
}

- (NSString *)formatString:(NSString *)str
{
    NSMutableString *returnStr = [NSMutableString stringWithString:str];
    
    NSMutableString *zbc = [NSMutableString string];
    for (NSInteger i = 0; i < returnStr.length; i++) {
        unichar c = [returnStr characterAtIndex:i];
        if (i > 0) {
            if (i == 2) {
                [zbc appendFormat:@"%C ",c];
                
            }else if (i == 6){
                [zbc appendFormat:@"%C ",c];
            }else {
                [zbc appendFormat:@"%C",c];
            }
        } else {
            [zbc appendFormat:@"%C",c];
        }
    }
    return zbc;
}

-(void)clickAgreementImage:(UITapGestureRecognizer *)sender{

    UIImageView *agreementImage = (UIImageView *)sender.view;
    self.btnStatus = !self.btnStatus;
    
    if (!self.btnStatus) {
        agreementImage.image = [UIImage imageNamed:@"trick"];
    } else {
        agreementImage.image = [UIImage imageNamed:@"tricked"];
    }
}

-(void)clickAgreement{
    
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
    [commonVM obtainProductProtocolType:@"operInfo" typeCode:@"4" apply_id:nil periods:nil];
}

-(void)obtainUseHelp{
    
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
    [commonVM obtainProductProtocolType:nil typeCode:@"12" apply_id:nil periods:nil];
    
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
