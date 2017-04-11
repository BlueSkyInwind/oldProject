//
//  HomeInfoViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/30.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeInfoViewController.h"
#import "InfoCommonCell.h"
#import "InfoThirdCell.h"
#import "sumitView.h"
#import "HomeDailViewController.h"
#import "HomeBankCardViewController.h"
#import "HomeTelSecoryViewController.h"
#import "WTCameraViewController.h"
#import "InfoFiveCell.h"
#import "ContactList.h"
#import "TelMessageCell.h"
#import "BtnProtectionCell.h"
#import "SubmitViewController.h"
#import "DetaillabeCell.h"
#import "TextDetailLabelCell.h"
#import "ReturnMsgBaseClass.h"
#import "SMSViewModel.h"

//#import "CameraViewController.h"
//#import "WintoneCardOCR.h"


@interface HomeInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BankTableViewSelectDelegate,WTCameraDelegate>
{
    UITableView *_tableView;
    UIView *viewbg;
    NSIndexPath *_inde;
    NSInteger _pushRow;
    NSInteger _push5;
    NSInteger _push8;
    CGFloat _dataString;
    CGFloat _costString;
    NSString *_bankListWhich;
    sumitView *_submitView;
    NSString *_loanNum;
    NSString *_loanData;
    NSString *_loanCost;
    NSString *_loanName;
    NSString *_loanID;
    NSString *_loanBank;
    NSString *_loanBankself;
    NSString *_loanTele;
    NSString *_debitBankName;
    NSString *_creditBankName;
    NSString *_creditListWhich;
    NSArray *_bankNameArr;
    //银行卡
    NSDictionary *_bankCodeDict;
    //信用卡
    NSDictionary *_createBankDict;
    //验证码
    NSString *_telCode;
    //手机号
    NSString *_telPhoneNum;
    
    NSInteger _countdown;
    NSTimer * _countdownTimer;
    
    UIButton *btn;
    
    ReturnMsgBaseClass *_codeParse;
}

@property (assign, nonatomic) int cardType;

@property (assign, nonatomic) int resultCount;

@property (strong, nonatomic) NSString *typeName;


//@property (strong, nonatomic) WintoneCardOCR *cardRecog;

@end

@implementation HomeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= rgb(241, 241, 241);
    _countdown = 60;
    [self addBackItem];
    [self createUI];
}

-(void)createUI{
    _bankCodeDict =@{@"ICBC":@[@"工商银行",@"中国工商银行"],
                     @"ABC":@[@"中国农业银行",@"农业银行"],
                     @"BOC":@[@"中国银行"],
                     @"CCB":@[@"中国建设银行",@"建设银行"],
                     @"CEB":@[@"中国光大银行",@"光大银行"],
                     @"CMBC":@[@"中国民生银行",@"民生银行"],
                     @"CIB":@[@"兴业银行"],
                     @"CITIC":@[@"中信银行"],
                     @"SPDB":@[@"上海浦东发展银行",@"浦东发展银行",@"浦发银行"],
                     @"SPAB":@[@"平安银行"]
                     };
    
    _createBankDict=@{@"ICBC":@[@"工商银行",@"中国工商银行"],
                      @"ABC":@[@"中国农业银行",@"农业银行"],
                      @"BOC":@[@"中国银行"],
                      @"CCB":@[@"中国建设银行",@"建设银行"],
                      @"COMM":@[@"交通银行"],
                      @"CITIC":@[@"中信银行"],
                      @"CEB":@[@"中国光大银行",@"光大银行"],
                      @"HXB":@[@"华夏银行"],
                      @"CMBC":@[@"中国民生银行",@"民生银行"],
                      @"GDB":@[@"广东发展银行",@"广发银行"],
                      @"CMB":@[@"招商银行"],
                      @"CIB":@[@"兴业银行"],
                      @"SPDB":@[@"上海浦东发展银行",@"浦东发展银行",@"浦发银行"],
                      @"PSBC":@[@"中国邮政储蓄银行",@"邮政储蓄，@“邮储银行"],
                      @"SPAB":@[@"平安银行"],
                      @"SDB":@[@"深圳发展银行"]
                      };
    
    self.navigationItem.title = @"提交资料";
    _bankListWhich=@"";
    _creditListWhich=@"";
    _loanNum=@"";
    _creditBankName=@"";
    _loanBankself=@"";
    _push5=100;
    _push8=100;
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64) style:UITableViewStylePlain];
    _tableView.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = rgb(241, 241, 241);
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:_tableView];
}

#pragma mark----Action
//保存
-(void)btnTelPhoneProt
{
    _loanBankself=[_loanBankself stringByReplacingOccurrencesOfString:@" " withString:@""];
    _loanBank=[_loanBank stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([_creditListWhich length]<1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的信用卡类别"];
    }else if ([_loanBankself length]<16) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确信用卡号"];
    }else if ([_bankListWhich length]<1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的银行卡类别"];
    }else if ([_loanBank length]<16) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确银行卡号"];
    }else if ([_telPhoneNum length] !=11) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的手机号"];
    }else if ([_telCode length] !=6) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确的验证码"];
    }else{
        
        NSDictionary *paramDic = @{@"token":[Utility sharedUtility].userInfo.tokenStr,
                                   @"identityId":[[Utility sharedUtility].getMoneyParam objectForKey:@"identityId"],
                                   @"realName":[[Utility sharedUtility].getMoneyParam objectForKey:@"realName"],
                                   @"bankNo":_loanBank,
                                   @"debitMobile":_telPhoneNum,
                                   @"verificationCode":_telCode};
        [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_BankNumCheck_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
            DLog(@"%@",object);
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                        [self setParaDic];
                        SubmitViewController *subVC= [SubmitViewController new];
                        [self.navigationController pushViewController:subVC animated:YES];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"银行卡验证失败!"];
            }
        } failure:^(EnumServerStatus status, id object) {
            
        }];
    }
}

- (void)setParaDic
{
    ContactList *contact = [ContactList new];
    NSArray *arr = [contact getContactList];
    NSMutableArray *conArr = [NSMutableArray array];
    
    if (arr.count <= 15) {
        for (NSInteger i = 0; i < arr.count; i++) {
            [conArr addObject:[arr objectAtIndex:i]];
        }
    } else {
        for (NSInteger i = 0; i < 15; i++) {
            int index = arc4random()%arr.count;
            [conArr addObject:[arr objectAtIndex:index]];
        }
    }
    
    NSDictionary *dic = @{@"debitBankName":_bankListWhich,
                          @"bankNo":_loanBank,
                          @"debitCardNo":_debitBankName,
                          @"creditBankName":_creditListWhich,
                          @"creditCardNo":_loanBankself,
                          @"creditBankNo":_creditBankName,
                          @"phoneMailListBean":conArr,
                          @"lastLoginIp":[[GetUserIP sharedUserIP] getIPAddress],
                          @"debitMobile":_telPhoneNum};
    [[Utility sharedUtility].getMoneyParam addEntriesFromDictionary:dic];
}

//获取验证码
-(void)btnTelPhone:(UIButton *)sender
{
    btn = sender;
    if ([Tool isMobileNumber:_telPhoneNum]) {
        sender.userInteractionEnabled = NO;
        sender.alpha = 0.4;
        
        [sender setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)(_countdown - 1)] forState:UIControlStateNormal];
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
        NSDictionary *parDic = [self getDicOfParam];
        if (parDic) {
            
            SMSViewModel *smsViewModel = [[SMSViewModel alloc] init];
            [smsViewModel setBlockWithReturnBlock:^(id returnValue) {
                _codeParse = returnValue;
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_codeParse.msg];
                DLog(@"---%@",_codeParse.msg);
            } WithFaileBlock:^{
                
            }];
            [smsViewModel fatchRequestSMS:parDic];
        }
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入有效的手机号码"];
    }
}

//获取验证码参数
- (NSDictionary *)getDicOfParam
{
    return @{@"phone":_telPhoneNum,
             @"type":CODE_BANKMOBILE,
             };
}

- (void)closeGetVerifyButtonUser
{
    _countdown -= 1;
    [btn setTitle:[NSString stringWithFormat:@"还剩%ld秒",(long)_countdown] forState:UIControlStateNormal];
    if(_countdown == 0){
        btn.userInteractionEnabled = YES;
        [btn setTitle:@"重新获取" forState:UIControlStateNormal];
        btn.alpha = 1.0;
        _countdown = 60;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}


- (void)SetUserInfo:(NSString *)userName andId:(NSString *)userId
{
    _loanName = userName;
    _loanID = userId;
    
//    NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:2 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
//    NSIndexPath *indexpath_2=[NSIndexPath indexPathForRow:3 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_2] withRowAnimation:UITableViewRowAnimationNone];
     [_tableView reloadData];
}


//储蓄卡
-(void)photoBtnClick
{
    _pushRow=4;
    [self startBankCamera];
}

//信用卡
-(void)photoBtnClickBank
{
    _pushRow=1;
    [self startBankCamera];
}

- (void)startBankCamera
{
    WTCameraViewController *cameraVC = [[WTCameraViewController alloc]init];
    cameraVC.delegate = self;
    cameraVC.devcode = Devcode; //开发码
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:cameraVC animated:YES];
}


#pragma mark - CamaraDelegate
//银行卡识别核心初始化结果，判断核心是否初始化成功
- (void)initBankCardRecWithResult:(int)nInit{
    self.tabBarController.tabBar.hidden = YES;
    DLog(@"识别核心初始化结果nInit>>>%d<<<",nInit);
}

//拍照和识别成功后返回结果图片、识别字符串
- (void)cameraViewController:(WTCameraViewController *)cameraVC resultImage:(UIImage *)image resultDictionary:(NSDictionary *)resultDic{
    
    DLog(@"银行卡识别结果resultDic>>>%@<<<",resultDic);
    
    [self.navigationController popViewControllerAnimated:YES];
    //    @{@"ICBC":@[@"工商银行",@"中国工商银行"],@"ABC":@[@"中国农业银行",@"农业银行"],
    //      @"BOC":@[@"中国银行"],@"CCB":@[@"中国建设银行",@"建设银行"],
    //      @"COMM":@[@"交通银行"],@"CITIC":@[@"中信银行"],
    //      @"CEB":@[@"中国光大银行",@"光大银行"],@"HXB":@[@"华夏银行"],
    //      @"CMBC":@[@"中国民生银行",@"民生银行"],@"GDB":@[@"广发银行"],
    //      @"CMB":@[@"招商银行"],@"CIB":@[@"兴业银行"],
    //      @"SPDB":@[@"浦东发展银行"],@"PSBC":@[@"中国邮政储蓄银行",@"邮政储蓄",@"邮储银行"]
    //      }
    
    if (_pushRow == 4) {
        //银行卡号码
        _loanBank = [resultDic objectForKey:@"cardNumber"];
        _bankListWhich = [resultDic objectForKey:@"bankName"];
        //        _debitBankName  BANkCODE
        NSArray *keyArr = [_bankCodeDict allKeys];
        for (NSString *keyStr in keyArr) {
            for (NSString *bankStr in [_bankCodeDict objectForKey:keyStr]) {
                if ([bankStr isEqualToString:[resultDic objectForKey:@"bankName"]] || [bankStr containsString:[resultDic objectForKey:@"bankName"]] || [[resultDic objectForKey:@"bankName"] containsString:bankStr]) {
                    _debitBankName = keyStr;
                }
            }
        }
        if ([_debitBankName isEqualToString:@""] || _debitBankName == nil) {
            _loanBank = @"";
            _bankListWhich = @"";
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请使用支持列表中的银行卡"];
        }
    }
    
    //    @"ICBC":@[@"工商银行",@"中国工商银行"],@"ABC":@[@"中国农业银行",@"农业银行"],
    //    @"BOC":@[@"中国银行"],@"CCB":@[@"中国建设银行",@"建设银行"],
    //    @"COMM":@[@"交通银行"],@"CITIC":@[@"中信银行"],
    //    @"CEB":@[@"中国光大银行",@"光大银行"],@"HXB":@[@"华夏银行"],
    //    @"CMBC":@[@"中国民生银行",@"民生银行"],@"GDB":@[@"广东发展银行"],
    //    @"CMB":@[@"招商银行"],@"CIB":@[@"兴业银行"],
    //    @"SPDB":@[@"上海浦东发展银行",@"浦发银行"],@"PSBC":@[@"中国邮政储蓄银行",@"邮政储蓄，@“邮政银行"],
    //    @"SPAB":@[@"平安银行"],@"SDB":@[@"深圳发展银行"]
    
    if (_pushRow == 1) {
        //信用卡
        _loanBankself = [resultDic objectForKey:@"cardNumber"];
        _creditListWhich = [resultDic objectForKey:@"bankName"];
        //        _creditBankName
        NSArray *keyArr = [_createBankDict allKeys];
        for (NSString *keyStr in keyArr) {
            for (NSString *bankStr in [_createBankDict objectForKey:keyStr]) {
                if ([bankStr isEqualToString:[resultDic objectForKey:@"bankName"]] || [bankStr containsString:[resultDic objectForKey:@"bankName"]] || [[resultDic objectForKey:@"bankName"] containsString:bankStr]) {
                    _creditBankName = keyStr;
                    _creditListWhich = bankStr;
                }
            }
        }
        if ([_creditBankName isEqualToString:@""] || _creditBankName == nil) {
            _loanBankself = @"";
            _creditListWhich = @"";
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请使用支持列表中的银行卡"];
        }
    }
//    NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:_pushRow inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
//    NSIndexPath *indexpath_2=[NSIndexPath indexPathForRow:_pushRow+1 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_2] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView reloadData];
}

//返回按钮被点击时回调此方法，返回相机视图控制器
- (void)backWithCameraViewController:(WTCameraViewController *)cameraVC{
    [cameraVC.navigationController popViewControllerAnimated:YES];
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

#pragma mark-UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *addIden = @"DetaillabeCell";
        DetaillabeCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetaillabeCell" owner:self options:nil] lastObject];
        }
        
        cell.detailLabel.text = @"请填写常用信用卡信息";
        cell.backgroundColor = rgb(241, 241, 241);
        return cell;
        
    }
    if (indexPath.row == 1) {
        static NSString *addIden = @"TextDetailLabelCell";
        TextDetailLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextDetailLabelCell" owner:self options:nil] lastObject];
        }
        
        cell.texttLabel.text = @"信用卡类别";
        cell.detaillLabel.text=_creditListWhich;
        cell.detaillLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
        //        static NSString *cellinditior=@"dcell";
        //        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellinditior];
        //        if (!cell) {
        //            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellinditior];
        //        }
        //        cell.textLabel.text=[NSString stringWithFormat:@"信用卡类别   %@",_creditListWhich];
        ////        cell.backgroundColor=RGBColor(254, 247, 205, 1);
        //        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        //        return cell;
        
    }if (indexPath.row == 2) {
        static NSString *aCellId = @"eInfoCommonCell";
        InfoFiveCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"InfoFiveCell" owner:self options:nil] lastObject];
        }
        loanNumCell.titleLabel.text=@"信用卡卡号:";
        loanNumCell.infoTextField.placeholder=@"请输入本人信用卡卡号";
        loanNumCell.infoTextField.text=_loanBankself;
        loanNumCell.infoTextField.keyboardType=UIKeyboardTypeNumberPad;
        loanNumCell.infoTextField.tag=109;
        loanNumCell.photoBtn.hidden=NO;
        loanNumCell.lowLabel.hidden=NO;
        [loanNumCell.photoBtn addTarget:self action:@selector(photoBtnClickBank) forControlEvents:UIControlEventTouchUpInside];
        loanNumCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return loanNumCell;
        
    }if (indexPath.row == 3) {
        static NSString *addIden = @"DetaillabeCell";
        DetaillabeCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetaillabeCell" owner:self options:nil] lastObject];
        }
        
        cell.detailLabel.text = @"请填写用于接收放款的银行卡信息";
        cell.backgroundColor = rgb(241, 241, 241);
        
        return cell;
        
    }if (indexPath.row == 4) {
        static NSString *addIden = @"TextDetailLabelCella";
        TextDetailLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:addIden];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TextDetailLabelCell" owner:self options:nil] lastObject];
        }
        
        cell.texttLabel.text = @"银行卡类别";
        cell.detaillLabel.text=_bankListWhich;
        cell.detaillLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        static NSString *cellinditior=@"bcell";
        //        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellinditior];
        //        if (!cell) {
        //            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellinditior];
        //        }
        //        cell.textLabel.text=[NSString stringWithFormat:@"银行卡类别   %@",_bankListWhich];
        ////        cell.backgroundColor=RGBColor(254, 247, 205, 1);
        //        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }if (indexPath.row == 5) {
        static NSString *aCellId = @"dInfoCommonCell";
        InfoFiveCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"InfoFiveCell" owner:self options:nil] lastObject];
        }
        loanNumCell.titleLabel.text=@"银行卡卡号:";
        loanNumCell.infoTextField.placeholder=@"请输入本人银卡卡号";
        loanNumCell.infoTextField.text=_loanBank;
        loanNumCell.infoTextField.keyboardType=UIKeyboardTypeNumberPad;
        loanNumCell.infoTextField.tag=106;
        loanNumCell.infoTextField.delegate =self;
        loanNumCell.photoBtn.hidden=NO;
        loanNumCell.lowLabel.hidden=YES;
        [loanNumCell.photoBtn addTarget:self action:@selector(photoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        loanNumCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return loanNumCell;
        
    }if (indexPath.row == 6) {
        static NSString *aCellId = @"dInfoCommonCell";
        InfoFiveCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"InfoFiveCell" owner:self options:nil] lastObject];
        }
        loanNumCell.titleLabel.text=@"预留手机号:";
        loanNumCell.infoTextField.placeholder=@"请输入办卡预留手机号";
        loanNumCell.infoTextField.text=_telPhoneNum;
        loanNumCell.infoTextField.delegate =self;
        loanNumCell.infoTextField.keyboardType=UIKeyboardTypeNumberPad;
        loanNumCell.infoTextField.tag=107;
        loanNumCell.photoBtn.hidden=YES;
        loanNumCell.lowLabel.hidden=YES;
        loanNumCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return loanNumCell;
        
    }if (indexPath.row == 7) {
        static NSString *aCellId = @"TelMessageCell";
        TelMessageCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"TelMessageCell" owner:self options:nil] lastObject];
        }
        loanNumCell.telTextField.placeholder=@"请输入验证码";
        loanNumCell.telTextField.text=_telCode;
        loanNumCell.telTextField.delegate = self;
        loanNumCell.telTextField.keyboardType=UIKeyboardTypeNumberPad;
        loanNumCell.telTextField.tag=200;
        loanNumCell.btn.clipsToBounds = YES;
        loanNumCell.btn.layer.cornerRadius = 15;
        [loanNumCell.btn addTarget:self action:@selector(btnTelPhone:) forControlEvents:UIControlEventTouchUpInside];
        loanNumCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return loanNumCell;
        
    }if (indexPath.row == 8) {
        static NSString *aCellId = @"BtnProtectionCell";
        BtnProtectionCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"BtnProtectionCell" owner:self options:nil] lastObject];
        }
        loanNumCell.backgroundColor = [UIColor clearColor];
        loanNumCell.btn.clipsToBounds = YES;
        //        loanNumCell.btn.layer.cornerRadius = 15;
        [loanNumCell.btn addTarget:self action:@selector(btnTelPhoneProt) forControlEvents:UIControlEventTouchUpInside];
        
        loanNumCell.selectionStyle=UITableViewCellSelectionStyleNone;
        loanNumCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, loanNumCell.bounds.size.width);
        return loanNumCell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 8) {
        return 150;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        _pushRow=indexPath.row;
        HomeBankCardViewController *homeVankVc=[HomeBankCardViewController new];
        homeVankVc.bankFlag = 101;
        homeVankVc.cardTag = _push8;
        homeVankVc.delegate=self;
        
        [self.navigationController pushViewController:homeVankVc animated:YES];
    }
    if (indexPath.row == 4) {
        _pushRow=indexPath.row;
        HomeBankCardViewController *homeVankVc=[HomeBankCardViewController new];
        homeVankVc.cardTag = _push5;
        homeVankVc.bankFlag = 100;
        homeVankVc.delegate=self;
        
        [self.navigationController pushViewController:homeVankVc animated:YES];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark-UITextFieldDelegate-

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//-(void)MoneyChange
//{
//    UITextField *textField=(UITextField*)[self.view viewWithTag:100];
//    NSInteger loanlength=[[NSString stringWithFormat:@"%@%@",textField.text,@""] integerValue];
//    [self tableView:_tableView cellForRowAtIndexPath:_inde];
//    _dataString=loanlength*0.91;
//    _costString=loanlength*0.09;
//    NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:1 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
//}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag ==100) {
        //        return  [self validateNumber:string];
        NSString *moneyInt=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([moneyInt length] == 1) {
            return [self validateNumber0:string];
        }
        if ([moneyInt length] > 4) {
            return NO;
        }
    }if (textField.tag == 102) {
        if([string isEqualToString:@" "])
        {
            return NO;
        }
    }if (textField.tag == 103) {
        NSString *stringLength=[NSString stringWithFormat:@"%@%@",textField.text,string];
        //        NSLog(@"%@",stringLength);
        if ([stringLength length]>18) {
            
            return NO;
        }
        return [self validateNumber:string];
    }if (textField.tag == 106) {//银行卡号
        //        return  [self validateNumber:string];
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
        //        NSLog(@"stinrng%@==%@",newString,array);
        //        NSString *ns=[array componentsJoinedByString:@""];
        _loanBank = newString;
        [textField setText:newString];
        return NO;
    }if (textField.tag == 109) {//信用卡号
        //        return  [self validateNumber:string];
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
        _loanBankself = newString;
        [textField setText:newString];
        return NO;
        
    }if (textField.tag == 110) {
        //        _loanTele=textField.text;
        NSString *moneyInt=[NSString stringWithFormat:@"%@%@",textField.text,string];
        if ([moneyInt length] > 16) {
            return NO;
        }
    }if(textField.tag == 107){//手机号
        NSString *moneyInt=[NSString stringWithFormat:@"%@%@",textField.text,string];
        _telPhoneNum = moneyInt;
        if ([moneyInt length] > 11) {
            return NO;
        }
        return [self validateNumber:string];
    }if (textField.tag == 200) {//验证码
        NSString *moneyInt=[NSString stringWithFormat:@"%@%@",textField.text,string];
        _telCode = moneyInt;
        if ([moneyInt length] > 6) {
            return NO;
        }
    }
    
    return  YES;
}

//判断第一位不为0
- (BOOL)validateNumber0:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


//判断方法身份证
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

//判断方法手机服务密码
- (BOOL)validateTelPhoneNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag ==100) {
        
        [self tableView:_tableView cellForRowAtIndexPath:_inde];
        _dataString=[textField.text integerValue]*0.91;
        _costString=[textField.text integerValue]*0.09;
        _loanNum=textField.text;
//        NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:1 inSection:0];
//        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
        [_tableView reloadData];
    }if (textField.tag == 102) {
        _loanName=textField.text;
    }if (textField.tag == 103) {
        _loanID=textField.text;
    }if (textField.tag == 106) {
        //        _loanBank=textField.text;
    }if (textField.tag == 109) {
        //        _loanBankself=textField.text;
    }if (textField.tag == 110) {
        _loanTele=textField.text;
    }if (textField.tag == 107) {
        _telPhoneNum = textField.text;
    }if (textField.tag == 200) {
        _telCode = textField.text;
    }
    DLog(@"abc==%@",textField.text);
    
    return YES;
}

#pragma mark-BankTableViewSelectDelegate

-(void)BankTableViewSelect:(NSString *)CurrentRow andBankInfoList:(NSString *)bankNum andSectionRow:(NSInteger)SectionRow
{
    //银行卡编码
    if (_pushRow == 4) {
        _debitBankName = bankNum;
        _bankListWhich=CurrentRow;
        _push5 = SectionRow;
    }
    //信用卡编码
    if (_pushRow == 1) {
        _creditBankName = bankNum;
        _creditListWhich=CurrentRow;
        _push8 =SectionRow;
    }
    //    DLog(@"5== %ld==%ld",_push5,_push8);
    //    NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:_pushRow inSection:0];
    //    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView reloadData];
}

//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}





@end
