//
//  MyViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "MyViewController.h"
#import "NextViewCell.h"
#import "MyCardsViewController.h"
#import "MoreViewController.h"
#import "RepayRecordController.h"
#import "DiscountTicketController.h"
#import "InvitationViewController.h"
#import "CashViewModel.h"
#import "PersonalCenterModel.h"
#import "MessageViewModel.h"
#import "AountStationLetterMsgModel.h"
#import "UITabBar+badge.h"
#import "MineViewModel.h"
#import "ExperienceValueGradeModel.h"
#import "LoginViewController.h"
#import "RepayMentViewModel.h"
#import "RepayListInfo.h"
@interface MyViewController () <UITableViewDataSource,UITableViewDelegate,MineMiddleViewDelegate,MineHeaderViewDelegate>
{
    //标题数组
    NSArray *titleAry;
    //标题图片数组
    NSArray *imgAry;
    AountStationLetterMsgModel *model;
    NSString *_h5_url_;
   
}
@property (strong, nonatomic) IBOutlet UITableView *MyViewTable;
@property (nonatomic, strong) MineMiddleView *middleView;
@property (nonatomic, strong) MineHeaderView *headerView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    titleAry=@[@"我的账单",@"我的订单",@"我的消息",@"收藏",@"我的银行卡",@"更多"];
    imgAry=@[@"bill",@"order",@"message",@"6_my_icon_2",@"6_my_icon_05",@"icon_my_setup"];
    if (@available(iOS 11.0, *)) {
        self.MyViewTable.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    self.MyViewTable.scrollEnabled = YES;

    [self.MyViewTable registerNib:[UINib nibWithNibName:@"NextViewCell" bundle:nil] forCellReuseIdentifier:@"bCell"];
    
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
//    [self getExperienceValueGrade];
//    [self getPersonalCenterInfo];
    
}



/**
 增加headerview
 */
-(void)addHeaderView{
    
    int height;
    height = 238;
    if (UI_IS_IPHONE6P) {
        height = 268;
    }
    UIView *headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, height)];
    //添加自定义头部
    _headerView = [[MineHeaderView alloc]initWithFrame:CGRectZero];
    _headerView.backgroundColor = UI_MAIN_COLOR;
    _headerView.delegate = self;
    [headerBgView addSubview:_headerView];
    if ([FXD_Utility sharedUtility].loginFlage) {
        _headerView.accountLabel.text = [FXD_Utility sharedUtility].userInfo.userMobilePhone;
    } else {
        _headerView.accountLabel.text = @"未登录，请登录";
    }
    [self.MyViewTable setTableHeaderView:headerBgView];
    _middleView = [[MineMiddleView alloc]initWithFrame:CGRectZero];
    _middleView.backgroundColor = [UIColor whiteColor];
    _middleView.delegate = self;
    [headerBgView addSubview:_middleView];
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
 经验值体系-展示等级
 */
-(void)getExperienceValueGrade{
    
    MineViewModel *mineMV = [[MineViewModel alloc]init];
    [mineMV setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = returnValue;
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            ExperienceValueGradeModel *model = [[ExperienceValueGradeModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            [_headerView.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.gradeLogo]];

            if ([model.gradeName isEqualToString:@"薪薪人类"]) {
//                _headerView.isFirstLevel = @"2";
            }
            _headerView.accountLabel.text = model.mobilePhone;
            _headerView.nameLabel.text = model.gradeName;
            _h5_url_ = model.h5_url_;
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [mineMV getExperienceValueGrad];
}

/**
 点击等级跳转
 */
-(void)shadowImageViewClick{
    
    FXDWebViewController *webView = [[FXDWebViewController alloc] init];
    webView.urlStr = _h5_url_;
    [self.navigationController pushViewController:webView animated:YES];
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
            _middleView.couponNumLabel.text = model.voucherNum;
            _middleView.couponNumLabel.hidden = false;
            _middleView.couponImageView.hidden = false;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 2;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

//创建自定义头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 5)];
    view.backgroundColor=RGBColor(242, 242, 242, 1);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bCellId = @"bCell";
    NextViewCell *bCell = [tableView dequeueReusableCellWithIdentifier:bCellId];
    
    if (!bCell) {
        bCell = [[[NSBundle mainBundle]loadNibNamed:@"MyViewBCell" owner:self options:nil] lastObject];
    }
    
    NSInteger index = 0;
    if (indexPath.section == 0) {
        index = indexPath.row;
    }
    if (indexPath.section == 1) {
        
        index = indexPath.row + 2;
    }
    if (indexPath.section == 2) {
        index = indexPath.row + 4;
    }
    
    bCell.lblTitle.text=titleAry[index];
    bCell.imgView.image=[UIImage imageNamed:imgAry[index]];
    bCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if((indexPath.section == 0 && indexPath.row == 1)||(indexPath.section == 1 && indexPath.row == 1) || (indexPath.section == 2 && indexPath.row == 1)) {
        bCell.lineView.hidden=YES;
    } else {
        bCell.lineView.hidden=NO;
    }
    if (indexPath.row == 0 && indexPath.section == 1) {
        if ([model.isDisplay isEqualToString:@"1"]) {
            bCell.messageLabel.text = model.countNum;
            bCell.messageView.hidden = false;

            if (model.countNum.integerValue > 9) {
               
                bCell.messageViewX.constant = 25;
                bCell.messageViewWidth.constant = 24;

            }else{
                
                bCell.messageViewX.constant = 33;
                bCell.messageViewWidth.constant = 13;

            }
            if (model.countNum.integerValue > 99) {
                bCell.messageLabel.text = @"99+";
            }
        }else{
            bCell.messageView.hidden = true;
        }
    }else{
        bCell.messageView.hidden = true;
    }
    return bCell;
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
                    [self getData];
//                    MyBillViewController *controller=[[MyBillViewController alloc]init];
//                    [self.navigationController pushViewController:controller animated:true];
                }
                    break;
                case 1:
                {
                    MyOrdersViewController * controller = [[MyOrdersViewController alloc]init];
                    [self.navigationController pushViewController:controller animated:true];
                }
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
                    {
                        
                        CollectionViewController * controller = [[CollectionViewController alloc]init];
                        [self.navigationController pushViewController:controller animated:true];

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
                        MyCardsViewController *myCrad=[[MyCardsViewController alloc]initWithNibName:@"MyCardsViewController" bundle:nil];
                        [self.navigationController pushViewController:myCrad animated:YES];
                    }
                    break;
                case 1:
                    {
                        MoreViewController *ticket=[[MoreViewController alloc]init];
                        [self.navigationController pushViewController:ticket animated:YES];
                    }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

- (void)presentLogin:(UIViewController *)vc
{
    LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
    [vc presentViewController:nav animated:YES completion:nil];
}


#pragma mark 我的账单状态
-(void)getData{
    
    RepayMentViewModel *viewModel = [[RepayMentViewModel alloc]init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = returnValue;
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            MyBillViewController *controller=[[MyBillViewController alloc]init];
            [self.navigationController pushViewController:controller animated:true];
            
        }else if([baseResultM.friendErrMsg containsString:@"正在"]||[baseResultM.friendErrMsg containsString:@"结清"] || [baseResultM.friendErrMsg containsString:@"还款"]){
          
            self.tabBarController.selectedIndex = 0;
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
        
    } WithFaileBlock:^{
        
    }];
    [viewModel fatchQueryWeekShouldAlsoAmount:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
