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
#import "UserDataViewController.h"
#import "ThirdWebViewController.h"
@interface MyViewController () <UITableViewDataSource,UITableViewDelegate,ShanLinBackAlertViewDelegate>
{
    NSArray *titleAry;
    NSArray *imgAry;
   
}
@property (strong, nonatomic) IBOutlet UITableView *MyViewTable;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    titleAry=@[@"借还记录",@"我的银行卡",@"邀请好友",@"优惠券",@"更多"];
    imgAry=@[@"6_my_icon_03",@"6_my_icon_05",@"6_my_icon_11",@"6_my_icon_07",@"icon_my_setup"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.MyViewTable.scrollEnabled = NO;
    if (UI_IS_IPHONE4) {
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

    MineHeaderView *headerView = [[MineHeaderView alloc]initWithFrame:CGRectZero];
    headerView.backgroundColor = UI_MAIN_COLOR;
    headerView.nameLabel.text = @"您好!";
    headerView.accountLabel.text = [Utility sharedUtility].userInfo.userMobilePhone;
    [self.MyViewTable setTableHeaderView:headerView];
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
        {
//            LoanSureFirstViewController *loanFirstVC = [[LoanSureFirstViewController alloc] init];
//            loanFirstVC.productId = @"P001002";
//            [self.navigationController pushViewController:loanFirstVC animated:true];
            RepayRecordController *repayRecord=[[RepayRecordController alloc]initWithNibName:@"RepayRecordController" bundle:nil];
            [self.navigationController pushViewController:repayRecord animated:true];
        }
            break;
        case 1:
        {
            MyCardsViewController *myCrad=[[MyCardsViewController alloc]initWithNibName:@"MyCardsViewController" bundle:nil];
            [self.navigationController pushViewController:myCrad animated:YES];
        }
            break;
        case 2:
        {
            InvitationViewController *invitationVC = [[InvitationViewController alloc] init];
            [self.navigationController pushViewController:invitationVC animated:true];
        }
            break;
        case 3:
        {
            DiscountTicketController *ticket=[[DiscountTicketController alloc]init];
            [self.navigationController pushViewController:ticket animated:YES];
        }
            break;
        case 4:
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
