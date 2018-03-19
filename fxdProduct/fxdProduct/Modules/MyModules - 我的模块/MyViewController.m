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

    titleAry=@[@"我的消息",@"借还记录",@"我的银行卡",@"邀请好友",@"更多"];
    imgAry=@[@"message",@"6_my_icon_03",@"6_my_icon_05",@"6_my_icon_11",@"icon_my_setup"];
    if (@available(iOS 11.0, *)) {
        self.MyViewTable.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    self.MyViewTable.scrollEnabled = NO;
    if (UI_IS_IPHONE4 ) {
        self.MyViewTable.scrollEnabled = YES;
    }
    
    [self addHeaderView];
    [self.MyViewTable registerNib:[UINib nibWithNibName:@"NextViewCell" bundle:nil] forCellReuseIdentifier:@"bCell"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

    [self getMessageNumber];
    [self getExperienceValueGrade];
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
    [self.MyViewTable setTableHeaderView:headerBgView];
    
    _middleView = [[MineMiddleView alloc]initWithFrame:CGRectZero];
    _middleView.backgroundColor = [UIColor whiteColor];
    _middleView.delegate = self;
    [headerBgView addSubview:_middleView];
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
//            [_headerView.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.gradeLogo] placeholderImage:[UIImage imageNamed:@"placeholderImage_Icon"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//            } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            }];
            if ([model.gradeName isEqualToString:@"薪薪人类"]) {
                _headerView.isFirstLevel = @"2";
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
    
    CashRedEnvelopeViewController *controller = [[CashRedEnvelopeViewController alloc]init];
    [FXD_Utility sharedUtility].operateType = @"1";
    [self.navigationController pushViewController:controller animated:true];

}

/**
 优惠券
 */
-(void)couponViewTap{
    
    DiscountTicketController *ticket=[[DiscountTicketController alloc]init];
    [self.navigationController pushViewController:ticket animated:YES];

}


/**
 账户余额
 */
-(void)accountViewTap{
    
    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"暂未开放，敬请期待"];

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
    return 54;
}

//创建自定义头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 10)];
    view.backgroundColor=RGBColor(242, 242, 242, 1);
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
    bCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row == titleAry.count-1) {
        bCell.lineView.hidden=YES;
    } else {
        bCell.lineView.hidden=NO;
    }
    if (indexPath.row == 0) {
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
