//
//  MyViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "MyViewController.h"
#import "MyCardsViewController.h"
#import "MoreViewController.h"
#import "DiscountTicketController.h"
#import "CashViewModel.h"
#import "PersonalCenterModel.h"
#import "MessageViewModel.h"
#import "AountStationLetterMsgModel.h"
#import "UITabBar+badge.h"
#import "LoginViewController.h"
#import "IdeaBackViewController.h"

@interface MyViewController () <UITableViewDataSource,UITableViewDelegate,MineHeaderViewDelegate>
{
    //标题数组
    NSArray *titleAry;
    //标题图片数组
    NSArray *imgAry;
    AountStationLetterMsgModel *model;
    NSString *_h5_url_;
    FXD_HomeProductListModel *_homeProductModel;
   
}
@property (strong, nonatomic) IBOutlet UITableView *MyViewTable;
@property (nonatomic, strong) MineHeaderView *headerView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    titleAry=@[@"我的订单",@"优惠券",@"消息",@"会员中心",@"银行卡",@"意见反馈",@"关于我们",@"设置"];
    imgAry=@[@"order",@"my-icon02",@"my-icon03",@"my-icon04",@"my-icon05",@"my-icon07",@"my-icon08",@"my-icon09"];
    if (@available(iOS 11.0, *)) {
        self.MyViewTable.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    self.MyViewTable.scrollEnabled = YES;
    [self.MyViewTable registerClass:[MineCell class] forCellReuseIdentifier:@"MineCell"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self addHeaderView];
    
    //检测登录
    if ([FXD_Utility sharedUtility].loginFlage) {
        [self getMessageNumber];
    }else{
        model.isDisplay = @"0";
        [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
        [self.MyViewTable reloadData];
    }
    
    [self getData];
//    [self getPersonalCenterInfo];
}

-(void)getData{
    __weak typeof (self) weakSelf = self;
    HomeViewModel * homeViewModel = [[HomeViewModel alloc]init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        
        _homeProductModel = [[FXD_HomeProductListModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            _headerView.type = _homeProductModel.flag;
            if (_homeProductModel.repayInfo != nil) {
                
                _headerView.moneyLabel.text = [NSString stringWithFormat:@"%@元",_homeProductModel.repayInfo.repayAmount];
                _headerView.dateLabel.text = [NSString stringWithFormat:@"还款日: %@",_homeProductModel.repayInfo.repayDate];;
                [_headerView.timeBtn setTitle:@"14天后" forState:UIControlStateNormal];
                [_headerView.timeBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
            }
            
            if (_homeProductModel.overdueInfo != nil) {
                
                _headerView.moneyLabel.text = [NSString stringWithFormat:@"%@元",_homeProductModel.overdueInfo.repayAmount];
                _headerView.dateLabel.text = [NSString stringWithFormat:@"还款日: %@",_homeProductModel.repayInfo.repayDate];;
                [_headerView.timeBtn setTitle:[NSString stringWithFormat:@"%@天后",_homeProductModel.overdueInfo.overdueDays] forState:UIControlStateNormal];
                [_headerView.timeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            
        }else{
            
            [[MBPAlertView sharedMBPTextView]showTextOnly:weakSelf.view message:baseResultM.friendErrMsg];
        }
        
        
    } WithFaileBlock:^{
    
    }];
    [homeViewModel homeDataRequest];
}

/**
 增加headerview
 */
-(void)addHeaderView{
    
    //添加自定义头部
    _headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 180)];
    _headerView.type = @"1";
    _headerView.titleLabel.text = @"待还款";
//    _headerView.moneyLabel.text = @"2300.34元";
//    _headerView.dateLabel.text = @"还款日：2017.03.24";
//    [_headerView.timeBtn setTitle:@"14天后" forState:UIControlStateNormal];
    _headerView.backgroundColor = [UIColor clearColor];
    _headerView.delegate = self;
    [self.view addSubview:_headerView];
    
    [self.MyViewTable setTableHeaderView:_headerView];

}

-(void)bottomBtnClick{
    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"待还款"];
}
-(void)memberBtnClick{
    //检测登录
    if (![FXD_Utility sharedUtility].loginFlage) {
        [self presentLogin:self];
        return;
    }
    MemberCenterViewController * memberCenterVC = [[MemberCenterViewController alloc]init];
    [self.navigationController pushViewController:memberCenterVC animated:true];
}

/**
 获取个人中心消息的个数
 */
-(void)getMessageNumber{
    
    MessageViewModel *messageVM = [[MessageViewModel alloc]init];
    [messageVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            model = [[AountStationLetterMsgModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            if ([model.isDisplay isEqualToString:@"1"]) {
                [self.tabBarController.tabBar showBadgeOnItemIndex:2];
            }else{
                [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
            }
            [self.MyViewTable reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [messageVM countStationLetterMsg];
}
/**
 获取个人中心优惠券的个数
 */
-(void)getPersonalCenterInfo{

    CashViewModel *cashVM = [[CashViewModel alloc]init];
    [cashVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            PersonalCenterModel *model = [[PersonalCenterModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
//            _middleView.couponNumLabel.text = model.voucherNum;
//            _middleView.couponNumLabel.hidden = false;
//            _middleView.couponImageView.hidden = false;
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [cashVM getPersonalCenterInfo];
}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
 
}

#pragma mark 我的页面中间部分点击事件

/**
 现金红包
 */
-(void)redPacketViewTap{
    //检测登录
    if (![FXD_Utility sharedUtility].loginFlage) {
        [self presentLogin:self];
        return;
    }
    CashRedEnvelopeViewController *controller = [[CashRedEnvelopeViewController alloc]init];
    [FXD_Utility sharedUtility].operateType = @"1";
    [self.navigationController pushViewController:controller animated:true];
}

/**
 优惠券
 */
-(void)couponViewTap{
    //检测登录
    if (![FXD_Utility sharedUtility].loginFlage) {
        [self presentLogin:self];
        return;
    }
    DiscountTicketController *ticket=[[DiscountTicketController alloc]init];
    [self.navigationController pushViewController:ticket animated:YES];

}

/**
 账户余额
 */
-(void)accountViewTap{
    //检测登录
    if (![FXD_Utility sharedUtility].loginFlage) {
        [self presentLogin:self];
        return;
    }
    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"暂未开放，敬请期待"];
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

//创建自定义头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 5)];
    view.backgroundColor=RGBColor(242, 242, 242, 1);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MineCell" owner:self options:nil] lastObject];
    }
    
    NSInteger index = 0;
    switch (indexPath.section) {
        case 0:
            index = indexPath.row;
            break;
        case 1:
            index = indexPath.row + 2;
            break;
        case 2:
            index = indexPath.row + 5;
            break;
        case 3:
            index = indexPath.row + 7;
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleImageView.image = [UIImage imageNamed:imgAry[index]];
    cell.titleLabel.text = titleAry[index];

    if((indexPath.section == 0 && indexPath.row == 1)||(indexPath.section == 1 && indexPath.row == 2) || (indexPath.section == 2 && indexPath.row == 1) || indexPath.section == 3) {
        
        cell.lineView.hidden = true;

    } else {

        cell.lineView.hidden = false;
        
    }
    if (indexPath.row == 0 && indexPath.section == 1) {
        if ([model.isDisplay isEqualToString:@"1"]) {
            cell.messageLabel.text = model.countNum;
            cell.messageView.hidden = false;
            cell.messageLabel.hidden = false;

            if (model.countNum.integerValue > 9) {
                
                cell.messageLabel.hidden = true;

            }
            
        }else{
            
            cell.messageView.hidden = true;
        }
    }else{
        
        cell.messageView.hidden = true;

    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //检测登录
    if (![FXD_Utility sharedUtility].loginFlage) {
        [self presentLogin:self];
        return;
    }
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    MyOrdersViewController * controller = [[MyOrdersViewController alloc]init];
                    [self.navigationController pushViewController:controller animated:true];
                }
                    break;
                case 1:

                    [self couponViewTap];
                    
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    {
                        
                        loginAndRegisterModules *myMessageVC=[[loginAndRegisterModules alloc]init];

//                        MyMessageViewController *myMessageVC=[[MyMessageViewController alloc]init];
                        [self.navigationController pushViewController:myMessageVC animated:true];
                    }
                    break;
                case 1:
                        
                    [self memberBtnClick];

                    break;
                case 2:
                {
                    MyCardsViewController *myCrad=[[MyCardsViewController alloc]initWithNibName:@"MyCardsViewController" bundle:nil];
                    [self.navigationController pushViewController:myCrad animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
            
        case 2:
            switch (indexPath.row) {
                case 0:
                    {
                        if ([FXD_Utility sharedUtility].loginFlage) {
                            IdeaBackViewController *ideaBack=[[IdeaBackViewController alloc]initWithNibName:@"IdeaBackViewController" bundle:nil];
                            [self.navigationController pushViewController:ideaBack animated:YES];
                        } else {
                            [self presentLogin:self];
                        }
                    }
                    break;
                case 1:
                    
                    [self obtainQuestionWebUrl:@"11"];
                    
                    break;
                default:
                    break;
            }
            break;
        case 3:
        {
            MoreViewController *ticket=[[MoreViewController alloc]init];
            [self.navigationController pushViewController:ticket animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)presentLogin:(UIViewController *)vc
{
//    LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
//    [vc presentViewController:nav animated:YES completion:nil];
    
    loginAndRegisterModules *myMessageVC=[[loginAndRegisterModules alloc]init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:myMessageVC];
    [vc presentViewController:nav animated:YES completion:nil];

}

-(void)obtainQuestionWebUrl:(NSString *)typeCode{
    
    CommonViewModel * commonVM = [[CommonViewModel alloc]init];
    [commonVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = returnValue;
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            NSDictionary * dic = (NSDictionary *)baseResultM.data;
            FXDWebViewController * fxdwebVC = [[FXDWebViewController alloc]init];
            fxdwebVC.urlStr =  [dic objectForKey:@"productProURL"];
            [self.navigationController pushViewController:fxdwebVC animated:YES];
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [commonVM obtainProductProtocolType:nil typeCode:typeCode apply_id:nil periods:nil stagingType:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
