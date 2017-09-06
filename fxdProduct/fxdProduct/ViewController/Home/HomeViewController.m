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
#import "HomePopView.h"
#import "LewPopupViewController.h"
#import "HomePop.h"
#import "FXDWebViewController.h"
#import "SDCycleScrollView.h"
#import "RepayRecordController.h"
#import "UserDefaulInfo.h"
#import "LoanSureSecondViewController.h"
#import "LoanSureFirstViewController.h"
#import "CycleTextCell.h"
#import "PayLoanChooseController.h"
#import "QRPopView.h"
#import "LoanRecordParse.h"
#import "UserDataViewController.h"
#import "RateModel.h"
#import "HomeProductList.h"
#import "CheckViewModel.h"
#import "QryUserStatusModel.h"
#import "GetCaseInfo.h"
#import "P2PViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "LoginViewModel.h"
#import "FirstBorrowViewController.h"
#import "AppDelegate.h"
#import "AuthenticationCenterViewController.h"
#import "LoanMoneyViewModel.h"
#import "ApplicationStatusModel.h"


@interface HomeViewController ()<PopViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,BMKLocationServiceDelegate,HomeDefaultCellDelegate>
{
   
    LoanRecordParse *_loanRecordParse;
    NSString *_advTapToUrl;
    NSString *_shareContent;
    NSString *_advImageUrl;
    NSTimer * _countdownTimer;
    HomePopView *_popView;
    NSInteger _count;
    UserStateModel *_model;
    HomeProductList *_homeProductList;
    SDCycleScrollView *_sdView;
    NSMutableArray *_dataArray;
    QryUserStatusModel *_qryUserStatusModel;
    
    BMKLocationService *_locService;
    double _latitude;
    double _longitude;

}

@end


@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"发薪贷";
    _count = 0;
   _dataArray = [NSMutableArray array];
    [self setUpTableview];
    [self setNavQRRightBar];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UserDefaulInfo getUserInfoData];
    
    if ([Utility sharedUtility].loginFlage) {
        //获取位置信息
        if ([Utility sharedUtility].isObtainUserLocation) {
            [self openLocationService];
        }
    }
    [self getHomeData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
    [super viewWillDisappear:animated];
}

#pragma mark -  定位服务迁移
/**
 开启定位服务
 */
-(void)openLocationService{
    
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
}

#pragma mark - BMKLocaltionServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    DLog(@"didUpdateUserLocation lat %f,long%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _latitude = userLocation.location.coordinate.latitude;
    _longitude = userLocation.location.coordinate.longitude;
    [self uploadUserLocationInfo];
}
/**
 上传用户的位置信息
 */
-(void)uploadUserLocationInfo{
    
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
            //定位功能可用，开始定位
            LoginViewModel * loginViewModel = [[LoginViewModel alloc]init];
            [loginViewModel uploadLocationInfoLongitude:[NSString stringWithFormat:@"%f",_longitude] Latitude:[NSString stringWithFormat:@"%f",_latitude]];
        }
    [_locService stopUserLocationService];
    [Utility sharedUtility].isObtainUserLocation = NO;
}

#pragma mark  - 视图布局
- (void)setNavQRRightBar {
    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"icon_qr"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(qrClick)];
    //initWithTitle:@"消息" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem = aBarbi;
}
- (void)setUpTableview
{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CycleTextCell class]) bundle:nil] forCellReuseIdentifier:@"CycleTextCell"];
    [self.tableView registerClass:[HomeDefaultCell class] forCellReuseIdentifier:@"HomeDefaultCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = rgb(245, 245, 245);
    DLog(@"%lf",_k_w);
    _sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _k_w, 0.5*_k_w) delegate:self placeholderImage:[UIImage imageNamed:@"banner-placeholder"]];
    //375 185
    _sdView.delegate = self;
    _sdView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    
    self.tableView.tableHeaderView = _sdView;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
}

-(void)headerRefreshing{

    __weak HomeViewController *weakSelf = self;
    NSLog(@"下拉刷新");
    [self getHomeData];
    [weakSelf.tableView.mj_header endRefreshing];
    
}

- (void)qrClick
{
    QRPopView *qrPopView = [QRPopView defaultQRPopView];
    [qrPopView layoutIfNeeded];
    qrPopView.parentVC = self;
    [self lew_presentPopupView:qrPopView animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
        
    }];
}

- (void)popView:(HomeProductList *)model
{
    if ([model.data.popList.firstObject.isValid isEqualToString:@"1"]) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.isShow = false;
        _popView = [HomePopView defaultPopupView];
        _popView.closeBtn.hidden = YES;
        _popView.delegate = self;
        [_popView.imageView sd_setImageWithURL:[NSURL URLWithString:model.data.popList.firstObject.image]];
//        _popView.imageView.image = [UIImage imageNamed:@"tanchuang"];
        _advImageUrl = model.data.popList.firstObject.toUrl;
        _advTapToUrl = model.data.popList.firstObject.toUrl;
//        _shareContent = model.result.content_;
        _popView.parentVC = self;
        
        [self lew_presentPopupView:_popView animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
            
        }];
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onClose) userInfo:nil repeats:true];
    }
}

- (void)imageTap
{
    DLog(@"广告图片点击");
//    if ([_advTapToUrl hasPrefix:@"http://"] || [_advTapToUrl hasPrefix:@"https://"]) {
//        FXDWebViewController *webView = [[FXDWebViewController alloc] init];
//        webView.urlStr = _advTapToUrl;
//        webView.shareContent = _shareContent;
//        [self.navigationController pushViewController:webView animated:true];
//        [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
//    }
    
    FirstBorrowViewController *firstBorrowVC = [[FirstBorrowViewController alloc] init];
    firstBorrowVC.url = _advImageUrl;
    [self.navigationController pushViewController:firstBorrowVC animated:YES];
    [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
    
}


- (void)onClose
{
    _count += 1;
    if (_count == 2) {
        _popView.closeBtn.hidden = false;
        [_countdownTimer invalidate];
    }
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSInteger i=0;
    if (_dataArray.count>0) {
        i=_dataArray.count;
    }else{
        i=2;
    }
    if (section < i) {
        return 3.0f;
    }
    return 0.1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if (_dataArray.count>0) {
        return _dataArray.count + 1;
    }
    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        return 30.f;
    }else {
        
        if (_dataArray.count>0) {
            
            if (indexPath.section == 1) {
                if (UI_IS_IPHONE5) {

                    return (180);
                
                }else{

                    return (210);
                }
            }else{
                if (UI_IS_IPHONE5) {

                    return (_k_h-0.5*_k_w-330);
                    
                }else{
                    
                    return (_k_h-0.5*_k_w-360);
                }
              
            }
        }else{
        
            if (UI_IS_IPHONE5) {
                return (_k_h-0.5*_k_w-155);
            }else{
                
                return (_k_h-0.5*_k_w-155);
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

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
            //测试
            if (result.content == nil) {
                continue;
            }
            [titlesArray addObject:result.content];
        }
//        sdCycleScrollview.titlesGroup = [titlesArray copy];
        sdCycleScrollview.titlesGroup = _homeProductList.data.paidList;
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
    
    HomeDefaultCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomeDefaultCell"];
    [homeCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    homeCell.backgroundColor = rgb(245, 245, 245);
    homeCell.selected = NO;
    homeCell.delegate = self;
    [homeCell.defaultBgImage removeFromSuperview];
    [homeCell.productFirstBgImage removeFromSuperview];
    [homeCell.productSecondBgImage removeFromSuperview];
    [homeCell.refuseBgImage removeFromSuperview];
    [homeCell.drawingBgImage removeFromSuperview];
    [homeCell.otherPlatformsBgView removeFromSuperview];
    //1:资料测评前 2:资料测评后 可进件 3:资料测评后:两不可申请（评分不足且高级认证未填完整） 4:资料测评后:两不可申请（其他原因，续贷规则不通过） 5:待提款 6:放款中 7:待还款 8:还款中 0 延期失败
    
    if (_homeProductList == nil) {
        return homeCell;
    }
    homeCell.homeProductData = _homeProductList;
    switch (_homeProductList.data.flag.integerValue) {
           
        case 1:
            [homeCell setupDefaultUI];
            break;
        case 2:
        
            if (indexPath.section == 1) {
            
                [homeCell productListFirst];
                return homeCell;
            }

            [homeCell productListOther];
            break;
        case 3:

            [homeCell setupRefuseUI];
            break;
        case 4:

            [homeCell setupOtherPlatformsUI];
            break;
        case 10:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:

            [homeCell setupDrawingUI];
            break;
        default:
            break;
    }

    return homeCell;

}

/**
 点击view
 */
-(void)clickView:(NSString *)url{
    
    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = url;
    [self.navigationController pushViewController:webVC animated:true];
    
}

/**
 点击更多
 */
-(void)moreClick{
    
    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_selectPlatform_url];
    [self.navigationController pushViewController:webVC animated:true];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}

#pragma mak - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DLog(@"点击");
    
    if (_homeProductList.data.bannerList && _homeProductList.data.bannerList.count > 0) {
        HomeBannerList *files = _homeProductList.data.bannerList[index];
        if ([files.image.lowercaseString hasPrefix:@"http"] || [files.image.lowercaseString hasPrefix:@"https"]) {
            if ([files.image.lowercaseString hasSuffix:@"sjbuy"]) {
                FirstBorrowViewController *firstBorrowVC = [[FirstBorrowViewController alloc] init];
                firstBorrowVC.url = files.image;
                [self.navigationController pushViewController:firstBorrowVC animated:YES];
            }else{
            
                FXDWebViewController *webView = [[FXDWebViewController alloc] init];
                webView.urlStr = files.image;
                [self.navigationController pushViewController:webView animated:true];
            }
        }
    }
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

-(void)getHomeData{
    
    __weak typeof (self) weakSelf = self;
    HomeViewModel * homeViewModel = [[HomeViewModel alloc]init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        _homeProductList = [HomeProductList yy_modelWithJSON:returnValue];
        if (![_homeProductList.errCode isEqualToString:@"0"]) {
            [[MBPAlertView sharedMBPTextView]showTextOnly:weakSelf.view message:_homeProductList.friendErrMsg];
            return;
        }
        [_dataArray removeAllObjects];
        for (HomeProductList *product in _homeProductList.data.productList) {
            [_dataArray addObject:product];
        }
//        if ([_homeProductList.data.productList.type isEqualToString:@"1"]) {
//            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:_homeProductList.data.productList.refuseMsg];
//        }
        
        NSMutableArray *filesArr = [NSMutableArray array];
        for (HomeBannerList *file in _homeProductList.data.bannerList) {
            [filesArr addObject:file.image];
        }
        _sdView.imageURLStringsGroup = filesArr.copy;
        
        [_tableView reloadData];
        
        if (_homeProductList.data.paidList.count>0) {
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            NSArray *indexArray=[NSArray arrayWithObject:indexPath];
            [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        if (appDelegate.isShow) {
            [self popView:_homeProductList];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel homeDataRequest];
}

-(void)getApplyStatus:(void(^)(BOOL isSuccess, UserStateModel *resultModel))finish{
    

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

#pragma mark  fxd用户状态查询，viewmodel
-(void)getUserStatus:(NSString *)applicationId success:(void(^)(QryUserStatusModel *resultModel))finish{
    
    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        QryUserStatusModel *model = [QryUserStatusModel yy_modelWithJSON:returnValue];
        _qryUserStatusModel = model;
        if ([model.flag isEqualToString:@"0000"]) {
            finish(model);
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [complianceViewModel getUserStatus:applicationId];
}

#pragma mark - 页面跳转
- (void)goCheckVC:(UserStateModel *)model
{
    CheckViewController *checkVC = [CheckViewController new];
    checkVC.userStateModel = model;
    checkVC.task_status = model.taskStatus;
    [self.navigationController pushViewController:checkVC animated:YES];
}

- (void)presentLogin:(UIViewController *)vc
{
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
    [vc presentViewController:nav animated:YES completion:nil];
}

-(void)goLoanMoneVC:(ApplicationStatus)status{
    
    LoanMoneyViewController *loanVc = [LoanMoneyViewController new];
    loanVc.applicationStatus = status;
    if ([_homeProductList.data.platformType isEqualToString:@"2"]) {
        loanVc.qryUserStatusModel = _qryUserStatusModel;
    }
    [self.navigationController pushViewController:loanVc animated:YES];
}
-(void)goLoanSureVC:(NSString *)productId{
    LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
    loanFirstVC.productId = productId;
    [self.navigationController pushViewController:loanFirstVC animated:true];
}
-(void)goUserDataVC{
    
    UserDataViewController *userDataVC = [[UserDataViewController alloc]initWithNibName:@"UserDataViewController" bundle:nil];
    [self.navigationController pushViewController:userDataVC animated:YES];
    
}

#pragma mark  首页视图的各种代理
#pragma mark 立即添加高级认证
-(void)advancedCertification{
    //立即添加高级认证
    self.tabBarController.selectedIndex = 1;
}
#pragma mark 提款，还款，中间状态点击
-(void)drawingBtnClick{
    if ([Utility sharedUtility].loginFlage) {
        [Utility sharedUtility].userInfo.pruductId = _homeProductList.data.productId;
        [self PostStatuesMyLoanAmount];
    } else {
        [self presentLogin:self];
    }
}
//状态判断
-(void)PostStatuesMyLoanAmount{
    
    switch (_homeProductList.data.flag.integerValue) {
        case 5:{
            [self goCheckVC:nil];
        }
            break;
        case 6:{
            [self goLoanMoneVC:InLoan];
        }
            break;
        case 7:
        case 10:{
            [self goLoanMoneVC:RepaymentNormal];
        }
            break;
        case 8:{
            if ([_homeProductList.data.platformType isEqualToString:@"2"]) {
                __weak typeof (self) weakSelf = self;
                [self getUserStatus:_homeProductList.data.applicationId success:^(QryUserStatusModel *resultModel) {
                    if ([_qryUserStatusModel.result.flg isEqualToString:@"11"] || [_qryUserStatusModel.result.flg isEqualToString:@"12"]) {
                        [weakSelf goLoanMoneVC:ComplianceInProcess];
                    }else{
                        [self goLoanMoneVC:RepaymentNormal];
                    }
                }];
                return;
            }
            [self goLoanMoneVC:Repayment];
        }
            break;
            
        case 9:{
            
           [self goLoanMoneVC:Staging];
        }
            break;
        
        default:
            break;
    }
}

#pragma mark 点击立即申请
-(void)applyBtnClick:(NSString *)money{
    NSLog(@"点击立即申请=%@",money);
    if ([Utility sharedUtility].loginFlage) {
        [Utility sharedUtility].userInfo.pruductId = _homeProductList.data.productId;
        [self goUserDataVC];
    } else {
        [self presentLogin:self];
    }
}

#pragma mark 点击导流平台的更多
-(void)moreBtnClick{
    
    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_selectPlatform_url];
    [self.navigationController pushViewController:webVC animated:true];
    NSLog(@"点击导流平台的更多");
}
#pragma mark 我要借款
-(void)loanBtnClick{
    NSLog(@"我要借款");
    if ([_homeProductList.data.productList[0].isOverLimit isEqualToString:@"1"]) {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"额度已满"];
        return;
    }
    if ([Utility sharedUtility].loginFlage) {
        [Utility sharedUtility].userInfo.pruductId = _homeProductList.data.productList[0].productId;
        [self goLoanSureVC:_homeProductList.data.productList[0].productId];
    } else {
        [self presentLogin:self];
    }
}

#pragma mark 点击产品列表
-(void)productBtnClick:(NSString *)productId isOverLimit:(NSString *)isOverLimit{

    if ([productId isEqualToString:SalaryLoan]||[productId isEqualToString:RapidLoan]) {
        
        if ([isOverLimit isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"额度已满"];
            return;
        }
        if ([Utility sharedUtility].loginFlage) {
            [Utility sharedUtility].userInfo.pruductId = productId;
            [self goLoanSureVC:productId];
        } else {
            [self presentLogin:self];
        }
        return;
    }
    //导流产品
    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = productId;
    [self.navigationController pushViewController:webVC animated:true];
    NSLog(@"产品productId = %@",productId);
}

#pragma mark -> 2.22	放款中 还款中 展期中 状态实时获取
-(void)getApplicationStatus:(NSString *)flag{
    
    __weak typeof (self) weakSelf = self;
    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            ApplicationStatusModel *applicationStatusModel = [[ApplicationStatusModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            applicationStatusModel = [[ApplicationStatusModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            
            
            switch (applicationStatusModel.status.integerValue) {
                case 1:
//                    [weakSelf updateUI:applicationStatusModel repayModel:nil];
                    break;
                case 2:
                case 3:
                case 4:
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    break;
                default:
                    break;
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [loanMoneyViewModel getApplicationStatus:flag];
}


@end
