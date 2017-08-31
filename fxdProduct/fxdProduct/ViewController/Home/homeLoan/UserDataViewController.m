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
#import "LoanSureSecondViewController.h"
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

@property (nonatomic, copy) NSString *isInfoEditable;  //0-前3项不可修改  1-可修改

@end

@implementation UserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"资料填写";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = true;
    processFlot = 0.0;
    isOpen = YES;
    _creditCardStatus = @"0";
    _socialSecurityStatus = @"0";

    _subTitleArr = @[@"请完善您的身份信息",@"请完善您的个人信息",@"请完善您的职业信息",@"请完成三方认证"];
    [self addBackItemRoot];
    [self configMoxieSDK];
    [self configTableview];
//    self.navigationController.navigationBar.barTintColor = UI_MAIN_COLOR;
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    if (_isMine) {
        _applyBtn.enabled = NO;
        _applyBtn.hidden = YES;
    }
}

- (void)addBackItemRoot
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    UIImage *img = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
    //    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
}

- (void)popBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setProcess
{

    if (_nextStep.integerValue > 0) {
        processFlot = (_nextStep.integerValue-1)*0.2;
    } else {
        if (_nextStep.integerValue == -1) {
            processFlot = 1;
            [_applyBtn setBackgroundColor:UI_MAIN_COLOR];
            _applyBtn.enabled = true;
        } else {
            processFlot = 1;
            [_applyBtn setBackgroundColor:UI_MAIN_COLOR];
            _applyBtn.enabled = true;
        }
        [_tableView reloadData];
    }
    if (processFlot <= 1 && processFlot >= 0) {
        CGFloat rightMarge = (_k_w-40)*processFlot;
        [processView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-(_k_w-20 - rightMarge)));
        }];
        [self.tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView.mj_header beginRefreshing];
//    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    [self getHomeProductList];
}

/**
 获取首页产品列表
 */
-(void)getHomeProductList{
    
    ProductListViewModel *productListViewModel = [[ProductListViewModel alloc]init];
    [productListViewModel setBlockWithReturnBlock:^(id returnValue) {
      HomeProductList *homeProductList = [HomeProductList yy_modelWithJSON:returnValue];

//        if ([homeProductList.data.productList.type isEqualToString:@"1"]) {
//            _applyBtn.enabled = NO;
//            _applyBtn.hidden = YES;
//            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:homeProductList.data.productList.refuseMsg];
//        }
    } WithFaileBlock:^{
        
    }];
    [productListViewModel fetchProductListInfo];
}


- (void)configTableview
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DataDisplayCell class]) bundle:nil] forCellReuseIdentifier:@"DataDisplayCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UnfoldTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"UnfoldTableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshInfoStep)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, _k_w*0.53)];
//    headView.backgroundColor = UI_MAIN_COLOR;
//    UIImageView *processBack = [[UIImageView alloc] init];
//    [self setCornerWithoutRadius:processBack];
//    processBack.image = [UIImage imageNamed:@"process"];
//    processBack.clipsToBounds = true;
//    [headView addSubview:processBack];
//    [processBack mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.top.equalTo(@100);
//        make.right.equalTo(@(-20));
//        make.height.equalTo(processBack.mas_width).multipliedBy(0.0597);
//    }];
//    [headView layoutIfNeeded];
//    
//    UIView *numView = [[UIView alloc] init];
//    numView.backgroundColor = [UIColor clearColor];
//    [headView addSubview:numView];
//    [numView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.top.equalTo(processBack.mas_bottom).offset(5);
//        make.right.equalTo(@(-20));
//        make.height.equalTo(numView.mas_width).multipliedBy(0.0597);
//    }];
//    [headView layoutIfNeeded];
//
//    for (int i = 0; i < 6; i++) {
//
//        UILabel *numLabel = [[UILabel alloc] init];
//        numLabel.textColor = [UIColor whiteColor];
//        numLabel.font = [UIFont systemFontOfSize:12.f];
//        numLabel.textAlignment = NSTextAlignmentCenter;
//        numLabel.text = [NSString stringWithFormat:@"%d%%",i*20];
//        
//        [numView addSubview:numLabel];
//        DLog(@"%lf",i*0.25*numView.frame.size.width);
//        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(numView.mas_left).offset(i*0.17*numView.frame.size.width);
//            make.top.equalTo(@0);
//            make.bottom.equalTo(@0);
//            make.width.equalTo(numLabel.mas_height).multipliedBy(2);
//        }];
//        [numLabel layoutIfNeeded];
//    }
//    
//    processView = [[UIView alloc] init];
//    processView.backgroundColor = rgb(128, 189, 51);
//    [headView addSubview:processView];
//    [self setCornerWithoutRadius:processView];
//    [processView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.top.equalTo(@100);
//        make.height.equalTo(processBack.mas_height);
//    }];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:13.f];
//    label.text = @"资料填写进度达到100%,即可借款";
//    label.textAlignment = NSTextAlignmentCenter;
//    [headView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
//        make.bottom.equalTo(@(-10));
//        make.height.equalTo(@20);
//    }];
//    
//    self.tableView.tableHeaderView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, _k_w*0.213)];
    footView.backgroundColor = [UIColor whiteColor];
    _applyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [Tool setCorner:_applyBtn borderColor:[UIColor clearColor]];
    [_applyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
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
    DLog(@"确认申请");
    
    [self PostStatuesMyLoanAmount:@{@"product_id_":_product_id}];
}

-(void)PostStatuesMyLoanAmount:(NSDictionary *)paramDic {
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if([returnValue[@"flag"] isEqualToString:@"0000"])
        {
            _model=[UserStateModel yy_modelWithJSON:returnValue[@"result"]];
            
            //            apply_flag_为0000，跳转到客户基本信息填写页面；
            //            apply_flag_为0001，跳转到审核未通过页面；
            //            apply_flag_为0002，跳转到提款选择还款周期页面；
            //            apply_flag_为0003，显示msg中的提示信息；
            //            apply_flag_为0004，根据apply_status_跳转到相应的页面。
            
            if ([_model.applyFlag isEqualToString:@"0000"]) {
                [self popViewFamily];
                
            }else if ([_model.applyFlag isEqualToString:@"0001"]){
                [self goCheckVC:_model];
            }else if ([_model.applyFlag isEqualToString:@"0002"]) {
                LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
                loanFirstVC.productId = _product_id;
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
                
            }else if ([_model.applyFlag isEqualToString:@"0003"]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
            }else if ([_model.applyFlag isEqualToString:@"0004"]){
                switch ([_model.applyStatus integerValue])
                {
                    case 6://就拒绝放款
                    case 2://审核失败
                    case 14://人工审核未通过
                    {
                        [self goCheckVC:_model];
                    }break;
                        
                    case 1://系统审核
                    case 3://人工审核中
                    case 15://人工审核通过
                    case 17:
                    {
                        [self goCheckVC:_model];
                    }
                        break;
                    case 13://已结清
                    case 12://提前结清
                    {
                        BOOL appAgin = [_model.applyAgain boolValue];
                        BOOL idtatues  = [_model.identifier boolValue];
                        if (idtatues) {
                            if (appAgin) {
                                [self goCheckVC:_model];
                            }
                        }else{
                            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"已经结清借款，当天不能借款"];
                        }
                    }
                        break;
                    case 11://已记坏账
                    case 10://委外催收
                    case 9://内部催收
                    case 8://逾期
                    case 7://正常放款
                    case 5://放款中
                    case 4://待放款
                    case 16://还款中
                    {
                        LoanMoneyViewController *loanVc = [LoanMoneyViewController new];
                        loanVc.userStateModel = _model;
                        [self.navigationController pushViewController:loanVc animated:YES];
                    }
                        break;
                    default:{
                        if ([[paramDic objectForKey:@"product_id_"] isEqualToString:RapidLoan]) {
//                            PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
//                            [self.navigationController pushViewController:payLoanview animated:true];
                        }
                        if ([[paramDic objectForKey:@"product_id_"] isEqualToString:SalaryLoan]) {
                            //                            UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                            //                            userDataVC.product_id = @"P001002";
                            //                            [self.navigationController pushViewController:userDataVC animated:true];

                        }
                    }
                        break;
                }
            }else if ([_model.applyFlag isEqualToString:@"0005"]) {
                if ([[paramDic objectForKey:@"product_id_"] isEqualToString:RapidLoan]) {
                    LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
                    loanFirstVC.productId = _product_id;
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
                if ([[paramDic objectForKey:@"product_id_"] isEqualToString:SalaryLoan]||[[paramDic objectForKey:@"product_id_"] isEqualToString:WhiteCollarLoan]) {
                    LoanSureSecondViewController *loanSecondVC = [[LoanSureSecondViewController alloc] init];
                    loanSecondVC.model = _model;
                    loanSecondVC.productId = [paramDic objectForKey:@"product_id_"];
                    [self.navigationController pushViewController:loanSecondVC animated:true];
                }
            }
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState:[paramDic objectForKey:@"product_id_"] ];
}

- (void)goCheckVC:(UserStateModel *)model
{
    CheckViewController *checkVC = [CheckViewController new];
    if ([model.applyFlag isEqualToString:@"0001"]) {
        checkVC.homeStatues = 2;
    }else {
        checkVC.homeStatues = [model.applyStatus integerValue];
    }
    checkVC.userStateModel = model;
    checkVC.task_status = model.taskStatus;
    checkVC.apply_again_ = model.applyAgain;
    if (model.days) {
        checkVC.days = model.days;
    }
    [self.navigationController pushViewController:checkVC animated:YES];
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
                cell.statusLabel.textColor = rgb(159, 160, 162);
                if ([_creditCardStatus isEqualToString:@"1"]) {
                    cell.statusLabel.textColor = rgb(42, 155, 234);
                }
                if ([_creditCardStatus isEqualToString:@"0"]) {
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
                cell.statusLabel.textColor = rgb(159, 160, 162);
                if ([_socialSecurityStatus isEqualToString:@"1"]) {
                    cell.statusLabel.textColor = rgb(42, 155, 234);
                }
                if ([_socialSecurityStatus isEqualToString:@"0"]) {
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
        }             break;
        case 3:
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
                if ([_creditCardStatus isEqualToString:@"1"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                    return;
                }
                if ([_creditCardStatus isEqualToString:@"2"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"认证中，请稍后！"];
                    return;
                }
                [self mailImportClick];
                break;
            case 1:
                if ([_socialSecurityStatus isEqualToString:@"1"]) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                    return;
                }
                if ([_socialSecurityStatus isEqualToString:@"2"]) {
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
            //此处需要一个返回默认卡的接口
            [self getGatheringInformation_jhtml:^(CardInfo *cardInfo) {
                EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:@"EditCardsController" bundle:nil];
                editCard.typeFlag = @"0";
                editCard.cardName = cardInfo.bankName;
                editCard.cardNum = cardInfo.tailNumber;
                editCard.reservedTel = cardInfo.phoneNum;
                [self.navigationController pushViewController:editCard animated:YES];
            }];
        }
            break;
        case 3:
        {
            if ([_userDataModel.others isEqualToString:@"1"]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
            }else {
                    thirdPartyAuthViewController * thirdPartyAuthVC = [[thirdPartyAuthViewController alloc]init];
                    [self.navigationController pushViewController:thirdPartyAuthVC animated:true];
            }
        }
            break;
        default:
            break;
    }
}
-(BOOL)cellStatusIsSelect:(NSInteger)row{
    
    if ([_isInfoEditable isEqualToString:@"0"] &&  row < 3) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
        return false;
    }
    if (row != 0) {
        if ([_userDataModel.identity isEqualToString:@"0"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请完善身份信息！"];
            return false;
        }
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

-(void)getGatheringInformation_jhtml:(void(^)(CardInfo *cardInfo))finish{
    
    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResult.flag isEqualToString:@"0000"]) {
            NSArray * array  = (NSArray *)baseResult.result;
            NSMutableArray * supportBankListArr = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [supportBankListArr addObject:bankList];
            }
            [self fatchCardInfo:supportBankListArr success:^(CardInfo *cardInfo) {
                finish(cardInfo);
            }];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getSupportBankListInfo:@"2"];
}
- (void)fatchCardInfo:(NSMutableArray *)supportBankListArr success:(void(^)(CardInfo *cardInfo))finish
{
    UserDataViewModel * userDataVM = [[UserDataViewModel alloc]init];
    [userDataVM setBlockWithReturnBlock:^(id returnValue) {
        UserCardResult *  userCardsModel = [UserCardResult yy_modelWithJSON:returnValue];
        if([userCardsModel.flag isEqualToString:@"0000"]){
            if (userCardsModel.result.count > 0) {
                for(NSInteger j=0;j<userCardsModel.result.count;j++)
                {
                    CardResult * cardResult = [userCardsModel.result objectAtIndex:0];
                    if([cardResult.card_type_ isEqualToString:@"2"]){
                        for (SupportBankList *banlist in supportBankListArr) {
                            if ([cardResult.card_bank_ isEqualToString: banlist.bank_code_]) {
                                CardInfo *cardInfo = [[CardInfo alloc] init];
                                cardInfo.tailNumber = cardResult.card_no_;
                                cardInfo.bankName = banlist.bank_name_;
                                cardInfo.cardIdentifier = cardResult.id_;
                                cardInfo.phoneNum = cardResult.bank_reserve_phone_;
                                finish(cardInfo);
                            }
                        }
                        break;
                    }
                }
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:userCardsModel.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataVM obtainGatheringInformation];
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
            _isInfoEditable = userDataM.edit;
            _userDataModel = userDataM;
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
    
    [MoxieSDK shared].taskType = @"email";
    [[MoxieSDK shared] startFunction];

}
//社保导入
-(void)securityImportClick{
    [MoxieSDK shared].taskType = @"security";
    [[MoxieSDK shared] startFunction];

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
                if ([highRandM.type isEqualToString:@"社保"]) {
                    _socialSecurityHighRandM = highRandM;
                    _socialSecurityStatus = highRandM.resultid;
                }
                if ([highRandM.type isEqualToString:@"邮箱信用卡"]) {
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
