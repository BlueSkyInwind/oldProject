//
//  HomeViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "CheckViewController.h"
#import "LoanMoneyViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationViewController.h"
#import "UserStateModel.h"
#import "ReturnMsgBaseClass.h"
#import "ExpressViewController.h"
#import "HomePopView.h"
#import "LewPopupViewController.h"
#import "PCCircleViewConst.h"
#import "HomePop.h"
#import "FXDWebViewController.h"
#import "MessageCenterViewController.h"
#import "HomeProductCell.h"
#import "SDCycleScrollView.h"
#import "HomeBottomCell.h"
#import "RepayRecordController.h"
#import "UserDefaulInfo.h"
#import "LoanSureSecondViewController.h"
#import "LoanSureFirstViewController.h"
#import "CycleTextCell.h"
#import "PayLoanChooseController.h"
#import "QRPopView.h"
#import "LoanProcessViewController.h"
#import "LoanProcessModel.h"
#import "LoanRecordParse.h"
#import "RepayRequestManage.h"
//#import "ContactClass.h"
#import "UserDataViewController.h"
#import "HomeBannerModel.h"
#import "RateModel.h"
#import "HomeProductList.h"
#import "CheckViewModel.h"
#import "QryUserStatusModel.h"
#import "GetCaseInfo.h"
#import "P2PViewController.h"
@interface HomeViewController ()<PopViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
    ReturnMsgBaseClass *_returnParse;
    LoanRecordParse *_loanRecordParse;
    NSString *_advTapToUrl;
    NSString *_shareContent;
    NSTimer * _countdownTimer;
    HomePopView *_popView;
    NSInteger _count;
    UserStateModel *_model;
    HomeBannerModel *_bannerParse;
    HomeProductList *_homeProductList;
    SDCycleScrollView *_sdView;
    NSMutableArray *_dataArray;
    QryUserStatusModel *_qryUserStatusModel;
}

@end


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavMesRightBar];
    
    self.navigationItem.title = @"发薪贷";
    _count = 0;
   _dataArray = [NSMutableArray array];
    [self setUpTableview];
    [self setNavQRRightBar];
    [self fatchAdv];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UserDefaulInfo getUserInfoData];
    
    [self fatchRecord];
    [self fatchBanner];
    [self getHomeProductList];
    [self getFxdCaseInfo];
    //[[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}
- (void)viewWillDisappear:(BOOL)animated
{
    //[[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    [super viewWillDisappear:animated];
    
}
#pragma mark  - 视图布局
- (void)setNavQRRightBar {
    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"icon_qr"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(qrClick)];
    //initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem = aBarbi;
}
- (void)setUpTableview
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeProductCell class]) bundle:nil] forCellReuseIdentifier:@"HomeProductCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeBottomCell class]) bundle:nil] forCellReuseIdentifier:@"HomeBottomCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CycleTextCell class]) bundle:nil] forCellReuseIdentifier:@"CycleTextCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    DLog(@"%lf",_k_w);
    _sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _k_w, 0.5*_k_w) delegate:self placeholderImage:[UIImage imageNamed:@"banner-placeholder"]];
    //375 185
    _sdView.delegate = self;
    _sdView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    
    self.tableView.tableHeaderView = _sdView;
}


- (void)qrClick
{
    QRPopView *qrPopView = [QRPopView defaultQRPopView];
    [qrPopView layoutIfNeeded];
    qrPopView.parentVC = self;
    [self lew_presentPopupView:qrPopView animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
        
    }];
}

- (void)setMessageBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"homemesage"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    //    btn.frame = CGRectMake(100, 25, 21, 21);
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@21);
        make.height.equalTo(@21);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(@25);
        
    }];
}

- (void)messageClick
{
    MessageCenterViewController *messView = [MessageCenterViewController new];
    [self.navigationController pushViewController:messView animated:YES];
}

- (void)popView:(HomePop *)model
{
    if ([model.result.is_valid_ isEqualToString:@"1"]) {
        _popView = [HomePopView defaultPopupView];
        _popView.closeBtn.hidden = YES;
        _popView.delegate = self;
        [_popView.imageView sd_setImageWithURL:[NSURL URLWithString:model.result.files_.firstObject.file_store_path_]];
        _advTapToUrl = model.result.files_.firstObject.link_url_;
        _shareContent = model.result.content_;
        _popView.parentVC = self;
        [self lew_presentPopupView:_popView animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
            
        }];
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onClose) userInfo:nil repeats:true];
    }
}

- (void)onClose
{
    _count += 1;
    if (_count == 2) {
        _popView.closeBtn.hidden = false;
        [_countdownTimer invalidate];
    }
}

- (void)imageTap
{
    DLog(@"广告图片点击");
    if ([_advTapToUrl hasPrefix:@"http://"] || [_advTapToUrl hasPrefix:@"https://"]) {
        FXDWebViewController *webView = [[FXDWebViewController alloc] init];
        webView.urlStr = _advTapToUrl;
        webView.shareContent = _shareContent;
        [self.navigationController pushViewController:webView animated:true];
        [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
    }
}

- (void)highSeeExpenses
{
    ExpressViewController *expressVC = [[ExpressViewController alloc] init];
    expressVC.productId = SalaryLoan;
    [self.navigationController pushViewController:expressVC animated:YES];
}

- (void)lowSeeExpenses
{
    ExpressViewController *expressVC = [[ExpressViewController alloc] init];
    expressVC.productId = RapidLoan;
    [self.navigationController pushViewController:expressVC animated:YES];
}

//- (void)checkVersion{
//    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSDictionary *paramDic = @{@"platform_type_":PLATFORM,
//                               @"app_version_":app_Version};
//    [[FXDNetWorkManager sharedNetWorkManager] CheckVersion:[NSString stringWithFormat:@"%@%@",_main_url,_checkVersion_jhtml] paramters:paramDic finished:^(EnumServerStatus status, id object) {
//        _returnParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
//        [UserDefaulInfo getUserInfoData];
//        if ([_returnParse.flag isEqualToString:@"0012"]) {
//            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:_returnParse.msg cencelBtn:nil otherBtn:@[@"好的"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
//                
//            }];
//        } else if ([_returnParse.flag isEqualToString:@"0013"]) {
//            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:_returnParse.msg cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
//                if (index == 1) {
//                    [Utility sharedUtility].userInfo.isUpdate = YES;
//                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
//                }
//            }];
//        }
//    } failure:^(EnumServerStatus status, id object) {
//        
//    }];
//}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSInteger i=0;
    if (_dataArray.count>0) {
        i=_dataArray.count+1;
    }else{
        i=1;
    }
    if (section < i) {
        return 3.0f;
    }
    return 0.1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger i = 0;
    if (_dataArray.count>0) {
        i=_dataArray.count+2;
    }else{
        i=2;
    }
    return i;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger i = 0;
    if (_dataArray.count>0) {
        i=_dataArray.count+1;
    }else{
        
        i=1;
    }
    if (indexPath.section == 0) {
        return 30.f;
    } else {
        return (_k_h-0.5*_k_w-155)/i;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    HomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeProductCell"];
    cell.helpImage.hidden = true;
    
    if (indexPath.section == 0) {
        CycleTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CycleTextCell"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cycleICON"]];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(@20);
            make.height.equalTo(@20);
            make.width.equalTo(@20);
        }];
        SDCycleScrollView *sdCycleScrollview = [[SDCycleScrollView alloc] init];
        sdCycleScrollview.userInteractionEnabled = false;
        sdCycleScrollview.delegate = self;
        sdCycleScrollview.onlyDisplayText = true;
        sdCycleScrollview.titleLabelBackgroundColor = [UIColor whiteColor];
        sdCycleScrollview.titleLabelTextColor = rgb(82, 82, 82);
        sdCycleScrollview.scrollDirection = UICollectionViewScrollDirectionVertical;
        NSMutableArray *titlesArray = [NSMutableArray new];
        for (LoanRecordResult *result in _loanRecordParse.result) {
            [titlesArray addObject:result.content];
        }
        sdCycleScrollview.titlesGroup = [titlesArray copy];
        if (UI_IS_IPHONE5) {
            sdCycleScrollview.titleLabelTextFont = [UIFont systemFontOfSize:13.f];
        }
        [cell.contentView addSubview:sdCycleScrollview];
        [sdCycleScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(5);
            make.right.equalTo(@(-10));
            make.centerY.equalTo(cell.mas_centerY);
            make.height.equalTo(@20);
        }];
        
        return cell;
    }
    
    if (indexPath.section>0&&indexPath.section<=_dataArray.count) {
        
        HomeProductListProducts *product = _dataArray[indexPath.section-1];
        cell.rightImageView.image = [UIImage imageNamed:@"home_08"];
        
        BOOL isOverLimit = [product.isOverLimit boolValue];
        if (isOverLimit) {
            [cell.loanBtn setBackgroundImage:[UIImage imageNamed:@"beyond_lines_Limit"] forState:UIControlStateNormal];
            [cell.loanBtn setTitle:@"" forState:UIControlStateNormal];
            
        }else {
            [cell.loanBtn setBackgroundImage:nil forState:UIControlStateNormal];
            [cell.loanBtn setTitle:@"我要借款" forState:UIControlStateNormal];
            
        }

        [cell.proLogoImage sd_setImageWithURL:[NSURL URLWithString:product.ext_attr_.icon_]];
        cell.periodLabel.text = product.ext_attr_.amt_desc_;
        cell.amountLabel.text = product.name_;
        
        cell.amountLabel.font = [UIFont systemFontOfSize:18.0];
        cell.amountLabel.textColor = [UIColor colorWithHexColorString:@"666666"];
        cell.helpImage.userInteractionEnabled = true;
 
        if ([product.id_ isEqualToString:SalaryLoan]) {
            
//         cell.proLogoImage.image = [UIImage imageNamed:@"home_01"];
            cell.specialtyImage.image = [UIImage imageNamed:@"home_04"];
            UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highSeeExpenses)];
            [cell.helpImage addGestureRecognizer:gest];
            
        }else if([product.id_ isEqualToString:WhiteCollarLoan]){
        
//            cell.proLogoImage.image = [UIImage imageNamed:@"home10"];
//            UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lowSeeExpenses)];
//            [cell.helpImage addGestureRecognizer:gest];
            cell.specialtyImage.image = [UIImage imageNamed:@"home11"];
            
        }else{
            
//         cell.proLogoImage.image = [UIImage imageNamed:@"home_02"];
            UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lowSeeExpenses)];
            [cell.helpImage addGestureRecognizer:gest];
            cell.specialtyImage.image = [UIImage imageNamed:@"home_05"];
        
        }
        return cell;
    }

    if (indexPath.section == _dataArray.count+1&&_dataArray.count>0) {
        HomeBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBottomCell"];
        UITapGestureRecognizer *gestPay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payMoney)];
        cell.payView.userInteractionEnabled = true;
        [cell.payView addGestureRecognizer:gestPay];
        
        UITapGestureRecognizer *gestProcess = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loanProcess)];
        cell.loanProcessView.userInteractionEnabled = true;
        [cell.loanProcessView addGestureRecognizer:gestProcess];
        
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expense)];
        cell.repayRecordView.userInteractionEnabled = true;
        [cell.repayRecordView addGestureRecognizer:gest];
        return cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section>0&&_dataArray.count+1 !=indexPath.section) {
        
        HomeProductListProducts *product = _dataArray[indexPath.section-1];
        
        if ([product.isOverLimit boolValue]) {
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"您申请的产品今日额度已满，请尝试其他产品或明天再来"];
            return;
        }
        if ([product.id_ isEqualToString:SalaryLoan]) {
            [self highLoanClick];
        }
        if ([product.id_ isEqualToString:RapidLoan]) {
            [self lowLoan];
        }
        if ([product.id_ isEqualToString:WhiteCollarLoan]) {
            [self whiteCollarLoanClick];
            //        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"本产品目前仅开放微信公众号用户申请，请关注“急速发薪”微信公众号进行申请"];
        }
    }
}

#pragma mak - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DLog(@"点击");
    if (_bannerParse && _bannerParse.result.files_.count > 0) {
        HomeBannerFiles *files = _bannerParse.result.files_[index];
        if ([files.link_url_.lowercaseString hasPrefix:@"http"] || [files.link_url_.lowercaseString hasPrefix:@"https"]) {
            FXDWebViewController *webView = [[FXDWebViewController alloc] init];
            webView.urlStr = files.link_url_;
            [self.navigationController pushViewController:webView animated:true];
        }
    }
}

#pragma mark ->我要借款... Action
- (void)highLoanClick
{
    DLog(@"高额借款");
    if ([Utility sharedUtility].loginFlage) {
        [Utility sharedUtility].userInfo.pruductId = SalaryLoan;
        [self PostStatuesMyLoanAmount:SalaryLoan];
    } else {
        [self presentLogin:self];
    }
}

#pragma mark ->白领贷借款... Action
- (void)whiteCollarLoanClick
{
    DLog(@"白领贷借款");
    if ([Utility sharedUtility].loginFlage) {
        [Utility sharedUtility].userInfo.pruductId = WhiteCollarLoan;
        [self PostStatuesMyLoanAmount:WhiteCollarLoan];
    } else {
        [self presentLogin:self];
    }
}

- (void)lowLoan
{
    DLog(@"低额借款");
    if ([Utility sharedUtility].loginFlage) {
        [Utility sharedUtility].userInfo.pruductId = RapidLoan;
        [self PostStatuesMyLoanAmount:RapidLoan];
    } else {
        [self presentLogin:self];
    }
}

#pragma mark ->我要还款
- (void)payMoney
{
    
    if ([Utility sharedUtility].loginFlage) {
        //        [self checkState:nil];
        if ([_model.platform_type isEqualToString:@"2"]) {
            if ([_qryUserStatusModel.result.flg isEqualToString:@"12"]) {
                
                LoanMoneyViewController *controller = [LoanMoneyViewController new];
                controller.userStateModel = _model;
                controller.qryUserStatusModel = _qryUserStatusModel;
                [self.navigationController pushViewController:controller animated:YES];
                
            }else if([_qryUserStatusModel.result.flg isEqualToString:@"3"]){
                
                NSString *url = [NSString stringWithFormat:@"%@%@?page_type_=%@&ret_url_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"1",_transition_url,[Utility sharedUtility].userInfo.userMobilePhone];
                P2PViewController *p2pVC = [[P2PViewController alloc] init];
                //        p2pVC.isOpenAccount = NO;
                p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [self.navigationController pushViewController:p2pVC animated:YES];
                
            }else{
                
                RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                repayRequest.targetVC = self;
                [repayRequest repayRequest];
            }
        }else{
        
            RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
            repayRequest.targetVC = self;
            [repayRequest repayRequest];
        }

    } else {
        [self presentLogin:self];
    }
}

- (void)expense
{
    DLog(@"费用说明");
    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_loanDetial_url];
    [self.navigationController pushViewController:webVC animated:true];
}

- (void)repayRecordClick
{
    
    if ([Utility sharedUtility].loginFlage) {
        RepayRecordController *repayRecord=[[RepayRecordController alloc]initWithNibName:@"RepayRecordController" bundle:nil];
        [self.navigationController pushViewController:repayRecord animated:YES];
    }else {
        [self presentLogin:self];
    }
}

#pragma mark - 获取数据
/**
 获取首页产品列表
 */
-(void)getHomeProductList{
    
    ProductListViewModel *productListViewModel = [[ProductListViewModel alloc]init];
    [productListViewModel setBlockWithReturnBlock:^(id returnValue) {
        _homeProductList = [HomeProductList yy_modelWithJSON:returnValue];
        [_dataArray removeAllObjects];
        for (HomeProductListProducts *product in _homeProductList.result.products) {
            [_dataArray addObject:product];
        }
        [_tableView reloadData];
    } WithFaileBlock:^{
        
    }];
    
    [productListViewModel fetchProductListInfo];
}
/**
 轮播图数据
 */
- (void)fatchBanner
{
    BannerViewModel *bannerViewModel = [[BannerViewModel alloc]init];
    [bannerViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        _bannerParse = [HomeBannerModel yy_modelWithJSON:returnValue];
        NSMutableArray *filesArr = [NSMutableArray array];
        for (HomeBannerFiles *file in _bannerParse.result.files_) {
            [filesArr addObject:file.file_store_path_];
        }
        _sdView.imageURLStringsGroup = filesArr.copy;
        [_tableView reloadData];
    } WithFaileBlock:^{
        
    }];
    
    [bannerViewModel fetchBannerInfo];
}

/**
 获取借款滚动记录
 */
- (void)fatchRecord
{
    HomeViewModel * homeViewModel = [[HomeViewModel alloc]init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        _loanRecordParse = [LoanRecordParse yy_modelWithJSON:returnValue];
        //        [self.tableView reloadData];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        NSArray *indexArray=[NSArray arrayWithObject:indexPath];
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchLoanRecord];
}
/**
 获取借款进度
 */
- (void)loanProcess
{
    DLog(@"借款进度");
    HomeViewModel * homeViewModel = [[HomeViewModel alloc]init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        LoanProcessModel *loanProcess = [LoanProcessModel yy_modelWithJSON:returnValue];
        if ([loanProcess.flag isEqualToString:@"0000"]) {
            
            LoanProcessViewController *processVC = [[LoanProcessViewController alloc] init];
            processVC.loanProcessParse = loanProcess;
            [self.navigationController pushViewController:processVC animated:true];
            
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:loanProcess.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchLoanProcess];
}
/**
 推广弹窗
 */
- (void)fatchAdv
{
    PopViewModel *popViewModel = [[PopViewModel alloc]init];
    [popViewModel setBlockWithReturnBlock:^(id returnValue) {
        HomePop *popParse = [HomePop yy_modelWithJSON:returnValue];
        [self popView:popParse];
    } WithFaileBlock:^{
        
    }];
    [popViewModel fetchPopViewInfo];
}

/**
 我要借款状态判断

 @param paramDic 参数
 */
-(void)PostStatuesMyLoanAmount:(NSString *)productId {
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if([returnValue[@"flag"] isEqualToString:@"0000"])
        {
            UserStateModel *model=[UserStateModel yy_modelWithJSON:returnValue[@"result"]];
            _model = model;
            //            apply_flag_为0000，跳转到客户基本信息填写页面；
            //            apply_flag_为0001，跳转到审核未通过页面；
            //            apply_flag_为0002，跳转到提款选择还款周期页面；
            //            apply_flag_为0003，显示msg中的提示信息；
            //            apply_flag_为0004，根据apply_status_跳转到相应的页面。
            
            if ([model.applyFlag isEqualToString:@"0000"]) {
                if ([productId isEqualToString:RapidLoan]) {
                    [self fatchRate:^(RateModel *rate) {
                        PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
                        payLoanview.product_id = productId;
                        payLoanview.userState = model;
                        payLoanview.rateModel = rate;
                        [self.navigationController pushViewController:payLoanview animated:true];
                    }];
                }
                if ([productId isEqualToString:SalaryLoan]) {

                    UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                    userDataVC.product_id = SalaryLoan;
                    [self.navigationController pushViewController:userDataVC animated:true];
                }
                if ([productId isEqualToString:WhiteCollarLoan]) {

                    UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                    userDataVC.product_id = WhiteCollarLoan;
                    [self.navigationController pushViewController:userDataVC animated:true];
                }
                
            }else if ([model.applyFlag isEqualToString:@"0001"]){
                UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                userDataVC.product_id = productId;
                [self.navigationController pushViewController:userDataVC animated:true];
            }else if ([model.applyFlag isEqualToString:@"0002"]) {
                LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
                loanFirstVC.productId = [Utility sharedUtility].userInfo.pruductId;
                loanFirstVC.model = model;
                [self.navigationController pushViewController:loanFirstVC animated:true];

            }else if ([model.applyFlag isEqualToString:@"0003"]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
            }else if ([model.applyFlag isEqualToString:@"0004"]){
//                if ([model.applyStatus isEqualToString:@""]) {
//                    model.applyStatus = @"21";
//                }
                switch ([model.applyStatus integerValue])
                {
                    
                    case 6://就拒绝放款
                    case 2://审核失败
                    case 14://人工审核未通过
                    {
                        BOOL mode = [model.identifier boolValue];
                        if (mode) {
                            UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                            userDataVC.product_id = productId;
                            [self.navigationController pushViewController:userDataVC animated:true];

                        }else{
                            [self goCheckVC:model productId:productId];
                        }
                    }break;
                        
                    case 1://系统审核
                    case 3://人工审核中
                    case 15://人工审核通过
                    case 17:
                    {
                        
                        if ([_qryUserStatusModel.result.flg isEqualToString:@"11"]||[_qryUserStatusModel.result.flg isEqualToString:@"12"]) {
                            
                            LoanMoneyViewController *controller = [LoanMoneyViewController new];
                            controller.userStateModel = _model;
                            controller.qryUserStatusModel = _qryUserStatusModel;
                            [self.navigationController pushViewController:controller animated:YES];
                            
                        }else{
                            [self goCheckVC:_model productId:productId];
                        }

                    }
                        break;
                    case 13://已结清
                    case 12://提前结清
                    {
                        BOOL appAgin = [model.applyAgain boolValue];
                        BOOL idtatues  = [model.identifier boolValue];
                        if (idtatues) {
                            if (appAgin) {
                                
                                if ([_qryUserStatusModel.result.flg isEqualToString:@"11"]||[_qryUserStatusModel.result.flg isEqualToString:@"12"]) {
                    
                                    LoanMoneyViewController *controller = [LoanMoneyViewController new];
                                    controller.userStateModel = _model;
                                    controller.qryUserStatusModel = _qryUserStatusModel;
                                    [self.navigationController pushViewController:controller animated:YES];
                    
                                }else{
                                    [self goCheckVC:_model productId:productId];
                                }

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
                    case 20://开户处理中
                    {
                        LoanMoneyViewController *loanVc = [LoanMoneyViewController new];
                        loanVc.userStateModel = model;
                        [self.navigationController pushViewController:loanVc animated:YES];
                    }
                        break;
                        
                    default:{
                        if ([productId isEqualToString:RapidLoan]) {
                            [self fatchRate:^(RateModel *rate) {
                                PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
                                payLoanview.product_id = productId;
                                payLoanview.userState = model;
                                payLoanview.rateModel = rate;
                                [self.navigationController pushViewController:payLoanview animated:true];
                            }];
                        }
                        if ([productId isEqualToString:SalaryLoan]) {
                            UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                            userDataVC.product_id = SalaryLoan;
                            [self.navigationController pushViewController:userDataVC animated:true];
                        }
                        if ([productId isEqualToString:WhiteCollarLoan]) {
                            UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                            userDataVC.product_id = WhiteCollarLoan;
                            [self.navigationController pushViewController:userDataVC animated:true];

                        }
                    }
                        break;
                }
            }else if ([model.applyFlag isEqualToString:@"0005"]) {
                if ([productId isEqualToString:RapidLoan]) {
                    [self fatchRate:^(RateModel *rate) {
                        PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
                        payLoanview.product_id = productId;
                        payLoanview.userState = model;
                        payLoanview.rateModel = rate;
                        [self.navigationController pushViewController:payLoanview animated:true];
                    }];
                }
                if ([productId isEqualToString:SalaryLoan]) {
                    LoanSureSecondViewController *loanSecondVC = [[LoanSureSecondViewController alloc] init];
                    loanSecondVC.model = model;
                    loanSecondVC.productId = productId;
                    [self.navigationController pushViewController:loanSecondVC animated:true];
                }
                if ([productId isEqualToString:WhiteCollarLoan]) {
                    LoanSureSecondViewController *loanSecondVC = [[LoanSureSecondViewController alloc] init];
                    loanSecondVC.model = model;
                    loanSecondVC.productId = productId;
                    [self.navigationController pushViewController:loanSecondVC animated:true];
                }
            }
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState:productId];
}

- (void)fatchRate:(void(^)(RateModel *rate))finish
{
    NSDictionary *dic = @{@"priduct_id_":RapidLoan};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
        if ([rateParse.flag isEqualToString:@"0000"]) {
            [Utility sharedUtility].rateParse = rateParse;
            finish(rateParse);
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:rateParse.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


#pragma mark 发标前查询进件
-(void)getFxdCaseInfo{
    
    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        GetCaseInfo *caseInfo = [GetCaseInfo yy_modelWithJSON:returnValue];
        if ([caseInfo.flag isEqualToString:@"0000"]) {

            [self getUserStatus:caseInfo];
        }
    } WithFaileBlock:^{
        
    }];
    [complianceViewModel getFXDCaseInfo];
    
}

#pragma mark  fxd用户状态查询，viewmodel
-(void)getUserStatus:(GetCaseInfo *)caseInfo{
    
    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        QryUserStatusModel *model = [QryUserStatusModel yy_modelWithJSON:returnValue];
        _qryUserStatusModel = model;
        if ([model.flag isEqualToString:@"0000"]) {
            

        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [complianceViewModel getUserStatus:caseInfo];
}


#pragma mark - 页面跳转
- (void)goCheckVC:(UserStateModel *)model productId:(NSString *)productId
{

    CheckViewController *checkVC = [CheckViewController new];
    checkVC.homeStatues = [model.applyStatus integerValue];
    checkVC.userStateModel = model;
    checkVC.task_status = model.taskStatus;
    checkVC.apply_again_ = model.applyAgain;

    if (model.days) {
        checkVC.days = model.days;
    }
    //急速贷特殊处理，获取到费率，期限后再跳转
    if ([productId isEqualToString:RapidLoan]) {
        __weak typeof (self) weakSelf = self;
        [self fatchRate:^(RateModel *rate) {
            [weakSelf.navigationController pushViewController:checkVC animated:YES];
        }];
    }else{
        [self.navigationController pushViewController:checkVC animated:YES];
    }
}

- (void)presentLogin:(UIViewController *)vc
{
    
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
    [vc presentViewController:nav animated:YES completion:nil];
    
}


@end
