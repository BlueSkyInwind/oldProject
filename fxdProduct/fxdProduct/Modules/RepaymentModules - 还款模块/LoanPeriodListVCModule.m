//
//  RepayListViewController.m
//  fxdProduct
//
//  Created by dd on 16/8/31.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "LoanPeriodListVCModule.h"
#import "RepayListCell.h"
#import "LoanPeriodForDetailsVCModule.h"
#import "LoanPaymentDetailVCModule.h"
#import "RepayMentViewModel.h"
#import "RepayListInfo.h"
#import "P2PBillDetail.h"
#import "UIScrollView+EmptyDataSet.h"
#import "CheckViewModel.h"
#import "SupportBankList.h"

@interface LoanPeriodListVCModule () <UITableViewDelegate,UITableViewDataSource,RepayCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSMutableArray<NSNumber *> *_cellSelectArr;
    //空白展位视图
    UIView *noneView;
    //状态标记
    NSNumber *_repayStateFlag;
    //数据模型
    RepayListInfo *_repayListModel;
    //待支付金额
    CGFloat _readyPayAmount;
    //可点击最大范围
    NSInteger _clickMax;
    
    NSMutableArray *_supportBankListArr;
    
    //最后一次点击坐标
    NSInteger _lastClick;
    
    CGFloat _save_amount;
    
    NSMutableArray<Situations *> *_situations;
    
    NSMutableArray<Situations *> *_vaildSituations;
    
    //当前期
    NSInteger _currenPeriod;
    
    P2PBillDetail *_p2pBillModel;
    
    NSMutableArray<BillList *> *_vaildBills;
    
    NSMutableArray<BillList *> *_bills;
}
@end

@implementation LoanPeriodListVCModule

static NSString * const repayCellIdentifier = @"RepayListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"全部待还";
    _cellSelectArr = [NSMutableArray array];
    _readyPayAmount = 0.0;
    _save_amount = 0.0;
    _lastClick = -1;
    _clickMax = -1;
    _currenPeriod = 0;
    _situations = [NSMutableArray array];
    _vaildSituations = [NSMutableArray array];
    _vaildBills = [NSMutableArray array];
    _bills = [NSMutableArray array];
    _supportBankListArr = [NSMutableArray array];
    if (@available(iOS 11.0, *)) {
        self.repayTableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    if (UI_IS_IPHONEX) {
        self.headerViewHeader.constant = 88;
    }
    self.endView.layer.borderWidth = 0.5;
    self.endView.layer.borderColor = [UIColor grayColor].CGColor;
    [self setUpTableview];
    [self setUpSelectAllBtn];
    [self addBackItem];
    [self createNoneView];
    [self checkState];
}

- (void)setUpTableview
{
    [self.repayTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RepayListCell class]) bundle:nil] forCellReuseIdentifier:repayCellIdentifier];
    [self.repayTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.repayTableView.showsVerticalScrollIndicator = NO;
    self.repayTableView.emptyDataSetSource = self;
    self.repayTableView.emptyDataSetDelegate = self;
}

- (void)setUpSelectAllBtn
{
    UIImage *btnImg = [UIImage imageNamed:@"repay_circle_02"];
    UIImage *selectImg = [UIImage imageNamed:@"repay_circle_03"];
    [_selectAllBtn setImage:btnImg forState:UIControlStateNormal];
    [_selectAllBtn setImage:selectImg forState:UIControlStateSelected];
    _selectAllBtn.selected = NO;
    _saveUpLabel.hidden = YES;
}

/**
 *  @author dd
 *
 *  状态判断
 */
-(void)checkState{
    
    _repayStateFlag=@0;
    [self post_getLastDate];
    
}

/**
 *  @author dd
 *
 *  查询用户账单信息
 *  status: 1->已还   2->逾期   3->未来期   4->当期
 */
- (void)post_getLastDate
{
    RepayMentViewModel *repayMentViewModel = [[RepayMentViewModel alloc] init];
    [repayMentViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM= returnValue;
        if ([baseRM.errCode isEqualToString:@"0"]) {
            _repayListModel = [[RepayListInfo alloc]initWithDictionary:(NSDictionary *)baseRM.data error:nil];
            for (int i = 0; i < _repayListModel.situations_.count; i++) {
                Situations *situation = [_repayListModel.situations_ objectAtIndex:i];
                if (![situation.status_ isEqualToString:@"1"]) {
                    if ([situation.status_ isEqualToString:@"2"] || [situation.status_ isEqualToString:@"4"]) {
                        if ([situation.status_ isEqualToString:@"4"]) {
                            _currenPeriod = [situation.no_ integerValue];
                        }
                        [_cellSelectArr addObject:[NSNumber numberWithBool:true]];
                        _readyPayAmount += [situation.debt_total_ floatValue];
                        _clickMax++;
                    }else {
                        [_cellSelectArr addObject:[NSNumber numberWithBool:false]];
                    }
                    [_vaildSituations addObject:situation];
                }
            }
            if (_currenPeriod == 0) {
                for (int i = 0; i < _repayListModel.situations_.count; i++) {
                    Situations *situation = [_repayListModel.situations_ objectAtIndex:i];
                    if ([situation.status_ isEqualToString:@"3"]) {
                        _currenPeriod = [situation.no_ integerValue] - 1;
                        break;
                    }
                }
            }
            _lastClick = _clickMax;
            [self updateUserNeedPayAmount];
            [self.repayTableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseRM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [repayMentViewModel fatchQueryWeekShouldAlsoAmount:nil];
}

- (void)loadViewWithState
{
    switch (_repayStateFlag.integerValue) {
        case 0:
            [self post_getLastDate];
            break;
        default:
            noneView.hidden = NO;
            break;
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



#pragma mark 全部还款
- (IBAction)checkAll:(UIButton *)sender {
    _selectAllBtn.selected = !_selectAllBtn.selected;
    _readyPayAmount = 0.0;
    _save_amount = _repayListModel.quickOmit != nil ? _repayListModel.quickOmit.floatValue : 0.0;
    if (_selectAllBtn.selected) {
        for (int i = 0; i < _cellSelectArr.count; i++) {
            [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:true]];
            Situations *situation = [_vaildSituations objectAtIndex:i];
            _readyPayAmount += [situation.debt_total_ floatValue];
//            if ([situation.status_ isEqualToString:@"3"]) {
//                _save_amount += [situation.debt_service_fee_ floatValue];
//            }
        }
//        if ([_vaildSituations.firstObject.status_ isEqualToString:@"2"] && [_vaildSituations.lastObject.status_ isEqualToString:@"2"]) {
//            _save_amount = 0;
//        }else {
//            if (_repayListModel.situations_.count <=  [_repayListModel.service_fee_min_period_ integerValue]) {
//                if (_currenPeriod <= _repayListModel.situations_.count) {
//                    _save_amount = 0.0;
//                }
//            } else {
//                if (_currenPeriod < [_repayListModel.service_fee_min_period_ integerValue]) {
//                    for (NSInteger i = _currenPeriod; i < [_repayListModel.service_fee_min_period_ integerValue]; i++) {
//                        Situations * situations = _repayListModel.situations_[i];
//                        _save_amount -= [situations.debt_service_fee_ floatValue];
//                    }
//                }
//            }
//        }
        
        _readyPayAmount = _repayListModel.settleRepayAmount != nil ? _repayListModel.settleRepayAmount.floatValue : 0.0;

        if ([self.product_id isEqualToString:EliteLoan]){
            NSString *saveAmount = [NSString stringWithFormat:@"%.2f",_save_amount];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"立省%@元",saveAmount]];
            [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(2, saveAmount.length)];
            self.saveUpLabel.attributedText = attriStr;
            self.saveUpLabel.hidden = NO;
            _payNumberTop.constant = 5;
            _payNumberBottom.constant = 15;
            [_payNumberLabel updateConstraintsIfNeeded];
            [_payNumberLabel updateConstraints];
        }
    }else {
        for (int i = 0; i < _cellSelectArr.count; i++) {
            if (i <= _lastClick) {
                [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:true]];
            }else {
                [_cellSelectArr replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:false]];
            }
        }
        DLog(@"%@",_cellSelectArr);
        for (int i = 0; i < _cellSelectArr.count; i++) {
            if([_cellSelectArr objectAtIndex:i].boolValue){
                Situations *situation = [_vaildSituations objectAtIndex:i];
                _readyPayAmount += [situation.debt_total_ floatValue];
            }
        }
        if ([self.product_id isEqualToString:EliteLoan]) {
            self.saveUpLabel.hidden = YES;
            _payNumberTop.constant = 10;
            _payNumberBottom.constant = 10;
            [_payNumberLabel updateConstraintsIfNeeded];
            [_payNumberLabel updateConstraints];
        }
    }
    [self updateUserNeedPayAmount];
    [self.repayTableView reloadData];
}

#pragma mark 弹框
-(void)showAlert{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提前结清费用" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mrak - 还款点击处理
/**
 *  @author dd
 *
 *  立即还款
 *
 */
- (IBAction)repayClick:(UIButton *)sender {
        if (_situations.count > 0) {
            [_situations removeAllObjects];
        }
        for (int i = 0; i < _cellSelectArr.count; i++) {
            if ([_cellSelectArr objectAtIndex:i].boolValue) {;
                [_situations addObject:[_vaildSituations objectAtIndex:i]];
            }
        }
        if (_situations.count > 0) {
            [self fatchCardInfo];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请至少选择一期"];
        }
}

- (void)fatchCardInfo
{
    int i = 0;
    for (NSNumber *num in _cellSelectArr) {
        if (num.boolValue) {
            i++;
        }
    }
    if (i > 0) {
        CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
        [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
            BaseResultModel * baseResult = returnValue;
            if ([baseResult.errCode isEqualToString:@"0"]) {
                NSArray * array  = (NSArray *)baseResult.data;
                _supportBankListArr = [NSMutableArray array];
                for (int i = 0; i < array.count; i++) {
                    SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                    [_supportBankListArr addObject:bankList];
                }
                
                LoanPaymentDetailVCModule *repayMent=[[LoanPaymentDetailVCModule alloc]initWithNibName:[[LoanPaymentDetailVCModule class] description] bundle:nil];
                if (_selectAllBtn.selected) {
                    repayMent.repayType = RepayTypeClean;
                } else {
                    repayMent.repayType = RepayTypeOption;
                }
                repayMent.supportBankListArr = _supportBankListArr;
                repayMent.repayListInfo = _repayListModel;
                repayMent.cellSelectArr = _cellSelectArr;
                repayMent.save_amount = _save_amount;
                repayMent.situations = _situations;

                repayMent.platform_type = _platform_type;
                repayMent.applicationId = _applicationId;
                [self.navigationController pushViewController:repayMent animated:YES];
                
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
            }
        } WithFaileBlock:^{
            
        }];
        [checkBankViewModel getSupportBankListInfo:@"2"];
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请至少选择一期"];
    }    
}

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
    cell.displayStyle = RepayCellNormal;
    cell.delegate = self;
    cell.cellSelectArr = _cellSelectArr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.row = indexPath.row;
    cell.situation = [_vaildSituations objectAtIndex:indexPath.row];

    cell.clickMinIndex = 0;
    //    DLog(@"%ld",_clickMax);
    cell.clickMaxIndex = _clickMax;
    cell.identifierSelect = [_cellSelectArr objectAtIndex:indexPath.row].boolValue;
    cell.detailClickBlock = ^(NSInteger row){
        LoanPeriodForDetailsVCModule *detailVC = [[LoanPeriodForDetailsVCModule alloc] init];
        detailVC.platform_type = self.platform_type;
        detailVC.repayListModel = _repayListModel;
        detailVC.product_id = self.product_id;
        detailVC.applicationId = self.applicationId;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    return cell;
}


- (void)clickCell:(NSInteger)row selectState:(BOOL)state
{
    _readyPayAmount = 0.0;
    
    NSNumber *n = [NSNumber numberWithBool:state];
    if (state) {
        if (_clickMax != _vaildBills.count-1) {
            _lastClick = row;
        }
        
        for (int i = 0; i <= row; i++) {
            [_cellSelectArr replaceObjectAtIndex:i withObject:n];
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
            Situations *situation = [_vaildSituations objectAtIndex:i];
            _readyPayAmount += [situation.debt_total_ floatValue];
        }
    }
    [self updateUserNeedPayAmount];
    [self.repayTableView reloadData];
}

- (void)updateUserNeedPayAmount
{
    NSString *repAmount = [NSString stringWithFormat:@"%.2f",_readyPayAmount];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待支付%@元",repAmount]];
    [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, repAmount.length)];
    _payNumberLabel.attributedText = attriStr;
}

#pragma mark - DZNEmptyDataSetSourceDelagete

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"my-logo"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    DLog(@"刷新");
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -150.0f;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"您当前无需还款";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: rgb(173, 173, 173)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return rgb(242, 242, 242);
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    if (_repayStateFlag.integerValue == 0) {
//        _endView.hidden = true;
        return NO;
    } else {
        _endView.hidden = true;
        return YES;
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
