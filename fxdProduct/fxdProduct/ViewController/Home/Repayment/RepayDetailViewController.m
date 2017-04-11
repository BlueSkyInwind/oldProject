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
#import "P2PRepaySaveViewController.h"

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
    self.automaticallyAdjustsScrollViewInsets=NO;
    defaultBankIndex = -1;
    userSelectIndex = defaultBankIndex;
    _useTotalAmount = 0.0;
    _selectRedPacket = 0.0;
    _useredPacketAmount = 0.0;
    _canUseReadPacket = false;
    //    if ([_product_id isEqualToString:@"P001002"]) {
    //        _finalyRepayAmount = _repayAmount;
    //    }
    //    if ([_product_id isEqualToString:@"P001004"]) {
    //        _finalyRepayAmount = _repayAmount + _repayListInfo.result.overdue_total_;
    //    }
    _finalyRepayAmount = _repayAmount;
    
    navBarHairlineImageView= [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self.PayDetailTB registerNib:[UINib nibWithNibName:@"PayMoneyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.PayDetailTB registerNib:[UINib nibWithNibName:@"PayMethodCell" bundle:nil] forCellReuseIdentifier:@"paycell"];
    titleAry = @[@"使用红包",@"使用溢缴金额",@"实扣金额",@"支付方式"];
    payLoanArry = @[@"使用红包",@"逾期费用",@"使用溢缴金额",@"实扣金额",@"支付方式"];
    self.PayDetailTB.bounces=NO;
    
    [self createHeaderView];
    [self addBackItem];
    [self createNoneView];
    [self updateTotalAmount];
    
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
    [self fatchUserCardList];
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
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        _userCardsModel = [UserCardResult yy_modelWithJSON:object];
        if([_userCardsModel.flag isEqualToString:@"0000"]){
            for(NSInteger j=0;j<_userCardsModel.result.count;j++)
            {
                CardResult *cardResult = [_userCardsModel.result objectAtIndex:j];
                if([cardResult.card_type_ isEqualToString:@"2"])
                {
                    if ([cardResult.if_default_ isEqualToString:@"1"]) {
                        defaultBankIndex = j;
                        for (BankList *banlist in _bankModel.result) {
                            if ([cardResult.card_bank_ isEqualToString: banlist.code]) {
                                //                                _selectCard
                                CardInfo *cardInfo = [[CardInfo alloc] init];
                                cardInfo.tailNumber = [self formatTailNumber:cardResult.card_no_];
                                cardInfo.bankName = banlist.desc;
                                cardInfo.cardIdentifier = cardResult.id_;
                                _selectCard = cardInfo;
                            }
                        }
                        //                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
                        //                        [self.PayDetailTB reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        [self.PayDetailTB reloadData];
                    }
                }
            }
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardsModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
    }];
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
        if ([_product_id isEqualToString:@"P001004"]) {
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
        if ([_product_id isEqualToString:@"P001004"]){
            return payLoanArry.count;
        }else {
            return titleAry.count;
        }
        
    }
    
    if (_p2pBillModel != nil) {
        return 3;
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
        if ([_product_id isEqualToString:@"P001002"]) {
            //红包和银行的cell
            if(indexPath.row==3){
                PayMethodCell *cell=[tableView dequeueReusableCellWithIdentifier:@"paycell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.PayTitleLabel.text=titleAry[indexPath.row];
                if (_selectCard != nil) {
                    cell.whichBank.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_selectCard.bankName,_selectCard.tailNumber];
                }else {
                    cell.whichBank.text = @"";
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
                            //            cell.accessoryType = UITableViewCellAccessoryNone;
                            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                        }else {
                            if (y > 0) {
                                cell.payLabel.text=@"您已逾期，不可使用红包";
                                _canUseReadPacket = false;
                                cell.payLabel.textColor=rgb(255, 134, 25);
                                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            }
                            if (w > 0) {
                                cell.payLabel.text=@"不可用";
                                _canUseReadPacket = false;
                                cell.payLabel.textColor=rgb(255, 134, 25);
                                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            }
                        }
                    }
                    if (_p2pBillModel != nil) {
                        cell.payLabel.text=@"不可用";
                        _canUseReadPacket = false;
                        cell.payLabel.textColor=rgb(255, 134, 25);
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    if ([_product_id isEqualToString:@"P001004"]) {
                        cell.payLabel.text=@"不可用";
                        _canUseReadPacket = false;
                        cell.payLabel.textColor=rgb(255, 134, 25);
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                }
                else if(indexPath.row==1){//溢缴金额
                    cell.payLabel.text = [NSString stringWithFormat:@"-%.2f元",_useTotalAmount];
                }
                else{                //应付金额
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
                if (_selectCard != nil) {
                    cell.whichBank.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_selectCard.bankName,_selectCard.tailNumber];
                }else {
                    cell.whichBank.text = @"";
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
                            //            cell.accessoryType = UITableViewCellAccessoryNone;
                            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                        }else {
                            if (y > 0) {
                                cell.payLabel.text=@"您已逾期，不可使用红包";
                                _canUseReadPacket = false;
                                cell.payLabel.textColor=rgb(255, 134, 25);
                                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            }
                            if (w > 0) {
                                cell.payLabel.text=@"不可用";
                                _canUseReadPacket = false;
                                cell.payLabel.textColor=rgb(255, 134, 25);
                                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            }
                        }
                    }
                    if (_p2pBillModel != nil) {
                        cell.payLabel.text=@"不可用";
                        _canUseReadPacket = false;
                        cell.payLabel.textColor=rgb(255, 134, 25);
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    }
                    if ([_product_id isEqualToString:@"P001004"]) {
                        cell.payLabel.text=@"不可用";
                        _canUseReadPacket = false;
                        cell.payLabel.textColor=rgb(255, 134, 25);
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    if (_p2pBillModel != nil) {
        //红包和银行的cell
        if(indexPath.row==3){
            PayMethodCell *cell=[tableView dequeueReusableCellWithIdentifier:@"paycell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.PayTitleLabel.text=titleAry[indexPath.row];
            if (_selectCard != nil) {
                cell.whichBank.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_selectCard.bankName,_selectCard.tailNumber];
            }else {
                cell.whichBank.text = @"";
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
                        //            cell.accessoryType = UITableViewCellAccessoryNone;
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                    }else {
                        if (y > 0) {
                            cell.payLabel.text=@"您已逾期，不可使用红包";
                            _canUseReadPacket = false;
                            cell.payLabel.textColor=rgb(255, 134, 25);
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        }
                        if (w > 0) {
                            cell.payLabel.text=@"不可用";
                            _canUseReadPacket = false;
                            cell.payLabel.textColor=rgb(255, 134, 25);
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        }
                    }
                }
                if (_p2pBillModel != nil) {
                    cell.payLabel.text=@"不可用";
                    _canUseReadPacket = false;
                    cell.payLabel.textColor=rgb(255, 134, 25);
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if ([_product_id isEqualToString:@"P001004"]) {
                    cell.payLabel.text=@"不可用";
                    _canUseReadPacket = false;
                    cell.payLabel.textColor=rgb(255, 134, 25);
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
            }
            else if(indexPath.row==1){//溢缴金额
                cell.payLabel.text = [NSString stringWithFormat:@"-%.2f元",_useTotalAmount];
            }
            else{                //应付金额
                cell.payLabel.text = [NSString stringWithFormat:@"%.2f元",_finalyRepayAmount];
            }
            cell.lblTitle.text=titleAry[indexPath.row];
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
    if ([_product_id isEqualToString:@"P001002"]) {
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
            DLog(@"选择付款方式");
            PayMethodViewController *payMethodVC = [[PayMethodViewController alloc] init];
            payMethodVC.bankModel = _bankModel;
            payMethodVC.payMethod = PayMethodNormal;
            if (userSelectIndex == -1) {
                payMethodVC.currentIndex = defaultBankIndex;
            } else {
                payMethodVC.currentIndex  = userSelectIndex;
            }
            payMethodVC.bankSelectBlock = ^(CardInfo *cardInfo, NSInteger currentIndex){
                if (cardInfo) {
                    _selectCard = cardInfo;
                }
                userSelectIndex = currentIndex;
                [self.PayDetailTB reloadData];
            };
            PayNavigationViewController *payNC = [[PayNavigationViewController alloc] initWithRootViewController:payMethodVC];
            payNC.view.frame = CGRectMake(0, 0, _k_w, 270);
            [self presentSemiViewController:payNC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)}];
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
        if(indexPath.row==4)//选择银行卡
        {
            DLog(@"选择付款方式");
            PayMethodViewController *payMethodVC = [[PayMethodViewController alloc] init];
            payMethodVC.bankModel = _bankModel;
            payMethodVC.payMethod = PayMethodNormal;
            if (userSelectIndex == -1) {
                payMethodVC.currentIndex = defaultBankIndex;
            } else {
                payMethodVC.currentIndex  = userSelectIndex;
            }
            payMethodVC.bankSelectBlock = ^(CardInfo *cardInfo, NSInteger currentIndex){
                if (cardInfo) {
                    _selectCard = cardInfo;
                }
                userSelectIndex = currentIndex;
                [self.PayDetailTB reloadData];
            };
            PayNavigationViewController *payNC = [[PayNavigationViewController alloc] initWithRootViewController:payMethodVC];
            payNC.view.frame = CGRectMake(0, 0, _k_w, 270);
            [self presentSemiViewController:payNC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)}];
        }
    }
    
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
        _selectRedPacket = redPacket.residual_amount;
        _selectRedPacketID = redPacket.RedpacketID;
        
        _finalyRepayAmount = _repayAmount - _repayListInfo.result.situations.firstObject.debt_service_fee;
        if (_selectRedPacket <= _repayListInfo.result.situations.firstObject.debt_service_fee) {
            _useredPacketAmount = _selectRedPacket;
            if (_repayListInfo.result.total_amount >= (_repayAmount - _selectRedPacket)) {
                _useTotalAmount = fabs(_repayAmount - _selectRedPacket - _repayListInfo.result.total_amount);
                _finalyRepayAmount = 0.0;
            } else {
                _useTotalAmount = _repayListInfo.result.total_amount;
                _finalyRepayAmount = _repayAmount - _selectRedPacket - _repayListInfo.result.total_amount;
            }
        } else {
            _useredPacketAmount = _repayListInfo.result.situations.firstObject.debt_service_fee;
            if (_repayListInfo.result.total_amount >= (_repayAmount - _repayListInfo.result.situations.firstObject.debt_service_fee)) {
                _useTotalAmount = _repayAmount - _repayListInfo.result.situations.firstObject.debt_service_fee;
                _finalyRepayAmount = 0.0;
            } else {
                _useTotalAmount = _repayListInfo.result.total_amount;
                _finalyRepayAmount = _repayAmount - _repayListInfo.result.situations.firstObject.debt_service_fee - _repayListInfo.result.total_amount;
            }
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
    if (_repayListInfo != nil) {
        [self fxdRepay];
    }
    if (_p2pBillModel != nil) {
        
        if (_repayType == RepayTypeOption) {
            [self p2pRepay];
        } else {
            [self p2pRepayClean];
        }
    }
}

- (void)fxdRepay
{
    NSMutableString *staging_ids = [NSMutableString string];
    for (int i = 0; i < _situations.count; i++) {
        //        if ([_cellSelectArr objectAtIndex:i].boolValue) {
        NSString *str = [NSString stringWithFormat:@"%@,",[_situations objectAtIndex:i].staging_id];
        [staging_ids appendString:str];
        //        }
    }
    [staging_ids deleteCharactersInRange:NSMakeRange(staging_ids.length - 1, 1)];
    
    NSDictionary *paramDic;
    NSString *save_amountTemp;
    if (_repayType == RepayTypeClean) {
        save_amountTemp = @"1";
    } else {
        save_amountTemp = @"0";
    }
    
    if (_useredPacketAmount > 0) {
        paramDic = @{@"staging_ids_":staging_ids,
                     @"account_card_id_":_selectCard.cardIdentifier,
                     @"total_amount_":@(_repayListInfo.result.total_amount),
                     @"repay_amount_":@(_finalyRepayAmount),
                     @"repay_total_":@(_repayAmount),
                     @"save_amount_":@(_save_amount),
                     @"socket":_repayListInfo.result.socket,
                     @"request_type_":save_amountTemp,
                     @"redpacket_id_":_selectRedPacketID,
                     @"redpacket_cash_":@(_useredPacketAmount),
                     };
    }else {
        paramDic = @{@"staging_ids_":staging_ids,
                     @"account_card_id_":_selectCard.cardIdentifier,
                     @"total_amount_":@(_repayListInfo.result.total_amount),
                     @"repay_amount_":@(_finalyRepayAmount),
                     @"repay_total_":@(_repayAmount),
                     @"save_amount_":@(_save_amount),
                     @"socket":_repayListInfo.result.socket,
                     @"request_type_":save_amountTemp,
                     };
    }
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_RepayOrSettleWithPeriod_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object[@"msg"]);
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)p2pRepay
{
    //    _finalyRepayAmount
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_memberService_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:nil finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        _p2pAccountInfo = [P2PAccountInfo yy_modelWithJSON:object];
        if (_p2pAccountInfo.data.accountInfo.available_amount_ < _finalyRepayAmount) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"您的帐户余额不足,请充值"];
            NSString *url = [NSString stringWithFormat:@"%@%@?from_user_id_=%@&from_mobile_=%@&RetUrl=%@&amount_=%lf&PageType=1&GateBusiId=QP&bill_id_=%@&bid_id_=%@&repay_amount_=%.2f&max_bill_date_=%@&method_=doPay",_P2P_url,_netSave_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone,_rechargeing_url,_finalyRepayAmount -_p2pAccountInfo.data.accountInfo.available_amount_,_p2pBillModel.data.bill_id_,_p2pBillModel.data.bid_id_,_finalyRepayAmount,[Tool dateToFormatString:_bills.lastObject.bill_date_]];
            P2PRepaySaveViewController *p2pSaveVC = [[P2PRepaySaveViewController alloc] init];
            p2pSaveVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [self.navigationController pushViewController:p2pSaveVC animated:YES];
        } else {
            [self repaySure];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)repaySure
{
    NSDictionary *dic = @{@"bill_id_":_p2pBillModel.data.bill_id_,
                          @"bid_id_":_p2pBillModel.data.bid_id_,
                          @"repay_amount_":[NSString stringWithFormat:@"%.2f",_finalyRepayAmount],
                          @"max_bill_date_":[Tool dateToFormatString:_bills.lastObject.bill_date_]};
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_doPay_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:dic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"appcode"] isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"还款成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"appmsg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)p2pRepayClean
{
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_memberService_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:nil finished:^(EnumServerStatus status, id object) {
        _p2pAccountInfo = [P2PAccountInfo yy_modelWithJSON:object];
        [self cleanUserMoney];
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)cleanUserMoney
{
    if (_p2pAccountInfo.data.accountInfo.available_amount_ < _finalyRepayAmount) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"您的帐户余额不足,请充值"];
        NSString *url = [NSString stringWithFormat:@"%@%@?from_user_id_=%@&from_mobile_=%@&amount_=%f&PageType=1&RetUrl=%@&GateBusiId=QP&bid_id_=%@&bill_id_=%@&repay_amount_=%.2f&method_=doSettle",_P2P_url,_netSave_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone,_finalyRepayAmount - _p2pAccountInfo.data.accountInfo.available_amount_,_rechargeing_url,_p2pBillModel.data.bid_id_,_p2pBillModel.data.bill_id_,_finalyRepayAmount];
        P2PRepaySaveViewController *p2pSaveVC = [[P2PRepaySaveViewController alloc] init];
        p2pSaveVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.navigationController pushViewController:p2pSaveVC animated:YES];
    } else {
        [self paySettle];
    }
}

- (void)paySettle
{
    NSDictionary *dic = @{@"bill_id_":_p2pBillModel.data.bill_id_,
                          @"bid_id_":_p2pBillModel.data.bid_id_,
                          @"repay_amount_":[NSString stringWithFormat:@"%.2f",_finalyRepayAmount]};
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_doSettle_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:dic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"appcode"] isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"结清成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

@end
