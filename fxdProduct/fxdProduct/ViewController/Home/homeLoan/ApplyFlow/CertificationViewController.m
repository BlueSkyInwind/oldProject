//
//  CertificationViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CertificationViewController.h"
#import "FaceCell.h"
#import "MobileCell.h"
#import <MGLivenessDetection/MGLivenessDetection.h>
#import "FaceIDLiveModel.h"
#import "JXLParse.h"
#import "JXLMessagePrse.h"
#import "ReturnMsgBaseClass.h"
#import "MGLiveViewController.h"
#import "BaseNavigationViewController.h"
#import "ExpressViewController.h"
#import "FXDWebViewController.h"
#import "AuthenticationViewModel.h"

typedef enum {
    
    DeafultViewType,
    VerifyCodeViewType,
    PicCodeViewType,
    verifyCodeAndPicCodeViewType,

}CurrentDisplayType;



@interface CertificationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,LiveDeteDelgate>
{
    JXLParse *_jxlParse;
    BOOL _captchaHidenDisplay;
    BOOL _picCodeHidenDisplay;
    
    NSMutableArray <NSString *>*_mobileRequArr;
    ReturnMsgBaseClass *_mobileParse;
    
    UIImage * picCodeImage;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL btnStatus;

@property (nonatomic,assign)CurrentDisplayType  currentDisplayType;

@end

@implementation CertificationViewController

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
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FaceCell class]) bundle:nil] forCellReuseIdentifier:@"FaceCell"];
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
    [Tool setCorner:cell.mobileBtn borderColor:[UIColor clearColor]];
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
        default:
            break;
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
    
    FXDWebViewController *controller = [[FXDWebViewController alloc]init];
    controller.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_mobileAuthentication_url];
    [self.navigationController pushViewController:controller animated:YES];

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
        if ([self.phoneAuthChannel isEqualToString:@"JXL"]) {
            // 手机号认证  （聚立信）
            [self mibileAuth];
        }else if([self.phoneAuthChannel isEqualToString:@"TC"]){
            //手机号认证  （天创）
            [self TCmobileAuth];
        }else{
            [self TCmobileAuth];
        }
    }
}
#pragma mark - 聚信立手机号认证
- (void)mibileAuth
{
    NSDictionary *paramDic;
    NSString *mobileStr = [_mobileRequArr[0] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (_currentDisplayType == DeafultViewType) {
        paramDic = @{@"mobile_phone_":mobileStr,
                     @"service_password_":_mobileRequArr[2]
                     };
    } else if(_currentDisplayType == VerifyCodeViewType){
        paramDic = @{@"mobile_phone_":mobileStr,
                     @"service_password_":_mobileRequArr[2],
                     @"verify_code_":_mobileRequArr[3]
                     };
    }
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_Certification_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            _mobileParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
            if ([_mobileParse.flag isEqualToString:@"0000"])
            {
                //                [dataListAll2 replaceObjectAtIndex:13 withObject:@"2"];
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                //                _segment.selectedSegmentIndex = 1;
                //                [self createUIWith:_segment.selectedSegmentIndex];
                [self saveMobileAuth:@"1"];
            }else if ([_mobileParse.flag isEqualToString:@"0006"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                //                [dataListAll2 replaceObjectAtIndex:12 withObject:@"flag"];
                _currentDisplayType = VerifyCodeViewType;//错误时 验证码显示
                [_tableView reloadData];
            }else{
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                [self saveMobileAuth:@"-1"];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}
#pragma mark - 天创手机号认证

-(void)TCmobileAuth{
    
    NSString *mobileStr = [_mobileRequArr[0] stringByReplacingOccurrencesOfString:@" " withString:@""];

    AuthenticationViewModel * authenticationViewModel = [[AuthenticationViewModel alloc]init];
    [authenticationViewModel setBlockWithReturnBlock:^(id returnValue) {
        _mobileParse = [ReturnMsgBaseClass modelObjectWithDictionary:returnValue];
        if ([_mobileParse.flag isEqualToString:@"0000"]){
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
            [self saveMobileAuth:@"1"];
        }else if ([_mobileParse.flag isEqualToString:@"0019"]){
            //需要图片验证码
            picCodeImage = [self returnPicCodeImage:[[returnValue objectForKey:@"result"] objectForKey:@"picContent"]];
            _currentDisplayType = PicCodeViewType;
            [_tableView reloadData];
        }else if ([_mobileParse.flag isEqualToString:@"0020"]){
            //需要图片和手机验证码
            picCodeImage = [self returnPicCodeImage:[[returnValue objectForKey:@"result"] objectForKey:@"picContent"]];
            _currentDisplayType = verifyCodeAndPicCodeViewType;
            [_tableView reloadData];
        }else if ([_mobileParse.flag isEqualToString:@"0006"]){
            //需要手机验证码
            _currentDisplayType = VerifyCodeViewType; //错误时 验证码显示
            [_tableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
            [self saveMobileAuth:@"-1"];
        }
    } WithFaileBlock:^{
        
    }];
    [authenticationViewModel TCphoneAuthenticationPhoneNum:mobileStr password:_mobileRequArr[2] smsCode:_mobileRequArr[3] picCode:_mobileRequArr[4]];
}
-(UIImage *)returnPicCodeImage:(NSString *)imageStr{
    
//    NSRange range = [imageStr rangeOfString:@","];
//    NSString * str = [imageStr substringFromIndex:range.location + 1];
    NSData *decodedImageData   = [[NSData alloc]initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *  image = [UIImage imageWithData:decodedImageData];
    return image;
}

- (void)saveMobileAuth:(NSString *)authCode
{
    NSDictionary *dic = @{@"code":authCode};
    __weak CertificationViewController *weakself = self;
    //    __block NSMutableArray * blockDataList = dataListAll2;
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_authMobilePhone_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *returnParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        if ([returnParse.flag isEqualToString:@"0000"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"认证成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.navigationController popViewControllerAnimated:YES];
            });
        }else{
//                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:returnParse.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

#pragma mark - 获取手机运营商
- (void)fatchMobileOpera
{
    //获取手机运营商
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getMobileOpera_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                NSString *telNum = [[object objectForKey:@"ext"] objectForKey:@"mobile_phone_"];
                [_mobileRequArr replaceObjectAtIndex:0 withObject:[self formatString:telNum]];
                NSString *result = [object objectForKey:@"result"];
                [_mobileRequArr replaceObjectAtIndex:1 withObject:result];
                [_tableView reloadData];
            }else{
                DLog(@"获取失败");
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"运营商信息获取失败"];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}
//- (void)mobileCheck
//{
//    if (_mobileRequArr[0].length<5 || _mobileRequArr[1].length < 3) {
//        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入服务密码或验证码"];
//    }
//
//    __weak CertificationViewController *weakSelf = self;
//    if (_jxlParse &&![_jxlParse.data.token isEqualToString:@""] && ![_jxlParse.data.datasource.website isEqualToString:@""]) {
//        [self startRequMessage:_jxlParse.data.token finsh:^(JXLMessagePrse *messageParse) {
//            [weakSelf setUIUpdate:messageParse];
//        }];
//    } else {
//        [weakSelf fatchJXLToken:^{
//            [weakSelf startRequMessage:_jxlParse.data.token finsh:^(JXLMessagePrse *messageParse) {
//                [weakSelf setUIUpdate:messageParse];
//            }];
//        }];
//    }
//}

- (void)setUIUpdate:(JXLMessagePrse *)messageParse
{
    if (messageParse.success) {
        switch (messageParse.data.process_code) {
            case 10002:
            case 10004:
            case 10006:
            {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:messageParse.data.content];
                _captchaHidenDisplay = false;
                [_tableView reloadData];
            }
                break;
            case 10003:
            case 10007:
            case 10009:
            case 10010:
            case 30000:
            {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:messageParse.data.content];
            }
                break;
            case 10008:
            {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:true];
                });
            }
                break;
                
            default:
                break;
        }
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:messageParse.data.content];
    }
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
    
    ExpressViewController *controller = [[ExpressViewController alloc]init];
    controller.productId = @"operInfo";
    [self.navigationController pushViewController:controller animated:YES];
    
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
