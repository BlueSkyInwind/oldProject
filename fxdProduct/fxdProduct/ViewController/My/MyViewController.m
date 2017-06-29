//
//  MyViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "MyViewController.h"
#import "MessageCenterViewController.h"
#import "NextViewCell.h"
#import "UserInfoViewController.h"
#import "MyCardsViewController.h"
#import "MoreViewController.h"
#import "UIImageView+WebCache.h"
#import "RepayRecordController.h"
#import "DiscountTicketController.h"
#import "BankModel.h"
#import "RepayListViewController.h"
#import "UserStateModel.h"
#import "InvitationViewController.h"
#import "RepayDetailViewController.h"
#import "RepayListInfo.h"
#import "RepayRequestManage.h"
#import "UserDataViewController.h"
#import "CheckViewModel.h"
#import "GetCaseInfo.h"
#import "QryUserStatusModel.h"
#import "P2PViewController.h"
#import "LoanMoneyViewController.h"
#import "HomeViewModel.h"

@interface MyViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titleAry;
    NSArray *imgAry;
    BankModel *_bankCardModel;
    UserStateModel *_model;
}
@property (strong, nonatomic) IBOutlet UITableView *MyViewTable;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的";
//    [self setNavMesRightBar];
    //    titleAry=@[@"个人资料",@"我要还款",@"优惠劵",@"借款记录",@"还款记录",@"我的银行卡"];
    titleAry=@[@"完善资料",@"我要还款",@"借款记录",@"我的红包",@"我的银行卡",@"邀请好友"];
    //  imgAry=@[@"6_my_icon_01",@"6_my_icon_02",@"6_my_icon_07",@"6_my_icon_03",@"6_my_icon_04",@"6_my_icon_05"];
 imgAry=@[@"6_my_icon_01",@"6_my_icon_02",@"6_my_icon_03",@"6_my_icon_07",@"6_my_icon_05",@"6_my_icon_11"];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.MyViewTable.scrollEnabled = NO;
    [self.MyViewTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.MyViewTable registerNib:[UINib nibWithNibName:@"NextViewCell" bundle:nil] forCellReuseIdentifier:@"bCell"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 120, 12);
}

-(void)viewWillAppear:(BOOL)animated{

    [self getApplyStatus];
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1 || section == 2) {
        return 20;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return titleAry.count-2;
    }
    else 
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//创建自定义头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 22)];
    view.backgroundColor=RGBColor(245, 245, 245, 1);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bCellId = @"bCell";
    NextViewCell *bCell = [tableView dequeueReusableCellWithIdentifier:bCellId];
    
    if (!bCell) {
        bCell = [[[NSBundle mainBundle]loadNibNamed:@"MyViewBCell" owner:self options:nil] lastObject];
    }
    if (indexPath.section == 0){
        bCell.lblTitle.text=titleAry[indexPath.row];
        bCell.imgView.image=[UIImage imageNamed:imgAry[indexPath.row]];
        if(indexPath.row==3) {
            bCell.lineView.hidden=YES;
        } else {
            bCell.lineView.hidden=NO;
        }
        return bCell;
    }  else if(indexPath.section == 1){
        bCell.lblTitle.text = titleAry[titleAry.count-2];
        bCell.imgView.image=[UIImage imageNamed:imgAry[imgAry.count-2]];
        bCell.lineView.hidden=YES;
        return bCell;
    } else {
        bCell.lblTitle.text = titleAry[titleAry.count-1];
        bCell.imgView.image=[UIImage imageNamed:imgAry[imgAry.count-1]];
        bCell.lineView.hidden=YES;
        return bCell;
    }
    return bCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0){
        if(indexPath.row==0) {
            UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
            userDataVC.product_id = SalaryLoan;
            [self.navigationController pushViewController:userDataVC animated:true];
            
        }else if (indexPath.row == 1) {
            if ([_model.platform_type isEqualToString:@"2"]) {
                
                [self getFxdCaseInfo];
            }else{
            
                RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                repayRequest.targetVC = self;
                [repayRequest repayRequest];
            }
        }
        else if (indexPath.row == 2){
            RepayRecordController *repayRecord=[[RepayRecordController alloc]initWithNibName:@"RepayRecordController" bundle:nil];
            [self.navigationController pushViewController:repayRecord animated:YES];
        }

        else {
            DiscountTicketController *ticket=[[DiscountTicketController alloc]init];
            [self.navigationController pushViewController:ticket animated:YES];
        }
    }
    else if(indexPath.section == 1) {
        [self fatchCardInfo];
    }else {
        InvitationViewController *invitationVC = [[InvitationViewController alloc] init];
        [self.navigationController pushViewController:invitationVC animated:true];
    }
}

- (void)fatchCardInfo
{
    NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        _bankCardModel = [BankModel yy_modelWithJSON:object];
        if ([_bankCardModel.flag isEqualToString:@"0000"]) {
            MyCardsViewController *myCrad=[[MyCardsViewController alloc]initWithNibName:@"MyCardsViewController" bundle:nil];
            myCrad.bankModel = _bankCardModel;
            [self.navigationController pushViewController:myCrad animated:YES];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_bankCardModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

#pragma mark 发标前查询进件
-(void)getFxdCaseInfo{
    
    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        GetCaseInfo *caseInfo = [GetCaseInfo yy_modelWithJSON:returnValue];
        if ([caseInfo.flag isEqualToString:@"0000"]) {
            
            [self getUserStatus:caseInfo];
        }
    } WithFaileBlock:^{
        
    }];
    [complianceViewModel getFXDCaseInfo];
    
}

#pragma mark  fxd用户状态查询，viewmodel
-(void)getUserStatus:(GetCaseInfo *)caseInfo{
    
    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        QryUserStatusModel *model = [QryUserStatusModel yy_modelWithJSON:returnValue];
        if ([model.flag isEqualToString:@"0000"]) {
            
            if ([model.result.flg isEqualToString:@"3"]) {
                NSString *url = [NSString stringWithFormat:@"%@%@?page_type_=%@&ret_url_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"1",_transition_url,[Utility sharedUtility].userInfo.userMobilePhone];
                P2PViewController *p2pVC = [[P2PViewController alloc] init];
                //        p2pVC.isOpenAccount = NO;
                p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [self.navigationController pushViewController:p2pVC animated:YES];
            }else if ([model.result.flg isEqualToString:@"12"]){
            
                LoanMoneyViewController *controller = [LoanMoneyViewController new];
                controller.userStateModel = _model;
                controller.qryUserStatusModel = model;
                [self.navigationController pushViewController:controller animated:YES];
            }else{
            
                RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                repayRequest.targetVC = self;
                [repayRequest repayRequest];
            
            }
            
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [complianceViewModel getUserStatus:caseInfo];
}

-(void)getApplyStatus{
    
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if([returnValue[@"flag"] isEqualToString:@"0000"])
        {
            _model = [UserStateModel yy_modelWithJSON:returnValue[@"result"]];
        
            
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
