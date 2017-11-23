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
#import "UserDataAuthenticationListVCModules.h"

@interface MyViewController () <UITableViewDataSource,UITableViewDelegate,MineMiddleViewDelegate>
{
    //标题数组
    NSArray *titleAry;
    //标题图片数组
    NSArray *imgAry;
   
}
@property (strong, nonatomic) IBOutlet UITableView *MyViewTable;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    titleAry=@[@"我的消息",@"借还记录",@"我的银行卡",@"邀请好友",@"更多"];
    imgAry=@[@"message",@"6_my_icon_03",@"6_my_icon_05",@"6_my_icon_11",@"icon_my_setup"];
    if (@available(iOS 11.0, *)) {
        self.MyViewTable.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    self.MyViewTable.scrollEnabled = NO;
    if (UI_IS_IPHONE4 || UI_IS_IPHONE5) {
        self.MyViewTable.scrollEnabled = YES;
    }
    [self.MyViewTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.MyViewTable registerNib:[UINib nibWithNibName:@"NextViewCell" bundle:nil] forCellReuseIdentifier:@"bCell"];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 120, 12);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

    UIView *headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 288)];
    //添加自定义头部
    MineHeaderView *headerView = [[MineHeaderView alloc]initWithFrame:CGRectZero];
    headerView.backgroundColor = UI_MAIN_COLOR;
    headerView.nameLabel.text = @"您好!";
    headerView.accountLabel.text = [FXD_Utility sharedUtility].userInfo.userMobilePhone;
    [headerBgView addSubview:headerView];
    
    MineMiddleView *middleView = [[MineMiddleView alloc]initWithFrame:CGRectZero];
//    middleView.redPacketNumLabel.text = @"3";
    middleView.couponNumLabel.text = @"3";
    middleView.backgroundColor = [UIColor whiteColor];
    middleView.delegate = self;
    [headerBgView addSubview:middleView];
    
    [self.MyViewTable setTableHeaderView:headerBgView];
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
    
    WithdrawViewController *controller = [[WithdrawViewController alloc]init];
    [self.navigationController pushViewController:controller animated:false];
    
//    SetTransactionInfoViewController * vc =  [[SetTransactionInfoViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:true];
//    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"现金红包"];

}


/**
 优惠券
 */
-(void)couponViewTap{
    
    CashRedEnvelopeViewController *controller = [[CashRedEnvelopeViewController alloc]init];
    controller.isWithdraw = true;
    [self.navigationController pushViewController:controller animated:true];

}


/**
 账户余额
 */
-(void)accountViewTap{
    
    CashRedEnvelopeViewController *controller = [[CashRedEnvelopeViewController alloc]init];
    [self.navigationController pushViewController:controller animated:true];

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
    if (indexPath.row == 0) {
        bCell.messageLabel.hidden = false;
        bCell.messageImage.hidden = false;
    }else{
        bCell.messageLabel.hidden = true;
        bCell.messageImage.hidden = true;
    }
    return bCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            MyMessageViewController *myMessageVC=[[MyMessageViewController alloc]init];
            [self.navigationController pushViewController:myMessageVC animated:true];
        }
            break;
        case 1:
        {
            
            RepayRecordController *repayRecord=[[RepayRecordController alloc]initWithNibName:@"RepayRecordController" bundle:nil];
            [self.navigationController pushViewController:repayRecord animated:true];
        }
            break;
        case 2:
        {
            MyCardsViewController *myCrad=[[MyCardsViewController alloc]initWithNibName:@"MyCardsViewController" bundle:nil];
            [self.navigationController pushViewController:myCrad animated:YES];
        }
            break;
        case 3:
        {
            InvitationViewController *invitationVC = [[InvitationViewController alloc] init];
            [self.navigationController pushViewController:invitationVC animated:true];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
