//
//  CardCreadViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "CardCreadViewController.h"
#import "InfoFiveCell.h"
#import "WTCameraViewController.h"
#import "HomeBankCardViewController.h"
#import "AddressViewController.h"


@interface CardCreadViewController ()<UITableViewDelegate,UITableViewDataSource,BankTableViewSelectDelegate,WTCameraDelegate,UITextFieldDelegate>
{
    //银行卡
    NSString *_1bankWhich;
    NSString *_1bankNum;
    NSString *_1bankCode;
    NSDictionary *_bankCodeDict;
    //信用卡
    NSString *_whichBank;
    NSString *_bankNum;
    NSInteger _pushRow;
    NSDictionary *_createBankDict;
    //银行卡编码
    NSString *_creditBankName;
    UIButton *btn;
    UIImage *imagea;
    //
    NSInteger _pushRow5;
    NSInteger _pushRow8;
    
    
}

@end

@implementation CardCreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"填写资料";
    [self addBackItem];
    _whichBank = @"";
    _pushRow = 17;
    _pushRow5 = 17;
    _pushRow8 = 17;
    imagea = [UIImage imageNamed:@"flow02Preserv01"];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setEnabled:NO];
    self.tableView.backgroundColor = RGBColor(241, 241, 241, 1);
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
    _bankCodeDict =@{@"ICBC":@[@"工商银行",@"中国工商银行"],
                     @"ABC":@[@"中国农业银行",@"农业银行"],
                     @"BOC":@[@"中国银行"],
                     @"CCB":@[@"中国建设银行",@"建设银行"],
                     @"CEB":@[@"中国光大银行",@"光大银行"],
                     @"CMBC":@[@"中国民生银行",@"民生银行"],
                     @"CIB":@[@"兴业银行"]
                     };

}

#pragma ->UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *cellinditior=@"acell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellinditior];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellinditior];
        }
        cell.textLabel.text = @"信用卡类别";
        cell.detailTextLabel.text=_whichBank;
        cell.detailTextLabel.textColor = RGBColor(0, 170, 238, 1);
        cell.backgroundColor=[UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    if (indexPath.row == 1) {
        static NSString *aCellId = @"eInfoCommonCell";
        InfoFiveCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"InfoFiveCell" owner:self options:nil] lastObject];
        }
        loanNumCell.titleLabel.text=@"信用卡卡号:";
        loanNumCell.infoTextField.placeholder=@"请输入本人信用卡卡号";
        loanNumCell.infoTextField.text=_bankNum;
        loanNumCell.infoTextField.textColor = RGBColor(0, 170, 238, 1);
        loanNumCell.infoTextField.keyboardType=UIKeyboardTypeNumberPad;
        loanNumCell.infoTextField.textColor = RGBColor(0, 170, 238, 1);
        loanNumCell.infoTextField.tag=109;
        loanNumCell.photoBtn.hidden=NO;
        loanNumCell.lowLabel.hidden=NO;
        [loanNumCell.photoBtn addTarget:self action:@selector(photoBtnClickBank) forControlEvents:UIControlEventTouchUpInside];
        loanNumCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return loanNumCell;
        
    }
    if (indexPath.row == 2) {
        static NSString *cellinditior=@"bcell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellinditior];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellinditior];
        }
        cell.textLabel.text = @"银行卡类别";
        cell.detailTextLabel.text=_1bankWhich;
        cell.detailTextLabel.textColor = RGBColor(0, 170, 238, 1);
        cell.backgroundColor=[UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }if (indexPath.row == 3) {
        static NSString *aCellId = @"dInfoCommonCell";
        InfoFiveCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"InfoFiveCell" owner:self options:nil] lastObject];
        }
        loanNumCell.titleLabel.text=@"银行卡卡号:";
        loanNumCell.infoTextField.placeholder=@"请输入本人银卡卡号";
        loanNumCell.infoTextField.text=_1bankNum;
        loanNumCell.infoTextField.keyboardType=UIKeyboardTypeNumberPad;
        loanNumCell.infoTextField.tag=106;
        loanNumCell.photoBtn.hidden=NO;
        loanNumCell.lowLabel.hidden=YES;
        [loanNumCell.photoBtn addTarget:self action:@selector(photoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        loanNumCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return loanNumCell;
        
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        _pushRow=indexPath.row;
        HomeBankCardViewController *homeVankVc=[HomeBankCardViewController new];
        homeVankVc.delegate=self;
        homeVankVc.bankFlag = 100;
        homeVankVc.cardTag=_pushRow5;
        
        [self.navigationController pushViewController:homeVankVc animated:YES];
    }
    if (indexPath.row == 0) {
        _pushRow=indexPath.row;
        HomeBankCardViewController *homeVankVc=[HomeBankCardViewController new];
        homeVankVc.delegate=self;
        homeVankVc.cardTag=_pushRow8;
        homeVankVc.bankFlag = 101;
        [self.navigationController pushViewController:homeVankVc animated:YES];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"请您填写常用的银行卡信息";
}

//银行卡信息列表 foot确定按钮
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footView=[[UIView alloc] initWithFrame:CGRectZero];
    footView.backgroundColor=[UIColor clearColor];
    
    CGFloat wid = imagea.size.width;
    CGFloat hei = imagea.size.height;
    
    btn.frame = CGRectMake((_k_w-wid)/2.0f, 150, wid, hei);
    [btn setImage:imagea forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btn];
    
    return footView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

//点击保存
-(void)btnClick
{
    if ([_whichBank length]<1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择正确的信用卡类别"];
    }else if ([_bankNum length]<16) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请输入正确信用卡号"];
    }else{
        AddressViewController *addVC= [AddressViewController new];
        [self.navigationController pushViewController:addVC animated:YES];
    }
    AddressViewController *addVC= [AddressViewController new];
    [self.navigationController pushViewController:addVC animated:YES];
}
//银行卡扫描
-(void)photoBtnClick{
    _pushRow=3;
    [self startBankCamera];
}
//信用卡卡扫描
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
    if (_pushRow == 3) {
        //银行卡号码
        _1bankNum = [resultDic objectForKey:@"cardNumber"];
        _1bankWhich = [resultDic objectForKey:@"bankName"];
        //        _debitBankName  BANkCODE
        NSArray *keyArr = [_bankCodeDict allKeys];
        for (NSString *keyStr in keyArr) {
            for (NSString *bankStr in [_bankCodeDict objectForKey:keyStr]) {
                if ([bankStr isEqualToString:[resultDic objectForKey:@"bankName"]] || [bankStr containsString:[resultDic objectForKey:@"bankName"]] || [[resultDic objectForKey:@"bankName"] containsString:bankStr]) {
                    _1bankCode = keyStr;
                }
            }
        }
        if ([_1bankCode isEqualToString:@""] || _1bankCode == nil) {
            _1bankNum = @"";
            _1bankWhich = @"";
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请使用支持列表中的银行卡"];
        }
    }
    if (_pushRow == 1) {
        //信用卡
        _bankNum = [resultDic objectForKey:@"cardNumber"];
        _whichBank = [resultDic objectForKey:@"bankName"];
        //        _creditBankName
        NSArray *keyArr = [_createBankDict allKeys];
        for (NSString *keyStr in keyArr) {
            for (NSString *bankStr in [_createBankDict objectForKey:keyStr]) {
                if ([bankStr isEqualToString:[resultDic objectForKey:@"bankName"]] || [bankStr containsString:[resultDic objectForKey:@"bankName"]] || [[resultDic objectForKey:@"bankName"] containsString:bankStr]) {
                    _creditBankName = keyStr;
                    _whichBank = bankStr;
                }
            }
        }
        if ([_creditBankName isEqualToString:@""] || _creditBankName == nil) {
            _bankNum = @"";
            _whichBank = @"";
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请使用支持列表中的银行卡"];
        }
    }
   
    imagea = [UIImage imageNamed:@"flow02Preserv02"];
    [btn setImage:imagea forState:UIControlStateNormal];
    [btn setEnabled:YES];
    [_tableView reloadData];
    
//    NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:0 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
//    NSIndexPath *indexpath_2=[NSIndexPath indexPathForRow:1 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_2] withRowAnimation:UITableViewRowAnimationNone];
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

#pragma mark->uitextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 106) {//银行卡号
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
        _1bankNum = newString;
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
        _bankNum = newString;
        [textField setText:newString];
        return NO;
        
    }

    return YES;
}

#pragma mark-BankTableViewSelectDelegate

-(void)BankTableViewSelect:(NSString *)CurrentRow andBankInfoList:(NSString *)bankNum andSectionRow:(NSInteger)SectionRow
{
    //银行卡编码
    if (_pushRow == 2) {
        _1bankCode = bankNum;
        _1bankWhich=CurrentRow;
        _pushRow5 = SectionRow;
    }
    //信用卡编码
    if (_pushRow == 0) {
        _creditBankName = bankNum;
        _whichBank=CurrentRow;
        _pushRow8 =SectionRow;
    }
    imagea = [UIImage imageNamed:@"flow02Preserv02"];
    [btn setImage:imagea forState:UIControlStateNormal];
    [btn setEnabled:YES];
    [_tableView reloadData];
    
//    NSIndexPath *indexpath_1=[NSIndexPath indexPathForRow:_pushRow inSection:0];
//    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath_1] withRowAnimation:UITableViewRowAnimationNone];
}

//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

@end
