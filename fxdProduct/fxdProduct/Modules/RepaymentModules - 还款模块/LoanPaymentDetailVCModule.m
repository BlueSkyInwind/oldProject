 //
//  LoanPaymentDetailVCModule.m
//  fxdProduct
//
//  Created by zy on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "LoanPaymentDetailVCModule.h"
#import "PayMoneyCell.h"
#import "PayMethodCell.h"
#import "UILabel+FlickerNumber.h"
#import "UIViewController+KNSemiModal.h"
#import "PayNavigationViewController.h"
#import "CardInfo.h"
#import "UserCardResult.h"
#import "RepayListInfo.h"
#import "P2PBillDetail.h"
#import "CheckViewModel.h"
#import "HomeViewModel.h"
#import "PaymentViewModel.h"
#import "PaymentDetailModel.h"
#import "BaseResultModel.h"
#import "SupportBankList.h"
#import "DiscountTicketModel.h"

@interface LoanPaymentDetailVCModule ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView*navBarHairlineImageView;
    NSArray *payLoanArry;
    CardInfo *_selectCard;
    
    UserCardResult *_userCardsModel;
    
    NSInteger defaultBankIndex;
    NSInteger userSelectIndex;
    //所选红包金额
    CGFloat _selectRedPacket;
    //使用红包金额
    CGFloat _useredPacketAmount;
    
    //所选红包ID
    NSString *_selectRedPacketID;
    //可否使用红包
    BOOL _canUseReadPacket;
    //用户最终还款金额
    CGFloat _finalyRepayAmount;
    NSString * discountNumStr;
    NSString * discountUsageStatus;

    //溢缴金
    CGFloat _useTotalAmount;
    //逾期费用
    CGFloat _debtOverdueTotal;

    //空白展位视图
    UIView *noneView;
    //银行卡名称
    NSString *_patternName;
    // 银行卡尾数号
    NSString *_bankNo;
    
    NSString *verfiyCode;
    NSString *smsSeq;
    //优惠券抵扣券
    DiscountTicketModel * discountTM;
    DiscountTicketDetailModel * chooseDiscountTDM;
    NSInteger chooseIndex;

}
@property (nonatomic,strong) UILabel *lblShouldrepay;
@end
@implementation LoanPaymentDetailVCModule

-(void)viewWillAppear:(BOOL)animated
{
    navBarHairlineImageView.hidden=YES;
    UIImage * navImage = [UIImage imageWithColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated
{
    navBarHairlineImageView.hidden=NO;
    UIImage * navImage = [UIImage gradientmageWithFrame:CGRectMake(0, 0, _k_w, BarHeightNew) Colors:@[rgb(33, 168, 234),rgb(95, 121, 234)] GradientType:1];
    [self.navigationController.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付详情";
    if (@available(iOS 11.0, *)) {
        self.PayDetailTB.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        self.PayDetailTB.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    chooseIndex = 0;
    defaultBankIndex = -1;
    userSelectIndex = 0;
    _useTotalAmount = 0.0;
    _debtOverdueTotal = 0.0;
    _selectRedPacket = 0.0;
    _useredPacketAmount = 0.0;
    _canUseReadPacket = false;
    navBarHairlineImageView= [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.PayDetailTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.PayDetailTB registerNib:[UINib nibWithNibName:@"PayMoneyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.PayDetailTB registerNib:[UINib nibWithNibName:@"PayMethodCell" bundle:nil] forCellReuseIdentifier:@"paycell"];

    payLoanArry = @[@"使用券",@"逾期费用",@"使用溢缴金额",@"实扣金额",@"支付方式"];
    self.PayDetailTB.bounces=NO;
    [FXD_Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
//    self.sureBtn.layer.cornerRadius = 16;
    
    if (_isPopRoot) {
        [self addBackItemRoot];
    }else{
        [self addBackItem];
    }
    
    [self createNoneView];
    [self fatchUserCardList];
    [self createHeaderView];

    discountNumStr = @"无可用券";
    //数据处理
    __weak typeof (self) weakSelf = self;
    [self eductibleAmountfDiscount:^(PaymentDetailAmountInfoModel *  paymentDetailInfo) {
        if (paymentDetailInfo != nil) {
            if ([discountUsageStatus isEqualToString:@"0"]) {
                [weakSelf obtainDiscountTicket:^(DiscountTicketModel *discountTicketModel) {
                    if (discountTicketModel.canuselist.count > 0) {
                        discountNumStr = @"有可用券";
                        [weakSelf.PayDetailTB reloadData];
                    }
                }];
            }
            [weakSelf.PayDetailTB reloadData];
        }else{
            noneView.hidden = false;
        }
    }];
}

-(void)setRepayAmount:(CGFloat)repayAmount{
    _repayAmount  = repayAmount;
    NSNumber *number = [NSNumber numberWithFloat:_repayAmount];
    [_lblShouldrepay fn_setNumber:number format:@"%.2f"];
}

-(void)createHeaderView
{
    
    UIImageView *header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 220)];
    UIImage * navImage = [UIImage gradientmageWithFrame:CGRectMake(0, 0, _k_w, BarHeightNew) Colors:@[rgb(33, 168, 234),rgb(95, 121, 234)] GradientType:1];
    header.image = navImage;

    CGPoint headerCenter = header.center;
#pragma mark 这个是顶部的还款金额 应该是请求完数据后
    self.lblShouldrepay=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    NSNumber *number = [NSNumber numberWithFloat:_repayAmount];
    [_lblShouldrepay fn_setNumber:number format:@"%.2f"];
    _lblShouldrepay.textColor=[UIColor whiteColor];
    _lblShouldrepay.textAlignment=NSTextAlignmentCenter;
    _lblShouldrepay.font = [UIFont fontWithName:@"ArialMT" size:45];
    [header addSubview:_lblShouldrepay];
    
    UILabel *lblRepayTip=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
    
    lblRepayTip.textColor=[UIColor whiteColor];
    lblRepayTip.text=@"应还总金额(元)";
    lblRepayTip.alpha=0.7;
    lblRepayTip.textAlignment=NSTextAlignmentCenter;
    [header addSubview:lblRepayTip];
    
    self.PayDetailTB.tableHeaderView = header;
    self.PayDetailTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    if (@available(iOS 11.0, *)) {
        _lblShouldrepay.center = CGPointMake(_k_w/2, headerCenter.y+20);
        lblRepayTip.center=CGPointMake(_k_w/2, headerCenter.y-30);
    }else{
        _lblShouldrepay.center=CGPointMake(_k_w/2, headerCenter.y+40);
        lblRepayTip.center=CGPointMake(_k_w/2, headerCenter.y);
    }
}

-(void)createNoneView
{
    noneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    noneView.backgroundColor=RGBColor(245, 245, 245, 1);
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((_k_w-130)/2, 132, 130, 130)];
    logoImg.image=[UIImage imageNamed:@"my-logo"];
    UILabel *lblNone=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-180)/2, logoImg.frame.origin.y+logoImg.frame.size.height+25, 180, 25)];
    lblNone.numberOfLines = 0;
    lblNone.text = @"您当前无需还款";
    lblNone.textAlignment = NSTextAlignmentCenter;
    lblNone.font = [UIFont systemFontOfSize:16];
    lblNone.textColor = RGBColor(180, 180, 181, 1);
    [noneView addSubview:logoImg];
    [noneView addSubview:lblNone];
    noneView.hidden = YES;
    [self.view addSubview:noneView];
}
/**
 获取用户绑定卡列表
 */
- (void)fatchUserCardList
{
    BankInfoViewModel * bankInfoVM = [[BankInfoViewModel alloc]init];
    [bankInfoVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            NSArray * array = (NSArray *)baseResultM.data;
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                CardInfo * cardInfo = [[CardInfo alloc]initWithDictionary:dic error:nil];
                if ([cardInfo.cardType isEqualToString:@"2"]) {
                    _selectCard = cardInfo;
                    break;
                }
            }
            [self.PayDetailTB reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardsModel.msg];
        }
    } WithFaileBlock:^{
    }];
    [bankInfoVM obtainUserBankCardListPlatformType:_platform_type];
}

- (NSString *)formatTailNumber:(NSString *)str
{
    return [str substringWithRange:NSMakeRange(str.length - 4, 4)];
}

#pragma mark TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_repayListInfo != nil) {
        return payLoanArry.count;
    }
    return 0;
}

/**
 *  @author dd
 *
 *  status: 1->已还   2->逾期   3->未来期   4->当期
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_repayListInfo != nil) {
            //红包和银行的cell
            if(indexPath.row == 4){
                PayMethodCell *cell=[tableView dequeueReusableCellWithIdentifier:@"paycell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.PayTitleLabel.text=payLoanArry[indexPath.row];
                cell.whichBank.text = @"";
                if (_selectCard != nil) {
                    cell.whichBank.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_selectCard.bankName,[self formatTailNumber:_selectCard.cardNo]];
                }
                return cell;
            } else//溢缴金额和应付金额cell
            {
                PayMoneyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
                if(indexPath.row==0)    //红包
                {
                    cell.payLabel.text = discountNumStr;
                    
                    if ([discountUsageStatus isEqualToString:@"0"]) {
                        _canUseReadPacket = true;
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                    }else{
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    
//                    if (_repayListInfo != nil) {
//                        int y = 0;  //逾期
//                        int w = 0;  //未来
//                        int d = 0;  //当期
//                        for (int i = 0; i < _situations.count; i++) {
//                            if ([[_situations objectAtIndex:i].status_ isEqualToString:@"2"]) {
//                                y++;
//                            } else if ([[_situations objectAtIndex:i].status_ isEqualToString:@"3"]) {
//                                w++;
//                            } else  {
//                                d++;
//                            }
//                        }
//                        if (y > 0) {
//                            cell.payLabel.text=@"您已逾期，不可使用券";
//                            _canUseReadPacket = false;
//                            cell.payLabel.textColor=rgb(255, 134, 25);
//                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                        }else{
//                            if (d > 0) {
//                                _canUseReadPacket = true;
//                                cell.payLabel.text = discountNumStr;
//                                cell.payLabel.textColor=rgb(255, 134, 25);
//                                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
//                            }else {
//                                if (w > 0) {
//                                    cell.payLabel.text=@"您当前结清，不可使用券";
//                                    _canUseReadPacket = false;
//                                    cell.payLabel.textColor=rgb(255, 134, 25);
//                                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                                }
//                            }
//                        }
//                    }
                }
                else if(indexPath.row == 1 ){//逾期费用
                    cell.payLabel.text = [NSString stringWithFormat:@"%.2f元",_debtOverdueTotal];
                }else if (indexPath.row == 2){//溢缴金额
                    cell.payLabel.text = [NSString stringWithFormat:@"-%.2f元",_useTotalAmount];
                }else{                //应付金额
                    cell.payLabel.text = [NSString stringWithFormat:@"%.2f元",_finalyRepayAmount];
                }
                cell.lblTitle.text=payLoanArry[indexPath.row];
                return cell;
            }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0){//红包
        if (_canUseReadPacket) {
            DLog(@"红包");
            if (discountTM.canuselist.count > 0) {
                [self showChooseAmountView];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前没有可用券"];
            }
        }
    }
    if(indexPath.row==4)//选择银行卡
    {
        if (_repayListInfo != nil) {
            [self pushUserBankListVC];
        }
    }
}
/**
 跳转到银行卡
 */
-(void)pushUserBankListVC{
    
    UserBankCardListVCModule * userBankCardListVC = [[UserBankCardListVCModule alloc]init];
    if (userSelectIndex == -1) {
        userBankCardListVC.currentIndex = defaultBankIndex;
    } else {
        userBankCardListVC.currentIndex  = userSelectIndex;
    }
    userBankCardListVC.applicationId = _applicationId;
    userBankCardListVC.payPatternSelectBlock = ^(CardInfo *cardInfo, NSInteger currentIndex) {
        _selectCard = cardInfo;
        if (cardInfo == nil) {
            [self  fatchUserCardList];
        }
        userSelectIndex = currentIndex;
        [self.PayDetailTB reloadData];
    };
    [self.navigationController pushViewController:userBankCardListVC animated:true];
}
#pragma mark - 抵扣券，折扣券模块
/**
 红包选择
 */
-(void)showChooseAmountView{
    
    DiscountCouponListVCModules *discountCouponVC = [[DiscountCouponListVCModules alloc]init];
    discountCouponVC.dataListArr = discountTM.canuselist;
    discountCouponVC.currentIndex = [NSString stringWithFormat:@"%ld",chooseIndex];
    discountCouponVC.displayType = @"3";
    discountCouponVC.view.frame = CGRectMake(0, 0, _k_w, _k_h * 0.6);
    __weak typeof (self) weakSelf = self;
    discountCouponVC.chooseDiscountTicket = ^(NSInteger index, DiscountTicketDetailModel * discountTicketDetailModel, NSString * str) {
        chooseIndex = index;
        chooseDiscountTDM = discountTicketDetailModel;
        if (index != 0) {
            [weakSelf eductibleAmountfDiscount:^(PaymentDetailAmountInfoModel *  paymentDetailInfo) {
                [weakSelf chooseDiscountAmountCalculate:paymentDetailInfo.redPacketRepayAmount discountTicketDetailModel:discountTicketDetailModel];
            }];
        }else{
            //不使用优惠券
            _selectRedPacketID = nil;
            _useredPacketAmount = 0.0;
//            if (_repayListInfo.total_amount_ > 0) {
//                _finalyRepayAmount = (_repayAmount - [_repayListInfo.total_amount_ floatValue]) > 0  ? (_repayAmount - [_repayListInfo.total_amount_ floatValue]) : 0 ;
//                _useTotalAmount = (_repayAmount - [_repayListInfo.total_amount_ floatValue])  > 0 ? [_repayListInfo.total_amount_ floatValue] :  _repayAmount;
//            }
            discountNumStr = @"有可用券";
        }
        [weakSelf.PayDetailTB reloadData];
    };
    [self presentSemiViewController:discountCouponVC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)} completion:nil dismissBlock:^{
    }];
}

/**
 获取抵扣券，折扣券数据
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
    [applicationVM new_obtainUserDiscountTicketListDisplayType:@"3" product_id:nil pageNum:nil pageSize:nil];
}
/**
 获取抵扣金额

 @param finish 结果回调
 */
-(void)eductibleAmountfDiscount:(void(^)(PaymentDetailAmountInfoModel *  paymentDetailInfo))finish{
    PaymentViewModel * paymentViewModel = [[PaymentViewModel alloc]init];
    [paymentViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultModel = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultModel.errCode isEqualToString:@"0"]) {
            //得到实际抵扣金额；
            PaymentDetailAmountInfoModel *  paymentDetailAIM = [[PaymentDetailAmountInfoModel alloc]initWithDictionary:(NSDictionary *)baseResultModel.data error:nil];
            _useTotalAmount = paymentDetailAIM.overpaidAmount.floatValue;
            _finalyRepayAmount = paymentDetailAIM.payAmount.floatValue;
            _debtOverdueTotal = paymentDetailAIM.debtOverdueTotal.floatValue;
            discountUsageStatus = paymentDetailAIM.couponUsageStatus;
//            discountNumStr = paymentDetailAIM.couponUsageDesc;
            self.repayAmount = paymentDetailAIM.repayTotal.floatValue;
            finish(paymentDetailAIM);
        }else {
            finish(nil);
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultModel.friendErrMsg];
        }
    } WithFaileBlock:^{
        finish(nil);
    }];
    [paymentViewModel obtaineductibleAmountfDiscount:chooseDiscountTDM.base_id stagingIds:[[self obtainRepayStaging_ids] copy]];
}

/**
  选择红包逻辑计算

 @param discountAmount 抵扣金额
 @param discountTicketDetailModel 选择红包数据
 */
-(void)chooseDiscountAmountCalculate:(NSString *)discountAmount  discountTicketDetailModel:(DiscountTicketDetailModel * )discountTicketDetailModel{
    
    _selectRedPacketID = discountTicketDetailModel.base_id;
    _useredPacketAmount = [discountAmount floatValue];
    
    if ([discountTicketDetailModel.voucher_type isEqualToString:@"1"]) {
        discountNumStr = [NSString stringWithFormat:@"抵扣%@元",discountAmount];
    }else if ([discountTicketDetailModel.voucher_type isEqualToString:@"3"]) {
        discountNumStr = [NSString stringWithFormat:@"折扣%@元",discountAmount];
    }
    
//    if ([_repayListInfo.total_amount_ floatValue] >= (_repayAmount - _useredPacketAmount)) {
//        _useTotalAmount = fabs(_repayAmount - _useredPacketAmount);
//        _finalyRepayAmount = 0.0;
//    } else {
//        _useTotalAmount = [_repayListInfo.total_amount_ floatValue];
//        _finalyRepayAmount = _repayAmount - _useredPacketAmount - [_repayListInfo.total_amount_ floatValue];
//    }
    [self.PayDetailTB reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView *subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark  确定按钮
- (IBAction)btnSureClick:(UIButton *)sender {
    DLog(@"确定按钮");
    if (_repayListInfo == nil) {
        return;
    }
//    [self fxdRepay];
    [self getInfo];
}

/**
 获取还款期数id

 @return 期数id
 */
-(NSMutableString *)obtainRepayStaging_ids{
    
    NSMutableString *staging_ids = [NSMutableString string];
    for (int i = 0; i < _situations.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@,",[_situations objectAtIndex:i].staging_id_];
        [staging_ids appendString:str];
    }
    [staging_ids deleteCharactersInRange:NSMakeRange(staging_ids.length - 1, 1)];
    
    return staging_ids;
}

- (void)fxdRepay
{
    self.sureBtn.enabled = NO;
    NSMutableString *staging_ids = [self obtainRepayStaging_ids];
    NSDictionary *paramDic;
    NSString *save_amountTemp;
    if (_repayType == RepayTypeClean) {
        save_amountTemp = @"1";
    } else {
        save_amountTemp = @"0";
    }
    PaymentDetailModel *  paymentDetailModel = [[PaymentDetailModel alloc]init];
    
    if (_useredPacketAmount > 0) {
        paymentDetailModel.staging_ids_ =staging_ids;
        paymentDetailModel.account_card_id_ =_selectCard.cardId;
        paymentDetailModel.total_amount_ = @(_useTotalAmount);    //溢缴金
        paymentDetailModel.repay_amount_ = @(_finalyRepayAmount);   //应还金额
        paymentDetailModel.repay_total_ = @(_repayAmount);           //实际金额
        paymentDetailModel.save_amount_ = @(_save_amount);        //前端全选时节省的未还服务费
        paymentDetailModel.socket = _repayListInfo.socket_;     //还款标示
        paymentDetailModel.request_type_ = save_amountTemp;      //请求类型
        paymentDetailModel.redpacket_id_ = _selectRedPacketID;
        paymentDetailModel.redpacket_cash_ = @(_useredPacketAmount);
    }else {
        paymentDetailModel.staging_ids_ =staging_ids;
        paymentDetailModel.account_card_id_ =_selectCard.cardId;
        paymentDetailModel.total_amount_ = @(_useTotalAmount);
        paymentDetailModel.repay_amount_ = @(_finalyRepayAmount);
        paymentDetailModel.repay_total_ = @(_repayAmount);
        paymentDetailModel.save_amount_ = @(_save_amount);
        paymentDetailModel.socket = _repayListInfo.socket_;
        paymentDetailModel.request_type_ = save_amountTemp;
    }
    
    PaymentViewModel * paymentViewModel = [[PaymentViewModel alloc]init];
    [paymentViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultModel = returnValue;
        if ([baseResultModel.errCode isEqualToString:@"0"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultModel.friendErrMsg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else {
            self.sureBtn.enabled = YES;
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultModel.friendErrMsg];
        }
    } WithFaileBlock:^{
        self.sureBtn.enabled = YES;
    }];
    [paymentViewModel FXDpaymentDetail:paymentDetailModel];
}

-(void)getInfo{
    BankCardAuthorizationViewModel *bankCardAuthorizationVM = [[BankCardAuthorizationViewModel alloc]init];
    [bankCardAuthorizationVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            BankCardAuthorizationModel * model = [[BankCardAuthorizationModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            if (model.authList.count > 0) {
                FXD_WithholdAuthViewController *controller = [[FXD_WithholdAuthViewController alloc]init];
                controller.bankName = _selectCard.bankName;
                controller.cardNum = _selectCard.cardNo;
                controller.telNum = _selectCard.bankPhone;
                controller.bankCode = _selectCard.cardShortName;
                controller.bankShortName = _selectCard.bankName;
                controller.requestType = @"";
                controller.applicationId = _applicationId;
                controller.type = Enum_queryRepay;
                [self.navigationController pushViewController:controller animated:true];
                
            }else{
                [self fxdRepay];
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
        
        
    } WithFaileBlock:^{
        
    }];
    [bankCardAuthorizationVM cardAuthQueryBankShortName:_selectCard.cardShortName cardNo:_selectCard.cardNo type:@"2"];
}


@end
