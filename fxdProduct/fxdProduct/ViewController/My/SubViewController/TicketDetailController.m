//
//  TicketDetailController.m
//  fxdProduct
//
//  Created by zy on 16/2/16.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "TicketDetailController.h"
#import "TicketCell.h"
#import "TicketExplainCell.h"
@interface TicketDetailController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TicketDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的红包";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self addBackItem];
    [self createTableView];
}

-(void)createTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=rgba(245, 245, 245, 1);
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight=142;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TicketCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TicketExplainCell" bundle:nil] forCellReuseIdentifier:@"explain"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        TicketCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.lblOverTime.hidden=YES;
        cell.backgroundColor=rgba(245, 245, 245, 1);
        [cell setValues:_redPacketModel];
        return cell;
    }
    else
    {
        TicketExplainCell *cell=[tableView dequeueReusableCellWithIdentifier:@"explain"];
        [cell setValues:_redPacketModel.validityPeriodFrom :_redPacketModel.validityPeriodTo];
        cell.backgroundColor=rgba(245, 245, 245, 1);
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
