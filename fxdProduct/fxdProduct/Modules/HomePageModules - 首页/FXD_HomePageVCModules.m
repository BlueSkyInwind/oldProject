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
#import "FXD_HomeProductListModel.h"
#import "LoanPeriodListVCModule.h"
#import "CommonViewModel.h"
#import "ComplianceViewModel.h"
#import "HgLoanProtoolListModel.h"
#import "QBBWitnDrawModel.h"
@interface FXD_HomePageVCModules ()<PopViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,BMKLocationServiceDelegate,LoadFailureDelegate,SDCycleScrollCellDelegate,HomeBetweenCellDelegate>
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

    _count = 0;
    _dataArray = [NSMutableArray array];
    [self createTab];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    self.navigationController.navigationBarHidden = true;
    _bgView.hidden = true;
    _messageNumLabel.text = @"";
    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
    [self LoadHomeView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = false;
}

-(void)createTab{
    
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -rectOfStatusbar.size.height, _k_w, _k_h-49 + rectOfStatusbar.size.height) style:UITableViewStylePlain];
    [self.tableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"HomePageCell"];
    [self.tableView registerClass:[HomeBetweenCell class] forCellReuseIdentifier:@"HomeBetweenCell"];
    [self.tableView registerClass:[RecentCell class] forCellReuseIdentifier:@"RecentCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = true;
    self.tableView.backgroundColor = rgb(250, 250, 250);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//    DLog(@"%lf",_k_w);
    _sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, _k_w, _k_w*0.44) delegate:self placeholderImage:[UIImage imageNamed:@"banner-placeholder"]];
    //375 185
    _sdView.delegate = self;
    _sdView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _sdView.pageControlDotSize = CGSizeMake(17, 7);
    _sdView.pageDotImage = [UIImage imageNamed:@"page_icon"];
    _sdView.currentPageDotImage = [UIImage imageNamed:@"page_sel_icon"];
    self.tableView.tableHeaderView = _sdView;

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    //    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    [self addMessageBtn:rectOfStatusbar.size.height];
}


/**
 我的消息视图
 */
- (void)addMessageBtn:(CGFloat)height {
    
    _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(_k_w - 15 - 30, 17 + height, 15, 16)];
    [_messageBtn setImage:[UIImage imageNamed:@"homeMessage"] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(homeQRMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_messageBtn];
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
 我的消息点击事件
 */
-(void)homeQRMessage{
    
    if ([FXD_Utility sharedUtility].loginFlage) {
        MyMessageViewController *myMessageCV = [[MyMessageViewController alloc]init];
        [self.navigationController pushViewController:myMessageCV animated:true];
    } else {
        [self presentLoginVCCompletion:nil];
    }
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
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.section) {
        case 0:
            return 95;
            break;
        case 1:
            
        {
            long height = 0;
            long count = _homeProductList.hotRecommend.count / 4;
            if (_homeProductList.hotRecommend.count % 4 == 0)  {
                height = count * 103;
            }else{
                height = (count + 1) * 103;
            }
            return height+60;
        }
            
            break;
        default:
            break;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10.0f;
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
            HomeBetweenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBetweenCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.homeProductListModel = _homeProductList;
            cell.dataArray = @[@"loan_icon",@"loan_icon",@"loan_icon",@"loan_icon"];
            return cell;
        }
            break;
        case 1:
        {
            RecentCell *recentCell = [tableView dequeueReusableCellWithIdentifier:@"RecentCell"];
            [recentCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            recentCell.backgroundColor = [UIColor whiteColor];
            recentCell.homeProductListModel = _homeProductList;
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


-(void)imageViewBtnClick:(UIButton *)sender{
    
    PlatTypeModel *model = _homeProductList.platType[sender.tag - 101];
    if (model.gatherUrl == nil) {
        
        self.tabBarController.selectedIndex = 3;
    }else{
        FXDWebViewController *controller = [[FXDWebViewController alloc]init];
        controller.urlStr = model.gatherUrl;
        [self.navigationController pushViewController:controller animated:true];
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
