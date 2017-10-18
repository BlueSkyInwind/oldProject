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
#import "InvitationViewController.h"
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
    self.title=@"优惠券";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addBackItem];
    [self addHelpItem];
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
-(void)addHelpItem{

    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithTitle:@"使用帮助" style:UIBarButtonItemStylePlain target:self action:@selector(goHelpVCClick)];
    self.navigationItem.rightBarButtonItem = aBarbi;
}

-(void)goHelpVCClick{
    
    
    
}

-(void)createNoneView
{
    NoneView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    NoneView.backgroundColor = RGBColor(245, 245, 245, 1);
    [self.view addSubview:NoneView];
    [NoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(@80);
    }];
    
    UIImageView *logoImg=[[UIImageView alloc]init];
    logoImg.image=[UIImage imageNamed:@"5_shenhe_icon_03"];
    [NoneView addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NoneView.mas_top).with.offset(60);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UILabel *lblNone=[[UILabel alloc]init];
    lblNone.numberOfLines = 0;
    lblNone.text = @"你当前没有优惠券";
    lblNone.textAlignment = NSTextAlignmentCenter;
    lblNone.font = [UIFont systemFontOfSize:18];
    lblNone.textColor = kUIColorFromRGB(0x4d4d4d);
    [NoneView addSubview:lblNone];
    [lblNone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImg.mas_bottom).with.offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@30);
        make.width.equalTo(@150);
    }];
    
    UILabel *prometLabel=[[UILabel alloc]init];
    prometLabel.numberOfLines = 0;
    prometLabel.text = @"邀请好友，可领优惠券";
    prometLabel.textAlignment = NSTextAlignmentCenter;
    prometLabel.font = [UIFont systemFontOfSize:20];
    prometLabel.textColor = kUIColorFromRGB(0x00AAEE);
    [NoneView addSubview:prometLabel];
    [prometLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblNone.mas_bottom).with.offset(50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@30);
        make.width.equalTo(@250);
    }];
    
    UIButton * invationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [invationBtn setTitle:@"立即邀请" forState:UIControlStateNormal];
    invationBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [invationBtn setTitleColor:kUIColorFromRGB(0x00AAee) forState:UIControlStateNormal];
    [Tool setCorner:invationBtn borderColor:kUIColorFromRGB(0x00AAee)];
    [invationBtn addTarget:self action:@selector(pushInvationFriend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:invationBtn];
    [invationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(prometLabel.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@130);
    }];
}

-(void)pushInvationFriend{
    InvitationViewController *invitationVC = [[InvitationViewController alloc] init];
    [self.navigationController pushViewController:invitationVC animated:true];
}

#pragma mark TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _validRedPacketArr.count;
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
