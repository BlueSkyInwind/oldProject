//
//  RepaymentViewController.m
//  fxdProduct
//
//  Created by zy on 15/12/7.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "RepaymentViewController.h"
#import "P2PRepayMent.h"
#import "P2PAccountInfo.h"
#import "P2PRepaySaveViewController.h"
#import "P2PSettleRepay.h"


@interface RepaymentViewController ()<UITableViewDataSource,UITableViewDelegate,MakeSureBtnDelegate,JustMakeSureBtnDelegate>
{
    NSArray *titleAry;
    testView *repayAsWeek;
    testView *repayOnce;
    FirstRepayment *operateHelp;
    JustMakeSureView *justSure;
    UIView *NoneView;
    //    UserStateBaseClass *_userStateParse;
    NSString *_isSettlement;
    
    NSString *_loanAmount;
    NSString *beOverAmount;
    NSString *_allAmount;
    NSString *_shouldAlsoAount;
    UIButton *loanbtn;
    NSString *tempDate;
    NSString *periodMoney;//本期金额
    NSString *periodInterest;//本期利息
    NSString *periodFreeInt;//本期免息
    NSString *socket;//防止多次扣款
    P2PRepayMent *_p2pRepayMentModel;
    P2PAccountInfo *_p2pAccountInfo;
    P2PSettleRepay *_settleRepayModel;
    NSString *_repayMoneyOnce;
}
@end

@implementation RepaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.repayDate=@"0000-00-00";
    self.title=@"我要还款";
    titleAry=@[@"本期最后还款日",@"本期应还本金",@"本期应还利息",@"本期免息",@"本期应还总额"];
    //    _loanAmount = [NSString stringWithFormat:@"%.2f",_userStateParse.result.loanAmount];
    //信息table
    self.MyTableIVew.delegate=self;
    self.MyTableIVew.dataSource=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [Tool setCorner:self.MyTableIVew borderColor:rgb(0, 170, 238)];
    self.MyTableIVew.scrollEnabled=NO;
    //逾期tableview
    self.OverTimeTableVIew.delegate=self;
    self.OverTimeTableVIew.dataSource=self;
    [Tool setCorner:self.OverTimeTableVIew borderColor:rgb(0, 170, 238)];
    self.OverTimeTableVIew.scrollEnabled=NO;
    //合计综合lbl
    self.lblTotalMoney.textColor=RGBColor(242, 111, 0, 1);
    [Tool setCorner:self.lblTotalMoney borderColor:[UIColor grayColor]];
    [Tool setCorner:self.btnRepayImmed borderColor:[UIColor grayColor]];
    // scroll
    self.MyScroll.userInteractionEnabled=YES;
    self.MyScroll.contentSize=CGSizeMake(0, 1000);
    //lblTip
    self.lblTip.textColor=RGBColor(242, 111, 0, 1);
    self.lblTip.hidden = YES;
    
    [self createItemBtn];
    [self addBackItem];
    [self.MyTableIVew registerNib:[UINib nibWithNibName:@"RepaymentViewCell" bundle:nil] forCellReuseIdentifier:@"repay"];
    [self.OverTimeTableVIew registerNib:[UINib nibWithNibName:@"RepaymentViewCell" bundle:nil] forCellReuseIdentifier:@"yuqi"];
    [self createHelpView];
    [self createNoneView];
    //    [self checkState];
    [self checkNoneView];
}

//右按钮
-(void)createItemBtn
{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    [btn setBackgroundImage:[UIImage imageNamed:@"flow-04-icon09"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=rightItem;
}

-(void)rightBtnClick
{
    RepaymentHelpController *helpController=[[RepaymentHelpController alloc]initWithNibName:@"RepaymentHelpController" bundle:nil];
    [self.navigationController pushViewController:helpController animated:YES];
}

-(void)createNoneView
{
    NoneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    NoneView.backgroundColor=RGBColor(245, 245, 245, 1);
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((_k_w-130)/2, 132, 130, 130)];
    logoImg.image=[UIImage imageNamed:@"my-logo"];
    UILabel *lblNone=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-180)/2, logoImg.frame.origin.y+logoImg.frame.size.height+25, 180, 25)];
    lblNone.numberOfLines=0;
    lblNone.text=@"您当前无需还款";
    lblNone.textAlignment=NSTextAlignmentCenter;
    lblNone.font=[UIFont systemFontOfSize:16];
    lblNone.textColor=RGBColor(180, 180, 181, 1);
    [NoneView addSubview:logoImg];
    [NoneView addSubview:lblNone];
    NoneView.hidden=YES;
    [self.view addSubview:NoneView];
}

-(void)createHelpView
{
    operateHelp=[[[NSBundle mainBundle] loadNibNamed:@"FirstRepayment" owner:self options:nil] objectAtIndex:0];
    operateHelp.frame=CGRectMake(0, 0, _k_w, _k_h);
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n还款方式有两种：1、主动还款：点击页面立即还款；2、系统扣款：账单日晚9：00系统自动划扣当期应还金额。\n"]];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9, 7)];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(25, 7)];
    operateHelp.lbltitle.attributedText=content;
    operateHelp.lbltitle.font=[UIFont systemFontOfSize:16];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.MyTableIVew) {
        return 6;
    }
    return 1;
}

- (void)post_getLastDate
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_WeekUserShouldAlsoAmount_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        _p2pRepayMentModel = [P2PRepayMent yy_modelWithJSON:object];
        if ([_p2pRepayMentModel.flag isEqualToString:@"0000"]) {
            //借款金额
            _loanAmount = _p2pRepayMentModel.result.loan_amount_;
            //最后还款日
            tempDate = _p2pRepayMentModel.result.repay_date_;
            //应还本金
            periodMoney = _p2pRepayMentModel.result.should_reapy_rincipal_;
            //应该还利息
            periodInterest = _p2pRepayMentModel.result.should_reapy_interest_;
            //免息
            periodFreeInt = @"0.00";
            //应还总额
            _allAmount = _p2pRepayMentModel.result.should_reapy_amount_;
            //逾期额
            beOverAmount = _p2pRepayMentModel.result.overdue_amount_;
            //合计还款额
            _repayMoneyOnce = [NSString stringWithFormat:@"%.2f",_allAmount.floatValue + beOverAmount.floatValue];
            self.lblTotalMoney.text = _repayMoneyOnce;
            [_MyTableIVew reloadData];
            [_OverTimeTableVIew reloadData];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_p2pRepayMentModel.msg];
        }
        //        [self checkNoneView];
        DLog(@"%@",object);
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)checkNoneView
{
    NSInteger status = _apply_status.integerValue;
    switch (status) {
        case 7:
        case 8:
            [self post_getLastDate];
            break;
            
        default:
            NoneView.hidden = NO;
            break;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.MyTableIVew) {
        RepaymentViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"repay"];
        cell.lblTitle.text=titleAry[indexPath.row];
        if(indexPath.row==4) {
            cell.lblMoney.textColor =RGBColor(242, 111, 0, 1);
            cell.lblMoney.text=[NSString stringWithFormat:@"%.2f元",[_allAmount floatValue]];
            cell.contentView.backgroundColor=[UIColor whiteColor];
        }
        else {
            cell.lblMoney.textColor =RGBColor(48, 152, 234, 1);
            if(indexPath.row==0)//最后还款日
            {
                if (tempDate.length > 0) {
                    cell.lblMoney.text=[NSString stringWithFormat:@"%@",tempDate];
                } else {
                    cell.lblMoney.text= @"";
                }
                
                cell.contentView.backgroundColor=[UIColor whiteColor];
            }
            if(indexPath.row==1)//本期本金
            {
                cell.lblMoney.text=[NSString stringWithFormat:@"%.2f元",[periodMoney floatValue]];
                cell.contentView.backgroundColor=RGBColor(240, 240, 240, 1);
            }
            if(indexPath.row==2)//本期利息
            {
                cell.lblMoney.text=[NSString stringWithFormat:@"%.2f元",[periodInterest floatValue]];
                cell.contentView.backgroundColor=[UIColor whiteColor];
            }
            if(indexPath.row==3)//本期免息
            {
                cell.lblMoney.text=[NSString stringWithFormat:@"-%.2f元",[periodFreeInt floatValue]];
                cell.contentView.backgroundColor=RGBColor(240, 240, 240, 1);
            }
        }
        return cell;
    }
    else {
        RepaymentViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"yuqi"];
        cell.lblMoney.textColor =RGBColor(242, 111, 0, 1);
        cell.lblTitle.text=@"逾期额";
        cell.lblMoney.text=[NSString stringWithFormat:@"%.2f元",[beOverAmount floatValue]];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.MyTableIVew.frame.size.width, 50)];
    view.backgroundColor=rgb(0, 170, 238);
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(17, 10, 200, 30)];
    lbl.textColor=[UIColor whiteColor];
    if(tableView==self.MyTableIVew)
    {
        lbl.text=@"当期还款信息";
    }
    else
    {
        lbl.text=@"逾期信息";
    }
    [view addSubview:lbl];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(void)loadViewWithState
{
    switch ([self.repayStateFlag intValue]) {
        case 0://初始
            [self.btnRepayImmed setBackgroundColor:UI_MAIN_COLOR];
//            [self.btnRepayImmed setBackgroundImage:[UIImage imageNamed:@"flow-04-Immediately"] forState:UIControlStateNormal];
            [self.btnReClean setTitleColor:RGBColor(74, 74, 74, 1) forState:UIControlStateNormal];
            self.btnRepayImmed.enabled=YES;
            self.btnReClean.enabled=YES;
            NoneView.hidden=YES;
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"firstRepayment"]==nil)
            {
                [operateHelp show];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"firstRepayment"];
            }
            tempDate=[self.repayDate substringToIndex:10];
            self.lblTip.hidden=YES;
            break;
        case 1://扣款中
            [self.btnRepayImmed setBackgroundColor:[UIColor grayColor]];
//            [self.btnRepayImmed setBackgroundImage:[UIImage imageNamed:@"flow-05-Immediately"] forState:UIControlStateNormal];
            [self.btnReClean setTitleColor:RGBColor(180, 180, 181, 1) forState:UIControlStateNormal];
            self.btnRepayImmed.enabled=NO;
            self.btnReClean.enabled=NO;
            NoneView.hidden=YES;
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"firstRepayment"]==nil)
            {
                [operateHelp show];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"firstRepayment"];
            }
            self.lblTip.hidden=YES;
            break;
        case 2://还款失败
            [self.btnRepayImmed setBackgroundColor:UI_MAIN_COLOR];
//            [self.btnRepayImmed setBackgroundImage:[UIImage imageNamed:@"flow-04-Immediately"] forState:UIControlStateNormal];
            [self.btnReClean setTitleColor:RGBColor(74, 74, 74, 1) forState:UIControlStateNormal];
            if([_isSettlement isEqualToString:@"1"])
            {
                [self.btnRepayImmed setBackgroundColor:[UIColor grayColor]];
//                [self.btnRepayImmed setBackgroundImage:[UIImage imageNamed:@"flow-05-Immediately"] forState:UIControlStateNormal];
                self.btnRepayImmed.enabled=NO;
                self.btnReClean.enabled=YES;
            }
            else
            {
                [self.btnRepayImmed setBackgroundColor:UI_MAIN_COLOR];
//                [self.btnRepayImmed setBackgroundImage:[UIImage imageNamed:@"flow-04-Immediately"] forState:UIControlStateNormal];
                self.btnRepayImmed.enabled=YES;
                self.btnReClean.enabled=YES;
            }
            NoneView.hidden=YES;
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"firstRepayment"]==nil)
            {
                [operateHelp show];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"firstRepayment"];
            }
            self.lblTip.hidden=NO;
            tempDate = [self.repayDate substringToIndex:10];
            break;
        case 3://成功
            [self.btnRepayImmed setBackgroundColor:[UIColor grayColor]];
//            [self.btnRepayImmed setBackgroundImage:[UIImage imageNamed:@"flow-05-Immediately"] forState:UIControlStateNormal];
            [self.btnReClean setTitleColor:RGBColor(74, 74, 74, 1) forState:UIControlStateNormal];
            self.btnRepayImmed.enabled=NO;
            self.btnReClean.enabled=YES;
            NoneView.hidden=YES;
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"firstRepayment"]==nil)
            {
                [operateHelp show];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"firstRepayment"];
            }
            self.lblTip.hidden=YES;
            break;
        default:
            NoneView.hidden=NO;
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  立即还款按钮

- (IBAction)btnRepayImmediatelyClick:(id)sender {
    DLog(@"%f",[_allAmount floatValue]);
    
    if([_allAmount floatValue]==0.00){
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"当前还款为0，不能还款"];
    }else{
        //        [self post_WeekUserShouldAlsoAmount_url];
        //        [self checkUserAccountMoney];
        NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_memberService_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
        [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:nil finished:^(EnumServerStatus status, id object) {
            DLog(@"%@",object);
            _p2pAccountInfo = [P2PAccountInfo yy_modelWithJSON:object];
            if (_p2pAccountInfo.data.accountInfo.available_amount_ < _repayMoneyOnce.floatValue) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"您的帐户余额不足,请充值"];
                NSString *url = [NSString stringWithFormat:@"%@%@?from_user_id_=%@&from_mobile_=%@&RetUrl=%@&amount_=%lf&PageType=1&RetUrl=%@&GateBusiId=QP&bill_id_=%@&bid_id_=%@&repay_amount_=%@&method_=doPay",_P2P_url,_netSave_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone,_transition_url,_repayMoneyOnce.floatValue -_p2pAccountInfo.data.accountInfo.available_amount_,_rechargeing_url,_p2pRepayMentModel.result.bill_id_,_p2pRepayMentModel.result.bid_id_,_repayMoneyOnce];
                P2PRepaySaveViewController *p2pSaveVC = [[P2PRepaySaveViewController alloc] init];
                p2pSaveVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [self.navigationController pushViewController:p2pSaveVC animated:YES];
            } else {
                [self repaySure];
            }
        } failure:^(EnumServerStatus status, id object) {
            
        }];
    }
}

- (void)checkUserAccountMoney
{
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_memberService_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:nil finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        _p2pAccountInfo = [P2PAccountInfo yy_modelWithJSON:object];
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

//结清还款
- (IBAction)btnRepayClean:(id)sender {
    DLog(@"%f",[_allAmount floatValue]);
    //    [self post_AllUserShouldAlsoAmount_url];
    [self fatchRepayClean];
    
}
- (void)fatchRepayClean
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_AllUserShouldAlsoAmount_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        _settleRepayModel = [P2PSettleRepay yy_modelWithJSON:object];
        if ([_settleRepayModel.flag isEqualToString:@"0000"]) {
            repayOnce=[[[NSBundle mainBundle] loadNibNamed:@"testView" owner:self options:nil] objectAtIndex:0];
            repayOnce.frame=CGRectMake(0, 0, _k_w, _k_h);
            repayOnce.num = 1;
            repayOnce.delegat=self;
            NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n确定结清剩余欠款吗?\n%@元",_settleRepayModel.result.settle_amount_]];
            NSRange contentRange = {0,[content length]};
            [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
            NSRange contentRangeRe = {0,11};
            [content removeAttribute:NSUnderlineStyleAttributeName range:contentRangeRe];
            [content addAttribute:NSForegroundColorAttributeName value:RGBColor(74, 74, 74, 1) range:contentRangeRe];
            repayOnce.lbltitle.attributedText = content;
            [repayOnce show];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_settleRepayModel.msg];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


#pragma mark 正常还款
- (void)repaySure
{
    NSDictionary *dic = @{@"bill_id_":_p2pRepayMentModel.result.bill_id_,
                          @"bid_id_":_p2pRepayMentModel.result.bid_id_,
                          @"repay_amount_":_allAmount,
                          @"requester":@"2"};
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_doPay_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:dic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"appcode"] isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"还款成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


#pragma mark MyAlertDelegate
//周还款确定
-(void)MakeSureBtn:(NSInteger)tag
{
    DLog(@"%@",_allAmount);
    if (tag == 0) {
        DLog(@"周还款repayAsWeek");
        [self post_WeekUserRepayment_url];
        //        [repayAsWeek hide];
        //        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"还款成功!"];
    }
    if(tag == 1) {
        DLog(@"结清");
        //        [self post_AlluserRepayment_url];
        //        [repayOnce hide];
        NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_memberService_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
        [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:nil finished:^(EnumServerStatus status, id object) {
            DLog(@"%@",object);
            _p2pAccountInfo = [P2PAccountInfo yy_modelWithJSON:object];
            [self cleanUserMoney];
        } failure:^(EnumServerStatus status, id object) {
            
        }];
    }
}


#pragma mark 结清
- (void)cleanUserMoney
{
    if (_p2pAccountInfo.data.accountInfo.available_amount_ < _settleRepayModel.result.settle_amount_.floatValue) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"您的帐户余额不足,请充值"];
        NSString *url = [NSString stringWithFormat:@"%@%@?from_user_id_=%@&from_mobile_=%@&amount_=%f&PageType=1&RetUrl=%@&GateBusiId=QP&bid_id_=%@&bill_id_=%@&repay_amount_=%@&method_=doSettle",_P2P_url,_netSave_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone,_settleRepayModel.result.settle_amount_.floatValue - _p2pAccountInfo.data.accountInfo.available_amount_,_rechargeing_url,_settleRepayModel.result.bid_id_,_settleRepayModel.result.bill_id_,_settleRepayModel.result.settle_amount_];
        P2PRepaySaveViewController *p2pSaveVC = [[P2PRepaySaveViewController alloc] init];
        p2pSaveVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [self.navigationController pushViewController:p2pSaveVC animated:YES];
        [repayOnce hide];
    } else {
        [self paySettle];
        [repayOnce hide];
    }
}

- (void)paySettle
{
    NSDictionary *dic = @{@"bill_id_":_settleRepayModel.result.bill_id_,
                          @"bid_id_":_settleRepayModel.result.bid_id_,
                          @"repay_amount_":_settleRepayModel.result.settle_amount_,
                          @"requester":@"2"};
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_doSettle_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:dic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"appcode"] isEqualToString:@"1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"结清成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

//单按钮确定
-(void)JustMakeSureBtn:(NSInteger)tag
{
    [justSure hide];
    [self.navigationController popViewControllerAnimated:YES];
}

//查询用户周还款额(周)
-(void)post_WeekUserShouldAlsoAmount_url{
    repayAsWeek=[[[NSBundle mainBundle] loadNibNamed:@"testView" owner:self options:nil] objectAtIndex:0];
    repayAsWeek.frame=CGRectMake(0, 0, _k_w, _k_h);
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n我们将自动从您的绑定借记卡中扣除应还金额%@元",_allAmount]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    NSRange contentRangeRe = {0,21};
    [content removeAttribute:NSUnderlineStyleAttributeName range:contentRangeRe];
    [content addAttribute:NSForegroundColorAttributeName value:RGBColor(74, 74, 74, 1) range:contentRangeRe];
    repayAsWeek.lbltitle.attributedText=content;
    repayAsWeek.num=0;
    repayAsWeek.delegat=self;
    [repayAsWeek show];
    
}

//用户还款(按周)
-(void)post_WeekUserRepayment_url{
    //    NSDictionary *dicParam = @{@"token":[Utility sharedUtility].userInfo.tokenStr,
    //                               @"id":[NSString stringWithFormat:@"%.0f",_userStateParse.result.resultIdentifier],
    //                               @"socket":_weekPaySelectParse.result.socket,
    //                               @"shouldAlsoAount":_allAmount};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_WeekUserRepayment_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            DLog(@"周还款结束");
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"确定扣款!"];
            [repayAsWeek hide];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else{
            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeTop leaveMode:HHAlertLeaveModeBottom disPlayMode:HHAlertViewModeError title:nil detail:@"还款失败，请重试！" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                if (index == 1) {
                    
                }
            }];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

//用户还款(一次结清)
-(void)post_AlluserRepayment_url{
    //    NSDictionary *dicParam = @{@"token":[Utility sharedUtility].userInfo.tokenStr,
    //                               @"id":[NSString stringWithFormat:@"%.0f",_userStateParse.result.resultIdentifier],
    //                               @"earlySettleAmount":shouldAlsoAountAll,
    //                               @"socket":socket};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_AlluserRepayment_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            DLog(@"还款接受");
            [repayOnce hide];
            
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"确认扣款!"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else{
            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeTop leaveMode:HHAlertLeaveModeBottom disPlayMode:HHAlertViewModeError title:nil detail:@"还款失败，请重试！" cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                if (index == 1) {
                    
                }
            }];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}


//- (void)popBack
//{
//    if([_userStateParse.result.status isEqualToString:@"1088"]||[_userStateParse.result.status isEqualToString:@"1080"])
//    {
//       [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    else
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//
//
//}

@end
