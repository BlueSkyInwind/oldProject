//
//  DetailRepayViewController.m
//  fxdProduct
//
//  Created by dd on 16/9/1.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "DetailRepayViewController.h"
#import "DetailRepayHeader.h"
#import "RepayListCell.h"
#import "RepayDetailViewController.h"
#import "RepayListInfo.h"
#import "BankModel.h"
#import "P2PBillDetail.h"

@interface DetailRepayViewController () <UITableViewDelegate,UITableViewDataSource,RepayCellDelegate>
{
    NSMutableArray<NSNumber *> *_cellSelectArr;
    UIImageView *navBarHairlineImageView;
    DetailRepayHeader *_headerView;
    
    //待支付金额
    CGFloat _readyPayAmount;
    
    //可点击最大范围
    NSInteger _clickMax;
    
    //可点击最小范围
    NSInteger _clickMin;
    
    //最后一次点击坐标
    NSInteger _lastClick;
    
    CGFloat _save_amount;
    
    BankModel *_bankCardModel;
    
    NSMutableArray<Situations *> *_situations;
    
    NSMutableArray<BillList *> *_bills;
    
    NSInteger _currenPeriod;
}
@end

@implementation DetailRepayViewController
static NSString * const repayCellIdentifier = @"RepayDetailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackItem];
    self.navigationItem.title = @"期供详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _readyPayAmount = 0.0;
    _clickMax = 0;
    _clickMin = 0;
    _save_amount = 0.0;
    _lastClick = -1;
    _currenPeriod = 0;
    _cellSelectArr = [NSMutableArray array];
    _situations = [NSMutableArray array];
    _bills  = [NSMutableArray array];
    self.saveUpLabel.hidden = YES;
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.endView.layer.borderWidth = 0.5;
    self.endView.layer.borderColor = [UIColor grayColor].CGColor;
    [self setUpTableview];
    [self setUpTopView];
    [self setUpSelectAllBtn];
    [self setData];
}

- (void)setUpTopView
{
    _headerView = [[NSBundle mainBundle] loadNibNamed:[[DetailRepayHeader class] description] owner:self options:nil].lastObject;
    _topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation"]];
    _topView.alpha = 0.9;
    [self.topView addSubview:_headerView];
}

- (void)setUpSelectAllBtn
{
    UIImage *btnImg = [UIImage imageNamed:@"repay_circle_02"];
    UIImage *selectImg = [UIImage imageNamed:@"repay_circle_03"];
    [_selectAllBtn setImage:btnImg forState:UIControlStateNormal];
    [_selectAllBtn setImage:selectImg forState:UIControlStateSelected];
    _selectAllBtn.selected = NO;
}


/**
 *  @author dd
 *
 *  查询用户账单信息
 *  status: 1->已还   2->逾期   3->未来期   4->当期
 */
- (void)setData
{
    if (_repayListModel != nil) {
        for (int i = 0; i < _repayListModel.result.situations.count; i++) {
            Situations *situation = [_repayListModel.result.situations objectAtIndex:i];
            if ([situation.status isEqualToString:@"1"]) {
                [_cellSelectArr addObject:[NSNumber numberWithBool:false]];
            }else if ([situation.status isEqualToString:@"2"] || [situation.status isEqualToString:@"4"]) {
                if ([situation.status isEqualToString:@"4"]) {
                    _currenPeriod = situation.no;
                }
                [_cellSelectArr addObject:[NSNumber numberWithBool:true]];
                _readyPayAmount += situation.debt_total;
                _clickMax = i;
            }else {
                [_cellSelectArr addObject:[NSNumber numberWithBool:false]];
            }
        }
    }
    
    if (_p2pBillDetail != nil) {
        for (int i = 0; i < _p2pBillDetail.data.bill_List_.count; i++) {
            BillList *bill = [_p2pBillDetail.data.bill_List_ objectAtIndex:i];
            if (bill.status_ == 1) {
                [_cellSelectArr addObject:[NSNumber numberWithBool:false]];
            }else if (bill.status_ == 2 || bill.status_ == 4) {
                if (bill.status_ == 4) {
                    _currenPeriod = bill.cur_stage_no_;
                }
                [_cellSelectArr addObject:[NSNumber numberWithBool:true]];
                _readyPayAmount += bill.amount_total_;
                _clickMax = i;
            }else {
                [_cellSelectArr addObject:[NSNumber numberWithBool:false]];
            }
        }
    }
    
    if (_currenPeriod == 0) {
        if (_repayListModel != nil) {
            for (int i = 0; i < _repayListModel.result.situations.count; i++) {
                Situations *situation = [_repayListModel.result.situations objectAtIndex:i];
                if ([situation.status isEqualToString:@"3"]) {
                    _currenPeriod = situation.no - 1;
                    break;
                }
            }
        }
        if (_p2pBillDetail != nil) {
            for (BillList *bill in _p2pBillDetail.data.bill_List_) {
                if (bill.status_ == 3) {
                    _currenPeriod = bill.cur_stage_no_ - 1;
                    break;
                }
            }
        }
        
    }
    for (int i = 0; i < _cellSelectArr.count; i++) {
        if ([_cellSelectArr objectAtIndex:i].boolValue) {
            _clickMin = i;
            break;
        }
    }
    _lastClick = _clickMax;
    if (_repayListModel != nil) {
        _headerView.sigingDayLabel.text = [NSString stringWithFormat:@"借款时间%@",_repayListModel.result.siging_day];
        _headerView.principalAmountLabel.text = [NSString stringWithFormat:@"%.2f",_repayListModel.result.principal_amount];
        _headerView.feeAmountLabel.text = [NSString stringWithFormat:@"%.2f",_repayListModel.result.fee_amount];
        _headerView.repaymentAmountLabel.text = [NSString stringWithFormat:@"%.2f",_repayListModel.result.repayment_amount];
        _headerView.periodsLabel.text = [NSString stringWithFormat:@"已还%ld期,待还%ld期",_repayListModel.result.periods_repayed,_repayListModel.result.periods_repaying];
    }
    
    if (_p2pBillDetail != nil) {
        _headerView.sigingDayLabel.text = [NSString stringWithFormat:@"借款时间%@",[Tool dateToFormatString:_p2pBillDetail.data.bid_release_time_]];
        _headerView.principalAmountLabel.text = [NSString stringWithFormat:@"%.2f",_p2pBillDetail.data.amount_];
        _headerView.feeAmountLabel.text = [NSString stringWithFormat:@"%.2f",_p2pBillDetail.data.repay_svc_charge_ + _p2pBillDetail.data.repay_interest_];
        _headerView.repaymentAmountLabel.text = [NSString stringWithFormat:@"%.2f",_p2pBillDetail.data.repay_total_];
        _headerView.periodsLabel.text = [NSString stringWithFormat:@"已还%d期,待还%d期",_p2pBillDetail.data.paid_period_,_p2pBillDetail.data.stay_period_];
    }
    
    [self updateUserNeedPayAmount];
    [self.tableView reloadData];
}

- (void)updateUserNeedPayAmount
{
    //    _payNumberLabel.text = [NSString stringWithFormat:@"待支付%.2f元",_readyPayAmount];
    
    NSString *repAmount = [NSString stringWithFormat:@"%.2f",_readyPayAmount];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待支付%@元",repAmount]];
    [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(255, 134, 25) range:NSMakeRange(3, repAmount.length)];
    _payNumberLabel.attributedText = attriStr;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}
//在页面消失的时候就让出现
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}


- (void)setUpTableview
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RepayListCell class]) bundle:nil] forCellReuseIdentifier:repayCellIdentifier];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 175;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    DetailRepayHeader *headerView = [[NSBundle mainBundle] loadNibNamed:[[DetailRepayHeader class] description] owner:self options:nil].lastObject;
//    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation"]];
//    headerView.alpha = 0.9;
//    return headerView;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellSelectArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepayListCell *cell = [tableView dequeueReusableCellWithIdentifier:repayCellIdentifier];
    cell.displayStyle = RepayCellDetail;
    cell.delegate = self;
    if (_repayListModel != nil) {
        Situations *situation = [_repayListModel.result.situations objectAtIndex:indexPath.row];
        cell.situation = situation;
        cell.numberOfIdentifier.text = [NSString stringWithFormat:@"%ld",situation.no];
    }
    if (_p2pBillDetail != nil) {
        BillList *bill = [_p2pBillDetail.data.bill_List_ objectAtIndex:indexPath.row];
        cell.bill = bill;
        cell.numberOfIdentifier.text = [NSString stringWithFormat:@"%d",bill.cur_stage_no_];
    }
    cell.cellSelectArr = _cellSelectArr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.row = indexPath.row;
    cell.clickMinIndex = _clickMin;
    cell.clickMaxIndex = _clickMax;
    cell.orderStateView.hidden = YES;
    cell.detailStateView.hidden = NO;
    cell.identifierSelect = [_cellSelectArr objectAtIndex:indexPath.row].boolValue;
    return cell;
}


- (void)clickCell:(NSInteger)row selectState:(BOOL)state
{
    _readyPayAmount = 0.0;
    
    NSNumber *n = [NSNumber numberWithBool:state];
    if (state) {
        _lastClick = row;
        NSInteger index = row;
        
        if (_repayListModel != nil) {
            if (![[_repayListModel.result.situations objectAtIndex:row].status isEqualToString:@"1"]) {
                [_cellSelectArr replaceObjectAtIndex:row withObject:n];
            }
            while (index >= 0) {
                if (![[_repayListModel.result.situations objectAtIndex:index].status isEqualToString:@"1"]) {
                    [_cellSelectArr replaceObjectAtIndex:index withObject:n];
                }
                index--;
            }
        }
        if (_p2pBillDetail != nil) {
            if ([_p2pBillDetail.data.bill_List_ objectAtIndex:row].status_ != 1) {
                [_cellSelectArr replaceObjectAtIndex:row withObject:n];
            }

            while (index >= 0) {
                if ([_p2pBillDetail.data.bill_List_ objectAtIndex:index].status_ != 1) {
                    [_cellSelectArr replaceObjectAtIndex:index withObject:n];
                }
                index--;
            }
        }
        
        
    } else {
        NSInteger index = row;
        _lastClick = row - 1;
        while (index < _cellSelectArr.count) {
            [_cellSelectArr replaceObjectAtIndex:index withObject:n];
            index++;
        }
        if (_selectAllBtn.selected) {
            [self checkAll:self.selectAllBtn];
            _readyPayAmount = 0.0;
        }
        
    }
    for (int i = 0; i < _cellSelectArr.count; i++) {
        if([_cellSelectArr objectAtIndex:i].boolValue){
            if (_repayListModel != nil) {
                Situations *situation = [_repayListModel.result.situations objectAtIndex:i];
                _readyPayAmount += situation.debt_total;
            }
            if (_p2pBillDetail != nil) {
                BillList *bill = [_p2pBillDetail.data.bill_List_ objectAtIndex:i];
                _readyPayAmount += bill.amount_total_;
            }
        }
    }
    [self updateUserNeedPayAmount];
    [self.tableView reloadData];
}

- (IBAction)checkAll:(UIButton *)sender {
    _selectAllBtn.selected = !_selectAllBtn.selected;
    _readyPayAmount = 0.0;
    _save_amount = 0.0;
    if (_selectAllBtn.selected) {
        
//         [self showAlert];
        
        for (int i = 0; i < _cellSelectArr.count; i++) {
            if (_repayListModel != nil) {
                if (![[_repayListModel.result.situations objectAtIndex:i].status isEqualToString:@"1"]) {
                    [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:true]];
                }
                if([_cellSelectArr objectAtIndex:i].boolValue){
                    Situations *situation = [_repayListModel.result.situations objectAtIndex:i];
                    _readyPayAmount += situation.debt_total;
                    if ([situation.status isEqualToString:@"3"]) {
                        _save_amount += situation.debt_service_fee;
                    }
                }
            }
            if (_p2pBillDetail != nil) {
                if ([_p2pBillDetail.data.bill_List_ objectAtIndex:i].status_ != 1) {
                    [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:true]];
                }
                if ([_cellSelectArr objectAtIndex:i].boolValue) {
                    BillList *bill = [_p2pBillDetail.data.bill_List_ objectAtIndex:i];
                    _readyPayAmount += bill.amount_total_;
                    if (bill.status_ == 3) {
                        _save_amount += (bill.amount_total_ - bill.repayment_corpus_);
                    }
                }
            }
        }
        
        if (_repayListModel != nil) {
            if ([_repayListModel.result.situations.lastObject.status isEqualToString:@"2"]) {
                _save_amount = 0;
            }else {
                if (_repayListModel.result.situations.count < _repayListModel.result.service_fee_min_period) {
                    if (_currenPeriod <= _repayListModel.result.situations.count) {
                        _save_amount = 0.0;
                    }
                } else {
                    if (_currenPeriod < _repayListModel.result.service_fee_min_period) {
//                        _save_amount -= (_repayListModel.result.service_fee_min_period - _currenPeriod) * (_repayListModel.result.fee_amount / _repayListModel.result.situations.count);
//                        NSInteger k = _repayListModel.result.service_fee_min_period - _currenPeriod;
//                        NSInteger count = _repayListModel.result.situations.count - 1;
//                        while (k > 0 && count >= 0 && count < _repayListModel.result.situations.count) {
//                            _save_amount -= _repayListModel.result.situations[count].debt_service_fee;
//                            k--;
//                            count--;
//                        }
                        for (NSInteger i = _currenPeriod; i < _repayListModel.result.service_fee_min_period; i++) {
                            _save_amount -= _repayListModel.result.situations[i].debt_service_fee;
                        }
                    }
                }
            }
        }
        
        if (_p2pBillDetail != nil) {
            if (_p2pBillDetail.data.bill_List_.lastObject.status_ == 2) {
                _save_amount = 0;
            }else {
                if (_p2pBillDetail.data.bill_List_.count < _p2pBillDetail.data.service_fee_min_period) {
                    if (_currenPeriod <= _p2pBillDetail.data.bill_List_.count) {
                        _save_amount = 0.0;
                    }
                } else {
                    if (_currenPeriod < _p2pBillDetail.data.service_fee_min_period) {
                        NSInteger k = _p2pBillDetail.data.service_fee_min_period - _currenPeriod;
                        NSInteger count = _p2pBillDetail.data.bill_List_.count - 1;
                        while (k > 0 && count >= 0 && count < _p2pBillDetail.data.bill_List_.count) {
                            _save_amount -= _p2pBillDetail.data.bill_List_[count].repayment_interest_ + _p2pBillDetail.data.bill_List_[count].repayment_service_charge_;
                            k--;
                            count--;
                        }
//                        _save_amount -= (_p2pBillDetail.data.service_fee_min_period - _currenPeriod) * ([_p2pBillDetail.data.bill_List_ firstObject].amount_total_ - [_p2pBillDetail.data.bill_List_ firstObject].repayment_corpus_);
                    }
                }
            }
        }
        if (_p2pBillDetail != nil) {
            _readyPayAmount = _p2pBillDetail.data.curr_settle_amt_;
        }else {
            _readyPayAmount = _readyPayAmount - _save_amount;
        }
        
//        _readyPayAmount = _readyPayAmount - _save_amount;
        if ([_product_id isEqualToString:@"P001002"]) {
            NSString *saveAmount = [NSString stringWithFormat:@"%.2f",_save_amount];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"立省%@元",saveAmount]];
            [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(255, 134, 25) range:NSMakeRange(2, saveAmount.length)];
            self.saveUpLabel.attributedText = attriStr;
            self.saveUpLabel.hidden = NO;
            _payNumberTop.constant = 5;
            _payNumberBottom.constant = 15;
            [_payNumberLabel updateConstraintsIfNeeded];
            [_payNumberLabel updateConstraints];
        }
       
    }else {
        for (int i = 0; i < _cellSelectArr.count; i++) {
            if (_repayListModel != nil) {
                
                if (![[_repayListModel.result.situations objectAtIndex:i].status isEqualToString:@"1"]) {
                    if (i <= _lastClick) {
                        [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:true]];
                    }else {
                        [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:false]];
                    }
                }
                if([_cellSelectArr objectAtIndex:i].boolValue){
                    Situations *situation = [_repayListModel.result.situations objectAtIndex:i];
                    _readyPayAmount += situation.debt_total;
                }
            }
            if (_p2pBillDetail != nil) {
                
                if ([_p2pBillDetail.data.bill_List_ objectAtIndex:i].status_ != 1) {
                    if (i <= _lastClick) {
                        [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:true]];
                    }else {
                        [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:false]];
                    }
                }
                if([_cellSelectArr objectAtIndex:i].boolValue){
                    BillList *bill = [_p2pBillDetail.data.bill_List_ objectAtIndex:i];
                    _readyPayAmount += bill.amount_total_;
                }
            }
            
        }
        
        self.saveUpLabel.hidden = YES;
        _payNumberTop.constant = 10;
        _payNumberBottom.constant = 10;
        [_payNumberLabel updateConstraintsIfNeeded];
        [_payNumberLabel updateConstraints];
    }
    [self updateUserNeedPayAmount];
    [self.tableView reloadData];
}


- (IBAction)repayBtnClick:(UIButton *)sender {
    if (_repayListModel != nil) {
        for (int i = 0; i < _cellSelectArr.count; i++) {
            if ([_cellSelectArr objectAtIndex:i].boolValue) {
                [_situations addObject:[_repayListModel.result.situations objectAtIndex:i]];
            }
        }
        
        if (_situations.count > 0) {
            [self fatchCardInfo];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请至少选择一期"];
        }
    }
    if (_p2pBillDetail != nil) {
        for (int i = 0; i < _cellSelectArr.count; i++) {
            if ([_cellSelectArr objectAtIndex:i].boolValue) {
                [_bills addObject:[_p2pBillDetail.data.bill_List_ objectAtIndex:i]];
            }
        }
        if (_bills.count > 0) {
            RepayDetailViewController *repayMent=[[RepayDetailViewController alloc]initWithNibName:[[RepayDetailViewController class] description] bundle:nil];
            if (_selectAllBtn.selected) {
                repayMent.repayType = RepayTypeClean;
            } else {
                repayMent.repayType = RepayTypeOption;
            }
            repayMent.repayAmount = _readyPayAmount;
            repayMent.cellSelectArr = _cellSelectArr;
            repayMent.save_amount = _save_amount;
            repayMent.p2pBillModel = _p2pBillDetail;
            repayMent.bills = _bills;
            [self.navigationController pushViewController:repayMent animated:YES];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请至少选择一期"];
        }
    }
    
}

- (void)fatchCardInfo
{
    NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        _bankCardModel = [BankModel yy_modelWithJSON:object];
        if ([_bankCardModel.flag isEqualToString:@"0000"]) {
            RepayDetailViewController *repayMent=[[RepayDetailViewController alloc]initWithNibName:[[RepayDetailViewController class] description] bundle:nil];
            repayMent.product_id = _product_id;
            if (_selectAllBtn.selected) {
                repayMent.repayType = RepayTypeClean;
            } else {
                repayMent.repayType = RepayTypeOption;
            }
            repayMent.bankModel = _bankCardModel;
            repayMent.repayAmount = _readyPayAmount;
            repayMent.repayListInfo = _repayListModel;
            repayMent.cellSelectArr = _cellSelectArr;
            repayMent.save_amount = _save_amount;
            repayMent.situations = _situations;
            [self.navigationController pushViewController:repayMent animated:YES];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_bankCardModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

#pragma mark 弹框
-(void)showAlert{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提前结清费用" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
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
