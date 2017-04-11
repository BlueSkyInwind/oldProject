//
//  RepaymentHelpController.m
//  fxdProduct
//
//  Created by zy on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "RepaymentHelpController.h"
#import "RepaymentHelpCell.h"
@interface RepaymentHelpController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *contentAry;
    NSArray *titleAry;
}
@end

@implementation RepaymentHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于还款";
    [self addBackItem];
    titleAry=@[@"Q1:如何还款?",@"Q2:如果还款逾期,需要支付哪些费用?"];
    contentAry=@[@"        发薪贷采用自动扣款或主动还款,自动从您借款时添加的银行卡中扣除还款金额,请保障您绑定的银行卡中有足够的余额.",@"        如果借款人未能按期足额还款,除了必须偿还原先的欠款,还应支付逾期罚息.\n        罚息为自应还款日起按每日借款金额的0.5%收取逾期手续费,并支付10元/笔的滞纳金.\n        逾期超过15日,甲方仍未实际还款的,则应每日借款金额的0.75%计收逾期手续费.\n        逾期超过30日的,我方将把借款人拉入网站黑名单,并将该黑名单对第三方披露,并与任何三方数据共享,由此造成借款人的损失,乙方不承担法律责任."];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 146.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"RepaymentHelpCell" bundle:nil] forCellReuseIdentifier:@"help"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepaymentHelpCell *cell=[tableView dequeueReusableCellWithIdentifier:@"help"];
    cell.lblTitle.text=titleAry[indexPath.row];
    cell.lblContent.text=contentAry[indexPath.row];
    CGRect  rect=self.tableView.frame;
    self.tableView.frame=rect;
    return cell;
}



@end
