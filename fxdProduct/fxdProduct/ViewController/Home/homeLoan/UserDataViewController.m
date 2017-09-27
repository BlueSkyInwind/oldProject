//
//  UserDataViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserDataViewController.h"
#import "DataDisplayCell.h"
#import "PserInfoViewController.h"
#import "ProfessionViewController.h"
#import "UserContactsViewController.h"
#import "CertificationViewController.h"
#import "GetCustomerBaseViewModel.h"
#import "Custom_BaseInfo.h"
#import "GetCareerInfoViewModel.h"
#import "CustomerCareerBaseClass.h"
#import "LoanSureFirstViewController.h"
#import "CareerParse.h"
#import "testView.h"
#import "HomeViewModel.h"
#import "UserStateModel.h"
#import "LoanMoneyViewController.h"
#import "PayLoanChooseController.h"
#import "CheckViewController.h"
#import "RateModel.h"
#import "DataWriteAndRead.h"
#import "SesameCreditViewController.h"
#import "HomeProductList.h"
#import "SeniorCertificationView.h"
#import "UnfoldTableViewCell.h"
#import "MoxieSDK.h"
#import "EditCardsController.h"
#import "UserDataViewModel.h"
#import "HighRandingModel.h"
#import "UserDataModel.h"
#import "UserCardResult.h"
#import "CardInfo.h"
#import "CheckViewModel.h"
#import "SupportBankList.h"

@interface UserDataViewController ()<UITableViewDelegate,UITableViewDataSource,ProfessionDataDelegate,MoxieSDKDelegate>
{
    CGFloat processFlot;
    UIView *processView;
    NSArray *_subTitleArr;
    UIButton *_applyBtn;
    //职业信息返回信息
    CareerParse *_careerParse;
    testView *_alertView;
    
    UIView *topView;
    
    NSString *_resultCode;
    NSString *_rulesId;
    NSString *_isMobileAuth;
    NSString *_isZmxyAuth;
    NSString *_phoneAuthChannel;
    NSString *_creditCardStatus;
    NSString *_socialSecurityStatus;
    HighRandingModel * _creditCardHighRandM;
    HighRandingModel * _socialSecurityHighRandM;
    UserStateModel *_model;
    UserDataModel * _userDataModel;
    BOOL isOpen;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"资料填写";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = true;
    processFlot = 0.0;
    isOpen = NO;
    _creditCardStatus = @"3";
    _socialSecurityStatus = @"3";
    _subTitleArr = @[@"请完善您的身份信息",@"请完善您的个人信息",@"请完善您的职业信息",@"请完成三方认证"];
    [self addBackItemRoot];
    [self configMoxieSDK];
    [self configTableview];
    
    topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    if (_isMine) {
        _applyBtn.enabled = NO;
        _applyBtn.hidden = YES;
    }
}

- (void)setApplyBtnStatus
{
    if ([_userDataModel.test isEqualToString:@"1"]) {
        [_applyBtn setBackgroundColor:UI_MAIN_COLOR];
        _applyBtn.enabled = true;
    }else{
        [_applyBtn setBackgroundColor:rgb(139, 140, 143)];
        _applyBtn.enabled = false;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView.mj_header beginRefreshing];
}

- (void)configTableview
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DataDisplayCell class]) bundle:nil] forCellReuseIdentifier:@"DataDisplayCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UnfoldTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"UnfoldTableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    //声明tableView的位置 添加下面代码
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshInfoStep)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, _k_w*0.15)];
    footView.backgroundColor = [UIColor whiteColor];
    _applyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [Tool setCorner:_applyBtn borderColor:[UIColor clearColor]];
    [_applyBtn setTitle:@"资料审核" forState:UIControlStateNormal];
    [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_applyBtn setBackgroundColor:rgb(139, 140, 143)];
    _applyBtn.enabled = false;
    //    rgb(16, 129, 249)
    [footView addSubview:_applyBtn];
    [_applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.bottom.equalTo(@0);
        make.height.equalTo(_applyBtn.mas_width).multipliedBy(0.15f);
    }];
    self.tableView.tableFooterView = footView;
}

- (void)applyBtnClick
{
    [self UserDataCertificationinterface];
}

#pragma mark -Tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else if(section == 1){
        if (isOpen) {
            return 3;
        }
        return 1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _k_w*0.21f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SeniorCertificationView * seniorCertificationView =   [[NSBundle mainBundle]loadNibNamed:@"SeniorCertificationView" owner:self options:nil].lastObject;
    if (section == 0) {
        seniorCertificationView.titleLabel.text = @"基础信息（必填）";
        seniorCertificationView.subtitleLabel.text = @"请按照顺序进行各项资料填写";
    }
    return seniorCertificationView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger  unfoldBtnIndex = 2;
        if (!isOpen) {
            unfoldBtnIndex = 0;
        }
        if (unfoldBtnIndex == indexPath.row) {
            UnfoldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnfoldTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"拉起";
            cell.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);

            if (!isOpen) {
                cell.titleLabel.text = @"更多";
                cell.arrowImageView.transform = CGAffineTransformIdentity;
            }
            __weak typeof(self) weakSelf = self;
            cell.unfoldBtnClick = ^{
                isOpen = !isOpen;
                NSIndexSet * set  =  [NSIndexSet indexSetWithIndex:1];
                [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            return cell;
        }
        
        DataDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataDisplayCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.statusLabel.text = @"未完成";
        cell.statusLabel.textColor = rgb(159, 160, 162);
        switch (indexPath.row) {
            case 0:
            {
                cell.iconImage.image = [UIImage imageNamed:@"creditCard_icon"];
                cell.subTitleLabel.text = @"完善信用卡认证信息";
                cell.titleLable.text = @"信用卡认证";
                cell.statusLabel.text = _creditCardHighRandM != nil ? _creditCardHighRandM.result : @"未完成";
                cell.statusLabel.textColor = rgb(42, 155, 234);
                if ([_creditCardStatus isEqualToString:@"2"]) {
                    cell.statusLabel.textColor = rgb(42, 155, 234);
                }
                if ([_creditCardStatus isEqualToString:@"3"]) {
                    cell.statusLabel.textColor = rgb(159, 160, 162);
                    cell.statusLabel.text = @"未完成";
                }
                return cell;
            }
                break;
            case 1:
            {
                cell.iconImage.image = [UIImage imageNamed:@"shebao_icon"];
                cell.subTitleLabel.text = @"完善社保认证信息";
                cell.titleLable.text = @"社保认证";
                cell.statusLabel.text = _socialSecurityHighRandM != nil ? _socialSecurityHighRandM.result : @"未完成";;
                cell.statusLabel.textColor =  rgb(42, 155, 234);
                if ([_socialSecurityStatus isEqualToString:@"2"]) {
                    cell.statusLabel.textColor = rgb(42, 155, 234);
                }
                if ([_socialSecurityStatus isEqualToString:@"3"]) {
                    cell.statusLabel.textColor = rgb(159, 160, 162);
                    cell.statusLabel.text = @"未完成";
                }
                return cell;
            }
                break;
            default:
                break;
        }
    }
    
    DataDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataDisplayCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.row) {
        case 0:
        {
            cell.iconImage.image = [UIImage imageNamed:@"UserData2"];
            cell.titleLable.text = @"身份信息";
            cell.subTitleLabel.text = @"完善您的个人信息";
            cell.statusLabel.text = @"未完成";
            cell.statusLabel.textColor = rgb(159, 160, 162);
            if ([_userDataModel.identity isEqualToString:@"1"]) {
                cell.statusLabel.text = @"已完成";
                cell.statusLabel.textColor = rgb(42, 155, 234);
            }
            return cell;
        }
            break;
        case 1:
        {
            cell.iconImage.image = [UIImage imageNamed:@"UserData1"];
            cell.titleLable.text = @"个人信息";
            cell.subTitleLabel.text = @"完善您的联系人信息";
            cell.statusLabel.text = @"未完成";
            cell.statusLabel.textColor = rgb(159, 160, 162);
            if ([_userDataModel.person isEqualToString:@"1"]) {
                cell.statusLabel.text = @"已完成";
                cell.statusLabel.textColor = rgb(42, 155, 234);
            }
            return cell;
        }
            break;
        case 2:
        {
            cell.iconImage.image = [UIImage imageNamed:@"UserData4"];
            cell.titleLable.text = @"第三方认证";
            cell.subTitleLabel.text = @"完成第三方认证有助于通过审核";
            if (UI_IS_IPHONE5) {
                cell.subTitleLabel.font = [UIFont systemFontOfSize:10.f];
            }
            cell.statusLabel.text = @"未完成";
            cell.statusLabel.textColor = rgb(159, 160, 162);
            if ([_userDataModel.others isEqualToString:@"1"]) {
                cell.statusLabel.text = @"已完成";
                cell.statusLabel.textColor = rgb(42, 155, 234);
            }
            return cell;

        }
            break;
        case 3:
        {
            cell.iconImage.image = [UIImage imageNamed:@"UserData3"];
            cell.titleLable.text = @"收款信息";
            cell.subTitleLabel.text = @"";
            cell.statusLabel.text = @"未完成";
            cell.statusLabel.textColor = rgb(159, 160, 162);
            if ([_userDataModel.gathering isEqualToString:@"1"]) {
                cell.statusLabel.text = @"已完成";
                cell.statusLabel.textColor = rgb(42, 155, 234);
            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([_userDataModel.others isEqualToString:@"0"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请先完成基础资料认证"];
            return;
        }
        switch (indexPath.row) {
            case 0:
                if ([_creditCardStatus isEqualToString:@"2"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                    return;
                }
                if ([_creditCardStatus isEqualToString:@"1"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证中，请稍后！"];
                    return;
                }
                [self mailImportClick];
                break;
            case 1:
                if ([_socialSecurityStatus isEqualToString:@"2"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                    return;
                }
                if ([_socialSecurityStatus isEqualToString:@"1"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证中，请稍后！"];
                    return;
                }
                [self securityImportClick];
                break;
            default:
                break;
        }
        return;
    }

    if (![self cellStatusIsSelect:indexPath.row]) {
        return;
    }
    switch (indexPath.row) {
        case 0:
        {
            [self getUserInfo:^(Custom_BaseInfo *custom_baseInfo) {
                PserInfoViewController *perInfoVC = [[PserInfoViewController alloc] init];
                perInfoVC.custom_baseInfo = custom_baseInfo;
                [self.navigationController pushViewController:perInfoVC animated:true];
            }];
        }
            break;
        case 1:
        {
            [self getCustomerCarrer_jhtml:^(CustomerCareerBaseClass *careerInfo) {
                ProfessionViewController *professVC = [[ProfessionViewController alloc] init];
                professVC.delegate = self;
                professVC.product_id = _product_id;
                professVC.careerInfo = careerInfo;
                [self.navigationController pushViewController:professVC animated:true];
            }];
        }
            break;
        case 2:
        {
            if ([_userDataModel.others isEqualToString:@"1"]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
            }else {
                thirdPartyAuthViewController * thirdPartyAuthVC = [[thirdPartyAuthViewController alloc]init];
                [self.navigationController pushViewController:thirdPartyAuthVC animated:true];
            }
        }
            break;
        case 3:
        {
            //此处需要一个返回默认卡的接口
            [self getGatheringInformation_jhtml:^(CardInfo *cardInfo) {
                EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:@"EditCardsController" bundle:nil];
                editCard.typeFlag = @"0";
                editCard.cardName = cardInfo.bankName;
                editCard.cardNum = cardInfo.cardNo;
                editCard.reservedTel = cardInfo.bankPhone;
                editCard.cardCode = cardInfo.cardId;
                editCard.popOrdiss  = true;
                [self.navigationController pushViewController:editCard animated:YES];
            }];
        }
            break;
        default:
            break;
    }
}
-(BOOL)cellStatusIsSelect:(NSInteger)row{
    if ([_userDataModel.identity isEqualToString:@"0"] && row > 0) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请您先完善身份信息！"];
        return false;
    }
    if ([_userDataModel.person isEqualToString:@"0"] && row > 1) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请您先完善个人信息！"];
        return false;
    }
    switch (row) {
        case 0:{
            if ([_userDataModel.identityEdit isEqualToString:@"0"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return false;
            }
        }
            break;
        case 1:{
            if ([_userDataModel.personEdit isEqualToString:@"0"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return false;
            }
        }
            break;
        case 2:{
            if ([_userDataModel.others isEqualToString:@"1"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return false;
            }
        }
            break;
        case 3:{
            if ([_userDataModel.gathering isEqualToString:@"1"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return false;
            }
        }
            break;
        default:
            break;
    }
    return true;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    topView.backgroundColor = UI_MAIN_COLOR;
//    topView.frame = CGRectMake(0, 0, _k_w, -scrollView.contentOffset.y);
}
- (void)getUserInfo:(void(^)(Custom_BaseInfo *custom_baseInfo))finish
{
    GetCustomerBaseViewModel *customerInfo = [[GetCustomerBaseViewModel alloc] init];
    [customerInfo setBlockWithReturnBlock:^(id returnValue) {
        Custom_BaseInfo *custom_model = returnValue;
        [Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
        if ([custom_model.flag isEqualToString:@"0000"]) {
            id data = [DataWriteAndRead readDataWithkey:UserInfomation];
            if (data) {
                [DataWriteAndRead writeDataWithkey:UserInfomation value:nil];
                if (![custom_model.result.idCode isEqualToString:@""] && custom_model.result.idCode != nil) {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:custom_model];
                    [Utility sharedUtility].userInfo.userIDNumber = custom_model.result.idCode;
                    [Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
                    [Utility sharedUtility].userInfo.realName = custom_model.result.customerName;
                    if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
                        [Utility sharedUtility].userInfo.account_id = custom_model.result.createBy;
                    }
                }
            } else {
                if (![custom_model.result.idCode isEqualToString:@""] && custom_model.result.idCode != nil) {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:custom_model];
                    [Utility sharedUtility].userInfo.userIDNumber = custom_model.result.idCode;
                    [Utility sharedUtility].userInfo.userMobilePhone = custom_model.ext.mobilePhone;
                    [Utility sharedUtility].userInfo.realName = custom_model.result.customerName;
                    if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
                        [Utility sharedUtility].userInfo.account_id = custom_model.result.createBy;
                    }
                } else {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:nil];
                }
            }
            finish(custom_model);
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:custom_model.msg];
        }
        
    } WithFaileBlock:^{
        
    }];
    [customerInfo fatchCustomBaseInfo:nil];
}
-(void)getCustomerCarrer_jhtml:(void(^)(CustomerCareerBaseClass *careerInfo))finish
{
    GetCareerInfoViewModel *getCareerInfoViewModel = [[GetCareerInfoViewModel alloc] init];
    [getCareerInfoViewModel setBlockWithReturnBlock:^(id returnValue) {
        CustomerCareerBaseClass *carrerInfoModel = returnValue;
        if ([carrerInfoModel.flag isEqualToString:@"0000"]) {
            finish(carrerInfoModel);
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:carrerInfoModel.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [getCareerInfoViewModel fatchCareerInfo:nil];
}
/**
 发薪贷银行卡信息
 */

-(void)getGatheringInformation_jhtml:(void(^)(CardInfo *cardInfo))finish{
    
    BankInfoViewModel * bankInfoVM = [[BankInfoViewModel alloc]init];
    [bankInfoVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            CardInfo *resultCardInfo = [[CardInfo alloc] init];
            for (NSDictionary *dic in baseResultM.data) {
                CardInfo * cardInfo = [[CardInfo alloc]initWithDictionary:dic error:nil];
                if ([cardInfo.cardType isEqualToString:@"2"]) {
                    resultCardInfo = cardInfo;
                    break;
                }
            }
            finish(resultCardInfo);
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [bankInfoVM obtainUserBankCardList];
}

- (BOOL)checkUserAuth:(NSInteger)selectRow
{
    if (_nextStep.integerValue > 0 && _nextStep.integerValue >= selectRow) {
        return true;
    } else {
        return false;
    }
}

#pragma mark -获取进度条的进度
- (void)refreshInfoStep
{
    //高级认证状态查询
    [self obtainHighRanking];
    
    UserDataViewModel * userDataVM1 = [[UserDataViewModel alloc]init];
    [userDataVM1 setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * resultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([resultM.errCode isEqualToString:@"0"]) {
            UserDataModel * userDataM = [[UserDataModel alloc]initWithDictionary:(NSDictionary *)resultM.data error:nil];
            _userDataModel = userDataM;
            [self setApplyBtnStatus];
            [self.tableView reloadData];
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:resultM.msg];
        }
        [self.tableView.mj_header endRefreshing];
    } WithFaileBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    [userDataVM1 obtainBasicInformationStatus];
}
/**
 用户认证接口
 */
-(void)UserDataCertificationinterface{
    UserDataViewModel * userDataVM =  [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            CheckingViewController * checkVC = [[CheckingViewController  alloc]init];
            [self.navigationController pushViewController:checkVC animated:true];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM UserDataCertification];
}
- (void)popViewFamily
{
    _alertView = [[[NSBundle mainBundle] loadNibNamed:@"testView" owner:self options:nil] lastObject];
    _alertView.frame = CGRectMake(0, 0, _k_w, _k_h);
    _alertView.lbltitle.text = @"\n是否愿意家人知晓";
    _alertView.lbltitle.textColor = rgb(95, 95, 95);
    [_alertView.DisSureBtn setTitleColor:rgb(142, 142, 142) forState:UIControlStateNormal];
    [_alertView.sureBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
    _alertView.DisSureBtn.tag = 11;
    _alertView.sureBtn.tag = 10;
    [_alertView.DisSureBtn setTitle:@"否" forState:UIControlStateNormal];
    [_alertView.sureBtn setTitle:@"是" forState:UIControlStateNormal];
    [_alertView.DisSureBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView.sureBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView show];
}

- (void)click:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
            [_alertView hide];
            //            [self goLoanMoneyVC:@"0"];
            [self goVC:@"0"];
        }
            break;
        case 11:
        {
            [_alertView hide];
            //            [self goLoanMoneyVC:@"1"];
            [self goVC:@"1"];
        }
            break;
        default:
            break;
    }
}

- (void)goVC:(NSString *)is_know
{
    
    LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
    loanFirstVC.productId = _product_id;
    loanFirstVC.if_family_know = is_know;
    if (_careerParse != nil) {
        loanFirstVC.resultCode = _careerParse.result.resultcode;
        loanFirstVC.rulesId = _careerParse.result.rulesid;
    } else {
        loanFirstVC.resultCode = _resultCode;
        loanFirstVC.rulesId = _rulesId;
    }
    loanFirstVC.model = _model;
    if ([_product_id isEqualToString:RapidLoan]) {
        loanFirstVC.req_loan_amt = _req_loan_amt;
    }
    [self.navigationController pushViewController:loanFirstVC animated:true];
    
}

#pragma mark - 借款确认页面
- (void)goLoanMoneyVC:(NSString *)is_know
{
    LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
    loanFirstVC.productId = _product_id;
    loanFirstVC.if_family_know = is_know;
    DLog(@"%@-------%@",_careerParse.result.resultcode,_careerParse.result.rulesid);
    if (_careerParse != nil) {
        loanFirstVC.resultCode = _careerParse.result.resultcode;
        loanFirstVC.rulesId = _careerParse.result.rulesid;
    } else {
        loanFirstVC.resultCode = _resultCode;
        loanFirstVC.rulesId = _rulesId;
    }
    
    if ([[Utility sharedUtility].userInfo.pruductId isEqualToString:RapidLoan]) {
        loanFirstVC.req_loan_amt = _req_loan_amt;
    }
    [self.navigationController pushViewController:loanFirstVC animated:true];
}

- (void)fatchRate:(void(^)(RateModel *rate))finish
{
    NSDictionary *dic = @{@"priduct_id_":RapidLoan};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
        if ([rateParse.flag isEqualToString:@"0000"]) {
            finish(rateParse);
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:rateParse.msg];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)setProfessRule:(CareerParse *)careerParse
{
    _careerParse = careerParse;
    _resultCode = careerParse.result.resultcode;
    _rulesId = careerParse.result.rulesid;
}

- (void)setCornerWithoutRadius:(UIView *)view
{
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
}

#pragma mark - 魔蝎信用卡以及社保集成
//邮箱导入
- (void)mailImportClick{
    @try {
        [MoxieSDK shared].taskType = @"email";
        [[MoxieSDK shared] startFunction];
    } @catch (NSException *exception) {
        DLog(@"%s\n%@", __FUNCTION__, exception);
    } @finally {
    }
}
//社保导入
-(void)securityImportClick{
    @try {
        [MoxieSDK shared].taskType = @"security";
        [[MoxieSDK shared] startFunction];
    } @catch (NSException *exception) {
        DLog(@"%s\n%@", __FUNCTION__, exception);
    } @finally {
    }
}
-(void)configMoxieSDK{
    /***必须配置的基本参数*/
    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].userId = [Utility sharedUtility].userInfo.juid;
    [MoxieSDK shared].apiKey = theMoxieApiKey;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].useNavigationPush = NO;
    [self editSDKInfo];
};

#pragma MoxieSDK Result Delegate
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    int code = [resultDictionary[@"code"] intValue];
    NSString *taskType = resultDictionary[@"taskType"];
    NSString *taskId = resultDictionary[@"taskId"];
    NSString *message = resultDictionary[@"message"];
    NSString *account = resultDictionary[@"account"];
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d",code,taskType,taskId,message,account,loginDone);
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
        [self obtainHighRankingClassifyStatus:taskType TaskId:taskId];

    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");

        [self obtainHighRankingClassifyStatus:taskType TaskId:taskId];
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        NSLog(@"用户未登录");
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    //0 其他失败原因
    //-2平台方不可用（如中国移动维护等）
    //-3魔蝎数据服务异常
    //-4用户输入出错（密码、验证码等输错后退出）
    else{
        NSLog(@"任务失败");
    }
}

-(void)editSDKInfo{
    [MoxieSDK shared].navigationController.navigationBar.translucent = YES;
    [MoxieSDK shared].backImageName = @"return";
    [MoxieSDK shared].navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [MoxieSDK shared].navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[MoxieSDK shared].navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation"] forBarMetrics:UIBarMetricsDefault];
}

-(void)TheCreditCardInfoupload:(NSString *)taskid {
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if (baseResultM.errCode.integerValue == 0) {
            //高级认证状态查询
            [self obtainHighRanking];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM TheCreditCardInfoUpload:taskid];
}
-(void)TheSocialSecurityupload:(NSString *)taskid {
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if (baseResultM.errCode.integerValue == 0) {
            //高级认证状态查询
            [self obtainHighRanking];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM socialSecurityInfoUpload:taskid];
}
-(void)obtainHighRankingClassifyStatus:(NSString *)type TaskId:(NSString *)taskId{
    if (!taskId || !type) {
        return;
    }
    if ([type isEqualToString:@"email"]) {
//        _creditCardStatus = @"1";
        [self TheCreditCardInfoupload:taskId];
    }
    if ([type isEqualToString:@"security"]) {
//        _socialSecurityStatus = @"1";
        [self TheSocialSecurityupload:taskId];
    }
}

-(void)obtainHighRanking{
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            NSArray * array = (NSArray *)baseResultM.data;
            for (NSDictionary * dic  in array) {
                HighRandingModel * highRandM  = [[HighRandingModel alloc]initWithDictionary:dic error:nil];
                if ([highRandM.tasktypeid isEqualToString:@"1"]) {
                    _socialSecurityHighRandM = highRandM;
                    _socialSecurityStatus = highRandM.resultid;
                }
                if ([highRandM.tasktypeid isEqualToString:@"2"]) {
                    _creditCardHighRandM = highRandM;
                    _creditCardStatus = highRandM.resultid;
                }
            }
            [self.tableView reloadData];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM obtainhighRankingStatus];
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
