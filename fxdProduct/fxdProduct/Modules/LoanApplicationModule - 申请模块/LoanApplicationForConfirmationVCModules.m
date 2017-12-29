//
//  LoanSureFirstViewController.m
//  fxdProduct
//
//  Created by dd on 2017/1/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanApplicationForConfirmationVCModules.h"
#import "WithdrawalsVCModule.h"
#import "FMDeviceManager.h"
#import "RateModel.h"
#import "ApplicationViewModel.h"
#import "ApplicaitonModel.h"
#import "DiscountTicketModel.h"
#import "UserStateModel.h"
@interface LoanApplicationForConfirmationVCModules ()<DiscountCouponsViewDelegate>{
    
    DiscountTicketModel * discountTM;
    DiscountTicketDetailModel * chooseDiscountTDM;
    NSInteger chooseIndex;
}

@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic,strong) RateModel *rateModel;
@property (nonatomic,strong) DiscountCouponsView * discountCouponsV;

@end

@implementation LoanApplicationForConfirmationVCModules

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"借款申请确认";
    chooseIndex = 1;
    [self addBackItem];
    
    if ([_productId isEqualToString:SalaryLoan] || [_productId isEqualToString:RapidLoan] || [_productId isEqualToString:DeriveRapidLoan]) {
        [self obtainDiscountTicket:^(DiscountTicketModel *discountTicketModel) {
            if (discountTicketModel.canuselist != nil && discountTicketModel.canuselist.count != 0) {
                [self addDiscountCoupons:discountTicketModel.canuselist[0]];
            } 
        }];
    }
    
    if (UI_IS_IPHONEX) {
        self.headerViewHeader.constant = 88;
        self.bottomViewBottom.constant = 100;
    }
    [FXD_Tool setCorner:self.sureBtn borderColor:[UIColor clearColor]];

    NSString *str = self.agreementLabel.text;
    NSMutableAttributedString *ssa = [[NSMutableAttributedString alloc] initWithString:str];
    [ssa addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3,13)];
    self.agreementLabel.attributedText = ssa;
    self.agreementLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreement)];
    [self.agreementLabel addGestureRecognizer:tap1];
    [self.sureBtn addTarget:self action:@selector(getcreateApplication) forControlEvents:UIControlEventTouchUpInside];
    
}

/**
 增加券视图
 @param discountTicketDetailM 默认券
 */
-(void)addDiscountCoupons:(DiscountTicketDetailModel *)discountTicketDetailM{
    
    chooseDiscountTDM = discountTicketDetailM;
    float discountCouponsTop = 115;
    if (UI_IS_IPHONE6P) {
        discountCouponsTop = 164;
    }else if (UI_IS_IPHONE6){
        discountCouponsTop = 140;
    }else if (UI_IS_IPHONE5){
        self.headerViewHeight.constant = 190;
        self.bottomViewBottom.constant = 60;
    }else if (UI_IS_IPHONEX){
         discountCouponsTop = 164;
    }
    self.discountCouponsV = [[DiscountCouponsView alloc]initWithFrame:CGRectZero];
    self.discountCouponsV.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    self.discountCouponsV.delegate = self;
    self.discountCouponsV.amountLabel.text = [NSString stringWithFormat:@"+￥%@",chooseDiscountTDM.total_amount];
     [self.view addSubview:self.discountCouponsV];
    [self.discountCouponsV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom).with.offset(0);
        make.height.equalTo(@(discountCouponsTop));
    }];
    self.bottomViewTop.constant = discountCouponsTop;
}

#pragma DiscountCouponsDelergate
/**
 展现券的使用列表
 */
-(void)pushChooseAmountView{
    DiscountCouponListVCModules *discountCouponVC = [[DiscountCouponListVCModules alloc]init];
    discountCouponVC.dataListArr = discountTM.canuselist;
    discountCouponVC.currentIndex = [NSString stringWithFormat:@"%ld",chooseIndex];
    discountCouponVC.view.frame = CGRectMake(0, 0, _k_w, _k_h * 0.6);
    discountCouponVC.chooseDiscountTicket = ^(NSInteger index, DiscountTicketDetailModel * discountTicketDetailModel, NSString * str) {
        chooseIndex = index;
        chooseDiscountTDM = discountTicketDetailModel;
        if (index != 0) {
            self.discountCouponsV.amountLabel.text = [NSString stringWithFormat:@"+￥%@",chooseDiscountTDM.total_amount];
        }else{
            self.discountCouponsV.amountLabel.text = [NSString stringWithFormat:@"+￥0"];
        }
    };
    [self presentSemiViewController:discountCouponVC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)} completion:nil dismissBlock:^{
    }];
}

-(void)pushDirectionsForUse{
    FXDWebViewController * webVC = [[FXDWebViewController alloc]init];
    webVC.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_DiscountTicketRule_url];
    [self.navigationController pushViewController:webVC animated:true];
}

-(void)viewWillAppear:(BOOL)animated{
    [self fatchRate];
}
#pragma 数据请求
- (void)fatchRate
{
    ApplicationViewModel * applicationVM = [[ApplicationViewModel alloc]init];
    [applicationVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            ApplicaitonViewInfoModel * applicationVM = [[ApplicaitonViewInfoModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            [self setUpProductData:applicationVM];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [applicationVM queryApplicationInfo:_productId];
}

/**
 获取折扣券 数据

 @param finish 结果回调
 */
-(void)obtainDiscountTicket:(void(^)(DiscountTicketModel * discountTicketModel))finish{
    ApplicationViewModel * applicationVM = [[ApplicationViewModel alloc]init];
    [applicationVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            DiscountTicketModel * discountTicketM = [[DiscountTicketModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            discountTM = discountTicketM;
            finish(discountTicketM);
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [applicationVM new_obtainUserDiscountTicketListDisplayType:@"1" product_id:_productId  pageNum:nil pageSize:nil];
}

- (YYTextView *)textView
{
    if (_textView == nil) {
        _textView = [YYTextView new];
        [self.detailView addSubview:_textView];
        if (UI_IS_IPHONE5) {
            _textView.scrollEnabled = YES;
            _textView.showsVerticalScrollIndicator = false;
        }else {
            _textView.scrollEnabled = NO;
        }
        _textView.editable = NO;
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.bottom.equalTo(@0);
            make.right.equalTo(@0);
        }];
    }
    return _textView;
}

-(void)setUpProductData:(ApplicaitonViewInfoModel *)applicationVM{
//    [self.productLogo sd_setImageWithURL:[NSURL URLWithString:applicationVM.icon] placeholderImage:[UIImage imageNamed:@"placeholderImage_Icon"] options:SDWebImageRefreshCached];
    [self.productLogo sd_setImageWithURL:[NSURL URLWithString:applicationVM.icon] placeholderImage:[UIImage imageNamed:@"placeholderImage_Icon"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    
    self.productTitle.text = applicationVM.productName;
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"当前额度:"];
    NSString *amountStr = [NSString stringWithFormat:@"%@",applicationVM.amount];
    [attriStr yy_appendString:amountStr];
    [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 5)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(5, amountStr.length-1)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(5, amountStr.length)];
    self.amountLabel.attributedText = attriStr;
    
    NSString *str = [NSString stringWithFormat:@"期限:%@",applicationVM.period];
    NSMutableAttributedString * attriStr2 = [[NSMutableAttributedString alloc] initWithString:str];
    [attriStr2 addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 2)];
    [attriStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 2)];
    [attriStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(3, str.length-3)];
    [attriStr2 addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, str.length-3)];
    self.timeLabel.attributedText = attriStr2;

    NSString * specialStr = @" ";
    for (NSString *str2  in applicationVM.special) {
        specialStr = [specialStr stringByAppendingString:str2];
    }
    self.specialLabel.text = specialStr;
    
    NSString * detailStr = @"";
    for (NSString *str1  in applicationVM.detail) {
        detailStr = [detailStr stringByAppendingString:str1];
    }
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:detailStr];
    if (UI_IS_IPHONE5) {
        contentText.yy_font = [UIFont systemFontOfSize:12];
        self.specialLabel.font = [UIFont systemFontOfSize:12];
    } else {
        contentText.yy_font = [UIFont systemFontOfSize:14];
        self.specialLabel.font = [UIFont systemFontOfSize:14];
    }
    contentText.yy_color = rgb(122, 131, 139);
    self.textView.attributedText = contentText;
}

#pragma mark -> 进件接口
-(void)getcreateApplication
{
    DLog(@"首次进件")
    ApplicationViewModel * applicationVM = [[ApplicationViewModel alloc]init];
    __weak LoanApplicationForConfirmationVCModules *weakSelf = self;
    [applicationVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){

            [weakSelf goCheckVC:nil];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [applicationVM userCreateApplication:_productId platformCode:@"" baseId:chooseDiscountTDM.base_id];
    
}

-(void)failed{

    WithdrawalsVCModule *checkVC = [WithdrawalsVCModule new];

    [self.navigationController pushViewController:checkVC animated:YES];
}

- (void)goCheckVC:(UserStateModel *)model
{
    WithdrawalsVCModule *checkVC = [WithdrawalsVCModule new];

    [self.navigationController pushViewController:checkVC animated:YES];
}

#pragma mark -> 跳转到用户信息授权服务协议
-(void)clickAgreement{


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
