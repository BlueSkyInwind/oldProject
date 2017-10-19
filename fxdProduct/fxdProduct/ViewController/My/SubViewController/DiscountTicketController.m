//
//  DiscountTicketController.m
//  fxdProduct
//
//  Created by zy on 16/2/15.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "DiscountTicketController.h"
#import "TicketCell.h"
#import "RedPacketTicketModel.h"
#import "RepayWeeklyRecordViewModel.h"
#import "InvitationViewController.h"
#import "DiscountTicketModel.h"
#import "LapseDiscountTicketViewController.h"

@interface DiscountTicketController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *NoneView;
    RedPacketTicketModel *_redPacketTicketM;
    DiscountTicketModel * discountTicketModel;
    
}
@property (nonatomic,strong)NSMutableArray * validTicketArr;
@end

@implementation DiscountTicketController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"优惠券";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self addBackItem];
    [self addHelpItem];
    [self createTableView];
    [self createbottomView];
    _validTicketArr = [NSMutableArray array];
    
    [self addObserver:self forKeyPath:@"validTicketArr" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"validTicketArr"]) {
        if (_validTicketArr.count == 0 || _validTicketArr == nil) {
            [self createNoneView];
        }
    }
}

- (void)fatchRedpacket
{
    if (self.validTicketArr.count > 0) {
        [self.validTicketArr removeAllObjects];
    }
    [self obtainDiscountTicket];
    RepayWeeklyRecordViewModel *repayWeeklyRecordViewModel = [[RepayWeeklyRecordViewModel alloc]init];
    [repayWeeklyRecordViewModel setBlockWithReturnBlock:^(id returnValue) {
        [self.tableView.mj_header endRefreshing];
         BaseResultModel *  baseModel = [[BaseResultModel alloc] initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseModel.flag isEqualToString:@"0000"]) {
            _redPacketTicketM = [[RedPacketTicketModel alloc]initWithDictionary:(NSDictionary *)baseModel.result error:nil];
            for (RedpacketDetailModel *redpacketDetailM in _redPacketTicketM.validRedPacket) {
                if ([redpacketDetailM.is_valid_ boolValue]) {
                    [self.validTicketArr addObject:redpacketDetailM];
                }
            }
            if (self.validTicketArr.count < 1) {
                NoneView.hidden = NO;
            }else {
                NoneView.hidden = YES;
                [self.tableView reloadData];
            }
        } else {
            NoneView.hidden = NO;
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseModel.msg];
        }
    } WithFaileBlock:^{
        NoneView.hidden = NO;
    }];
    [repayWeeklyRecordViewModel getUserRedpacketList];
}

-(void)obtainDiscountTicket{
    ApplicationViewModel * applicationVM = [[ApplicationViewModel alloc]init];
    [applicationVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            DiscountTicketModel * discountTicketM = [[DiscountTicketModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            discountTicketModel = discountTicketM;
            for (DiscountTicketDetailModel *discountTicketDetailM in discountTicketM.valid) {
                    [self.validTicketArr addObject:discountTicketDetailM];
            }
            [self.tableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [applicationVM obtainUserDiscountTicketList:@"1"];
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
    NoneView =[[UIView alloc]init];
    NoneView.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self.view addSubview:NoneView];
    [NoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
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
    [NoneView addSubview:invationBtn];
    [invationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(prometLabel.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@130);
    }];
}
-(void)createbottomView{
    
    self.tableView.frame = CGRectMake(0, 64, _k_w, _k_h - 164);
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushInVailDiscountTicketVC)];
    [bottomView addGestureRecognizer:tap];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-60));
        make.left.right.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    UILabel * prometLabel = [[UILabel alloc]init];
    prometLabel.text = @"查看过期优惠券";
    prometLabel.textColor = kUIColorFromRGB(0x666666);
    prometLabel.font = [UIFont systemFontOfSize:13];
    prometLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:prometLabel];
    [prometLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX).with.offset(-10);
        make.centerY.equalTo(bottomView.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    UIImageView * leftIcon = [[UIImageView alloc]init];
    leftIcon.image = [UIImage imageNamed:@"left_Image_icon"];
    [bottomView addSubview:leftIcon];
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(prometLabel.mas_right).with.offset(0);
        make.width.equalTo(@15);
        make.height.equalTo(@13);
    }];
}

-(void)pushInVailDiscountTicketVC{
    
    LapseDiscountTicketViewController *lapseDiscountTicketVC = [[LapseDiscountTicketViewController alloc] init];
    lapseDiscountTicketVC.invalidTicketArr = [discountTicketModel.invalid mutableCopy];
    [self.navigationController pushViewController:lapseDiscountTicketVC animated:true];
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
    return _validTicketArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    id resultParse = [_validTicketArr objectAtIndex:indexPath.section];
    if ([resultParse isKindOfClass:[RedpacketDetailModel class]]) {
        [cell setValues:resultParse];
    }
    if ([resultParse isKindOfClass:[DiscountTicketDetailModel class]]) {
        [cell setVailValues:resultParse];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
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
