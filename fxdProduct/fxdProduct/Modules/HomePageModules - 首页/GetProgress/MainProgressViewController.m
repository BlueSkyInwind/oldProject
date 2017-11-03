//
//  MainProgressViewController.m
//  fxdProduct
//
//  Created by zy on 15/12/8.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "MainProgressViewController.h"
#import "RepaymentViewCell.h"
#import "DrawMoneyView.h"
#import "RepaymentViewController.h"
#import "testView.h"
#import "UserStateBaseClass.h"
#import <ShareSDK/ShareSDK.h>
#import "HomeViewModel.h"


//MakeSureBtnDelegate
@interface MainProgressViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NSArray *imgAry;
    NSArray *titleAry;
    NSMutableArray *moneyAry;
    //    DrawMoneyView *darwmoney;
    //    testView *TestView;
    //我要还款页面
    RepaymentViewController *payment;
    UIActionSheet *shareSheet;
    UIView *NoneView;
    UserStateBaseClass *_userStateParse;
    UIButton *loadBtn;
    
}
@end

@implementation MainProgressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem1];
    [self createNoneView];
    [self loadMyView];
    self.navigationItem.title=@"借款进度";
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    imgAry=@[@"flow-04-icon01",@"flow-04-icon02",@"flow-04-icon03",@"flow-04-icon04"];
    titleAry=@[@"借款金额",@"借款周期",@"每周还款",@"总还款额"];
    moneyAry = [NSMutableArray arrayWithObjects:@"0元",@"0周",@"0元",@"0元", nil];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    DLog(@"%f",_userStateParse.result.resultIdentifier);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RepaymentViewCell" bundle:nil] forCellReuseIdentifier:@"Progress"];
    
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        _userStateParse = returnValue;
        if (_userStateParse.result.loanAmount > 0.0) {
            [Utility sharedUtility].getMineyInfo.loanAmount = _userStateParse.result.loanAmount;
        } else {
            [Utility sharedUtility].getMineyInfo.loanAmount = 0;
        }
        
        if (_userStateParse.result.periods > 0.0) {
            [Utility sharedUtility].getMineyInfo.periods = _userStateParse.result.periods;
        } else {
            [Utility sharedUtility].getMineyInfo.periods = 0;
        }
        if([_userStateParse.flag isEqualToString:@"0000"])
        {
            self.stateFlag = [_userStateParse.result.status integerValue];
            [self loadMyView];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userStateParse.msg];
        }
        
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState];
}
- (void)addBackItem1
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    UIImage *img = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
}

- (void)popBack
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)loadMyView
{
    switch (self.stateFlag) {
        case 1081://系统审核
            NoneView.hidden=YES;
            self.lblTitle.text=@"系统审核";
            self.lblDetailText.text=@"请耐心等候";
            self.lblTipText.text=@"您的资料正在审核,请稍后";
            self.submitBtn.hidden=NO;
            self.submitBtn.enabled=YES;
            [self.submitBtn setBackgroundImage:[UIImage imageNamed:@"flow-04-home"] forState:UIControlStateNormal];
            [moneyAry replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.0f元",_userStateParse.result.applyAmount]];
            [moneyAry replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.0f周",_userStateParse.result.periods]];
            [moneyAry replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.2f元",_userStateParse.result.applyAmount/_userStateParse.result.periods + _userStateParse.result.applyAmount*0.021]];
            [moneyAry replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.2f元",(_userStateParse.result.applyAmount/_userStateParse.result.periods + _userStateParse.result.applyAmount*0.021)*_userStateParse.result.periods]];
            [self.tableView reloadData];
            break;
        case 1083://审核失败
            NoneView.hidden=YES;
            self.lblTitle.text=@"申请失败";
            self.lblDetailText.text=@"对不起";
            self.lblTipText.text = [NSString stringWithFormat:@"审核未通过,%@天后可再次申请",_userStateParse.result.days];
            self.submitBtn.hidden=YES;
            self.submitBtn.enabled=NO;
            [moneyAry replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.0f元",_userStateParse.result.applyAmount]];
            [moneyAry replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.0f周",_userStateParse.result.periods]];
            [moneyAry replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.2f元",_userStateParse.result.applyAmount/_userStateParse.result.periods + _userStateParse.result.applyAmount*0.021]];
            [moneyAry replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.2f元",(_userStateParse.result.applyAmount/_userStateParse.result.periods + _userStateParse.result.applyAmount*0.021)*_userStateParse.result.periods]];
            [self.tableView reloadData];
            break;
        case 1082://确认金额->财务审核
            NoneView.hidden=YES;
            self.lblTitle.text = [NSString stringWithFormat:@"%.0f",_userStateParse.result.loanAmount];
            self.lblDetailText.text=@"可借款金额";
            self.lblTipText.text=@"确认后进入财务审核";
            self.submitBtn.hidden=NO;
            self.submitBtn.enabled=YES;
            [self.submitBtn setBackgroundImage:[UIImage imageNamed:@"flow-01-Confirm02"] forState:UIControlStateNormal];
            [moneyAry replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.0f元",_userStateParse.result.applyAmount]];
            [moneyAry replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.0f周",_userStateParse.result.periods]];
            [moneyAry replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.2f元",_userStateParse.result.loanAmount/_userStateParse.result.periods + _userStateParse.result.loanAmount*0.021]];
            [moneyAry replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.2f元",(_userStateParse.result.loanAmount/_userStateParse.result.periods + _userStateParse.result.loanAmount*0.021)*_userStateParse.result.periods]];
            [self.tableView reloadData];
            break;
        case 1087://财务审核失败
            NoneView.hidden=YES;
            self.lblTitle.text=@"放款失败";
            self.lblDetailText.text=@"对不起";
            self.lblTipText.text = [NSString stringWithFormat:@"财务审核未通过,%@天后可再次申请",_userStateParse.result.days];
            self.submitBtn.hidden=YES;
            self.submitBtn.enabled=NO;
            [moneyAry replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.0f元",_userStateParse.result.applyAmount]];
            [moneyAry replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.0f周",_userStateParse.result.periods]];
            [moneyAry replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.2f元",_userStateParse.result.applyAmount/_userStateParse.result.periods + _userStateParse.result.applyAmount*0.021]];
            [moneyAry replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.2f元",(_userStateParse.result.applyAmount/_userStateParse.result.periods + _userStateParse.result.applyAmount*0.021)*_userStateParse.result.periods]];
            [self.tableView reloadData];
            break;
        case 1090://财务审核
            NoneView.hidden=YES;
            self.lblTitle.text=@"财务审核";
            self.lblDetailText.text=@"尽快放款";
            self.lblTipText.text=@"财务审核通过即可放款";
            self.submitBtn.hidden=YES;
            self.submitBtn.enabled=NO;
            [moneyAry replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.0f元",_userStateParse.result.loanAmount]];
            [moneyAry replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.0f周",_userStateParse.result.periods]];
            [moneyAry replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.2f元",_userStateParse.result.loanAmount/_userStateParse.result.periods + _userStateParse.result.loanAmount*0.021]];
            [moneyAry replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.2f元",(_userStateParse.result.loanAmount/_userStateParse.result.periods + _userStateParse.result.loanAmount*0.021)*_userStateParse.result.periods]];
            [self.tableView reloadData];
            break;
        default:
            if(self.stateFlag==1080)
            {
                NoneView.hidden=NO;
                self.submitBtn.enabled=YES;
                self.submitBtn.hidden=NO;
                [self.submitBtn setBackgroundImage:[UIImage imageNamed:@"my-Loan"] forState:UIControlStateNormal];
            }else
            {
                NoneView.hidden=YES;
                self.lblTitle.text=@"已到账";
                self.lblDetailText.text=@"借款金额已经到账";
                self.lblTipText.text=@"请准时还款,保障信用";
                self.submitBtn.hidden=NO;
                self.submitBtn.enabled=YES;
                [self.submitBtn setBackgroundImage:[UIImage imageNamed:@"flow-04-Repayment"] forState:UIControlStateNormal];
                [moneyAry replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.0f元",_userStateParse.result.loanAmount]];
                [moneyAry replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.0f周",_userStateParse.result.periods]];
                [moneyAry replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.2f元",_userStateParse.result.loanAmount/_userStateParse.result.periods + _userStateParse.result.loanAmount*0.021]];
                [moneyAry replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.2f元",(_userStateParse.result.loanAmount/_userStateParse.result.periods + _userStateParse.result.loanAmount*0.021)*_userStateParse.result.periods]];
                [self.tableView reloadData];
            }
            break;
    }
}
-(void)createNoneView
{
    NoneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    NoneView.backgroundColor=RGBColor(245, 245, 245, 1);
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((_k_w-130)/2, 132, 130, 130)];
    logoImg.image=[UIImage imageNamed:@"my-logo"];
    UILabel *lblNone=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-190)/2, logoImg.frame.origin.y+logoImg.frame.size.height+25, 190, 25)];
    lblNone.numberOfLines=0;
    lblNone.text=@"您还没有正在申请的借款\n暂无进度详情";
    [lblNone sizeToFit];
    lblNone.textAlignment=NSTextAlignmentCenter;
    lblNone.font=[UIFont systemFontOfSize:16];
    lblNone.textColor=RGBColor(180, 180, 181, 1);
    
    [NoneView addSubview:logoImg];
    [NoneView addSubview:lblNone];
    NoneView.hidden=NO;
    [self.view addSubview:NoneView];
    //无还款信息时的我要借款按钮
    loadBtn=[[UIButton alloc]initWithFrame:CGRectMake(17, _k_h-26-64, _k_w-34, 51)];
    [loadBtn setBackgroundImage:[UIImage imageNamed:@"my-Loan"] forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(BtnLoan) forControlEvents:UIControlEventTouchUpInside];
    [NoneView addSubview:loadBtn];
    [self.view addSubview:NoneView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepaymentViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Progress"];
//    cell.myImgView.image=[UIImage imageNamed:imgAry[indexPath.row]];
    cell.lblTitle.text=titleAry[indexPath.row];
//    cell.lblMoney.text = [NSString stringWithFormat:@"%@",moneyAry[indexPath.row]];
//    if(indexPath.row==3)
//    {
//        cell.lblLine.hidden=YES;
//    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0 ;
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
//按钮点击事件
- (IBAction)submitBtnClick:(id)sender {
    switch (self.stateFlag) {
        case 1081:
            [self shareContent:sender];
            break;
        case 1082:
            [self MakeSureBtn];
            break;
        default:
            if(!(self.stateFlag==1080))
            {
                [self checkState];
            }
            break;
    }
}
//无状态的借款按钮
-(void)BtnLoan
{
    
    if([_userStateParse.result.status intValue]==1080)
    {
//        HomeLoanViewController *homeLoan=[[HomeLoanViewController alloc]initWithNibName:@"HomeLoanViewController" bundle:nil];
//        homeLoan.totalMoney = @"3000";
//        homeLoan.weekSel = YES;
//        [self.navigationController pushViewController:homeLoan animated:YES];
    }
    else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"您已存在一笔未还清的贷款"];
    }
}

#pragma mark darwmoneyDelegate
//提款
-(void)MakeSureBtn
{
    //此处又是一次掉渣天的网络请求
    //    [TestView hide];
    
    NSDictionary *dicParam = @{@"token":[Utility sharedUtility].userInfo.tokenStr,
                               @"id":[NSString stringWithFormat:@"%.0f",_userStateParse.result.resultIdentifier]};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_userLoan_url] parameters:dicParam finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            NSData * data = [[object objectForKey:@"result"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([Tool dicContainsKey:dic keyValue:@"typeStatus"]) {
                self.stateFlag = [[dic objectForKey:@"typeStatus"] integerValue];
                [self loadMyView];
            }
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"进入财务审核"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeTop leaveMode:HHAlertLeaveModeBottom disPlayMode:HHAlertViewModeError title:nil detail:@"提款失败，请重试！" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                if (index == 1) {
                    
                }
            }];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

//分享函数
-(void)shareContent:(UIButton*)sender
{
    id<ISSContent>  publishContent = [ShareSDK content:@"发薪贷只专注于网络小额贷款。是一款新型网络小额贷款神器, 尽可能优化贷款申请流程，申请步骤更便捷，轻完成网上贷款。链接:http://www.faxindai.com"
                                        defaultContent:@"发薪贷只专注于网络小额贷款。是一款新型网络小额贷款神器, 尽可能优化贷款申请流程，申请步骤更便捷，轻完成网上贷款。链接:http://www.faxindai.com"
                                                 image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"logo_60"]]
                                                 title:@"发薪贷"
                                                   url:@"www.faxindai.com"
                                           description:@"发薪贷只专注于网络小额贷款。是一款新型网络小额贷款神器, 尽可能优化贷款申请流程，申请步骤更便捷，轻完成网上贷款。链接:http://www.faxindai.com"
                                             mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container= [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSShareActionSheetItem>item1 = [ShareSDK shareActionSheetItemWithTitle:NSLocalizedString(@"复制链接", @"自定义项1")
                                                                          icon:[UIImage imageNamed:@"more-share-6"]
                                                                  clickHandler:^{
                                                                      UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                                                                      pasteboard.string =@"www.faxindai.com";
                                                                      [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"复制分享链接成功，请在粘贴分享"];
                                                                  }];
    
    NSArray *shareList = [ShareSDK customShareListWithType:
                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                          SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                          SHARE_TYPE_NUMBER(ShareTypeQQ),
                          SHARE_TYPE_NUMBER(ShareTypeQQSpace),
                          item1,
                          nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
     
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享成功"];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享失败"];
                                    DLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
}

//查询状态
-(void)checkState{
    
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        _userStateParse = returnValue;
        if([_userStateParse.flag isEqualToString:@"0000"])
        {
            RepaymentViewController *repayMent=[[RepaymentViewController alloc]initWithNibName:@"RepaymentViewController" bundle:nil];
            repayMent.userStateParse = _userStateParse;
            [self.navigationController pushViewController:repayMent animated:YES];
            
            if (_userStateParse.result.loanAmount > 0.0) {
                [Utility sharedUtility].getMineyInfo.loanAmount = _userStateParse.result.loanAmount;
            } else {
                [Utility sharedUtility].getMineyInfo.loanAmount = 0;
            }
            
            if (_userStateParse.result.periods > 0.0) {
                [Utility sharedUtility].getMineyInfo.periods = _userStateParse.result.periods;
            } else {
                [Utility sharedUtility].getMineyInfo.periods = 0;
            }
            
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userStateParse.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState];
}


@end
