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
#import "HomePopView.h"
#import "LewPopupViewController.h"
//#import "HomePop.h"
#import "FXDWebViewController.h"
#import "SDCycleScrollView.h"
#import "RepayRecordController.h"
#import "UserDefaulInfo.h"
#import "LoanSureFirstViewController.h"
#import "CycleTextCell.h"
#import "PayLoanChooseController.h"
#import "QRPopView.h"
#import "UserDataViewController.h"
#import "HomeProductList.h"
#import "CheckViewModel.h"
#import "P2PViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "LoginViewModel.h"
#import "FirstBorrowViewController.h"
#import "AppDelegate.h"
#import "AuthenticationCenterViewController.h"
#import "LoanMoneyViewModel.h"
#import "ApplicationStatusModel.h"
#import "UserDataViewModel.h"

@interface HomeViewController ()<PopViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,BMKLocationServiceDelegate,HomeDefaultCellDelegate,LoadFailureDelegate>
{
   
    NSString *_advTapToUrl;
    NSString *_shareContent;
    NSString *_advImageUrl;
    NSTimer * _countdownTimer;
    HomePopView *_popView;
    NSInteger _count;
    HomeProductList *_homeProductList;
    SDCycleScrollView *_sdView;
    NSMutableArray *_dataArray;
    BMKLocationService *_locService;
    double _latitude;
    double _longitude;

    ApplicationStatus applicationStatus;
}

@property (nonatomic,strong) LoadFailureView * loadFailView;
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
    [self loadViewStatus];
}

/**
 根据数据加载视图的状况
 */
-(void)loadViewStatus{
    [self getHomeData:^(BOOL isSuccess) {
        if (_loadFailView) {
            [_loadFailView removeFromSuperview];
        }
        self.tableView.hidden = false;
        if (_homeProductList == nil || _homeProductList.data == nil) {
            [self setUploadFailView];
        }
    }];
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
    self.tableView.backgroundColor = rgb(242, 242, 242);
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
-(void)setUploadFailView{
    if (_loadFailView) {
        [_loadFailView removeFromSuperview];
    }
    self.tableView.hidden = true;
    _loadFailView = [[LoadFailureView alloc]initWithFrame:CGRectZero];
    _loadFailView.delegate = self;
    [self.view addSubview:_loadFailView];
    [_loadFailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(void)LoadFailureLoadRefreshButtonClick{
    [self loadViewStatus];
}

-(void)headerRefreshing{

    __weak HomeViewController *weakSelf = self;
    NSLog(@"下拉刷新");
    [self getHomeData:^(BOOL isSuccess) {
    }];
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
//        _popView.backgroundColor = [UIColor redColor];
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
    [homeCell.refuseBgView removeFromSuperview];
    
    
    //1:资料测评前 2:资料测评后 可进件 3:资料测评后:两不可申请（评分不足且高级认证未填完整） 4:资料测评后:两不可申请（其他原因，续贷规则不通过） 5:待提款 6:放款中 7:待还款 8:还款中 10 延期失败
    
    if (_homeProductList == nil) {
        return homeCell;
    }
    homeCell.homeProductData = _homeProductList;
    
    homeCell.tabRefuseCellClosure = ^(NSInteger index){
        
        [self refuseTabClick:index];
        
    };
    
    switch (_homeProductList.data.flag.integerValue) {
           
        case 1:
            [homeCell setupDefaultUI];
            break;
        case 2:
        
            if (indexPath.section == 1) {
            
                [homeCell productListFirst];
                return homeCell;
            }

            [homeCell productListOtherWithIndex:indexPath.section];
            break;
        case 3:

//            [homeCell setupRefuseUI];
            [homeCell refuseTab];

            break;
        case 4:

            [homeCell setupOtherPlatformsUI];
            break;
        case 10:
        case 11:
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mak - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DLog(@"点击");
    if (_homeProductList.data.bannerList && _homeProductList.data.bannerList.count > 0) {
        HomeBannerList *files = _homeProductList.data.bannerList[index];
        if ([files.toUrl.lowercaseString hasPrefix:@"http"] || [files.toUrl.lowercaseString hasPrefix:@"https"]) {
            if ([files.toUrl.lowercaseString hasSuffix:@"sjbuy"]) {
                FirstBorrowViewController *firstBorrowVC = [[FirstBorrowViewController alloc] init];
                firstBorrowVC.url = files.toUrl;
                [self.navigationController pushViewController:firstBorrowVC animated:YES];
            }else{
                FXDWebViewController *webView = [[FXDWebViewController alloc] init];
                webView.urlStr = files.toUrl;
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

-(void)getHomeData:(void(^)(BOOL isSuccess))finish{
    
    __weak typeof (self) weakSelf = self;
    HomeViewModel * homeViewModel = [[HomeViewModel alloc]init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        _homeProductList = [HomeProductList yy_modelWithJSON:returnValue];
        if (![_homeProductList.errCode isEqualToString:@"0"]) {
            [[MBPAlertView sharedMBPTextView]showTextOnly:weakSelf.view message:_homeProductList.friendErrMsg];
            finish(false);
            return;
        }
        finish(true);
        [_dataArray removeAllObjects];
        for (HomeProductList *product in _homeProductList.data.productList) {
            [_dataArray addObject:product];
        }
        
        NSMutableArray *filesArr = [NSMutableArray array];
        for (HomeBannerList *file in _homeProductList.data.bannerList) {
            [filesArr addObject:file.image];
        }
        _sdView.imageURLStringsGroup = filesArr.copy;
        [_tableView reloadData];
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        if (appDelegate.isShow) {
            [self popView:_homeProductList];
        }
    } WithFaileBlock:^{
        finish(false);
    }];
    [homeViewModel homeDataRequest];
}

-(void)getApplyStatus:(void(^)(BOOL isSuccess, UserStateModel *resultModel))finish{
    

    
}
//- (void)fatchRate:(void(^)(RateModel *rate))finish
//{
//    NSDictionary *dic = @{@"priduct_id_":RapidLoan};
//    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) {
//        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
//        if ([rateParse.flag isEqualToString:@"0000"]) {
//            [Utility sharedUtility].rateParse = rateParse;
//            finish(rateParse);
//        } else {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:rateParse.msg];
//        }
//    } failure:^(EnumServerStatus status, id object) {
//        
//    }];
//}

#pragma mark - 页面跳转
- (void)goCheckVC
{
    CheckViewController *checkVC = [CheckViewController new];
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
            //提款
            if ([_homeProductList.data.platformType isEqualToString:@"2"]) {
                if ([_homeProductList.data.userStatus isEqualToString:@"11"] || [_homeProductList.data.userStatus isEqualToString:@"12"]) {
                    applicationStatus = ComplianceInLoan;
                    [self getApplicationStatus:@"4"];
                    return;
                }
                if ([_homeProductList.data.userStatus isEqualToString:@"2"] || [_homeProductList.data.userStatus isEqualToString:@"3"]) {
                    //合规未开户
                    [self goCheckVC];
                    return;
                }
            }
            //发薪贷待提款
            [self goCheckVC];
        }
            break;
        case 6:{
            //放款中
            applicationStatus = InLoan;
            [self getApplicationStatus:@"1"];
        }
            break;
        case 7:{
            //还款
            if ([_homeProductList.data.platformType isEqualToString:@"2"]) {
                if ([_homeProductList.data.userStatus isEqualToString:@"11"] || [_homeProductList.data.userStatus isEqualToString:@"12"]) {
                    applicationStatus = ComplianceRepayment;
                    [self getApplicationStatus:@"5"];
                    return;
                }
                if ([_homeProductList.data.userStatus isEqualToString:@"2"] || [_homeProductList.data.userStatus isEqualToString:@"3"] || [_homeProductList.data.userStatus isEqualToString:@"6"]) {
                    //还款激活成功，和未激活
                    [self goLoanMoneVC:RepaymentNormal];
                    return;
                }
            }
            //发薪贷待还款
            [self goLoanMoneVC:RepaymentNormal];
        }
            break;
        case 10:{
            //延期成功
            [self goLoanMoneVC:RepaymentNormal];
        }
            break;
        case 8:{
            //还款中
            applicationStatus = Repayment;
            [self getApplicationStatus:@"2"];
        }
            break;
        case 9:{
            //延期中
            applicationStatus = Staging;
            [self getApplicationStatus:@"3"];
        }
            break;
        case 11:{
            //延期中
            applicationStatus = ComplianceProcessing;
            [self getApplicationStatus:@"6"];
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
        [self userDataResult];
        
    } else {
        [self presentLogin:self];
    }
}

-(void)refuseTabClick:(NSInteger)index{

    switch (index) {
        case 0:
        case 1:
            self.tabBarController.selectedIndex = 1;
            break;
        
        case 2:
            [self moreBtnClick];
            break;
            
        default:
            break;
    }
}
#pragma mark 点击导流平台的更多
-(void)moreBtnClick{
    
    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_selectPlatform_url];
    [self.navigationController pushViewController:webVC animated:true];
    NSLog(@"点击导流平台的更多");
}

-(void)otherBtnClick{

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

    if ([productId isEqualToString:SalaryLoan]||[productId isEqualToString:RapidLoan] || [productId isEqualToString:DeriveRapidLoan]) {
        
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
    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            ApplicationStatusModel *applicationStatusModel = [[ApplicationStatusModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            applicationStatusModel = [[ApplicationStatusModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            if ([applicationStatusModel.platformType isEqualToString:@"2"]) {
                if ([applicationStatusModel.userStatus isEqualToString:@"11"] || [applicationStatusModel.userStatus isEqualToString:@"12"]) {
                    [self goLoanMoneVC:applicationStatus];
                    return;
                }
                if ([applicationStatusModel.userStatus isEqualToString:@"2"] || [applicationStatusModel.userStatus isEqualToString:@"3"]) {
                    // 未激活未开户 或者失败
                    if (applicationStatus == ComplianceRepayment) {
                        [self goLoanMoneVC:RepaymentNormal];
                    }else if (applicationStatus == ComplianceInLoan) {
                        [self goCheckVC];
                    }
                    return;
                }
                if ([applicationStatusModel.userStatus isEqualToString:@"13"]) {
                    [self goLoanMoneVC:applicationStatus];
                    return;
                }
            }
            switch (applicationStatusModel.status.integerValue) {
                case 1:{
                    if (applicationStatus == ComplianceRepayment) {
                        [self goLoanMoneVC:RepaymentNormal];
                    }else if (applicationStatus == ComplianceInLoan){
                        [self goLoanMoneVC:InLoan];
                    }else{
                        [self goLoanMoneVC:applicationStatus];
                    }
                }
                    break;
                case 2:{
                    if (applicationStatus == Repayment) {
                        //还款成功刷新首页
                        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"还款成功"];
                        [self getHomeData:^(BOOL isSuccess) {
                        }];
                        return;
                    }
                    [self goLoanMoneVC:RepaymentNormal];
                }
                    break;
                case 3:
                case 4:{
                    //中间状态失败刷新首页
                    [self getHomeData:^(BOOL isSuccess) {
                    }];
                }
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

#pragma mark 得到测评结果
-(void)userDataResult{

    UserDataViewModel *userDataMV = [[UserDataViewModel alloc]init];
    [userDataMV setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            UserDataResult * userDataModel = [[UserDataResult alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            switch (userDataModel.rc_status.integerValue) {
                case 10:
                {
                    CheckingViewController *controller = [[CheckingViewController alloc]init];
                    [self.navigationController pushViewController:controller animated:true];
                }
                    break;
                case 00:
                    [self goUserDataVC];
                    break;
                case 20:
                case 30:
                {
                    //中间状态失败刷新首页
                    [self getHomeData:^(BOOL isSuccess) {
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [userDataMV UserDataCertificationResult];
}

@end
