//
//  FXD_HomePageVCModules.m
//  fxdProduct
//
//  Created by sxp on 2017/12/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_HomePageVCModules.h"
#import "HomeViewModel.h"
#import "WithdrawalsVCModule.h"
#import "LoanMoneyViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationViewController.h"
#import "ActivityHomePopView.h"
#import "LewPopupViewController.h"
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
#import "MessageViewModel.h"
#import "AountStationLetterMsgModel.h"
#import "MyViewController.h"
#import "FXDBaseTabBarVCModule.h"
#import "UITabBar+badge.h"
#import "NextViewCell.h"
#import "CycleTextCell.h"
#import "FXD_HomeProductListModel.h"
@interface FXD_HomePageVCModules ()<PopViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,BMKLocationServiceDelegate,LoadFailureDelegate,HomePageCellDelegate>
{
    NSString *_advTapToUrl;
    NSString *_shareContent;
    NSString *_advImageUrl;
    NSTimer * _countdownTimer;
    ActivityHomePopView *_popView;
    
    NSInteger _count;
    FXD_HomeProductListModel *_homeProductList;
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
    self.navigationItem.title = @"发薪贷";
    _count = 0;
    _dataArray = [NSMutableArray array];
    [self setNavQRRightBar];
    [self setNavQRLeftBar];
    [self createTab];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([FXD_Utility sharedUtility].loginFlage) {
        //获取位置信息
        if ([FXD_Utility sharedUtility].isObtainUserLocation) {
            [self openLocationService];
        }
    }
    [self LoadHomeView];
    
    
    
}


-(void)createTab{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64) style:UITableViewStylePlain];
    [self.tableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"HomePageCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = rgb(250, 250, 250);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    DLog(@"%lf",_k_w);
    _sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _k_w, 165) delegate:self placeholderImage:[UIImage imageNamed:@"banner-placeholder"]];
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
    
    [self getMessageNumber];
    [self getAllTheHomePageData:^(BOOL isSuccess) {
        if (_loadFailView) {
            [_loadFailView removeFromSuperview];
        }
        self.tableView.hidden = false;
        if (_homeProductList == nil ) {
            [self setUploadFailView];
        }
    }];
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
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        if (appDelegate.isShow) {
            
            NSArray * popArray = (NSArray *)_homeProductList.popList;
            PopListModel *model = (PopListModel *)popArray[0];
            [self homeActivitiesPopups:model];
        }
        if (appDelegate.isHomeChooseShow) {
            [self homeEvaluationRedEnvelopeActivitiesPopups:_homeProductList];
        }
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
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.isShow = false;
        _popView = [ActivityHomePopView defaultPopupView];
        _popView.closeBtn.hidden = YES;
        _popView.delegate = self;
        [_popView.imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
        _advImageUrl = model.toUrl;
        _advTapToUrl = model.toUrl;
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
-(void)homeEvaluationRedEnvelopeActivitiesPopups:(FXD_HomeProductListModel *)model{
    
    if ([model.jumpBomb isEqualToString:@"1"]) {
        
        RedCollarListModel *redCollarList = [[RedCollarListModel alloc]initWithDictionary:(NSDictionary *)_homeProductList.redCollarList error:nil];
       
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.isHomeChooseShow = false;
        _popChooseView = [[HomeChoosePopView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
        _popChooseView.displayLabel.text = redCollarList.collarContent;
        [_popChooseView.cancelButton setTitle:redCollarList.cancel forState:UIControlStateNormal];
        [_popChooseView.sureButton setTitle:redCollarList.redCollar forState:UIControlStateNormal];
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
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//
//    if (section == 0) {
//        return 12.0f;
//    }
//
//    return 0.1f;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if ([self getAllProduct] > 1) {
//
//        return [self getAllProduct]+1;
//
//    }
//    return 2;
    
    return 1;
}

//-(NSInteger)getAllProduct{
//
//    NSInteger i = 0;
//    for (HomeProductsList *product in _homeProductList.data.productList) {
//        if ([product.isValidate isEqualToString:@"1"]) {
//            i++;
//        }
//    }
//    return i;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.section == 0) {
//        return 30.f;
//    }else {
//
//        if ([self getAllProduct]>1) {
//            int height = 0;
//            if (UI_IS_IPHONE5) {
//                height = 113;
//            }else if(UI_IS_IPHONE6P){
//
//                height = 150;
//            }else if (UI_IS_IPHONE6){
//
//                height = 160;
//            }else if (UI_IS_IPHONEX){
//                height = 210;
//            }
//
//            if ([self getAllProduct]>2) {
//                return (_k_h-0.5*_k_w-height)/_dataArray.count;
//            }
//            return 120;
//
//        }else{
//            if (UI_IS_IPHONE5) {
//                return (_k_h-0.5*_k_w-155);
//            }else if(UI_IS_IPHONEX){
//                return (_k_h-0.5*_k_w-250);
//            }else{
//                return (_k_h-0.5*_k_w-155);
//            }
//        }
//    }
    
    return _k_h-265;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomePageCell *homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell"];
    [homeCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    homeCell.backgroundColor = rgb(250, 250, 250);
    homeCell.selected = NO;
    homeCell.delegate = self;
    homeCell.defaultMoneyLabel.text = @"8000元";
    homeCell.defaultTimeLabel.text = @"180天";
    homeCell.homeProductListModel = _homeProductList;
    if (_homeProductList != nil) {
        
        homeCell.type = _homeProductList.flag;

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

-(void)helpBtnClick{
    NSLog(@"点击帮助中心");
}

-(void)daoliuBtnClick{
    NSLog(@"量子互助");
}

-(void)withdrawMoneyImmediatelyBtnClick{
    NSLog(@"立即提款");
}

-(void)loanBtnClick{
    NSLog(@"我要借款");
}

-(void)productListClick:(NSString *)productId isOverLimit:(NSString *)isOverLimit amount:(NSString *)amount Path:(NSString *)Path{
    NSLog(@"===%@,===%@,===%@,===%@==",productId,isOverLimit,amount,Path);
    FXDWebViewController *webView = [[FXDWebViewController alloc]init];
    webView.urlStr = Path;
    [self.navigationController pushViewController:webView animated:true];
}

-(void)moreBtnClick{
    NSLog(@"更多按钮");
}

-(void)questionDescBtnClick{
    NSLog(@"帮助图标按钮");
}

-(void)repayImmediatelyBtnClick:(BOOL)isSelected{
    if (!isSelected) {
        NSLog(@"立即还款");
    }else{
        NSLog(@"勾选框");
    }
}

-(void)applyImmediatelyBtnClick:(NSString *)money :(NSString *)time{
    
    NSLog(@"===%@===%@==",money,time);
}


-(void)bankProtocolClick{
   
    NSLog(@"bankProtocolClick");
}

-(void)loanProtocolClick{
    
    NSLog(@"loanProtocolClick");
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
