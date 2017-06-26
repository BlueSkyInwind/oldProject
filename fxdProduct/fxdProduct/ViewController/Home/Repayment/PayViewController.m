//
//  PayViewController.m
//  fxdProduct
//
//  Created by dd on 16/7/15.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "PayViewController.h"
#import "PayMoneyCell.h"
#import "PayMethodCell.h"
#import "UIViewController+KNSemiModal.h"
#import "PayMethodViewController.h"
#import "CardInfo.h"
#import "UnbundlingBankCardViewController.h"
@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    CardInfo *_selectCardInfo;
}

@end

@implementation PayViewController

static NSString * const methodCellIdentifier = @"MethodCell";
static NSString * const moneyCellIdentifier = @"MoneyCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (_payType == PayTypeWeekPay) {
        self.navigationItem.title = @"支付详情";
    } else if (_payType == PayTypeCleanPay){
        self.navigationItem.title = @"确定结清?";
    }else {
        self.navigationItem.title = @"到账到银行卡";
    }
    
    [Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
    [self.myTableview registerNib:[UINib nibWithNibName:NSStringFromClass([PayMethodCell class]) bundle:nil] forCellReuseIdentifier:methodCellIdentifier];
    [self.myTableview registerNib:[UINib nibWithNibName:NSStringFromClass([PayMoneyCell class]) bundle:nil] forCellReuseIdentifier:moneyCellIdentifier];
    [self.myTableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.myTableview.showsVerticalScrollIndicator = NO;
    self.myTableview.scrollEnabled = NO;
    [self addDisMissItem];
}

- (void)addDisMissItem
{
    UIBarButtonItem *disMissItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    [disMissItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil]  forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = disMissItem;
    
    if (_isP2P) {
        
        UIBarButtonItem *changeBankItem = [[UIBarButtonItem alloc] initWithTitle:@"更换" style:UIBarButtonItemStylePlain target:self action:@selector(changeBank)];
        [changeBankItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName, nil]  forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = changeBankItem;
    }
}

#pragma mark  更换银行卡按钮
-(void)changeBank{

    [self dismissSemiModalView];
    self.changeBankBlock();
    
}

- (void)dismiss
{
    [self dismissSemiModalView];
}

- (IBAction)sureBtnClick:(UIButton *)sender {
    
    
    self.makesureBlock(self.payType,_selectCardInfo,_banckCurrentIndex);
}


#pragma mark --TableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_payType == PayTypeWeekPay || _payType == PayTypeCleanPay) {
        return 2;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_payType == PayTypeWeekPay || _payType == PayTypeCleanPay) {
        return 40;
    } else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       
        PayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:methodCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (_payType == PayTypeGetMoneyToCard) {
            cell.PayTitleLabel.text = @"银行卡";
        }
        if (_isP2P) {
            
            cell.whichBank.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_bankName,_banNum];
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (_cardInfo) {
                cell.whichBank.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_cardInfo.bankName,_cardInfo.tailNumber];
            } else {
                cell.whichBank.text = @"";
            }
        }
        
        return cell;
        
        
    } else {
        PayMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:moneyCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        cell.payLabel.text = [NSString stringWithFormat:@"%@元",_shouldAmount];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self fatchCardInfo];
    if (!_isP2P) {
        
        PayMethodViewController *payMethodVC = [[PayMethodViewController alloc] init];
        payMethodVC.bankModel = _bankCardModel;
        
        
        if (_payType == PayTypeWeekPay || _payType == PayTypeCleanPay) {
            payMethodVC.payMethod = PayMethodNormal;
        } else {
            payMethodVC.payMethod = PayMethodSelectBankCad;
        }
        payMethodVC.currentIndex = _banckCurrentIndex;
        payMethodVC.bankSelectBlock = ^(CardInfo *cardInfo, NSInteger currentIndex){
            if (cardInfo) {
                _selectCardInfo = cardInfo;
                _cardInfo = cardInfo;
            }
            _banckCurrentIndex = currentIndex;
            [self.myTableview reloadData];
        };
        [self.navigationController pushViewController:payMethodVC animated:YES];
        
    }
    
}

//- (void)fatchCardInfo
//{
//    if (_bankCardModel) {
//        PayMethodViewController *payMethodVC = [[PayMethodViewController alloc] init];
//        payMethodVC.bankModel = _bankCardModel;
//        [self.navigationController pushViewController:payMethodVC animated:YES];
//    } else {
//        NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
//        [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
//            _bankCardModel = [BankModel yy_modelWithJSON:object];
//            if ([_bankCardModel.flag isEqualToString:@"0000"]) {
//                PayMethodViewController *payMethodVC = [[PayMethodViewController alloc] init];
//                payMethodVC.bankModel = _bankCardModel;
//
//                if (_payType == PayTypeWeekPay || _payType == PayTypeCleanPay) {
//                    payMethodVC.payMethod = PayMethodNormal;
//                } else {
//                    payMethodVC.payMethod = PayMethodSelectBankCad;
//                }
//                payMethodVC.currentIndex = -1;
//                [self.navigationController pushViewController:payMethodVC animated:YES];
//            } else {
//                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_bankCardModel.msg];
//            }
//        } failure:^(EnumServerStatus status, id object) {
//            DLog(@"%@",object);
//        }];
//    }
//}

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
