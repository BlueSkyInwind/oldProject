 //
//  RepayDetailViewController.m
//  fxdProduct
//
//  Created by zy on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "RepayDetailViewController.h"
#import "PayMoneyCell.h"
#import "PayMethodCell.h"
#import "UILabel+FlickerNumber.h"
#import "UIViewController+KNSemiModal.h"
#import "SelectTableViewController.h"
#import "PayNavigationViewController.h"
#import "PayMethodViewController.h"
#import "CardInfo.h"
#import "UserCardResult.h"
#import "BankModel.h"
#import "RepayListInfo.h"
#import "P2PBillDetail.h"
#import "P2PAccountInfo.h"
#import "PaymentServiceModel.h"
#import "AccountHSServiceModel.h"
#import "P2PViewController.h"
#import "PayViewController.h"
#import "QueryCardInfo.h"
#import "UnbundlingBankCardViewController.h"
#import "QryUserStatusModel.h"
#import "CheckViewModel.h"
#import "SaveLoanCaseModel.h"
#import "HomeViewModel.h"
#import "UserStateModel.h"
#import "PayVerificationCodeCell.h"
#import "PayDisplayCell.h"
#import "PaymentViewModel.h"
#import "PaymentDetailModel.h"
#import "BaseResultModel.h"
#import "HGBankListModel.h"
#import "SupportBankList.h"

@interface RepayDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SelectViewDelegate>
{
    UIImageView*navBarHairlineImageView;
    NSArray *titleAry;
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
    
    //溢缴金
    CGFloat _useTotalAmount;
    
    P2PAccountInfo *_p2pAccountInfo;
    
    //空白展位视图
    UIView *noneView;
    
    //银行卡名称
    NSString *_patternName;
    // 银行卡尾数号
    NSString *_bankNo;
    
    QueryCardInfo *_queryCardInfoModel;
    
    QryUserStatusModel *_userStatusModel;
    
    NSString *verfiyCode;
    NSString *smsSeq;

    
}
@property (nonatomic,strong) UILabel *lblShouldrepay;
@end
@implementation RepayDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    navBarHairlineImageView.hidden=YES;

}

-(void)viewWillDisappear:(BOOL)animated
{
    navBarHairlineImageView.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付详情";
    if (@available(iOS 11.0, *)) {
        self.PayDetailTB.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    defaultBankIndex = -1;
    userSelectIndex = 0;
    _useTotalAmount = 0.0;
    _selectRedPacket = 0.0;
    _useredPacketAmount = 0.0;
    _canUseReadPacket = false;
    _finalyRepayAmount = _repayAmount;
    
    navBarHairlineImageView= [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.PayDetailTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.PayDetailTB registerNib:[UINib nibWithNibName:@"PayMoneyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.PayDetailTB registerNib:[UINib nibWithNibName:@"PayMethodCell" bundle:nil] forCellReuseIdentifier:@"paycell"];
    [self.PayDetailTB registerNib:[UINib nibWithNibName:@"PayVerificationCodeCell" bundle:nil] forCellReuseIdentifier:@"PayVerificationCodeCell"];
    [self.PayDetailTB registerNib:[UINib nibWithNibName:@"PayDisplayCell" bundle:nil] forCellReuseIdentifier:@"PayDisplayCell"];

    if ([self.platform_Type isEqualToString:@"2"]) {
        titleAry = @[@"使用红包",@"使用溢缴金额",@"实扣金额",@"支付方式",@"验证码",@"提示语"];
    }else{
        titleAry = @[@"使用红包",@"使用溢缴金额",@"实扣金额",@"支付方式"];
    }
    payLoanArry = @[@"使用红包",@"逾期费用",@"使用溢缴金额",@"实扣金额",@"支付方式"];
    self.PayDetailTB.bounces=NO;
    [Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
    [self createHeaderView];
    
    if (_isPopRoot) {
        [self addBackItemRoot];
    }else{
        [self addBackItem];
    }
    
    [self createNoneView];
    [self updateTotalAmount];
    
    //    [self checkStatus];
    if ([self.platform_Type isEqualToString:@"2"]) {
        //合规银行卡查询
        [self checkBank];
    }else{
        [self fatchUserCardList];
    }
}

-(void)createHeaderView
{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 200)];
    header.backgroundColor=[UIColor redColor];
    header.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation"]];
    
#pragma mark 这个是顶部的还款金额 应该是请求完数据后
    self.lblShouldrepay=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    _lblShouldrepay.center=CGPointMake(_k_w/2, 200-20-30);
    //    _lblShouldrepay.text=@"937.66";
    
//    NSNumber *number;
//    if ([_product_id isEqualToString:@"P001002"]) {
//        number = [NSNumber numberWithFloat:_repayAmount];
//    }
//    if ([_product_id isEqualToString:@"P001004"]) {
//        number = [NSNumber numberWithFloat:_repayListInfo.result.repayment_amount];
//    }
    
    NSNumber *number = [NSNumber numberWithFloat:_repayAmount];
    [_lblShouldrepay fn_setNumber:number format:@"%.2f"];
    _lblShouldrepay.textColor=[UIColor whiteColor];
    _lblShouldrepay.textAlignment=NSTextAlignmentCenter;
    _lblShouldrepay.font = [UIFont fontWithName:@"ArialMT" size:45];
    [header addSubview:_lblShouldrepay];
    
    UILabel *lblRepayTip=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
    lblRepayTip.center=CGPointMake(_k_w/2, 200-30-40-25);
    lblRepayTip.textColor=[UIColor whiteColor];
    lblRepayTip.text=@"应还总金额(元)";
    lblRepayTip.alpha=0.7;
    lblRepayTip.textAlignment=NSTextAlignmentCenter;
    [header addSubview:lblRepayTip];
    
    self.PayDetailTB.tableHeaderView = header;
    self.PayDetailTB.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    [bankInfoVM obtainUserBankCardList];
    
}

- (NSString *)formatTailNumber:(NSString *)str
{
    return [str substringWithRange:NSMakeRange(str.length - 4, 4)];
}

- (void)updateTotalAmount
{
    if (_repayListInfo != nil) {
        if (_repayListInfo.result.total_amount > 0) {
            if (_repayListInfo.result.total_amount <= _repayAmount) {
                _useTotalAmount = _repayListInfo.result.total_amount;
                _finalyRepayAmount = _repayAmount - _repayListInfo.result.total_amount;
            } else {
                _useTotalAmount = _repayAmount;
                _finalyRepayAmount = 0.0;
            }
        }
    }else {
        if ([_product_id isEqualToString:RapidLoan] || [_product_id isEqualToString:DeriveRapidLoan]) {
            noneView.hidden = false;
        }
    }
    [self.PayDetailTB reloadData];
}

#pragma mark TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLog(@"%@",_product_id);
    if (_repayListInfo != nil) {
        if ([_product_id isEqualToString:RapidLoan] || [_product_id isEqualToString:DeriveRapidLoan] ){
            return payLoanArry.count;
        }else {
            return titleAry.count;
        }
    }
    //合规通道弃用
    if (_p2pBillModel != nil) {
        return 4;
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
        if ([_product_id isEqualToString:SalaryLoan]||[_product_id isEqualToString:WhiteCollarLoan]) {
            
            //合规发送验证码
            if (indexPath.row== 4) {
                PayVerificationCodeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PayVerificationCodeCell"];
                cell.titleLabel.text = titleAry[indexPath.row];
                cell.cardNum = _queryCardInfoModel.result.UsrCardInfolist.CardId;
                cell.phoneNum = _queryCardInfoModel.result.UsrCardInfolist.BindMobile;
                cell.userVerfiyCode = ^(NSString *str, NSString *seqStr) {
                    verfiyCode = str;
                    smsSeq = seqStr;
                };
                return cell;
            }
            
            //合规验证码提示
            if (indexPath.row== 5) {
                PayDisplayCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PayDisplayCell"];
                [cell setDispalyLabeltext:_queryCardInfoModel.result.UsrCardInfolist.BindMobile];
                return cell;
            }
            
            //红包和银行的cell
            if(indexPath.row==3){
                PayMethodCell *cell=[tableView dequeueReusableCellWithIdentifier:@"paycell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.PayTitleLabel.text=titleAry[indexPath.row];
                
                if ([self.platform_Type isEqualToString:@"2"]) {
                    if ([_queryCardInfoModel.result.UsrCardInfolist.BankId isEqualToString:@""]) {
                        cell.whichBank.text = @"请更换银行卡";
                    }else{
                        cell.whichBank.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_queryCardInfoModel.result.UsrCardInfolist.bankName,[_queryCardInfoModel.result.UsrCardInfolist.CardId substringFromIndex:_queryCardInfoModel.result.UsrCardInfolist.CardId.length-4]];
                    }
                }else{
                    cell.whichBank.text = @"";
                    if (_selectCard != nil) {
                        cell.whichBank.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_selectCard.bankName,[self formatTailNumber:_selectCard.cardNo]];
                    }
                }
                return cell;
            }
            else//溢缴金额和应付金额cell
            {
                PayMoneyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
                if(indexPath.row==0)    //红包
                {
                    if (_repayListInfo != nil) {
                        int y = 0;  //逾期
                        int w = 0;  //未来
                        int d = 0;  //当期
                        for (int i = 0; i < _situations.count; i++) {
                            if ([[_situations objectAtIndex:i].status isEqualToString:@"2"]) {
                                y++;
                            } else if ([[_situations objectAtIndex:i].status isEqualToString:@"3"]) {
                                w++;
                            } else  {
                                d++;
                            }
                        }
                        
                        if (y > 0) {
                            cell.payLabel.text=@"您已逾期，不可使用红包";
                            _canUseReadPacket = false;
                            cell.payLabel.textColor=rgb(255, 134, 25);
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        }else{
                            if (d > 0) {
                                _canUseReadPacket = true;
                                if (_selectRedPacket > 0) {
                                    cell.payLabel.text = [NSString stringWithFormat:@"-%.2f元",_useredPacketAmount];
                                    cell.payLabel.textColor=rgb(255, 134, 25);
                                }else {
                                    Situations *currentSituation = nil;
                                    for (Situations *situation in _situations) {
                                        if ([situation.status isEqualToString:@"4"]) {
                                            currentSituation = situation;
                                        }
                                    }
                                    if (currentSituation) {
                                        if (currentSituation.debt_service_fee > 0) {
                                            cell.payLabel.text = @"请选择";
                                            cell.payLabel.textColor = [UIColor grayColor];
                                        } else {
                                            cell.payLabel.text=@"不可用";
                                            _canUseReadPacket = false;
                                            cell.payLabel.textColor=rgb(255, 134, 25);
                                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                                        }
                                    }
                                }
                                // cell.accessoryType = UITableViewCellAccessoryNone;
                                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                            } else {
                                if (w > 0) {
                                    cell.payLabel.text=@"不可用";
                                    _canUseReadPacket = false;
                                    cell.payLabel.textColor=rgb(255, 134, 25);
                                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                                }
                            }
                        }
                    }
                }
                else if(indexPath.row==1){//溢缴金额
                    cell.payLabel.text = [NSString stringWithFormat:@"-%.2f元",_useTotalAmount];
                }
                else if(indexPath.row == 2){                //应付金额
                    cell.payLabel.text = [NSString stringWithFormat:@"%.2f元",_finalyRepayAmount];
                }
                cell.lblTitle.text=titleAry[indexPath.row];
                return cell;
            }
        } else {
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
                    if (_repayListInfo != nil) {
                        int y = 0;  //逾期
                        int w = 0;  //未来
                        int d = 0;  //当期
                        for (int i = 0; i < _situations.count; i++) {
                            if ([[_situations objectAtIndex:i].status isEqualToString:@"2"]) {
                                y++;
                            } else if ([[_situations objectAtIndex:i].status isEqualToString:@"3"]) {
                                w++;
                            } else  {
                                d++;
                            }
                        }
                        if (y > 0) {
                            cell.payLabel.text=@"您已逾期，不可使用红包";
                            _canUseReadPacket = false;
                            cell.payLabel.textColor=rgb(255, 134, 25);
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        }else{
                            if (d > 0) {
                                _canUseReadPacket = true;
                                if (_selectRedPacket > 0) {
                                    cell.payLabel.text = [NSString stringWithFormat:@"-%.2f元",_useredPacketAmount];
                                    cell.payLabel.textColor=rgb(255, 134, 25);
                                }else {
                                    Situations *currentSituation = nil;
                                    for (Situations *situation in _situations) {
                                        if ([situation.status isEqualToString:@"4"]) {
                                            currentSituation = situation;
                                        }
                                    }
                                    if (currentSituation) {
                                        cell.payLabel.text = @"请选择";
                                        cell.payLabel.textColor = [UIColor grayColor];
                                    }
                                }
                                //            cell.accessoryType = UITableViewCellAccessoryNone;
                                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                            }else {
                                if (w > 0) {
                                    cell.payLabel.text=@"不可用";
                                    _canUseReadPacket = false;
                                    cell.payLabel.textColor=rgb(255, 134, 25);
                                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                                }
                            }
                        }
                    }
                }
                else if(indexPath.row == 1 ){//逾期费用
                    cell.payLabel.text = [NSString stringWithFormat:@"%.2f元",_repayListInfo.result.overdue_total_];
                }else if (indexPath.row == 2){//溢缴金额
                    cell.payLabel.text = [NSString stringWithFormat:@"-%.2f元",_useTotalAmount];
                }else{                //应付金额
                    cell.payLabel.text = [NSString stringWithFormat:@"%.2f元",_finalyRepayAmount];
                }
                cell.lblTitle.text=payLoanArry[indexPath.row];
                return cell;
            }
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
    if ([_product_id isEqualToString:SalaryLoan]||[_product_id isEqualToString:WhiteCollarLoan]) {
        if(indexPath.row==0){//红包
            if (_canUseReadPacket) {
                DLog(@"红包");
                if (_repayListInfo.result.available_redpackets.count > 0) {
                    SelectTableViewController *selectVC = [[SelectTableViewController alloc] initWithStyle:UITableViewStylePlain];
                    selectVC.delegate = self;
                    [selectVC setData:_repayListInfo.result.available_redpackets];
                    [self presentSemiViewController:selectVC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)} completion:nil dismissBlock:^{
                    }];
                } else {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前没有可用红包"];
                }
            }
        }
        if(indexPath.row==3)//选择银行卡
        {
            if ([self.platform_Type isEqualToString:@"2"]) {
                [self gotoUnbundlingBank];
                return;
            }
            
            if (_repayListInfo != nil) {
                [self pushUserBankListVC];
            }
        }
    }else {
        if(indexPath.row==0){//红包
            if (_canUseReadPacket) {
                DLog(@"红包");
                if (_repayListInfo.result.available_redpackets.count > 0) {
                    SelectTableViewController *selectVC = [[SelectTableViewController alloc] initWithStyle:UITableViewStylePlain];
                    selectVC.delegate = self;
                    [selectVC setData:_repayListInfo.result.available_redpackets];
                    [self presentSemiViewController:selectVC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)} completion:nil dismissBlock:^{
                    }];
                } else {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前没有可用红包"];
                }
            }
        }
        if (indexPath.row==3) {
            if (_p2pBillModel != nil) {
                [self gotoUnbundlingBank];
            }
        }
        if(indexPath.row==4)//选择银行卡
        {
            if (_repayListInfo != nil) {
                [self pushUserBankListVC];
            }
            if (_p2pBillModel != nil) {
                [self gotoUnbundlingBank];
            }
        }
    }
}
/**
 跳转到银行卡
 */
-(void)pushUserBankListVC{
    
    UserBankCardListViewController * userBankCardListVC = [[UserBankCardListViewController alloc]init];
    if (userSelectIndex == -1) {
        userBankCardListVC.currentIndex = defaultBankIndex;
    } else {
        userBankCardListVC.currentIndex  = userSelectIndex;
    }
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
#pragma mark - selectVCDelegate

/**
 红包选择完成后金额的计算
 
 @param index 所选红包标识
 */
- (void)selectIndex:(NSInteger)index
{
    [self dismissSemiModalViewWithCompletion:^{
        Available_Redpackets *redPacket = [_repayListInfo.result.available_redpackets objectAtIndex:index];
        _selectRedPacket = redPacket.residual_amount;   //所选红包金额
        _selectRedPacketID = redPacket.RedpacketID;     //红包id
        _finalyRepayAmount = _repayAmount - _repayListInfo.result.situations.firstObject.debt_service_fee;
        // 折扣金额
        CGFloat _discountsAmount = 0;   // 红包 或者 利息
        _useredPacketAmount = _selectRedPacket;
        _discountsAmount = _selectRedPacket;
        
        // 红包小于第一期，使用红包
        if (_selectRedPacket <= _repayListInfo.result.situations.firstObject.debt_total) {
            _useredPacketAmount = _selectRedPacket;
            _discountsAmount = _selectRedPacket;
        } else {
             // 红包大于第一期，使用服务费
            _useredPacketAmount = _repayListInfo.result.situations.firstObject.debt_total;
            _discountsAmount = _repayListInfo.result.situations.firstObject.debt_total;
        }
    
        if ([_product_id isEqualToString:RapidLoan] || [_product_id isEqualToString:DeriveRapidLoan]) {
            //急速贷没有服务费，直接拿本金减红包
            _finalyRepayAmount = _repayAmount;
        }
        
        // 溢缴金  大于  本金减折息金额
        if (_repayListInfo.result.total_amount >= (_repayAmount - _discountsAmount)) {
            _useTotalAmount = fabs(_repayAmount - _discountsAmount);
            _finalyRepayAmount = 0.0;
        } else {
            _useTotalAmount = _repayListInfo.result.total_amount;
            _finalyRepayAmount = _repayAmount - _discountsAmount - _repayListInfo.result.total_amount;
        }
        [self.PayDetailTB reloadData];
    }];
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
    if ([self.platform_Type isEqualToString:@"2"] ) {        
        [self getMoney];
    }else{
        [self fxdRepay];
    }
}

/**
 获取还款期数id

 @return 期数id
 */
-(NSMutableString *)obtainRepayStaging_ids{
    
    NSMutableString *staging_ids = [NSMutableString string];
    for (int i = 0; i < _situations.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@,",[_situations objectAtIndex:i].staging_id];
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
        paymentDetailModel.total_amount_ = @(_useTotalAmount);
        paymentDetailModel.repay_amount_ = @(_finalyRepayAmount);
        paymentDetailModel.repay_total_ = @(_repayAmount);
        paymentDetailModel.save_amount_ = @(_save_amount);
        paymentDetailModel.socket = _repayListInfo.result.socket;
        paymentDetailModel.request_type_ = save_amountTemp;
        paymentDetailModel.redpacket_id_ = _selectRedPacketID;
        paymentDetailModel.redpacket_cash_ = @(_useredPacketAmount);
    }else {
        paymentDetailModel.staging_ids_ =staging_ids;
        paymentDetailModel.account_card_id_ =_selectCard.cardId;
        paymentDetailModel.total_amount_ = @(_useTotalAmount);
        paymentDetailModel.repay_amount_ = @(_finalyRepayAmount);
        paymentDetailModel.repay_total_ = @(_repayAmount);
        paymentDetailModel.save_amount_ = @(_save_amount);
        paymentDetailModel.socket = _repayListInfo.result.socket;
        paymentDetailModel.request_type_ = save_amountTemp;
    }
    
    //合规的还款增加两个参数
    if ([self.platform_Type isEqualToString:@"2"]) {
        if (!smsSeq) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的验证码"];
            return;
        }
        if (!verfiyCode || [verfiyCode isEqualToString:@""]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的验证码"];
            return;
        }
        paymentDetailModel.sms_code_ =  verfiyCode;
        paymentDetailModel.sms_seq_ = smsSeq;
        paymentDetailModel.account_card_id_ =_queryCardInfoModel.result.accountCardId;
    }
    PaymentViewModel * paymentViewModel = [[PaymentViewModel alloc]init];
    [paymentViewModel setBlockWithReturnBlock:^(id returnValue) {
        DLog(@"%@",returnValue[@"msg"]);
        BaseResultModel * baseResultModel = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultModel.flag isEqualToString:@"0000"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultModel.msg];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else {
            self.sureBtn.enabled = YES;
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultModel.msg];
        }
    } WithFaileBlock:^{
        self.sureBtn.enabled = YES;
    }];
    [paymentViewModel FXDpaymentDetail:paymentDetailModel];
}

#pragma mark 正常扣款
- (void)repaySure
{
    NSDictionary *dic = @{@"bill_id_":_p2pBillModel.data.bill_id_,
                          @"bid_id_":_p2pBillModel.data.bid_id_,
                          @"amount_":[NSString stringWithFormat:@"%.2f",_finalyRepayAmount],
                          @"method_":@"doPay",
                          @"max_bill_date_":[Tool dateToFormatString:_bills.lastObject.bill_date_],
                          @"from_mobile_":[Utility sharedUtility].userInfo.userMobilePhone};
    NSString *url = [NSString stringWithFormat:@"%@%@",_P2P_url,_paymentService_url];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:dic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"appcode"] isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:[object objectForKey:@"appmsg"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"appmsg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

//#pragma mark P2P结清  全部还款
- (void)paySettle
{

    NSDictionary *dic = @{@"bill_id_":_p2pBillModel.data.bill_id_,
                          @"bid_id_":_p2pBillModel.data.bid_id_,
                          @"amount_":[NSString stringWithFormat:@"%.2f",_finalyRepayAmount],
                          @"method_":@"doSettle",
                          @"max_bill_date_":[Tool dateToFormatString:_bills.lastObject.bill_date_],
                          @"from_mobile_":[Utility sharedUtility].userInfo.userMobilePhone};
    
    NSString *url = [NSString stringWithFormat:@"%@%@",_P2P_url,_paymentService_url];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:dic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"appcode"] isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:[object objectForKey:@"appmsg"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:[object objectForKey:@"appmsg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

#pragma mark 查询用户状态

-(void)getMoney{
    
    [self getUserStatus:self.applicationID success:^(QryUserStatusModel *_model) {
        if ([_model.result.flg isEqualToString:@"2"]) {//未开户
            
        }else if ([_model.result.flg isEqualToString:@"3"]){//待激活
            NSString *url = [NSString stringWithFormat:@"%@%@?page_type_=%@&ret_url_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"1",_transition_url,[Utility sharedUtility].userInfo.userMobilePhone];
            P2PViewController *p2pVC = [[P2PViewController alloc] init];
            p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            p2pVC.applicationId = self.applicationID;
            [self.navigationController pushViewController:p2pVC animated:YES];
        }else if ([_model.result.flg isEqualToString:@"6"]){//正常用户
            [self fxdRepay];
        }
    }];
}

#pragma mark 跳转到解绑银行卡页面
-(void)gotoUnbundlingBank{
    
    UnbundlingBankCardViewController *controller = [[UnbundlingBankCardViewController alloc]initWithNibName:@"UnbundlingBankCardViewController" bundle:nil];
    controller.queryCardInfo = _queryCardInfoModel;
    controller.isCheck = NO;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark  银行卡查询
-(void)checkBank{

    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
//        NSArray *array = @[@"BOC",@"ICBC",@"CCB",@"ABC",@"CITIC",@"CIB",@"CEB"];
        QueryCardInfo *model = [QueryCardInfo yy_modelWithJSON:returnValue];
        if ([model.flag isEqualToString:@"0000"]) {
            _queryCardInfoModel = model;
            [self obtain_HeGui_BankList:model];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel queryCardInfo];
}

-(void)obtain_HeGui_BankList:(QueryCardInfo *)infoModel{
    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseREsultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseREsultM.flag isEqualToString:@"0000"]) {
            BOOL isHave = NO;
            NSArray * array = (NSArray *)baseREsultM.result;
            for (NSDictionary *dic  in array) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:dic error:nil];
                if ([bankList.bank_short_name_ isEqualToString:infoModel.result.UsrCardInfolist.BankId]) {
                    isHave = YES;
                    break;
                }
            }
            if (!isHave) {
                _queryCardInfoModel.result.UsrCardInfolist.BankId = @"";
            }
            [self.PayDetailTB reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view  message:baseREsultM.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getSupportBankListInfo:@"4"];
}


#pragma mark  fxd用户状态查询，viewmodel
-(void)getUserStatus:(NSString  *)applicationId success:(void(^)(QryUserStatusModel *_model))finish{
    
    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        QryUserStatusModel *model = [QryUserStatusModel yy_modelWithJSON:returnValue];
        if ([model.result.appcode isEqualToString:@"1"]) {
            _userStatusModel = model;
            finish(model);
        }else{
            
        }
    } WithFaileBlock:^{
        
    }];
    [complianceViewModel getUserStatus:applicationId];
}


@end
