//
//  UserDataAuthenticationListVCModules.m
//  fxdProduct
//
//  Created by dd on 2017/2/22.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserDataAuthenticationListVCModules.h"
#import "DataDisplayCell.h"
#import "UserIdentityInformationVCModules.h"
#import "UserProfessionalInformationVCModules.h"
#import "UserMobileAuthenticationVCModules.h"
#import "GetCustomerBaseViewModel.h"
#import "Custom_BaseInfo.h"
#import "GetCareerInfoViewModel.h"
#import "CareerParse.h"
#import "testView.h"
#import "HomeViewModel.h"
#import "DataWriteAndRead.h"
#import "SesameCreditCertificationVCModules.h"
#import "HomeProductList.h"
#import "SeniorCertificationView.h"
#import "UnfoldTableViewCell.h"
#import "MoxieSDK.h"
#import "EditCardsController.h"
#import "UserDataViewModel.h"
#import "UserDataModel.h"
#import "CardInfo.h"
#import "CheckViewModel.h"
#import "SupportBankList.h"
#import "CustomerCareerResult.h"

@interface UserDataAuthenticationListVCModules ()<UITableViewDelegate,UITableViewDataSource,ProfessionDataDelegate>
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
    UserDataModel * _userDataModel;
    BOOL isOpen;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserDataAuthenticationListVCModules

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
    _subTitleArr = @[@"请完善您的身份信息",@"请完善您的个人信息",@"请完成三方认证",@"请完善您的收款信息"];
    if (_isCash) {
        [self addBackItem];
    }else{
        [self addBackItemRoot];
    }
    
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
        [_applyBtn setBackgroundImage:[UIImage imageNamed:@"applicationBtn_Image"] forState:UIControlStateNormal];
        _applyBtn.enabled = true;
    }else{
        [_applyBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
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
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    //声明tableView的位置 添加下面代码
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(BarHeightNew, 0, 0, 0);
    }else if (@available(iOS 9.0, *)){
        self.automaticallyAdjustsScrollViewInsets = true;
    }else{
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshInfoStep)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, _k_w*0.15)];
    footView.backgroundColor = [UIColor whiteColor];
    _applyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [FXD_Tool setCorner:_applyBtn borderColor:[UIColor clearColor]];
    [_applyBtn setTitle:@"额度测评" forState:UIControlStateNormal];
    [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_applyBtn setBackgroundImage:[UIImage imageNamed:@"applicationBtn_Image"] forState:UIControlStateNormal];
    _applyBtn.enabled = false;
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
                cell.statusLabel.text = _userDataModel != nil ? _userDataModel.creditMailDesc : @"未完成";
                cell.statusLabel.textColor = rgb(159, 160, 162);
                if ([_creditCardStatus isEqualToString:@"3"]) {
                    cell.statusLabel.textColor = UI_MAIN_COLOR;
                }
                return cell;
            }
                break;
            case 1:
            {
                cell.iconImage.image = [UIImage imageNamed:@"shebao_icon"];
                cell.subTitleLabel.text = @"完善社保认证信息";
                cell.titleLable.text = @"社保认证";
                cell.statusLabel.text = _userDataModel != nil ? _userDataModel.socialDesc : @"未完成";;
                cell.statusLabel.textColor =  rgb(159, 160, 162);
                if ([_socialSecurityStatus isEqualToString:@"3"]) {
                    cell.statusLabel.textColor = UI_MAIN_COLOR;
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
            cell.statusLabel.text = _userDataModel.identityDesc;
            cell.statusLabel.textColor = rgb(159, 160, 162);
            if ([_userDataModel.identity isEqualToString:@"3"]) {
                cell.statusLabel.textColor = UI_MAIN_COLOR;
            }
            return cell;
        }
            break;
        case 1:
        {
            cell.iconImage.image = [UIImage imageNamed:@"UserData1"];
            cell.titleLable.text = @"个人信息";
            cell.subTitleLabel.text = @"完善您的联系人信息";
            cell.statusLabel.text = _userDataModel.personDesc;
            cell.statusLabel.textColor = rgb(159, 160, 162);
            if ([_userDataModel.person isEqualToString:@"3"]) {
                cell.statusLabel.textColor = UI_MAIN_COLOR;
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
            cell.statusLabel.text = _userDataModel.othersDesc;
            cell.statusLabel.textColor = rgb(159, 160, 162);
            if ([_userDataModel.others isEqualToString:@"3"]) {
                cell.statusLabel.textColor = UI_MAIN_COLOR;
            }
            return cell;
        }
            break;
        case 3:
        {
            cell.iconImage.image = [UIImage imageNamed:@"UserData3"];
            cell.titleLable.text = @"收款信息";
            cell.subTitleLabel.text = @"";
            cell.statusLabel.text = _userDataModel.gatheringDesc;
            cell.statusLabel.textColor = rgb(159, 160, 162);
            if ([_userDataModel.gathering isEqualToString:@"3"]) {
                cell.statusLabel.textColor = UI_MAIN_COLOR;
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
        switch (indexPath.row) {
            case 0:
                if ([_creditCardStatus isEqualToString:@"3"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                    return;
                }
                if ([_creditCardStatus isEqualToString:@"2"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证中，请稍后！"];
                    return;
                }
                [[FXD_MXVerifyManager sharedInteraction]mailImportClick];
                break;
            case 1:
                if ([_socialSecurityStatus isEqualToString:@"3"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                    return;
                }
                if ([_socialSecurityStatus isEqualToString:@"2"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证中，请稍后！"];
                    return;
                }
                [[FXD_MXVerifyManager sharedInteraction]securityImportClick];
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
            [self getUserInfo:^(UserDataInformationModel * userDataInformationM) {
                UserIdentityInformationVCModules *perInfoVC = [[UserIdentityInformationVCModules alloc] init];
                 perInfoVC.userDataIformationM = userDataInformationM;
                [self.navigationController pushViewController:perInfoVC animated:true];
            }];
        }
            break;
        case 1:
        {
            [self getCustomerCarrer_jhtml:^(CustomerCareerResult *careerInfo) {
                UserProfessionalInformationVCModules *professVC = [[UserProfessionalInformationVCModules alloc] init];
                professVC.delegate = self;
                professVC.product_id = _product_id;
                professVC.careerInfo = careerInfo;
                [self.navigationController pushViewController:professVC animated:true];
            }];
        }
            break;
        case 2:
        {
            if ([_userDataModel.others isEqualToString:@"3"]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
            }else {
                UserThirdPartyAuthVCModules * thirdPartyAuthVC = [[UserThirdPartyAuthVCModules alloc]init];
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
    if ([_userDataModel.identity isEqualToString:@"1"] && row > 0) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请您先完善身份信息！"];
        return false;
    }
    if ([_userDataModel.person isEqualToString:@"1"] && row > 1) {
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
            if ([_userDataModel.others isEqualToString:@"3"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
                return false;
            }
        }
            break;
        case 3:{
            if ([_userDataModel.gathering isEqualToString:@"3"]) {
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
- (void)getUserInfo:(void(^)(UserDataInformationModel * userDataInformationM))finish
{
    GetCustomerBaseViewModel *customerInfo = [[GetCustomerBaseViewModel alloc] init];
    [customerInfo setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseVM = returnValue;
        if ([baseVM.errCode isEqualToString:@"0"]) {
            UserDataInformationModel * userDataIM = [[UserDataInformationModel alloc]initWithDictionary:(NSDictionary *)baseVM.data error:nil];
            [DataWriteAndRead writeDataWithkey:UserInfomation value:userDataIM];
            [FXD_Utility sharedUtility].userInfo.userIDNumber = userDataIM.id_code_;
            [FXD_Utility sharedUtility].userInfo.realName = userDataIM.customer_name_;
            [FXD_Utility sharedUtility].userInfo.account_id = userDataIM.create_by_;
            finish(userDataIM);
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseVM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [customerInfo fatchCustomBaseInfo:nil];
}
-(void)getCustomerCarrer_jhtml:(void(^)(CustomerCareerResult *careerInfo))finish
{
    GetCareerInfoViewModel *getCareerInfoViewModel = [[GetCareerInfoViewModel alloc] init];
    [getCareerInfoViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM = returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            CustomerCareerResult * customerCareerR = [[CustomerCareerResult alloc]initWithDictionary:(NSDictionary *)baseRM.data error:nil];
            finish(customerCareerR);
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
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
//    //高级认证状态查询
//    [self obtainHighRanking];
    
    UserDataViewModel * userDataVM1 = [[UserDataViewModel alloc]init];
    [userDataVM1 setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * resultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([resultM.errCode isEqualToString:@"0"]) {
            UserDataModel * userDataM = [[UserDataModel alloc]initWithDictionary:(NSDictionary *)resultM.data error:nil];
            _userDataModel = userDataM;
            _socialSecurityStatus = userDataM.social;
            _creditCardStatus = userDataM.creditMail;
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
//            UserDataEvaluationVCModules * checkVC = [[UserDataEvaluationVCModules  alloc]init];
//            [self.navigationController pushViewController:checkVC animated:true];
//            //首次测评发放红包提示
//            NSString * str = baseResultM.data[@"redIssuedSucce"];
//            if (str != nil && ![str isEqualToString:@""]) {
//                [[MBPAlertView sharedMBPTextView]showTextOnly:[UIApplication sharedApplication].keyWindow message:str];
//            }
            [self.navigationController popToRootViewControllerAnimated:true];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM UserDataCertification:EliteLoan];
}

#pragma mark - 魔蝎信用卡以及社保集成
-(void)configMoxieSDK{
    [[FXD_MXVerifyManager sharedInteraction]configMoxieSDKViewcontroller:self mxResult:^(NSDictionary *resultDic) {
        int code = [resultDic[@"code"] intValue];
        NSString *taskType = resultDic[@"taskType"];
        NSString *taskId = resultDic[@"taskId"];
        BOOL loginDone = [resultDic[@"loginDone"] boolValue];
        if(code == 2 && loginDone == true){
            [self obtainHighRankingClassifyStatus:taskType TaskId:taskId];
        }
        else if(code == 1){
            [self obtainHighRankingClassifyStatus:taskType TaskId:taskId];
        }
    }];
};

-(void)TheCreditCardInfoupload:(NSString *)taskid {
    
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if (baseResultM.errCode.integerValue == 0) {
            //高级认证状态查询
            [self refreshInfoStep];
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
            [self refreshInfoStep];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
