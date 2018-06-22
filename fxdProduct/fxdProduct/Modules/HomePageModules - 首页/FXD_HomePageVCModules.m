//
//  FXD_HomePageVCModules.m
//  fxdProduct
//
//  Created by sxp on 2017/12/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_HomePageVCModules.h"
#import "HomeViewModel.h"
#import "LoginViewController.h"
#import "BaseNavigationViewController.h"
#import "ActivityHomePopView.h"
#import "LewPopupViewController.h"
#import "FXDWebViewController.h"
#import "SDCycleScrollView.h"
#import "RepayRecordController.h" 
#import "QRCodePopView.h"
#import "UserDataAuthenticationListVCModules.h"
#import "CheckViewModel.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "LoginViewModel.h"
#import "HomepageActivityImageDisplayModule.h"
#import "AppDelegate.h"
#import "UserDataViewModel.h"
#import "MessageViewModel.h"
#import "AountStationLetterMsgModel.h"
#import "MyViewController.h"
#import "FXDBaseTabBarVCModule.h"
#import "UITabBar+badge.h"
#import "NextViewCell.h"
#import "FXD_HomeProductListModel.h"
#import "LoanPeriodListVCModule.h"
#import "CommonViewModel.h"
#import "ComplianceViewModel.h"
#import "HgLoanProtoolListModel.h"
#import "QBBWitnDrawModel.h"

@interface FXD_HomePageVCModules ()<PopViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,BMKLocationServiceDelegate,LoadFailureDelegate,HomePageCellDelegate,SDCycleScrollCellDelegate,RecentCellDelegate>
{
    NSString *_advTapToUrl;
    NSString *_shareContent;
    NSString *_advImageUrl;
    NSTimer * _countdownTimer;
    ActivityHomePopView *_popView;
    
    NSInteger _count;
    FXD_HomeProductListModel *_homeProductList;
    NSMutableArray *_protocolArray ;
    SDCycleScrollView *_sdView;
    NSMutableArray *_dataArray;
    BMKLocationService *_locService;
    double _latitude;
    double _longitude;
    
    ApplicationStatus applicationStatus;
}
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) LoadFailureView * loadFailView;
@property (nonatomic,strong) HomeChoosePopView * popChooseView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *messageNumLabel;
@property (nonatomic,strong) UIButton *messageBtn;

@end

@implementation FXD_HomePageVCModules

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(BarHeightNew - 64, 0, 0, 0);
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    self.navigationItem.title = @"憨分";
    _count = 0;
    _dataArray = [NSMutableArray array];
    _protocolArray = [NSMutableArray array];
    [self setNavQRRightBar];
//    [self setNavQRLeftBar];
    [self createTab];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*
    if ([FXD_Utility sharedUtility].loginFlage) {
        //获取位置信息
        if ([FXD_Utility sharedUtility].isObtainUserLocation) {
            [self openLocationService];
        }
    }
     */
    
    _bgView.hidden = true;
    _messageNumLabel.text = @"";
    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
    [self LoadHomeView];
    
}

-(void)createTab{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64-49) style:UITableViewStylePlain];
    [self.tableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"HomePageCell"];
    [self.tableView registerClass:[SDCycleScrollCell class] forCellReuseIdentifier:@"SDCycleScrollCell"];
    [self.tableView registerClass:[RecentCell class] forCellReuseIdentifier:@"RecentCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = true;
    self.tableView.backgroundColor = rgb(250, 250, 250);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    DLog(@"%lf",_k_w);
    _sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _k_w, _k_w*0.44) delegate:self placeholderImage:[UIImage imageNamed:@"banner-placeholder"]];
    //375 185
    _sdView.delegate = self;
    _sdView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _sdView.currentPageDotColor = UI_MAIN_COLOR;
    _sdView.pageDotColor = RGBColor(214, 213, 213, 1.0);
    
    self.tableView.tableHeaderView = _sdView;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    //    [header beginRefreshing];
    self.tableView.mj_header = header;
}

/**
 我的消息视图
 */
- (void)setNavQRRightBar {
    
    _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 23, 18)];
    [_messageBtn setImage:[UIImage imageNamed:@"homeMessage"] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(homeQRMessage) forControlEvents:UIControlEventTouchUpInside];
    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor redColor];
    _bgView.layer.cornerRadius = 6.5;
    _bgView.hidden = true;
    [_messageBtn addSubview:_bgView];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_messageBtn.mas_left).offset(13);
        make.top.equalTo(_messageBtn.mas_top).offset(-4);
        make.width.equalTo(@13);
        make.height.equalTo(@13);
    }];
    
    _messageNumLabel = [[UILabel alloc]init];
    _messageNumLabel.textAlignment = NSTextAlignmentCenter;
    _messageNumLabel.textColor = [UIColor whiteColor];
    _messageNumLabel.font = [UIFont systemFontOfSize:12];
    [_bgView addSubview:_messageNumLabel];
    [_messageNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).offset(0);
        make.top.equalTo(_bgView.mas_top).offset(0);
        make.right.equalTo(_bgView.mas_right).offset(0);
        make.height.equalTo(@13);
    }];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn addTarget:self action:@selector(homeQRMessage) forControlEvents:UIControlEventTouchUpInside];
    [_messageBtn addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_messageBtn.mas_left).offset(-10);
        make.top.equalTo(_messageBtn.mas_top).offset(-4);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithCustomView:_messageBtn];
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
/**
 站内信用户未读信息统计接口
 */

-(void)getMessageNumber{
    
    MessageViewModel *messageVM = [[MessageViewModel alloc]init];
    [messageVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            AountStationLetterMsgModel *model = [[AountStationLetterMsgModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            
            if ([model.isDisplay isEqualToString:@"1"]) {
                _bgView.hidden = false;
                _messageNumLabel.text = model.countNum;
                
                if (model.countNum.integerValue > 9) {
                    
                    [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(_messageBtn.mas_left).offset(6);
                        make.width.equalTo(@24);
                    }];
                    
                }else{
                    
                    [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(_messageBtn.mas_left).offset(11);
                        make.width.equalTo(@13);
                    }];
                    
                }
                if (model.countNum.integerValue > 99) {
                    _messageNumLabel.text = @"99+";
                }
                [self.tabBarController.tabBar showBadgeOnItemIndex:2];
            }else{
                _bgView.hidden = true;
                [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [messageVM countStationLetterMsg];
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
    
    if ([FXD_Utility sharedUtility].loginFlage) {
        MyMessageViewController *myMessageCV = [[MyMessageViewController alloc]init];
        [self.navigationController pushViewController:myMessageCV animated:true];
    } else {
        [self presentLoginVC:self];
    }
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

/**
 根据数据加载视图的状况
 */
-(void)LoadHomeView{
    
    if ([FXD_Utility sharedUtility].loginFlage){
        
        [self getMessageNumber];
    }
    [self getAllTheHomePageData:^(BOOL isSuccess) {
        if (_loadFailView) {
            [_loadFailView removeFromSuperview];
        }
        
        if (isSuccess) {
            
            [self getHgLoanProtoolList];
        }
        
        self.tableView.hidden = false;
        if (_homeProductList == nil ) {
            [self setUploadFailView];
        }
    }];
}

//根据申请件id返回投资人列表
-(void)getHgLoanProtoolList{

    ComplianceViewModel *complianceVM = [[ComplianceViewModel alloc]init];
    [complianceVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            [_protocolArray removeAllObjects];
            NSArray * arr = (NSArray *)baseResultM.data;
            for (int i = 0; i<arr.count; i++) {
                 HgLoanProtoolListModel *model = [[HgLoanProtoolListModel alloc]initWithDictionary:arr[i] error:nil];
                [_protocolArray addObject:model];
            }
            [self.tableView reloadData];
        }else{
           
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [complianceVM hgLoanProtoolListApplicationId:_homeProductList.applicationId];
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
    
    __weak FXD_HomePageVCModules *weakSelf = self;
    NSLog(@"下拉刷新");
    [self getAllTheHomePageData:^(BOOL isSuccess) {
    }];
    [weakSelf.tableView.mj_header endRefreshing];
    
}


#pragma mark - 获取数据

-(void)getAllTheHomePageData:(void(^)(BOOL isSuccess))finish{
    
    __weak typeof (self) weakSelf = self;
    HomeViewModel * homeViewModel = [[HomeViewModel alloc]init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        
        _homeProductList = [[FXD_HomeProductListModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
        if (![baseResultM.errCode isEqualToString:@"0"]) {
            
            [[MBPAlertView sharedMBPTextView]showTextOnly:weakSelf.view message:baseResultM.friendErrMsg];
            finish(false);
            return ;
        }
        
        finish(true);
        
        NSMutableArray *filesArr = [NSMutableArray array];
        NSArray * array = (NSArray *)_homeProductList.bannerList;
        
        for (NSDictionary * dic  in array) {
            
            BannerListModel *file = (BannerListModel *)dic;
            [filesArr addObject:file.image];
        }

        _sdView.imageURLStringsGroup = filesArr.copy;
        [_tableView reloadData];
        
        if ([FXD_Utility sharedUtility].isActivityShow) {
            [self homeActivitiesPopups:_homeProductList.popList.firstObject];
        }
        if ([FXD_Utility sharedUtility].isHomeChooseShow) {
            [self homeEvaluationRedEnvelopeActivitiesPopups:_homeProductList];
        }
        
        [FXD_Utility sharedUtility].userInfo.applicationId = _homeProductList.applicationId;
        
    } WithFaileBlock:^{
        finish(false);
    }];
    [homeViewModel homeDataRequest];
}

#pragma mark - 首页活动弹窗
//首单活动

/**
 首页活动弹窗
 
 @param model 数据model
 */
- (void)homeActivitiesPopups:(PopListModel *)model
{
    if ([model.isValid isEqualToString:@"1"]) {
        _advImageUrl = model.toUrl;
        _advTapToUrl = model.toUrl;
        [FXD_Utility sharedUtility].isActivityShow = false;
        __weak typeof (self) weakSelf = self;
        [[FXD_AlertViewCust sharedHHAlertView] homeActivityPopLoadImageUrl:model.image ParentVC:self compleBlock:^(NSInteger index) {
            if (index == 1) {
                [weakSelf homeActivityPictureClick];
            }
        }];

    }
}

/**
 测评红包活动
 
 @param model 测评红包数据model
 */
-(void)homeEvaluationRedEnvelopeActivitiesPopups:(FXD_HomeProductListModel *)model{
    
    if ([model.jumpBomb isEqualToString:@"1"]) {
       
        [FXD_Utility sharedUtility].isHomeChooseShow = false;
        _popChooseView = [[HomeChoosePopView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
        _popChooseView.displayLabel.text = _homeProductList.redCollarList.collarContent;
        [_popChooseView.cancelButton setTitle:_homeProductList.redCollarList.cancel forState:UIControlStateNormal];
        [_popChooseView.sureButton setTitle:_homeProductList.redCollarList.redCollar forState:UIControlStateNormal];
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
    }
    if ([_advTapToUrl hasPrefix:@"http://"] || [_advTapToUrl hasPrefix:@"https://"]) {
        FXDWebViewController *webView = [[FXDWebViewController alloc] init];
        webView.urlStr = _advTapToUrl;
        [self.navigationController pushViewController:webView animated:true];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if (_homeProductList == nil) {
        return 0;
    }
    
    switch (_homeProductList.flag.integerValue) {
        case 3:
        case 4:
            return 2;
            break;
            
        default:
            return 3;
            break;
    }
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.section) {
        case 0:
            return 30;
            break;
        case 1:
            switch (_homeProductList.flag.integerValue) {
                
                case 9:
                case 10:
                case 13:
                case 14:
                case 15:
                    return _k_h-_k_w*0.44-113-113;
                    break;
                case 1:
                case 2:
                case 7:
                case 6:
                case 8:
                case 12:
                    return 130;
                    break;
                default:
                {
                    long height = 0;
                    long count = _homeProductList.hotRecommend.count / 4;
                    if (_homeProductList.hotRecommend.count % 4 == 0)  {
                        height = count * 103;
                    }else{
                        height = (count + 1) * 103;
                    }
                    return height+30;
                }
//                    return 85*_homeProductList.hotRecommend.count+30;
                    
                    break;
            }
            break;
        case 2:
            
        {
            long height = 0;
            long count = _homeProductList.hotRecommend.count / 4;
            if (_homeProductList.hotRecommend.count % 4 == 0)  {
                height = count * 103;
            }else{
                height = (count + 1) * 103;
            }
            return height+30;
        }
//            return 85*_homeProductList.hotRecommend.count+30;
            break;
        default:
            break;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 5.0f;
    }
    return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            SDCycleScrollCell *sdcycleScrollCell = [tableView dequeueReusableCellWithIdentifier:@"SDCycleScrollCell"];
            sdcycleScrollCell.selected = NO;
            sdcycleScrollCell.selectionStyle = UITableViewCellSelectionStyleNone;
            sdcycleScrollCell.sdCycleScrollview.delegate = self;
            sdcycleScrollCell.backgroundColor = rgb(242, 242, 242);
//            sdcycleScrollCell.delegate = self;
            
//            [sdcycleScrollCell.loanBtn setTitle:@"" forState:UIControlStateNormal];
//            [sdcycleScrollCell.loanBtnImage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//            [sdcycleScrollCell.gameBtn setTitle:@"" forState:UIControlStateNormal];
//            [sdcycleScrollCell.gameBtnImage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//            [sdcycleScrollCell.tourismBtn setTitle:@"" forState:UIControlStateNormal];
//            [sdcycleScrollCell.tourismBtnImage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//
//            for (int i = 0; i<_homeProductList.platType.count; i++) {
//                PlatTypeModel *model = _homeProductList.platType[i];
//                switch (model.code_.integerValue) {
//                    case 1:
//                        [sdcycleScrollCell.loanBtn setTitle:model.desc_ forState:UIControlStateNormal];
//                        [sdcycleScrollCell.loanBtnImage setImage:[UIImage imageNamed:@"loan_icon"] forState:UIControlStateNormal];
//                        break;
//                    case 2:
//                        [sdcycleScrollCell.gameBtn setTitle:model.desc_ forState:UIControlStateNormal];
//                        [sdcycleScrollCell.gameBtnImage setImage:[UIImage imageNamed:@"game_icon"] forState:UIControlStateNormal];
//                        break;
//                    case 3:
//                        [sdcycleScrollCell.tourismBtn setTitle:model.desc_ forState:UIControlStateNormal];
//                        [sdcycleScrollCell.tourismBtnImage setImage:[UIImage imageNamed:@"tourism_icon"] forState:UIControlStateNormal];
//                        break;
//                    default:
//                        break;
//                }
//            }
            
            
            sdcycleScrollCell.sdCycleScrollview.titlesGroup = _homeProductList.paidList;
            return sdcycleScrollCell;
        }
            break;
        case 1:
            switch (_homeProductList.flag.integerValue) {
                case 7:
                case 8:
                case 9:
                case 10:
                case 13:
                case 14:
                case 15:
                case 1:
                case 2:
                case 12:
                case 6:
    
                {
                    HomePageCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell"];
                    [homeCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    homeCell.backgroundColor = [UIColor whiteColor];
                    homeCell.selected = NO;
                    homeCell.delegate = self;
                    homeCell.homeProductListModel = _homeProductList;
                    if (_homeProductList != nil) {
                        
                        homeCell.type = _homeProductList.flag;
                        homeCell.protocolArray = _protocolArray;
                        NSString *descStr = @"";
                        switch (_homeProductList.flag.integerValue) {
                            case 1:
                                descStr = @"最高额度";
                                break;
                            case 2:
                                descStr = @"可用额度";
                                break;
                            case 7:
                                descStr = @"待还金额";
                                break;
                            default:
                                break;
                        }
                        homeCell.titleLabel.text = [NSString stringWithFormat:@"%@%@",descStr,_homeProductList.amount];
                        [homeCell.quotaBtn setTitle:_homeProductList.buttonText forState:UIControlStateNormal];
                        if (![homeCell.titleLabel.text isEqualToString:@""] && ([_homeProductList.flag isEqualToString:@"1"] ||[_homeProductList.flag isEqualToString:@"2"] || [_homeProductList.flag isEqualToString:@"7"])) {
                            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:homeCell.titleLabel.text];
                            [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,4)];
                            [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0,4)];
                            homeCell.titleLabel.attributedText = attriStr;
                        }
                    }
                    
                    return homeCell;
                }
                    break;
                    
                default:
                {
                    RecentCell *recentCell = [tableView dequeueReusableCellWithIdentifier:@"RecentCell"];
                    [recentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    recentCell.backgroundColor = [UIColor whiteColor];
                    recentCell.homeProductListModel = _homeProductList;
                    recentCell.delegate = self;
                    [recentCell.tableView reloadData];
                    [recentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    return recentCell;
                }
                
                    break;
            }
            break;
        case 2:
        {
            RecentCell *recentCell = [tableView dequeueReusableCellWithIdentifier:@"RecentCell"];
            [recentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            recentCell.backgroundColor = [UIColor whiteColor];
            recentCell.homeProductListModel = _homeProductList;
            recentCell.delegate = self;
            [recentCell.collectionView reloadData];
            [recentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return recentCell;
        }
            break;
        default:
            break;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mak - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DLog(@"点击");
    
    NSArray * array = (NSArray *)_homeProductList.bannerList;
    BannerListModel *model = (BannerListModel *)array[index];
    if (model) {
        if ([model.toUrl.lowercaseString hasPrefix:@"http"] || [model.toUrl.lowercaseString hasPrefix:@"https"]) {
            if ([model.toUrl.lowercaseString hasSuffix:@"sjbuy"]) {
                HomepageActivityImageDisplayModule *firstBorrowVC = [[HomepageActivityImageDisplayModule alloc] init];
                firstBorrowVC.url = model.toUrl;
                [self.navigationController pushViewController:firstBorrowVC animated:YES];
            }else{
                FXDWebViewController *webView = [[FXDWebViewController alloc] init];
                webView.urlStr = model.toUrl;
                [self.navigationController pushViewController:webView animated:true];
            }
        }
    }
}


#pragma mark -  HomePageCellDelegate


/**
 帮助中心
 */
-(void)helpBtnClick{

    FXDWebViewController *webView = [[FXDWebViewController alloc] init];
    webView.urlStr = _homeProductList.qaUrl;
    [self.navigationController pushViewController:webView animated:true];
}

/**
 量子互助
 */

-(void)daoliuBtnClick{

    FXDWebViewController *webView = [[FXDWebViewController alloc] init];
    webView.urlStr = _liangzihuzhu_url;
    [self.navigationController pushViewController:webView animated:true];
    
}


/**
 提款
 */
-(void)withdrawMoneyImmediatelyBtnClick{
    
    if ([_homeProductList.platfromType isEqualToString:@"0"]) {
        if ([_homeProductList.flag isEqualToString:@"15"]) {
            LoanPeriodListVCModule *controller = [[LoanPeriodListVCModule alloc]initWithNibName:@"LoanPeriodListVCModule" bundle:nil];
            controller.applicationId = _homeProductList.applicationId;
            [self.navigationController pushViewController:controller animated:true];
        }else{
            FXD_ToWithdrawFundsViewController * loanApplicationVC = [[FXD_ToWithdrawFundsViewController alloc]init];
            [self.navigationController pushViewController:loanApplicationVC animated:true];
        }
    }else if ([_homeProductList.platfromType isEqualToString:@"2"]){
        [self jumpControllerUserStatus:_homeProductList.userStatus];
    }else if ([_homeProductList.platfromType isEqualToString:@"5"]){
        
        switch (_homeProductList.userStatus.integerValue) {
            case 1:
                
                [[HG_Manager sharedHGManager]hgUserRegJumpP2pCtrlBankNo:@"" bankReservePhone:@"" bankShortName:@"" cardId:@"" cardNo:@"" retUrl:@"" smsSeq:@"" userCode:@"" verifyCode:@"" capitalPlatform:@"5" vc:self];
                break;
            case 3:
            {
                if ([_homeProductList.flag isEqualToString:@"15"]) {
                    LoanPeriodListVCModule *controller = [[LoanPeriodListVCModule alloc]initWithNibName:@"LoanPeriodListVCModule" bundle:nil];
                    controller.applicationId = _homeProductList.applicationId;
                    [self.navigationController pushViewController:controller animated:true];
                }else{
                    FXD_ToWithdrawFundsViewController * loanApplicationVC = [[FXD_ToWithdrawFundsViewController alloc]init];
                    [self.navigationController pushViewController:loanApplicationVC animated:true];
                }
            }
                break;
                
            default:
                break;
        }
    }
}

//根据合规状态跳转页面
-(void)jumpControllerUserStatus:(NSString *)userStatus{
    
    switch (userStatus.integerValue) {
        case 1:
        {
            OpenAccountViewController * controller = [[OpenAccountViewController alloc]init];
            [self.navigationController pushViewController:controller animated:true];
        }
            
            break;
        case 2:
        {
            IntermediateViewController * controller = [[IntermediateViewController alloc]init];
            [self.navigationController pushViewController:controller animated:true];
        }
            
            break;
        case 3:
        {
            if ([_homeProductList.flag isEqualToString:@"15"]) {
                LoanPeriodListVCModule *controller = [[LoanPeriodListVCModule alloc]initWithNibName:@"LoanPeriodListVCModule" bundle:nil];
                controller.applicationId = _homeProductList.applicationId;
                [self.navigationController pushViewController:controller animated:true];
            }else{
                FXD_ToWithdrawFundsViewController * loanApplicationVC = [[FXD_ToWithdrawFundsViewController alloc]init];
                [self.navigationController pushViewController:loanApplicationVC animated:true];
            }
        }
            break;
        case 4:
        {
            [[HG_Manager sharedHGManager]hgUserActiveJumpP2pCtrlCapitalPlatform:@"2" retUrl:_transition_url vc:self];
            
        }
            break;
        
        default:
            break;
    }
}
/**
 我要借款
 */
-(void)loanBtnClick{
    
    //isComplete  基础资料是否完整
    if ([_homeProductList.drawInfo.isComplete isEqualToString:@"1"]) {

        FXD_LoanApplicationViewController * loanApplicationVC = [[FXD_LoanApplicationViewController alloc]init];
        loanApplicationVC.productId = _homeProductList.productId;
        [self.navigationController pushViewController:loanApplicationVC animated:true];
    }else{

        NSMutableString *content = [[NSMutableString alloc]initWithCapacity:100] ;
        for (int i = 0; i<_homeProductList.drawInfo.tipsContent.count; i++) {
            [content appendString:_homeProductList.drawInfo.tipsContent[i]];
            if (i != _homeProductList.drawInfo.tipsContent.count-1) {
                [content appendString:@"\n"];
            }
        }
        [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:_homeProductList.drawInfo.tipsTitle content:content attributeDic:nil TextAlignment:NSTextAlignmentLeft cancelTitle:@"取消" sureTitle:@"前去更新" compleBlock:^(NSInteger index) {
            if (index == 1) {
                UserDataAuthenticationListVCModules *controller = [[UserDataAuthenticationListVCModules alloc]init];
                [self.navigationController pushViewController:controller animated:true];
            }
        }];
    }
}


/**
 第三方借款

 @param productId 产品id
 @param isOverLimit
 @param amount 产品额度
 @param Path 第三方产品path
 */
-(void)productListClick:(NSString *)productId isOverLimit:(NSString *)isOverLimit amount:(NSString *)amount Path:(NSString *)Path{
    
    FXDWebViewController *webView = [[FXDWebViewController alloc]init];
    webView.urlStr = Path;
    [self.navigationController pushViewController:webView animated:true];
}


/**
 更多按钮
 */
-(void)moreBtnClick{
    self.tabBarController.selectedIndex = 1;
//    [self pushMoreProductPlatform];
}

-(void)pushMoreProductPlatform{
    HomeViewModel * homeVM = [[HomeViewModel alloc]init];
    [homeVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseVM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseVM.errCode isEqualToString:@"0"]) {
            NSDictionary *  dic = (NSDictionary *)baseVM.data;
            if ([dic.allKeys containsObject:@"url"]) {
                FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
                webVC.urlStr = dic[@"url"];
                [self.navigationController pushViewController:webVC animated:true];
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseVM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [homeVM statisticsDiversionPro:nil];
}



/**
 帮助图标按钮
 */
-(void)questionDescBtnClick{
   
    [self OverdueInfoPopView];
}


/**
 立即还款

 @param isSelected 协议勾选框
 */
-(void)repayImmediatelyBtnClick:(BOOL)isSelected{
    if (!isSelected) {
        
        LoanPeriodListVCModule *controller = [[LoanPeriodListVCModule alloc]initWithNibName:@"LoanPeriodListVCModule" bundle:nil];
        controller.applicationId = _homeProductList.applicationId;
        [self.navigationController pushViewController:controller animated:true];
    
    }else{
        
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"请勾选协议"];
      
    }
}


/**
 立即借款

 @param money 借款额度
 @param time 借款周期时间
 */
-(void)applyImmediatelyBtnClick:(NSString *)money :(NSString *)time{
    
    if ([FXD_Utility sharedUtility].loginFlage) {
            UserDataAuthenticationListVCModules *controller = [[UserDataAuthenticationListVCModules alloc]initWithNibName:@"UserDataAuthenticationListVCModules" bundle:nil];
            [self.navigationController pushViewController:controller animated:true];
    } else {
        [self presentLoginVC:self];
    }
}

#pragma mark -  逾期弹窗
-(void)OverdueInfoPopView{
    
    FeeTextModel *firstModel = _homeProductList.overdueInfo.feeText[0];
    FeeTextModel *secondModel = _homeProductList.overdueInfo.feeText[1];
    
    NSMutableString *content;
    for (int i = 0; i<_homeProductList.overdueInfo.ruleText.count; i++) {
        
        [content appendString:_homeProductList.overdueInfo.ruleText[i]];
        if (i != _homeProductList.overdueInfo.ruleText.count-1) {
            [content appendString:@"\n"];
        }
    }
    [[FXD_AlertViewCust sharedHHAlertView] showFXDOverdueViewAlertViewTitle:_homeProductList.overdueInfo.ruleTitle TwoTitle:_homeProductList.overdueInfo.currentFeeTitle content:content deditAmount:firstModel.value deditTitle:[NSString stringWithFormat:@"%@:",firstModel.label]  defaultInterestLabel:secondModel.value defaultInterestTitle:[NSString stringWithFormat:@"%@:",secondModel.label] sureTitle:@"我知道了" compleBlock:^(NSInteger index) {
        
    }];
}

#pragma mark -  还款协议点击事件
//还款协议点击事件
-(void)protocolNameClick:(NSInteger)index protocoalName:(NSString *)protocoalName{
    
    NSLog(@"%ld",index);
    
    HgLoanProtoolListModel *model = _protocolArray[0];
    NSString *inverBorrowId = @"";
    NSString *typeCode = @"";
    if ([protocoalName containsString:@"借款协议"]) {
        inverBorrowId = model.inverBorrowId;
        typeCode = @"2";
    }else if([protocoalName containsString:@"转账授权书"]){
        typeCode = @"1";
    }
    NSString *periods = _homeProductList.periods;
    if ([_homeProductList.productId isEqualToString:EliteLoan]) {
        periods = @"";
    }
    
    [self getProtocolContentProtocolType:_homeProductList.productId typeCode:typeCode applicationId:_homeProductList.applicationId periods:periods];

}

-(void)getProtocolContentProtocolType:(NSString *)productId typeCode:(NSString *)typeCode applicationId:(NSString *)applicationId periods:(NSString *)periods{

    CommonViewModel *commonVM = [[CommonViewModel alloc]init];
    [commonVM setBlockWithReturnBlock:^(id returnValue) {

        BaseResultModel *  baseResultM = returnValue;
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            NSDictionary * dic = (NSDictionary *)baseResultM.data;
            FXDWebViewController * fxdwebVC = [[FXDWebViewController alloc]init];
            fxdwebVC.urlStr =  [dic objectForKey:@"productProURL"];
            [self.navigationController pushViewController:fxdwebVC animated:YES];
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [commonVM obtainProductProtocolType:productId typeCode:typeCode apply_id:applicationId periods:periods stagingType:_homeProductList.stagingType];
}

//-(void)protocolListClick:(UIButton *)sender{
//
//    HgLoanProtoolListModel *model = _protocolArray[0];
//    NSString *inverBorrowId = @"";
//    NSString *protocolType = @"";
//    if ([sender.titleLabel.text containsString:@"借款协议"]) {
//        inverBorrowId = model.inverBorrowId;
//        protocolType = @"2";
//    }else if ([sender.titleLabel.text containsString:@"转账授权书"]){
//        protocolType = @"1";
//    }else if ([sender.titleLabel.text containsString:@"信用咨询及管理服务协议"]){
//        protocolType = @"3";
//    }else if ([sender.titleLabel.text containsString:@"运营商信息授权协议"]){
//        protocolType = @"4";
//    }else if ([sender.titleLabel.text containsString:@"用户信息授权服务协议"]){
//        protocolType = @"5";
//    }else if ([sender.titleLabel.text containsString:@"技术服务协议"]){
//        protocolType = @"6";
//    }else if ([sender.titleLabel.text containsString:@"风险管理与数据服务协议"]){
//        protocolType = @"7";
//    }else if ([sender.titleLabel.text containsString:@"电子签章授权委托协议"]){
//        protocolType = @"18";
//    }else if ([sender.titleLabel.text containsString:@"会员服务协议"]){
//        protocolType = @"19";
//    }
//    NSString *periods = _homeProductList.periods;
//    if ([_homeProductList.productId isEqualToString:EliteLoan]) {
//        periods = @"";
//    }
//    [self getProtocolContentProtocolType:_homeProductList.productId typeCode:protocolType applicationId:_homeProductList.applicationId periods:periods];
//
//}


//-(void)bottomBtnClick{
//
//
//}

//#pragma mark 超市按钮
//-(void)loanClick{
//
//    if (_homeProductList.platType == nil) {
//        return;
//    }
//    LoanListViewController *controller = [[LoanListViewController alloc]init];
//    PlatTypeModel *model = [self getPlatFlag:1];
//    controller.titleStr = model.desc_;
//    controller.moduleType = model.code_;
//    controller.location = @"1";
//    [self.navigationController pushViewController:controller animated:true];
//
//}
//
//#pragma mark 游戏按钮
//-(void)gameBtnClick{
//
//    if (_homeProductList.platType == nil) {
//        return;
//    }
//    LoanListViewController *controller = [[LoanListViewController alloc]init];
//    PlatTypeModel *model = [self getPlatFlag:2];
//    controller.titleStr = model.desc_;
//    controller.moduleType = model.code_;
//    controller.location = @"";
//    [self.navigationController pushViewController:controller animated:true];
//
//}
//
//#pragma mark 旅游按钮
//-(void)tourismBtnClcik{
//
//    if (_homeProductList.platType == nil) {
//        return;
//    }
//    LoanListViewController *controller = [[LoanListViewController alloc]init];
//    PlatTypeModel *model = [self getPlatFlag:3];
//    controller.titleStr = model.desc_;
//    controller.moduleType = model.code_;
//    controller.location = @"";
//    [self.navigationController pushViewController:controller animated:true];
//
//}
//
//-(PlatTypeModel *)getPlatFlag:(NSInteger)flag{
//
//    for (int i = 0; i<_homeProductList.platType.count; i++) {
//
//        PlatTypeModel *model = _homeProductList.platType[i];
//        if (flag == model.code_.integerValue) {
//            return model;
//        }
//
//    }
//
//    return nil;
//}
#pragma mark 查看更多
-(void)recentMoreBtnClick{
    
    HotRecommendationViewController *controller = [[HotRecommendationViewController alloc]init];
    [self.navigationController pushViewController:controller animated:true];

}

#pragma mark 收藏
-(void)collectionBtnClick:(UIButton *)sender{
    
    if ([FXD_Utility sharedUtility].loginFlage) {
        
        [self collectionRequest:sender.tag];
        
    } else {
        [self presentLoginVC:self];
    }
}

-(void)collectionRequest:(NSInteger)tag{
    HomeHotRecommendModel *model = _homeProductList.hotRecommend[tag];
    
    CollectionViewModel *collectionVM = [[CollectionViewModel alloc]init];
    [collectionVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            
            [self getAllTheHomePageData:^(BOOL isSuccess) {
                if (_loadFailView) {
                    [_loadFailView removeFromSuperview];
                }
                
                if (isSuccess) {
                    
                    [self getHgLoanProtoolList];
                }
                
                self.tableView.hidden = false;
                if (_homeProductList == nil ) {
                    [self setUploadFailView];
                }
            }];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
        
    } WithFaileBlock:^{
        
    }];
    
    [collectionVM addMyCollectionInfocollectionType:model.moduletype platformId:model.id_];
}


#pragma mark 极速申请 -- 手机卡充值
-(void)quotaBtnClick{
    
    switch (_homeProductList.flag.integerValue) {
        case 1:
            if ([FXD_Utility sharedUtility].loginFlage) {
                UserDataAuthenticationListVCModules *controller = [[UserDataAuthenticationListVCModules alloc]initWithNibName:@"UserDataAuthenticationListVCModules" bundle:nil];
                [self.navigationController pushViewController:controller animated:true];
            } else {
                [self presentLoginVC:self];
            }
            break;
        case 2:
        {
            ShoppingMallModules *controller = [[ShoppingMallModules alloc]init];
            [self.navigationController pushViewController:controller animated:true];
        }
            
            break;
        case 7:
            switch (_homeProductList.platfromType.integerValue) {
                case 0:
                case 2:
                {
                    LoanPeriodListVCModule *controller = [[LoanPeriodListVCModule alloc]initWithNibName:@"LoanPeriodListVCModule" bundle:nil];
                    controller.applicationId = _homeProductList.applicationId;
                    [self.navigationController pushViewController:controller animated:true];
                }
                    break;
                case 16:
                
                {
                    MyBillViewController *controller = [[MyBillViewController alloc]init];
                    [self.navigationController pushViewController:controller animated:true];
                }
                    
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
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
