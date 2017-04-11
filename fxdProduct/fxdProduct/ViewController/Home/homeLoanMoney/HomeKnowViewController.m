//
//  HomeKnowViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeKnowViewController.h"
#import "RepaymentHelpCell.h"

@interface HomeKnowViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *contentAry;
    NSArray *titleAry;
}
@end

@implementation HomeKnowViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem];
    self.navigationItem.title = @"借款须知";
    titleAry=@[@"Q1:借款周期是多久？",@"Q2:计息方式？",@"Q3:如何还款？",@"Q4:结清欠款如何计算本息？"];
    contentAry=@[@"        30周或50周。",@"        按日计息，日利率0.3%。",@"        按周还款，如果提前还当期欠款，收取本期全部利息和本金。",@"        如果要结清全部欠款，需要结清当期本金和利息以及剩余本金。"];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.estimatedRowHeight=55.0;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
//    [self.tableView registerNib:[UINib nibWithNibName:@"RepaymentHelpCell" bundle:nil] forCellReuseIdentifier:@"help"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleAry.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RepaymentHelpCell *cell=[tableView dequeueReusableCellWithIdentifier:@"help"];
//    cell.lblTitle.text=titleAry[indexPath.row];
//    cell.lblContent.text=contentAry[indexPath.row];
//    CGRect  rect=self.tableView.frame;
//    self.tableView.frame=rect;
//    return cell;
    static NSString *aCellId = @"RepaymentHelpCell";
    RepaymentHelpCell *loanNumCell = [tableView dequeueReusableCellWithIdentifier:aCellId];
    if (!loanNumCell) {
        loanNumCell = [[[NSBundle mainBundle] loadNibNamed:@"RepaymentHelpCell" owner:self options:nil] lastObject];
    }
    loanNumCell.lblTitle.text = titleAry[indexPath.row];
    loanNumCell.lblContent.text=contentAry[indexPath.row];
    CGRect  rect=self.tableView.frame;
    self.tableView.frame=rect;
    return loanNumCell;
}



@end
