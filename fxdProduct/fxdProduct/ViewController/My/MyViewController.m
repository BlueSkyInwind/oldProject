//
//  MyViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "MyViewController.h"
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
#import "SupportBankList.h"
@interface MyViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titleAry;
    NSArray *imgAry;
    BankModel *_bankCardModel;
    NSMutableArray *_supportBankListArr;
    UserStateModel *_model;
}
@property (strong, nonatomic) IBOutlet UITableView *MyViewTable;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    titleAry=@[@"我要还款",@"借还记录",@"我的银行卡",@"邀请好友",@"我的红包",@"更多"];
    imgAry=@[@"6_my_icon_02",@"6_my_icon_03",@"6_my_icon_05",@"6_my_icon_11",@"6_my_icon_07",@"icon_my_setup"];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.MyViewTable.scrollEnabled = NO;
    MineHeaderView *headerView = [[MineHeaderView alloc]initWithFrame:CGRectZero];
    headerView.backgroundColor = UI_MAIN_COLOR;
    headerView.nameLabel.text = @"您好!";
    headerView.accountLabel.text = @"15883945876";
    [self.MyViewTable setTableHeaderView:headerView];
    [self.MyViewTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.MyViewTable registerNib:[UINib nibWithNibName:@"NextViewCell" bundle:nil] forCellReuseIdentifier:@"bCell"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 120, 12);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if ([Utility sharedUtility].loginFlage) {
        [self getApplyStatus:^(BOOL isSuccess, UserStateModel *resultModel) {
        }];
    }
}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return titleAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//创建自定义头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 10)];
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
    bCell.lblTitle.text=titleAry[indexPath.row];
    bCell.imgView.image=[UIImage imageNamed:imgAry[indexPath.row]];
    if(indexPath.row == titleAry.count-1) {
        bCell.lineView.hidden=YES;
    } else {
        bCell.lineView.hidden=NO;
    }
    return bCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            //platform_type  2、合规   0、发薪贷
            if ([_model.platform_type isEqualToString:@"2"]) {
                //applyStatus  7、8 待还款
                if ([_model.applyStatus isEqualToString:@"7"]||[_model.applyStatus isEqualToString:@"8"]) {
                    //查询用户状态
                    [self getFxdCaseInfo];
                }else{
                    
                    RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                    repayRequest.targetVC = self;
                    [repayRequest repayRequest];
                }
            }else{
                RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                repayRequest.targetVC = self;
                [repayRequest repayRequest];
            }
            break;
        case 1:
        {
            RepayRecordController *repayRecord=[[RepayRecordController alloc]initWithNibName:@"RepayRecordController" bundle:nil];
            [self.navigationController pushViewController:repayRecord animated:YES];
        }
            break;
        case 2:
            [self fatchCardInfo];
            break;
        case 3:
        {
            UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
//            userDataVC.product_id = WhiteCollarLoan;
            [self.navigationController pushViewController:userDataVC animated:true];
//            InvitationViewController *invitationVC = [[InvitationViewController alloc] init];
//            [self.navigationController pushViewController:invitationVC animated:true];
        }
            break;
        case 4:
        {
            DiscountTicketController *ticket=[[DiscountTicketController alloc]init];
            [self.navigationController pushViewController:ticket animated:YES];
        }
            break;
        case 5:
        {
            MoreViewController *ticket=[[MoreViewController alloc]init];
            [self.navigationController pushViewController:ticket animated:YES];
            
        }
            break;
        default:
            break;
    }
}

- (void)fatchCardInfo
{

    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResult.flag isEqualToString:@"0000"]) {
            NSArray * array  = (NSArray *)baseResult.result;
            _supportBankListArr = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [_supportBankListArr addObject:bankList];
            }
            MyCardsViewController *myCrad=[[MyCardsViewController alloc]initWithNibName:@"MyCardsViewController" bundle:nil];
            myCrad.supportBankListArr = _supportBankListArr;
            [self.navigationController pushViewController:myCrad animated:YES];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getSupportBankListInfo:@"2"];
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
            
            if ([model.result.flg isEqualToString:@"3"]) {//待激活
                NSString *url = [NSString stringWithFormat:@"%@%@?page_type_=%@&ret_url_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"1",_transition_url,[Utility sharedUtility].userInfo.userMobilePhone];
                P2PViewController *p2pVC = [[P2PViewController alloc] init];
                p2pVC.isRepay = YES;
                p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [self.navigationController pushViewController:p2pVC animated:YES];
            }else if ([model.result.flg isEqualToString:@"12"]){//处理中
            
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

/**
 申请件状态查询
 */

-(void)getApplyStatus:(void(^)(BOOL isSuccess, UserStateModel *resultModel))finish{
    
    [[FXDNetWorkManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_userState_url]   isNeedNetStatus:NO isNeedWait:NO parameters:nil finished:^(EnumServerStatus status, id object) {
        if([object[@"flag"] isEqualToString:@"0000"])
        {
            _model = [UserStateModel yy_modelWithJSON:object[@"result"]];
            finish(YES,_model);
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:object[@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
