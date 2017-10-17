//
//  DiscountTicketController.m
//  fxdProduct
//
//  Created by zy on 16/2/15.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "DiscountTicketController.h"
#import "TicketCell.h"
#import "TicketDetailController.h"
#import "RedpacketBaseClass.h"
#import "RepayWeeklyRecordViewModel.h"
@interface DiscountTicketController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *NoneView;
    RedpacketBaseClass *_redPacketParse;
    NSMutableArray *_validRedPacketArr;
}
@end

@implementation DiscountTicketController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的红包";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addBackItem];
    [self createTableView];
    [self createNoneView];
    _validRedPacketArr = [NSMutableArray array];
    //    [self fatchRedpacket];
}

- (void)fatchRedpacket
{
    if (_validRedPacketArr.count > 0) {
        [_validRedPacketArr removeAllObjects];
    }
    
    RepayWeeklyRecordViewModel *repayWeeklyRecordViewModel = [[RepayWeeklyRecordViewModel alloc]init];
    [repayWeeklyRecordViewModel setBlockWithReturnBlock:^(id returnValue) {
        [self.tableView.mj_header endRefreshing];
        _redPacketParse = [RedpacketBaseClass modelObjectWithDictionary:returnValue];
        for (RedpacketResult *result in _redPacketParse.result) {
            if (result.valid) {
                [_validRedPacketArr addObject:result];
            }
        }
        if ([_redPacketParse.flag isEqualToString:@"0000"]) {
            if (_validRedPacketArr.count < 1) {
                NoneView.hidden = NO;
            }else {
                NoneView.hidden = YES;
                [self.tableView reloadData];
            }
        } else {
            NoneView.hidden = NO;
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_redPacketParse.msg];
        }
        DLog(@"%@",_redPacketParse);
    } WithFaileBlock:^{
        NoneView.hidden = NO;
    }];
    [repayWeeklyRecordViewModel getUserRedpacketList];

}

-(void)createTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64, _k_w, _k_h-64) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=rgba(245, 245, 245, 1);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"TicketCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fatchRedpacket)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
}

-(void)createNoneView
{
    NoneView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    NoneView.backgroundColor = RGBColor(245, 245, 245, 1);
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((_k_w-130)/2, 132, 130, 130)];
    logoImg.image=[UIImage imageNamed:@"my-logo"];
    UILabel *lblNone=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-180)/2, logoImg.frame.origin.y+logoImg.frame.size.height+25, 180, 25)];
    lblNone.numberOfLines = 0;
    lblNone.text = @"您当前没有红包";
    lblNone.textAlignment = NSTextAlignmentCenter;
    lblNone.font = [UIFont systemFontOfSize:16];
    lblNone.textColor = RGBColor(180, 180, 181, 1);
    [NoneView addSubview:logoImg];
    [NoneView addSubview:lblNone];
    NoneView.hidden = YES;
    [self.view addSubview:NoneView];
}

#pragma mark TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _validRedPacketArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    RedpacketResult *resultParse = [_validRedPacketArr objectAtIndex:indexPath.section];
    [cell setValues:resultParse];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketDetailController *ticket=[TicketDetailController new];
    RedpacketResult *resultParse = [_validRedPacketArr objectAtIndex:indexPath.section];
    ticket.redPacketModel = resultParse;
    [self.navigationController pushViewController:ticket animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 30)];
        view.backgroundColor=[UIColor whiteColor];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _k_w, 10)];
        lbl.backgroundColor=rgba(245, 245, 245, 1);
        [view addSubview:lbl];
        return view;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 20)];
    view.backgroundColor=[UIColor whiteColor];
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 20)];
    view.backgroundColor=[UIColor whiteColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 30;
    }
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==3)
    {
        return 20;
    }
    
    return CGFLOAT_MIN;
}

//隐藏与现实tabbar
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
