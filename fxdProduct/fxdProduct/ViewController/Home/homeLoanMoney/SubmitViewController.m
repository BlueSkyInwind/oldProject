//
//  SubmitViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/11.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "SubmitViewController.h"
#import "SubmitRow0Cell.h"
#import "SubmitRow1Cell.h"
#import "SubmitRow2Cell.h"
#import "Submitrow3Cell.h"
#import "SubmitRow4Cell.h"
#import "HomeDailViewController.h"
#import "SubmitImageCell.h"
#import "MainProgressViewController.h"

@interface SubmitViewController ()
{
    SubmitImageCell *_submitView;
}
@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackItem];
    self.navigationItem.title = @"信息确认";
//    self.automaticallyAdjustsScrollViewInsets = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}


#pragma ->UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//    return @"确认信息真实有效,如信息不实,90天后才可再次申请";
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *aCellId = @"SubmitRow0Cell";
        SubmitRow0Cell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"SubmitRow0Cell" owner:self options:nil] lastObject];
        }
        loanNumCell.selectionStyle = UITableViewCellSelectionStyleNone;
        loanNumCell.labelMoney.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"applyAmount"];
        loanNumCell.labelWeek.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"periods"];
        loanNumCell.labelWeekPay.text =  [NSString stringWithFormat:@"%.2f",[loanNumCell.labelMoney.text floatValue]/[loanNumCell.labelWeek.text floatValue] +[loanNumCell.labelMoney.text floatValue]*0.021];
        loanNumCell.labelPaytotal.text = [NSString stringWithFormat:@"%.0f",([loanNumCell.labelMoney.text floatValue]/[loanNumCell.labelWeek.text floatValue] +[loanNumCell.labelMoney.text floatValue]*0.021)*[loanNumCell.labelWeek.text floatValue]];
        return loanNumCell;
    }
    if (indexPath.row == 1) {
        static NSString *aCellId = @"SubmitRow1Cell";
        SubmitRow1Cell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"SubmitRow1Cell" owner:self options:nil] lastObject];
        }
        loanNumCell.selectionStyle = UITableViewCellSelectionStyleNone;
        loanNumCell.labelName.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"realName"];
        loanNumCell.labelID.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"identityId"];
        return loanNumCell;
    }
    if (indexPath.row == 2) {
        static NSString *aCellId = @"SubmitRow2Cell";
        SubmitRow2Cell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"SubmitRow2Cell" owner:self options:nil] lastObject];
        }
        loanNumCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dict = @{@"30":@"专科",@"20":@"本科",@"12":@"硕士研究生",@"11":@"博士",@"9":@"其他"};
//        loanNumCell.labelCollege.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"schoolName"];
//        loanNumCell.labelXueli.text = [dict objectForKey:[[Utility sharedUtility].getMoneyParam objectForKey:@"degree"]];
        loanNumCell.labelCollege.text = [dict objectForKey:[[Utility sharedUtility].getMoneyParam objectForKey:@"degree"]];
        loanNumCell.labelXueli.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"company"];
        loanNumCell.labelAddress.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"unitTelephone"];
        loanNumCell.labelTelPhone.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"unitAddress"];
        /*
         专科 30
         本科 20
         硕士研究生  12
         博士 11
         */

        return loanNumCell;
    }

    if (indexPath.row == 3) {
        static NSString *aCellId = @"Submitrow3Cell";
        Submitrow3Cell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"Submitrow3Cell" owner:self options:nil] lastObject];
        }
        loanNumCell.selectionStyle = UITableViewCellSelectionStyleNone;
        loanNumCell.labelCreditCard.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"creditBankName"];
        loanNumCell.labelCreditNum.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"creditCardNo"];
        loanNumCell.labelBankCard.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"debitBankName"];
        loanNumCell.labelBankNum.text=  [[Utility sharedUtility].getMoneyParam objectForKey:@"bankNo"];
        loanNumCell.labelTelPhone.text = [[Utility sharedUtility].getMoneyParam objectForKey:@"debitMobile"];
    
        return loanNumCell;
    }
    if (indexPath.row == 4) {
        static NSString *aCellId = @"SubmitRow4Cell";
        SubmitRow4Cell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
        if (!loanNumCell) {
            loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"SubmitRow4Cell" owner:self options:nil] lastObject];
        }
        loanNumCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [loanNumCell.btn addTarget:self action:@selector(SubmitClick) forControlEvents:UIControlEventTouchUpInside];
        [loanNumCell.lableIdea addTarget:self action:@selector(tapIdeaClick) forControlEvents:UIControlEventTouchUpInside];
        return loanNumCell;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 163;
    }
    if (indexPath.row == 1) {
        return 96;
    }
    if (indexPath.row == 2) {
        return 119;
    }
    if (indexPath.row == 3) {
        return 168;
    }
    if (indexPath.row == 4) {
        return 181;
    }
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma ->action

//提交按钮
-(void)SubmitClick{
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_saveLoanApplicant_url] parameters:[Utility sharedUtility].getMoneyParam finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"]) {
                _submitView = [[[NSBundle mainBundle] loadNibNamed:@"SubmitImageCell" owner:self options:nil] objectAtIndex:0];
                _submitView.frame = CGRectMake(0, 0, _k_w, _k_h);
                [_submitView show];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    MainProgressViewController *MainVC= [MainProgressViewController new];
                    [self.navigationController pushViewController:MainVC animated:YES];
                    [_submitView hide];
                    [Utility sharedUtility].ispressBtn =YES;
                });
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

//三方协议

-(void)tapIdeaClick{
    HomeDailViewController *homeDVC = [HomeDailViewController new];
    [self.navigationController pushViewController:homeDVC animated:YES];
}

@end
