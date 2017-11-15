//
//  HomePageVCModules.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "HomePageVCModules.h"
#import "HomeViewModel.h"
#import "WithdrawalsVCModule.h"
#import "LoanMoneyViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationViewController.h"
#import "ActivityHomePopView.h"
#import "LewPopupViewController.h"
//#import "HomePop.h"
#import "FXDWebViewController.h"
#import "SDCycleScrollView.h"
#import "RepayRecordController.h"
#import "UserDefaulInfo.h"
#import "LoanApplicationForConfirmationVCModules.h"
#import "CycleTextCell.h"
#import "QRCodePopView.h"
#import "UserDataAuthenticationListVCModules.h"
#import "HomeProductList.h"
#import "CheckViewModel.h"
#import "P2PViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "LoginViewModel.h"
#import "HomepageActivityImageDisplayModule.h"
#import "AppDelegate.h"
#import "AuthenticationCenterVCModules.h"
#import "LoanMoneyViewModel.h"
#import "ApplicationStatusModel.h"
#import "UserDataViewModel.h"

@interface HomePageVCModules ()<PopViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,BMKLocationServiceDelegate,HomeDefaultCellDelegate,LoadFailureDelegate>
{
   
    NSString *_advTapToUrl;
    NSString *_shareContent;
    NSString *_advImageUrl;
    NSTimer * _countdownTimer;
    ActivityHomePopView *_popView;

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
@property (nonatomic,strong) HomeChoosePopView * popChooseView;

@end

@implementation HomePageVCModules
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(BarHeightNew - 64, 0, 0, 0);
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    self.navigationItem.title = @"发薪贷";
    _count = 0;
   _dataArray = [NSMutableArray array];
    [self setUpTableview];
    [self setNavQRRightBar];
    [self setNavQRLeftBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UserDefaulInfo getUserInfoData];
    
    if ([FXD_Utility sharedUtility].loginFlage) {
        //获取位置信息
        if ([FXD_Utility sharedUtility].isObtainUserLocation) {
            [self openLocationService];
        }
    }
    [self LoadHomeView];
}

/**
 根据数据加载视图的状况
 */
-(void)LoadHomeView{
    [self getAllTheHomePageData:^(BOOL isSuccess) {
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
    [_popChooseView dismiss];
    _popChooseView = nil;
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
    [FXD_Utility sharedUtility].isObtainUserLocation = NO;
}

#pragma mark  - 视图布局

/**
 我的消息视图
 */
- (void)setNavQRRightBar {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 23, 18)];
    [btn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(homeQRMessage) forControlEvents:UIControlEventTouchUpInside];
//    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(16, -8, 13, 13)];
//    bgView.backgroundColor = [UIColor redColor];
//    bgView.layer.cornerRadius = 6.5;
//    [btn addSubview:bgView];
//
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, 10, 12)];
//    label.text = @"3";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:12];
//    [bgView addSubview:label];
    
    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(homeQRMessage)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 8;
    
    
    self.navigationItem.rightBarButtonItems = @[spaceItem,aBarbi];

}

/**
 微信弹窗视图
 */
-(void)setNavQRLeftBar {
    
    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"icon_qr"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(homeQRCodePopups)];
    self.navigationItem.leftBarButtonItem = aBarbi;
    
}


#pragma mark 首页navigation点击事件

/**
 首页二维码弹窗
 */
- (void)homeQRCodePopups
{
    QRCodePopView *qrPopView = [QRCodePopView defaultQRPopView];
    [qrPopView layoutIfNeeded];
    qrPopView.parentVC = self;
    [self lew_presentPopupView:qrPopView animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
    }];
}

/**
 我的消息点击事件
 */
-(void)homeQRMessage{
    
    MyMessageViewController *myMessageCV = [[MyMessageViewController alloc]init];
    [self.navigationController pushViewController:myMessageCV animated:true];
}
#pragma mark tabView视图
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
//    [header beginRefreshing];
    self.tableView.mj_header = header;
}

#pragma mark 首页加载失败视图
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
    [self LoadHomeView];
}

#pragma mark 下拉刷新
-(void)headerRefreshing{

    __weak HomePageVCModules *weakSelf = self;
    NSLog(@"下拉刷新");
    [self getAllTheHomePageData:^(BOOL isSuccess) {
    }];
    [weakSelf.tableView.mj_header endRefreshing];
    
}



#pragma mark - 首页活动弹窗
//首单活动

/**
 首页活动弹窗

 @param model 数据model
 */
- (void)homeActivitiesPopups:(HomeProductList *)model
{
    if ([model.data.popList.firstObject.isValid isEqualToString:@"1"]) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.isShow = false;
        _popView = [ActivityHomePopView defaultPopupView];
        _popView.closeBtn.hidden = YES;
        _popView.delegate = self;
        [_popView.imageView sd_setImageWithURL:[NSURL URLWithString:model.data.popList.firstObject.image]];
        _advImageUrl = model.data.popList.firstObject.toUrl;
        _advTapToUrl = model.data.popList.firstObject.toUrl;
        _popView.parentVC = self;
        [self lew_presentPopupView:_popView animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
        }];
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(homeActivitiesPopupsClose) userInfo:nil repeats:true];
    }
}
/**
 测评红包活动

 @param model 测评红包数据model
 */
-(void)homeEvaluationRedEnvelopeActivitiesPopups:(HomeProductList *)model{
    
    if ([model.data.jumpBomb isEqualToString:@"1"]) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.isHomeChooseShow = false;
        _popChooseView = [[HomeChoosePopView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
        _popChooseView.displayLabel.text = model.data.redCollarList.collarContent;
        [_popChooseView.cancelButton setTitle:model.data.redCollarList.cancel forState:UIControlStateNormal];
         [_popChooseView.sureButton setTitle:model.data.redCollarList.redCollar forState:UIControlStateNormal];
         [_popChooseView show];
        __weak typeof (self) weakSelf = self;
        _popChooseView.cancelClick = ^{
            [weakSelf.popChooseView dismiss];
            weakSelf.popChooseView = nil;
        };
        _popChooseView.sureClick  = ^{
            [weakSelf.popChooseView dismiss];
            weakSelf.popChooseView = nil;
            weakSelf.tabBarController.selectedIndex = 1;
        };
    }
}

/**
 首页活动图片点击
 */
- (void)homeActivityPictureClick
{
    DLog(@"广告图片点击");
    if ([_advTapToUrl containsString:@".png"] || [_advTapToUrl containsString:@".jpg"]) {
        HomepageActivityImageDisplayModule *firstBorrowVC = [[HomepageActivityImageDisplayModule alloc] init];
        firstBorrowVC.url = _advImageUrl;
        [self.navigationController pushViewController:firstBorrowVC animated:YES];
        [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
    }
    if ([_advTapToUrl hasPrefix:@"http://"] || [_advTapToUrl hasPrefix:@"https://"]) {
        FXDWebViewController *webView = [[FXDWebViewController alloc] init];
        webView.urlStr = _advTapToUrl;
        [self.navigationController pushViewController:webView animated:true];
        [self lew_dismissPopupViewWithanimation:[LewPopupViewAnimationSpring new]];
    }
}

/**
 首页活动弹窗关闭
 */
- (void)homeActivitiesPopupsClose
{
    _count += 1;
    if (_count == 2) {
        _popView.closeBtn.hidden = false;
        [_countdownTimer invalidate];
        _countdownTimer = nil;
        _count = 0;
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
                }else if(UI_IS_IPHONEX){
                    return (_k_h-0.5*_k_w-450);
                }else{
                    return (_k_h-0.5*_k_w-360);
                }
            }
        }else{
            if (UI_IS_IPHONE5) {
                return (_k_h-0.5*_k_w-155);
            }else if(UI_IS_IPHONEX){
                return (_k_h-0.5*_k_w-250);
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
        
        [self thirdPartyDiversionListClick:index];
        
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
                HomepageActivityImageDisplayModule *firstBorrowVC = [[HomepageActivityImageDisplayModule alloc] init];
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

//- (void)repayRecordClick
//{
//    if ([Utility sharedUtility].loginFlage) {
//        RepayRecordController *repayRecord=[[RepayRecordController alloc]initWithNibName:@"RepayRecordController" bundle:nil];
//        [self.navigationController pushViewController:repayRecord animated:YES];
//    }else {
//        [self presentLogin:self];
//    }
//}

#pragma mark - 获取数据

-(void)getAllTheHomePageData:(void(^)(BOOL isSuccess))finish{
    
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
            [self homeActivitiesPopups:_homeProductList];
        }
        if (appDelegate.isHomeChooseShow) {
            [self homeEvaluationRedEnvelopeActivitiesPopups:_homeProductList];
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

/**
 跳转到待提款页面
 */
- (void)goWithdrawalsVCModule
{
    WithdrawalsVCModule *checkVC = [WithdrawalsVCModule new];
    [self.navigationController pushViewController:checkVC animated:YES];
}


/**
 跳转到登录页面

 @param vc 登录的VC
 */
- (void)presentLoginVC:(UIViewController *)vc
{
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
    [vc presentViewController:nav animated:YES completion:nil];
}


/**
 跳转到处理中、我要还款页面

 @param status 进件的状态
 */
-(void)goLoanMoneVC:(ApplicationStatus)status{
    LoanMoneyViewController *loanVc = [LoanMoneyViewController new];
    loanVc.applicationStatus = status;
    [self.navigationController pushViewController:loanVc animated:YES];
}


/**
 跳转到确认申请页面

 @param productId 产品id
 */
-(void)goLoanApplicationForConfirmationVCModules:(NSString *)productId{
    LoanApplicationForConfirmationVCModules *loanFirstVC = [[LoanApplicationForConfirmationVCModules alloc] init];
    loanFirstVC.productId = productId;
    [self.navigationController pushViewController:loanFirstVC animated:true];
}


/**
 跳转到个人认证信息页面
 */
-(void)goUserDataAuthenticationListVCModules{
    UserDataAuthenticationListVCModules *userDataVC = [[UserDataAuthenticationListVCModules alloc]initWithNibName:@"UserDataAuthenticationListVCModules" bundle:nil];
    [self.navigationController pushViewController:userDataVC animated:YES];
}

#pragma mark  首页视图的各种代理
#pragma mark 立即添加高级认证
-(void)addAdvancedCertificationBtnClick{
    //立即添加高级认证
    self.tabBarController.selectedIndex = 1;
}
#pragma mark 提款，还款，中间状态点击
-(void)drawingBtnClick{
    if ([FXD_Utility sharedUtility].loginFlage) {
        [FXD_Utility sharedUtility].userInfo.pruductId = _homeProductList.data.productId;
        [self accordingToTheStateJumpPage];
    } else {
        
        [self presentLoginVC:self];
    }
}

//状态判断
-(void)accordingToTheStateJumpPage{
    
    switch (_homeProductList.data.flag.integerValue) {
        case 5:{
            //提款
            if ([_homeProductList.data.platformType isEqualToString:@"2"]) {
                if ([_homeProductList.data.userStatus isEqualToString:@"11"] || [_homeProductList.data.userStatus isEqualToString:@"12"]) {
                    applicationStatus = ComplianceInLoan;
                    [self intermediateStateAccess:@"4"];
                    return;
                }
                if ([_homeProductList.data.userStatus isEqualToString:@"2"] || [_homeProductList.data.userStatus isEqualToString:@"3"]) {
                    //合规未开户
                    [self goWithdrawalsVCModule];
                    return;
                }
            }
            //发薪贷待提款
            [self goWithdrawalsVCModule];
        }
            break;
        case 6:{
            //放款中
            applicationStatus = InLoan;
            [self intermediateStateAccess:@"1"];
        }
            break;
        case 7:{
            //还款
            if ([_homeProductList.data.platformType isEqualToString:@"2"]) {
                if ([_homeProductList.data.userStatus isEqualToString:@"11"] || [_homeProductList.data.userStatus isEqualToString:@"12"]) {
                    applicationStatus = ComplianceRepayment;
                    [self intermediateStateAccess:@"5"];
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
            //延期失败
            [self goLoanMoneVC:RepaymentNormal];
        }
            break;
        case 8:{
            //还款中
            applicationStatus = Repayment;
            [self intermediateStateAccess:@"2"];
        }
            break;
        case 9:{
            //延期中
            applicationStatus = Staging;
            [self intermediateStateAccess:@"3"];
        }
            break;
        case 11:{
            //合规标处理中
            applicationStatus = ComplianceProcessing;
            [self intermediateStateAccess:@"6"];
        }
            break;
        default:
            break;
    }
}

#pragma mark 点击立即申请

/**
 立即申请

 @param money 申请的额度
 */
-(void)applyImmediatelyBtnClick:(NSString *)money{
    NSLog(@"点击立即申请=%@",money);
    if ([FXD_Utility sharedUtility].loginFlage) {
        [FXD_Utility sharedUtility].userInfo.pruductId = _homeProductList.data.productId;
        [self getTheEvaluationResults];
    } else {
        [self presentLoginVC:self];
    }
}


/**
 第三方导流列表点击

 @param index 点击的index
 */
-(void)thirdPartyDiversionListClick:(NSInteger)index{

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

/**
 点击导流平台的更多
 */
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
    if ([FXD_Utility sharedUtility].loginFlage) {
        [FXD_Utility sharedUtility].userInfo.pruductId = _homeProductList.data.productList[0].productId;
        
        NSString * productId = _homeProductList.data.productList[0].productId;
        if ([productId isEqualToString:SalaryLoan]) {
             [self goLoanApplicationForConfirmationVCModules:productId];
        }else{
            NSString *approvalAmount = [_homeProductList.data.productList[0].amount substringToIndex:_homeProductList.data.productList[0].amount.length-1];
            [self getCapitalListData:productId approvalAmount:approvalAmount];
        }
//        [self goLoanSureVC:_homeProductList.data.productList[0].productId];
    } else {
        [self presentLoginVC:self];
    }
}

#pragma mark 点击产品列表
-(void)productListClick:(NSString *)productId isOverLimit:(NSString *)isOverLimit amount:(NSString *)amount{

    if ([productId isEqualToString:SalaryLoan]||[productId isEqualToString:RapidLoan] || [productId isEqualToString:DeriveRapidLoan]) {
        
        if ([isOverLimit isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"额度已满"];
            return;
        }
        if ([FXD_Utility sharedUtility].loginFlage) {
            [FXD_Utility sharedUtility].userInfo.pruductId = productId;
            if ([productId isEqualToString:SalaryLoan]) {
                [self goLoanApplicationForConfirmationVCModules:productId];
            }else{
                [self getCapitalListData:productId approvalAmount:amount];
            }
//            [self goLoanSureVC:productId];
        } else {
            [self presentLoginVC:self];
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
-(void)intermediateStateAccess:(NSString *)flag{
    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            ApplicationStatusModel *applicationStatusModel = [[ApplicationStatusModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            applicationStatusModel = [[ApplicationStatusModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            [self hgIntermediateStateJumpPlatformType:applicationStatusModel.platformType userStatus:applicationStatusModel.userStatus];
            [self fxdIntermediateStateJumpStatus:applicationStatusModel.status];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [loanMoneyViewModel getApplicationStatus:flag];
}


/**
 合规用户中间状态跳转

 @param platformType 进件平台
 @param userStatus 用户状态
 */
-(void)hgIntermediateStateJumpPlatformType:(NSString *)platformType userStatus:(NSString *)userStatus{
    
    if ([platformType isEqualToString:@"2"]) {
        if ([userStatus isEqualToString:@"11"] || [userStatus isEqualToString:@"12"]) {
            [self goLoanMoneVC:applicationStatus];
            return;
        }
        if ([userStatus isEqualToString:@"2"] || [userStatus isEqualToString:@"3"]) {
            // 未激活未开户 或者失败
            if (applicationStatus == ComplianceRepayment) {
                [self goLoanMoneVC:RepaymentNormal];
            }else if (applicationStatus == ComplianceInLoan) {
                [self goWithdrawalsVCModule];
            }
            return;
        }
        if ([userStatus isEqualToString:@"13"]) {
            [self goLoanMoneVC:applicationStatus];
            return;
        }
    }
}

/**
 发薪贷各种状态跳转

 @param status 用户状态
 @param applicationStatus 枚举
 */
-(void)fxdIntermediateStateJumpStatus:(NSString *)status{
    switch (status.integerValue) {
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
                [self getAllTheHomePageData:^(BOOL isSuccess) {
                }];
                return;
            }
            [self goLoanMoneVC:RepaymentNormal];
        }
            break;
        case 3:
        case 4:{
            //中间状态失败刷新首页
            [self getAllTheHomePageData:^(BOOL isSuccess) {
            }];
        }
            break;
        default:
            break;
    }
}
#pragma mark 得到测评结果
-(void)getTheEvaluationResults{

    UserDataViewModel *userDataMV = [[UserDataViewModel alloc]init];
    [userDataMV setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            UserDataResult * userDataModel = [[UserDataResult alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            switch (userDataModel.rc_status.integerValue) {
                case 10:
                {
                    UserDataEvaluationVCModules *controller = [[UserDataEvaluationVCModules alloc]init];
                    [self.navigationController pushViewController:controller animated:true];
                }
                    break;
                case 00:
                    [self goUserDataAuthenticationListVCModules];
                    break;
                case 20:
                case 30:
                {
                    //中间状态失败刷新首页
                    [self getAllTheHomePageData:^(BOOL isSuccess) {
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

#pragma mark 资金平台列表
-(void)getCapitalListData:(NSString *)productId approvalAmount:(NSString *)approvalAmount{
    
    ApplicationViewModel *applicationMV = [[ApplicationViewModel alloc]init];
    [applicationMV setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        //errCode=0 跳往资金平台选择页面 errCode=4跳往发薪贷原来确认页面
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            NSMutableArray *dataArray = [NSMutableArray array];
            NSArray * array = (NSArray *)baseResultM.data;
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                CapitalListModel * capitalListModel = [[CapitalListModel alloc]initWithDictionary:dic error:nil];
                [dataArray addObject:capitalListModel];
            }
            
            [self goRap:productId dataArray:dataArray];
            
        }else if([baseResultM.errCode isEqualToString:@"4"]){
            
            [self goLoanApplicationForConfirmationVCModules:productId];
        
        }else{
            
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
        
    } WithFaileBlock:^{
        
    }];
    [applicationMV capitalList:productId approvalAmount:approvalAmount];
}

#pragma mark 跳转善林金融申请确认页面
-(void)goRap:(NSString *)productId dataArray:(NSMutableArray *)dataArray{
    OptionalRapidLoanApplicationVCModules *controller = [[OptionalRapidLoanApplicationVCModules alloc]init];
    controller.productId = productId;
    controller.dataArray = dataArray;
    [self.navigationController pushViewController:controller animated:false];
}
@end
