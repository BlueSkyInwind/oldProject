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

@interface UserDataViewController ()<UITableViewDelegate,UITableViewDataSource,ProfessionDataDelegate>
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
    UserStateModel *_model;
    
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
    self.automaticallyAdjustsScrollViewInsets = false;
    processFlot = 0.0;
    _subTitleArr = @[@"请完善您的个人信息",@"请完善您的联系人信息",@"请完善您的职业信息",@"请完成三方认证"];
    [self addBackItemRoot];
    
    [self configTableview];
    self.navigationController.navigationBar.barTintColor = UI_MAIN_COLOR;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    
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
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    [self getHomeProductList];
}


/**
 获取首页产品列表
 */
-(void)getHomeProductList{
    
    ProductListViewModel *productListViewModel = [[ProductListViewModel alloc]init];
    [productListViewModel setBlockWithReturnBlock:^(id returnValue) {
      HomeProductList *homeProductList = [HomeProductList yy_modelWithJSON:returnValue];

        if ([homeProductList.result.type isEqualToString:@"1"]) {
            _applyBtn.enabled = NO;
            _applyBtn.hidden = YES;
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:homeProductList.result.refuseMsg];
        }
        
    } WithFaileBlock:^{
        
    }];
    [productListViewModel fetchProductListInfo];
}


- (void)configTableview
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DataDisplayCell class]) bundle:nil] forCellReuseIdentifier:@"DataDisplayCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshInfoStep)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, _k_w*0.53)];
    headView.backgroundColor = UI_MAIN_COLOR;
    UIImageView *processBack = [[UIImageView alloc] init];
    [self setCornerWithoutRadius:processBack];
    processBack.image = [UIImage imageNamed:@"process"];
    processBack.clipsToBounds = true;
    [headView addSubview:processBack];
    [processBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@100);
        make.right.equalTo(@(-20));
        make.height.equalTo(processBack.mas_width).multipliedBy(0.0597);
    }];
    [headView layoutIfNeeded];
    
    UIView *numView = [[UIView alloc] init];
    numView.backgroundColor = [UIColor clearColor];
    [headView addSubview:numView];
    [numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(processBack.mas_bottom).offset(5);
        make.right.equalTo(@(-20));
        make.height.equalTo(numView.mas_width).multipliedBy(0.0597);
    }];
    [headView layoutIfNeeded];

    for (int i = 0; i < 6; i++) {

        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.font = [UIFont systemFontOfSize:12.f];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.text = [NSString stringWithFormat:@"%d%%",i*20];
        
        [numView addSubview:numLabel];
        DLog(@"%lf",i*0.25*numView.frame.size.width);
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numView.mas_left).offset(i*0.17*numView.frame.size.width);
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.width.equalTo(numLabel.mas_height).multipliedBy(2);
        }];
        [numLabel layoutIfNeeded];
    }
    
    processView = [[UIView alloc] init];
    processView.backgroundColor = rgb(128, 189, 51);
    [headView addSubview:processView];
    [self setCornerWithoutRadius:processView];
    [processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@100);
        make.height.equalTo(processBack.mas_height);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13.f];
    label.text = @"资料填写进度达到100%,即可借款";
    label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@(-10));
        make.height.equalTo(@20);
    }];
    
    self.tableView.tableHeaderView = headView;
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
                            PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
                            [self.navigationController pushViewController:payLoanview animated:true];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return 6;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (indexPath.row == 0) {
            return _k_w*0.06f;
        }else{
        
            return _k_w*0.21f;
        }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *iconView = [[UIImageView alloc] init];
            iconView.image = [UIImage imageNamed:@"topCellIcon"];
            [cell.contentView addSubview:iconView];
            [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@8);
                make.top.equalTo(@5);
                make.width.equalTo(@22);
                make.height.equalTo(@22);

            }];
            UILabel *label = [[UILabel alloc] init];
            [cell.contentView addSubview:label];
            label.text = @"请按照顺序进行各项资料填写";
            label.textColor = [UIColor redColor];
            label.font = [UIFont systemFontOfSize:13.f];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(iconView.mas_right).offset(4);
                make.top.equalTo(@10);
                make.height.equalTo(@15);
                make.right.equalTo(cell.contentView);
            }];

        }
        return cell;
    }else {
        
            DataDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataDisplayCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row < _nextStep.integerValue || _nextStep.integerValue < 0) {
                cell.statusLabel.text = @"已完成";
                cell.statusLabel.textColor = rgb(42, 155, 234);
            } else {
                cell.statusLabel.text = @"未完成";
                cell.statusLabel.textColor = rgb(159, 160, 162);
            }
            switch (indexPath.row) {
                case 1:
                {
                    
                    cell.iconImage.image = [UIImage imageNamed:@"UserData1"];
                    cell.titleLable.text = @"个人信息";
                    cell.subTitleLabel.text = @"完善您的个人信息";
                    
                    return cell;
                }
                    break;
                case 2:
                {
                    cell.iconImage.image = [UIImage imageNamed:@"UserData2"];
                    cell.titleLable.text = @"联系人信息";
                    cell.subTitleLabel.text = @"完善您的联系人信息";
                    return cell;
                }
                    break;
                case 3:
                {
                    cell.iconImage.image = [UIImage imageNamed:@"UserData3"];
                    cell.titleLable.text = @"职业信息";
                    cell.subTitleLabel.text = @"完善您的职业信息";
                    return cell;
                }
                    break;
                case 4:
                {
                    cell.iconImage.image = [UIImage imageNamed:@"UserData4"];
                    cell.titleLable.text = @"第三方认证";
                    cell.subTitleLabel.text = @"完成第三方认证有助于通过审核";
                    if (UI_IS_IPHONE5) {
                        cell.subTitleLabel.font = [UIFont systemFontOfSize:10.f];
                    }
                    return cell;
                }
                    break;
                case 5:
                    cell.iconImage.image = [UIImage imageNamed:@"zhima"];
                    cell.titleLable.text = @"芝麻信用";
                    cell.subTitleLabel.text = @"授权获取您的芝麻信用信息";
                    if (UI_IS_IPHONE5) {
                        cell.subTitleLabel.font = [UIFont systemFontOfSize:10.f];
                    }
                    cell.lineView.hidden = true;
                    if (_isZmxyAuth.integerValue == 2) {
                        cell.statusLabel.text = @"已完成";
                        cell.statusLabel.textColor = rgb(42, 155, 234);
                    } else if(_isZmxyAuth.integerValue == 1){
                        cell.statusLabel.text = @"认证中";
                        cell.statusLabel.textColor = rgb(159, 160, 162);
                    }else if(_isZmxyAuth.integerValue == 3){
                        
                        cell.statusLabel.text = @"未完成";
                        cell.statusLabel.textColor = rgb(159, 160, 162);
                    }
                    return cell;
                default:
                    break;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
        DLog(@"%ld",_nextStep.integerValue);
        if (_nextStep.integerValue > 0) {
            if (![self checkUserAuth:indexPath.row]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_subTitleArr[_nextStep.integerValue-1]];
                return;
            }
        }
        if (_nextStep.integerValue == -2) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前状态无法修改资料"];
            return;
        }
    
    switch (indexPath.row) {
        case 1:
        {
            [self getUserInfo:^(Custom_BaseInfo *custom_baseInfo) {
                PserInfoViewController *perInfoVC = [[PserInfoViewController alloc] init];
                perInfoVC.custom_baseInfo = custom_baseInfo;
                [self.navigationController pushViewController:perInfoVC animated:true];
            }];
        }
            break;
            
        case 2:
        {
            [self getUserInfo:^(Custom_BaseInfo *custom_baseInfo) {
                UserContactsViewController *userContactVC = [[UserContactsViewController alloc] init];
                userContactVC.custom_baseInfo = custom_baseInfo;
                [self.navigationController pushViewController:userContactVC animated:true];
            }];
        }
            break;
        case 3:
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
        case 4:
        {
            if (indexPath.row < _nextStep.integerValue || _nextStep.integerValue < 0){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
            }else {
                [self getUserInfo:^(Custom_BaseInfo *custom_baseInfo) {
                    CertificationViewController *certificationVC = [[CertificationViewController alloc] init];
                    certificationVC.phoneAuthChannel = _phoneAuthChannel;
                    certificationVC.isMobileAuth = _isMobileAuth;
                    certificationVC.resultCode = _resultCode;
                    if (custom_baseInfo.result.verifyStatus == 2) {
                        certificationVC.liveEnabel = false;
                    } else {
                        certificationVC.liveEnabel = true;
                        certificationVC.verifyStatus = [NSString stringWithFormat:@"%.0lf",custom_baseInfo.result.verifyStatus];
                    }
                    //  只有为 0  条件为真 走第三方认证   否则非零只显示运营商认证
                    if ([_resultCode isEqualToString:@"0"]) {
                        certificationVC.showAll = true;
                    } else {
                        certificationVC.showAll = false;
                    }
                    [self.navigationController pushViewController:certificationVC animated:true];
                }];
            }
        }
            break;
        case 5:
            if (_isZmxyAuth.integerValue == 2||processFlot ==1) {
                
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已完成认证"];
                return;
            }else if(_isZmxyAuth.integerValue == 1){
                
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您正在认证中，请勿重复认证!"];
                return;
                
            }else{
                
                SesameCreditViewController *controller = [[SesameCreditViewController alloc]initWithNibName:@"SesameCreditViewController" bundle:nil];
                [self.navigationController pushViewController:controller animated:YES];
                return;
            }
            break;
        default:
            break;
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    topView.backgroundColor = UI_MAIN_COLOR;
    topView.frame = CGRectMake(0, 0, _k_w, -scrollView.contentOffset.y);
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
    
    NSDictionary *paramDic = @{@"product_id_":_product_id,
                               
                               };
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_customerAuthInfo_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            _nextStep = [[object objectForKey:@"result"] objectForKey:@"nextStep"];
            _resultCode = [[object objectForKey:@"result"] objectForKey:@"resultcode"];
            _rulesId = [[object objectForKey:@"result"] objectForKey:@"rulesid"];
            _isMobileAuth = [[object objectForKey:@"result"] objectForKey:@"isMobileAuth"];
            _isZmxyAuth = [[object objectForKey:@"result"] objectForKey:@"isZmxyAuth"];// 1 未认证    2 认证通过   3 认证未通过
            _phoneAuthChannel = [[object objectForKey:@"result"] objectForKey:@"TRUCKS_"];  // 手机认证通道 JXL 表示聚信立，TC 表示天创认证
            if (_nextStep.integerValue == 4) {
                _isInfoEditable = [[object objectForKey:@"result"] objectForKey:@"isInfoEditable"];
            }
            [self setProcess];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(EnumServerStatus status, id object) {
        [self.tableView.mj_header endRefreshing];
    }];
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
