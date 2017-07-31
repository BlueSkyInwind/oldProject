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
#import "ExpressCreditRefuseView.h"
#import "HomeRefuseCell.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "LoginViewModel.h"

@interface HomeViewController ()<PopViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,BMKLocationServiceDelegate>
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
    

    BMKLocationService *_locService;
    double _latitude;
    double _longitude;
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
    [self createBottomView];

}


-(void)createBottomView{

    CGFloat heigh;
    if (UI_IS_IPHONE5) {
        heigh = 70;
    }else{
    
        heigh = 80;
    }
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _k_h-49-heigh, _k_w, heigh)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-55);
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//        make.width.equalTo(@186);
//    }];
    UIView *payView = [[UIView alloc]init];
    UITapGestureRecognizer *gestPay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payMoney)];
    payView.userInteractionEnabled = true;
    [payView addGestureRecognizer:gestPay];
    [bottomView addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).with.offset(0);
        make.left.equalTo(bottomView.mas_left).with.offset(25);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(0);
        make.width.equalTo(@70);
    }];
    
    UIImageView *payImage = [[UIImageView alloc]init];
    payImage.image = [UIImage imageNamed:@"home_06"];
    [payView addSubview:payImage];
    [payImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payView.mas_top).with.offset(10);
        make.centerX.equalTo(payView.mas_centerX);
    }];
    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.text = @"我要还款";
    payLabel.font = [UIFont systemFontOfSize:13];
    payLabel.textAlignment = NSTextAlignmentCenter;
    payLabel.textColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1.0];
    [payView addSubview:payLabel];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payImage.mas_bottom).with.offset(5);
        make.centerX.equalTo(payView.mas_centerX);
        make.height.equalTo(@15);
        make.width.equalTo(@70);
    }];
    
    UIView *processView = [[UIView alloc]init];
    
    UITapGestureRecognizer *gestProcess = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loanProcess)];
    processView.userInteractionEnabled = true;
    [processView addGestureRecognizer:gestProcess];
    [bottomView addSubview:processView];
    [processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).with.offset(0);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(0);
        make.centerX.equalTo(bottomView.mas_centerX);
        make.width.equalTo(@70);
    }];
    
    UIImageView *processImage = [[UIImageView alloc]init];
    processImage.image = [UIImage imageNamed:@"home_07"];
    [processView addSubview:processImage];
    [processImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(processView.mas_top).with.offset(10);
        make.centerX.equalTo(processView.mas_centerX);
        
    }];
    
    UILabel *processLabel = [[UILabel alloc]init];
    processLabel.textAlignment = NSTextAlignmentCenter;
    processLabel.text = @"借款进度";
    processLabel.font = [UIFont systemFontOfSize:13];
    processLabel.textColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1.0];
    [processView addSubview:processLabel];
    [processLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(processImage.mas_bottom).with.offset(5);
        make.centerX.equalTo(processView.mas_centerX);
        make.height.equalTo(@15);
        make.width.equalTo(@70);
    }];
    
    UIView *expenseView = [[UIView alloc]init];
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expense)];
    expenseView.userInteractionEnabled = true;
    [expenseView addGestureRecognizer:gest];
    [bottomView addSubview:expenseView];
    [expenseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_top).with.offset(0);
        make.right.equalTo(bottomView.mas_right).with.offset(-25);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(0);
        make.width.equalTo(@70);
    }];
    
    UIImageView *expenseImage = [[UIImageView alloc]init];
    expenseImage.image = [UIImage imageNamed:@"home_09"];
    [expenseView addSubview:expenseImage];
    [expenseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expenseView.mas_top).with.offset(10);
        make.centerX.equalTo(expenseView.mas_centerX);
    }];
    
    UILabel *expenseLabel = [[UILabel alloc]init];
    expenseLabel.text = @"费用说明";
    expenseLabel.textAlignment = NSTextAlignmentCenter;
    expenseLabel.font = [UIFont systemFontOfSize:13];
    expenseLabel.textColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1.0];
    [expenseView addSubview:expenseLabel];
    [expenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expenseImage.mas_bottom).with.offset(5);
        make.centerX.equalTo(expenseView.mas_centerX);
        make.height.equalTo(@15);
        make.width.equalTo(@70);
    }];
    
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
        //获取进件状态
        [self getFxdCaseInfo];
    }
    
    [self fatchRecord];
    [self fatchBanner];
    [self getHomeProductList];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeProductCell class]) bundle:nil] forCellReuseIdentifier:@"HomeProductCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeBottomCell class]) bundle:nil] forCellReuseIdentifier:@"HomeBottomCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CycleTextCell class]) bundle:nil] forCellReuseIdentifier:@"CycleTextCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = rgb(245, 245, 245);
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
    NSInteger i = 0;
    if (_dataArray.count>0) {
        if ([_homeProductList.result.type isEqualToString:@"0"]) {
            i = _dataArray.count + 1;
            
        }else{
        
            i = 2;
        }
    }else{
    
        i = 1;
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
    if (_dataArray.count > 0) {
        if ([_homeProductList.result.type isEqualToString:@"0"]) {
            if (_dataArray.count == 1) {
                i = 3;
            }else{
            
                i = _dataArray.count;
            }
            
        }else{
            i = 1;
        }
    }else{
    
        i = 1;
    }
    if (indexPath.section == 0) {
        return 30.f;
    }else{
    
        if (UI_IS_IPHONE5) {
            return (_k_h-0.5*_k_w-225)/i;
        }else{
            
            return (_k_h-0.5*_k_w-235)/i;
        }
        

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
            //测试
            if (result.content == nil) {
                continue;
            }
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
    
    if ([_homeProductList.result.type isEqualToString:@"0"]) {
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
            cell.periodLabel.text = [NSString stringWithFormat:@"%@还款，额度%@",product.ext_attr_.period_desc_,product.ext_attr_.amt_desc_];;
            cell.amountLabel.text = product.name_;
            cell.amountLabel.font = [UIFont systemFontOfSize:18.0];
            cell.amountLabel.textColor = [UIColor colorWithHexColorString:@"666666"];
            cell.helpImage.userInteractionEnabled = true;
            
            if ([product.id_ isEqualToString:SalaryLoan]) {
                cell.specialtyImage.image = [UIImage imageNamed:@"home_04"];
                UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highSeeExpenses)];
                [cell.helpImage addGestureRecognizer:gest];
                
            }else if([product.id_ isEqualToString:WhiteCollarLoan]){
                cell.specialtyImage.image = [UIImage imageNamed:@"home11"];
                
            }else{
                
                cell.periodLabel.text = [NSString stringWithFormat:@"%@天还款，额度%@",product.ext_attr_.period_desc_,product.ext_attr_.amt_desc_];
                UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lowSeeExpenses)];
                [cell.helpImage addGestureRecognizer:gest];
                cell.specialtyImage.image = [UIImage imageNamed:@"home_05"];
                
            }
            return cell;

        }
        
    }else if([_homeProductList.result.type isEqualToString:@"1"]){
    
        if (indexPath.section == 1) {

            HomeRefuseCell *cell = [HomeRefuseCell cellWithTableView:tableView];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.selected = NO;
            cell.backgroundColor = rgb(245, 245, 245);
            cell.homeProductList = _homeProductList;
            cell.delegate = self;
            return cell;
        }
    }
    return cell;
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

    if (![Utility sharedUtility].loginFlage) {
        [self presentLogin:self];
        return;
    }
    __weak typeof (self) weakSelf = self;
    [self getApplyStatus:^(BOOL isSuccess, UserStateModel *resultModel) {
        
        if ([resultModel.platform_type isEqualToString:@"2"]) {
            if ([resultModel.applyStatus isEqualToString:@"7"]||[resultModel.applyStatus isEqualToString:@"8"]) {
                //此时用户的状态为 有还款列表的

                if ([_qryUserStatusModel.result.flg isEqualToString:@"12"]) {
                    LoanMoneyViewController *controller = [LoanMoneyViewController new];
                    controller.userStateModel = resultModel;
                    controller.qryUserStatusModel = _qryUserStatusModel;
                    [weakSelf.navigationController pushViewController:controller animated:YES];

                }else if([_qryUserStatusModel.result.flg isEqualToString:@"3"]){
                    //激活用户
                    NSString *url = [NSString stringWithFormat:@"%@%@?page_type_=%@&ret_url_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"1",_transition_url,[Utility sharedUtility].userInfo.userMobilePhone];
                    P2PViewController *p2pVC = [[P2PViewController alloc] init];
                    p2pVC.isRepay = YES;
                    p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    [weakSelf.navigationController pushViewController:p2pVC animated:YES];
                    
                }else{
                    RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                    repayRequest.targetVC = weakSelf;
                    [repayRequest repayRequest];
                }
            }else{

                RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                repayRequest.targetVC = weakSelf;
                [repayRequest repayRequest];
                
            }
        }else{

            RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
            repayRequest.targetVC = weakSelf;
            [repayRequest repayRequest];
        }
    }];

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
        
        if ([_homeProductList.result.type isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:_homeProductList.result.refuseMsg];
        }
        
//        _homeProductList.result.type = @"1";
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

-(void)getApplyStatus:(void(^)(BOOL isSuccess, UserStateModel *resultModel))finish{
    
    [[FXDNetWorkManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_userState_url]   isNeedNetStatus:NO isNeedWait:NO parameters:nil finished:^(EnumServerStatus status, id object) {
        if([object[@"flag"] isEqualToString:@"0000"])
        {
        
            UserStateModel *result;
            result = [UserStateModel yy_modelWithJSON:object[@"result"]];
            finish(YES,result);

        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:object[@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
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
                        
                        UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                        userDataVC.product_id = productId;
                        userDataVC.req_loan_amt = [NSString stringWithFormat:@"%ld",rate.result.principal_bottom_];
                        [self.navigationController pushViewController:userDataVC animated:true];
                        
//                        PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
//                        payLoanview.product_id = productId;
//                        payLoanview.userState = model;
//                        payLoanview.rateModel = rate;
//                        [self.navigationController pushViewController:payLoanview animated:true];
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
                                UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                                userDataVC.product_id = productId;
                                userDataVC.req_loan_amt = [NSString stringWithFormat:@"%ld",rate.result.principal_bottom_];
                                [self.navigationController pushViewController:userDataVC animated:true];
                                
//                                PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
//                                payLoanview.product_id = productId;
//                                payLoanview.userState = model;
//                                payLoanview.rateModel = rate;
//                                [self.navigationController pushViewController:payLoanview animated:true];
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
                        
                        UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
                        userDataVC.product_id = productId;
                        userDataVC.req_loan_amt = [NSString stringWithFormat:@"%ld",rate.result.principal_bottom_];
                        [self.navigationController pushViewController:userDataVC animated:true];
//                        PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
//                        payLoanview.product_id = productId;
//                        payLoanview.userState = model;
//                        payLoanview.rateModel = rate;
//                        [self.navigationController pushViewController:payLoanview animated:true];
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
