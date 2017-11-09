//
//  LoanMoneyViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "LoanMoneyViewController.h"
#import "MoneyIngView.h"
#import "YYText.h"
#import "P2PAgreeMentModel.h"
#import "HG_ContractListVCModules.h"
#import "DetailViewController.h"
#import "RepayRequestManage.h"
#import "IdeaBackViewController.h"
#import "LoanMoneyViewModel.h"
#import "RTRootNavigationController.h"
#import "P2PViewController.h"
#import "ApplicationStatusModel.h"
#import "RepayModel.h"
#import "BankInfoViewModel.h"
#import "QueryCardInfo.h"
#import "DrawLotteryModel.h"
#import "LewPopupViewController.h"
#import "ScratchAwardView.h"
@interface LoanMoneyViewController ()
{
    MoneyIngView *moenyViewing;
    BOOL _isFirst;//好评只弹出一次，再次刷新时，不弹对话框
    RepayModel *_repayModel;
    BOOL _isHidden;//老客周末活动判断是否弹框刮奖,只弹出一次，再次刷新时，不弹
}

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation LoanMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"审核";
    [self addBackItemRoot];
    //默认视图加载
    moenyViewing = [[[NSBundle mainBundle] loadNibNamed:@"MoneyIngView" owner:self options:nil] lastObject];
    moenyViewing.frame = CGRectMake(0, 0, _k_w, _k_h);
    moenyViewing.repayBtnView.hidden = YES;
    moenyViewing.middleView.hidden = YES;
    moenyViewing.moneyImage.hidden = YES;
    moenyViewing.repayView.hidden = YES;
    moenyViewing.headerView.hidden = YES;
    moenyViewing.promptLabel.hidden = YES;
    moenyViewing.statusBottomView.hidden = YES;
    moenyViewing.heguiBtn.hidden = YES;
    moenyViewing.heguiBtn.enabled = NO;
    moenyViewing.stagingBgView.hidden = YES;
    
    [self.view addSubview:moenyViewing];

    [FXD_Tool setCorner:moenyViewing.sureBtn borderColor:UI_MAIN_COLOR];
    //添加各种事件
    //续期点击事件
    moenyViewing.stagingView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(renewalBtnClick)];
    [moenyViewing.stagingView addGestureRecognizer:tap];
    //续期
    [moenyViewing.stagingBtn addTarget:self action:@selector(renewalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //提款
    [moenyViewing.sureBtn addTarget:self action:@selector(repaymentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //发薪贷协议
    [moenyViewing.agreementBtn addTarget:self action:@selector(agreementCheckboxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //合规协议
    [moenyViewing.heguiBtn addTarget:self action:@selector(hgContractBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _isFirst = _popAlert;
    _isHidden = NO;

  }

#pragma mark 合规查看合同
-(void)hgContractBtnClick{

    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        P2PAgreeMentModel *agreeModel = [P2PAgreeMentModel yy_modelWithJSON:returnValue];
        if ([agreeModel.result.appcode isEqualToString:@"1"]) {
            HG_ContractListVCModules *agreeMentListViewController = [[HG_ContractListVCModules alloc] init];
            agreeMentListViewController.agreeMentArr = agreeModel.result.pactList;
            [self.navigationController pushViewController:agreeMentListViewController animated:true];
        } else {
            
        }
    } WithFaileBlock:^{
        
    }];
    [loanMoneyViewModel getContractList:_repayModel.bidId];

}
#pragma mark 续借一期点击按钮
-(void)renewalBtnClick{

    
    if (!_repayModel.continueStaging) {
        
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"一次借款最多续借三次"];
        return;
    }
    
    RenewalVCModules *controller = [[RenewalVCModules alloc]init];
    controller.stagingId = _repayModel.stagingId;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark 协议勾选按钮
-(void)agreementCheckboxBtnClick:(UIButton *)btn{

    if (moenyViewing.agreementBtn.selected) {
        moenyViewing.sureBtn.enabled = YES;
        [FXD_Tool setCorner:moenyViewing.sureBtn borderColor:UI_MAIN_COLOR];
        moenyViewing.sureBtn.backgroundColor = UI_MAIN_COLOR;
        [moenyViewing.agreementBtn setImage:[UIImage imageNamed:@"Sign-in-icon06"] forState:UIControlStateNormal];

    }else{
    
        moenyViewing.sureBtn.enabled = NO;
        [FXD_Tool setCorner:moenyViewing.sureBtn borderColor:rgb(158, 158, 159)];
        moenyViewing.sureBtn.backgroundColor = rgb(158, 158, 159);
        [moenyViewing.agreementBtn setImage:[UIImage imageNamed:@"Sign-in-icon05"] forState:UIControlStateNormal];
    }
    btn.selected = !btn.selected;
}


- (void)loadView
{
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.contentSize = CGSizeMake(_k_w, _k_h);
    view.backgroundColor = [UIColor whiteColor];
    // 去掉滚动条
    view.showsVerticalScrollIndicator = NO;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
    header.automaticallyChangeAlpha = YES;
    view.mj_header = header;
    self.view = view;
    self.scrollView = view;
}

#pragma mark 下拉刷新
-(void)refresh{

//    self.navigationItem.title = [self setTitle];
        if (_applicationStatus == RepaymentNormal) {
            [self getRepaymentPageInformation];
            return;
        }
        [self getTheIntermediateState];
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

#pragma mark 请求银行卡列表信息

- (void)fxdBankCardListInformation:(void(^)(CardInfo *rate))finish{
    
    BankInfoViewModel *bankInfoVM = [[BankInfoViewModel alloc]init];
    [bankInfoVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            NSArray * array = (NSArray *)baseResultM.data;
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                CardInfo * cardInfo = [[CardInfo alloc]initWithDictionary:dic error:nil];
                if ([cardInfo.cardType isEqualToString:@"2"]) {
                    finish(cardInfo);
                    break;
                }
            }
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [bankInfoVM obtainUserBankCardList];
}

#pragma mark 请求银行卡列表信息

- (void)hgBankCardListInformation:(void(^)(QueryCardInfo *rate))finish{
    
    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        QueryCardInfo *model = [QueryCardInfo yy_modelWithJSON:returnValue];
        if ([model.flag isEqualToString:@"0000"]) {
            finish(model);
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel queryCardInfo];
}


#pragma mark 获取协议
-(void)initializeTheProtocolView{

    //发薪贷
    if ([_repayModel.platformType isEqualToString:@"0"]||[_repayModel.platformType isEqualToString:@"3"]) {
        
        [self fxdBankCardListInformation:^(CardInfo *rate) {
            
            moenyViewing.lableData.textAlignment = NSTextAlignmentLeft;
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并认可发薪贷《银行自动转账授权书》、《借款协议》"];
            one.yy_font = [UIFont systemFontOfSize:13];
            one.yy_color = rgb(102, 102, 102);
            [one yy_setTextHighlightRange:NSMakeRange(10, 11)
                                    color:UI_MAIN_COLOR
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                    DLog(@"授权书点击");
                                    
                                    //《银行自动转账授权书》点击
                                    NSArray *paramArray = @[_repayModel.applyId,_repayModel.productId,@"1",rate.cardNo,rate.bankName];
                                    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
                                    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
                                        if ([[returnValue objectForKey:@"flag"] isEqualToString:@"0000"]) {
                                            DetailViewController *detailVC = [[DetailViewController alloc] init];
                                            detailVC.content = [[returnValue objectForKey:@"result"] objectForKey:@"protocol_content_"];
                                            [self.navigationController pushViewController:detailVC animated:YES];
                                        } else {
                                            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
                                        }
                                    } WithFaileBlock:^{
                                        
                                    }];
                                    [loanMoneyViewModel getProductProtocol:paramArray];
                                    
                                }];
            [one yy_setTextHighlightRange:NSMakeRange(22, 6)
                                    color:UI_MAIN_COLOR
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                              DLog(@"三方协议");
                              
                              //《借款协议》点击
                              NSArray *paramArray = [NSArray array];
                              if ([_repayModel.productId isEqualToString:SalaryLoan]||[_repayModel.productId isEqualToString:WhiteCollarLoan]) {
                                  paramArray = @[_repayModel.applyId,_repayModel.productId,@"2",_repayModel.duration];
                              }
                              
                              /**
                              if ([_repayModel.productId isEqualToString:RapidLoan]||[_repayModel.productId isEqualToString:DeriveRapidLoan]) {
                                  paramArray = @[_repayModel.applyId,_repayModel.productId,@"2",@1];
                              }
                              */
                              if ([_repayModel.productId isEqualToString:RapidLoan]) {
                                  paramArray = @[_repayModel.applyId,_repayModel.productId,@"2",@2];
                              }
                              if ([_repayModel.productId isEqualToString:DeriveRapidLoan]) {
                                  paramArray = @[_repayModel.applyId,_repayModel.productId,@"2",@1];
                              }
                              
                              LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
                              [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
                                  if ([[returnValue objectForKey:@"flag"] isEqualToString:@"0000"]) {
                                      DetailViewController *detailVC = [[DetailViewController alloc] init];
                                      detailVC.content = [[returnValue objectForKey:@"result"] objectForKey:@"protocol_content_"];
                                      [self.navigationController pushViewController:detailVC animated:YES];
                                  } else {
                                      [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
                                  }
                              } WithFaileBlock:^{
                                  
                              }];
                              [loanMoneyViewModel getProductProtocol:paramArray];
                              
                          }];
            moenyViewing.agreeMentLabel.attributedText = one;
            moenyViewing.agreeMentLabel.textAlignment = NSTextAlignmentLeft;
        }];
    }
    
    //合规协议
    if ([_repayModel.platformType isEqualToString:@"2"]) {
    
        moenyViewing.heguiBtn.hidden = NO;
        moenyViewing.heguiBtn.enabled = YES;
        [self hgBankCardListInformation:^(QueryCardInfo *rate) {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"我已阅读《银行自动转账授权书》、《信用咨询及管理服务协议》"];
            moenyViewing.lableData.textAlignment = NSTextAlignmentLeft;
            one.yy_font = [UIFont systemFontOfSize:13];
            one.yy_color = rgb(102, 102, 102);
            [one yy_setTextHighlightRange:NSMakeRange(4, 11)
                                    color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                    DLog(@"《银行自动转账授权书》");
                                    
                                    //《银行自动转账授权书》
                                    NSArray *paramArray = @[_repayModel.applyId,_repayModel.productId,@"1",rate.result.UsrCardInfolist.CardId,rate.result.UsrCardInfolist.bankName];
                                    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
                                    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
                                        if ([[returnValue objectForKey:@"flag"] isEqualToString:@"0000"]) {
                                            DetailViewController *detailVC = [[DetailViewController alloc] init];
                                            detailVC.content = [[returnValue objectForKey:@"result"] objectForKey:@"protocol_content_"];
                                            [self.navigationController pushViewController:detailVC animated:YES];
                                        } else {
                                            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[returnValue objectForKey:@"msg"]];
                                        }
                                    } WithFaileBlock:^{
                                        
                                    }];
                                    [loanMoneyViewModel getProductProtocol:paramArray];
                                    
                                }];
            
            [one yy_setTextHighlightRange:NSMakeRange(15, 14)
                                    color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                    DLog(@"《信用咨询及管理服务协议》");
                                    
                                    //《信用咨询及管理服务协议》
                                    [self creditAdvisoryAndManagementServicesAgreement];
                                    
                                }];
            
        moenyViewing.agreeMentLabel.attributedText = one;
        moenyViewing.agreeMentLabel.textAlignment = NSTextAlignmentLeft;
        }];
    }
}



#pragma mark 信用咨询及管理服务协议
-(void)creditAdvisoryAndManagementServicesAgreement{
    
    NSDictionary *paramDic;
    if ([_repayModel.productId isEqualToString:SalaryLoan]||[_repayModel.productId isEqualToString:WhiteCollarLoan]) {
        
        paramDic = @{@"apply_id_":_repayModel.applyId,
                     @"product_id_":_repayModel.productId,
                     @"protocol_type_":@"7",
                     @"periods_":_repayModel.duration};
    }
    
    /**
    if ([_repayModel.productId isEqualToString:RapidLoan]||[_repayModel.productId isEqualToString:DeriveRapidLoan]) {
        paramDic = @{@"apply_id_":_repayModel.applyId,
                     @"product_id_":_repayModel.productId,
                     @"protocol_type_":@"7",
                     @"periods_":@1};
    }
  */
    
    if ([_repayModel.productId isEqualToString:RapidLoan]) {
        paramDic = @{@"apply_id_":_repayModel.applyId,
                     @"product_id_":_repayModel.productId,
                     @"protocol_type_":@"7",
                     @"periods_":@2};
    }
    
    if ( [_repayModel.productId isEqualToString:DeriveRapidLoan]) {
        paramDic = @{@"apply_id_":_repayModel.applyId,
                     @"product_id_":_repayModel.productId,
                     @"protocol_type_":@"7",
                     @"periods_":@1};
    }
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_agreement_url,_productProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            detailVC.content = [[object objectForKey:@"result"] objectForKey:@"protocol_content_"];
            [self.navigationController pushViewController:detailVC animated:YES];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}
#pragma mark 五星好评的弹框
- (void)showFiveStarPraiseAlertview
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"亲，您对发薪贷的服务满意吗？" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"五星好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
        });
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"我要吐槽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        IdeaBackViewController *ideaBack=[[IdeaBackViewController alloc]initWithNibName:@"IdeaBackViewController" bundle:nil];
        [self.navigationController pushViewController:ideaBack animated:YES];
    }];
    UIAlertAction *delayAction = [UIAlertAction actionWithTitle:@"以后再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:noAction];
    [alertController addAction:delayAction];
    [self presentViewController:alertController animated:true completion:nil];
}


#pragma mark 我要还款按钮
-(void)repaymentBtnClick:(UIButton *)sender
{
        //platform_type 2、合规平台  0发薪贷平台
        if ([_repayModel.platformType isEqualToString:@"2"]) {
            if ([_repayModel.userStatus isEqualToString:@"3"]) {//待激活用户
                
                NSString *url = [NSString stringWithFormat:@"%@%@?page_type_=%@&ret_url_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"1",_transition_url,[FXD_Utility sharedUtility].userInfo.userMobilePhone];
                P2PViewController *p2pVC = [[P2PViewController alloc] init];
                //        p2pVC.isOpenAccount = NO;
                p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                p2pVC.applicationId = _repayModel.applyId;
                p2pVC.product_id = _repayModel.productId;
                [self.navigationController pushViewController:p2pVC animated:YES];
                
            }else{
                RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
                repayRequest.targetVC = self;
                repayRequest.isPopRoot = NO;
                repayRequest.platform_type = _repayModel.platformType;
                repayRequest.product_id = _repayModel.productId;
                repayRequest.applicationId = _repayModel.applyId;
                [repayRequest repayRequest];
            }
        }else{
            RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
            repayRequest.targetVC = self;
            repayRequest.isPopRoot = NO;
            repayRequest.platform_type = _repayModel.platformType;
            repayRequest.product_id = _repayModel.productId;
            repayRequest.applicationId = _repayModel.applyId;
            [repayRequest repayRequest];
        }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //platform_type 2、合规平台  0发薪贷平台
    self.navigationItem.title = [self setTitle];
    if (_applicationStatus == RepaymentNormal) {
        
        [self getRepaymentPageInformation];
        return;
    }
    
//    //如果是放款中，会判断老客周末活动是否弹框刮奖
//    if (_applicationStatus == InLoan) {
//
//        [self getDrawLottery];
//    }
    [self getTheIntermediateState];
    
}

#pragma mark  老客周末活动判断是否弹框刮奖
-(void)getDrawLottery{
    
    __weak typeof(self) weakSelf = self;
    LoanMoneyViewModel *viewModel = [[LoanMoneyViewModel alloc]init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * resultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([resultM.errCode isEqualToString:@"0"]) {
            DrawLotteryModel * model = [[DrawLotteryModel alloc]initWithDictionary:(NSDictionary *)resultM.data error:nil];
            if ([model.isActivety isEqualToString:@"1"]) {
                _isHidden = YES;
                ScratchAwardView *scratchAwardView = [ScratchAwardView defaultPopView];
                scratchAwardView.linkUrl = model.luckDraw;
                scratchAwardView.parentVC = weakSelf;
                [scratchAwardView loadData];
                [weakSelf lew_presentPopupView:scratchAwardView animation:[LewPopupViewAnimationSpring new] backgroundClickable:NO dismissed:^{
                }];
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:resultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [viewModel getDrawLottery];
    
}

#pragma mark 设置标题
-(NSString *)setTitle{

    switch (_applicationStatus) {
        case InLoan:
            return @"放款中";
            break;
        case Repayment:
            return @"还款中";
            break;
        case Staging:
            return @"续期中";
            break;
        case RepaymentNormal:
            return @"待还款";
            break;
        case ComplianceInLoan:
        case ComplianceRepayment:
            return @"处理中";
            break;

        default:
            break;
    }
    return @"审核";
}

#pragma mark -> 2.22	放款中 还款中 展期中 状态实时获取
-(void)getTheIntermediateState{

    __weak typeof (self) weakSelf = self;
    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        [weakSelf.scrollView.mj_header endRefreshing];
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            
            ApplicationStatusModel *applicationStatusModel = [[ApplicationStatusModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            
            //处理合规中间状态的显示
            if ([applicationStatusModel.platformType isEqualToString:@"2"]) {
                if ([applicationStatusModel.userStatus isEqualToString:@"11"] || [applicationStatusModel.userStatus isEqualToString:@"12"]||[applicationStatusModel.userStatus isEqualToString:@"13"]) {

                    [weakSelf initializeTheIntermediateStatusPage:applicationStatusModel repayModel:nil];
                    return;
                }
                if ([applicationStatusModel.userStatus isEqualToString:@"2"]||[applicationStatusModel.userStatus isEqualToString:@"3"]) {
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    return;
                }
                if ([applicationStatusModel.userStatus isEqualToString:@"6"]) {
                    if (_applicationStatus == ComplianceInLoan) {
                        _applicationStatus = InLoan;
                    }
                    if (_applicationStatus == ComplianceRepayment) {
                        _applicationStatus = RepaymentNormal;
                        self.navigationItem.title = [self setTitle];
                        [self getRepaymentPageInformation];
                        return;
                    }
                }
            }
            //如果是放款中，会判断老客周末活动是否弹框刮奖
            if (_applicationStatus == InLoan) {
                if (!_isHidden) {
                    
                    [self getDrawLottery];
                }
                
            }
            //处理中间状态的显示
            switch (applicationStatusModel.status.integerValue) {
                case 1:
                    self.navigationItem.title = [self setTitle];
                    [weakSelf initializeTheIntermediateStatusPage:applicationStatusModel repayModel:nil];
                    break;
                case 2:
                    if (_applicationStatus == Repayment) {
                        
                        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"还款成功"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        break;
                    }
                    _applicationStatus = RepaymentNormal;
                    self.navigationItem.title = [self setTitle];
                    [self getRepaymentPageInformation];
                    break;
                case 3:
                case 4:
                   [self.navigationController popToRootViewControllerAnimated:YES];
                    break;
                default:
                    break;
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        [self.scrollView.mj_header endRefreshing];
    }];
    
    [loanMoneyViewModel getApplicationStatus:[NSString stringWithFormat:@"%ld",(unsigned long)_applicationStatus]];
}

#pragma mark -> 2.22	待还款界面信息获取
-(void)getRepaymentPageInformation{

     __weak typeof (self) weakSelf = self;
    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        [weakSelf.scrollView.mj_header endRefreshing];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            _applicationStatus = RepaymentNormal;
            _repayModel = [[RepayModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            
            [weakSelf initializeTheIntermediateStatusPage:nil repayModel:_repayModel];
        }else{
        
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        [self.scrollView.mj_header endRefreshing];
    }];
    [loanMoneyViewModel getRepayInfo];
}


#pragma mark -> 2.22	放款中 还款中 展期中 状态实时获取
-(void)initializeTheIntermediateStatusPage:(ApplicationStatusModel *)applicationStatusModel repayModel:(RepayModel *)repayModel{
    
    moenyViewing.repayBtnView.hidden = YES;
    moenyViewing.moneyImage.hidden = NO;
    moenyViewing.repayView.hidden = YES;
    moenyViewing.middleView.hidden = NO;
    moenyViewing.headerView.hidden = NO;
    moenyViewing.promptLabel.hidden = YES;
    moenyViewing.tipImage.hidden = NO;
    moenyViewing.statusBottomView.hidden = NO;
    moenyViewing.stagingBgView.hidden = NO;
    switch (_applicationStatus) {
        case InLoan:
            moenyViewing.stagingBgView.hidden = YES;
            moenyViewing.labelProgress.text = @"放款中";
            moenyViewing.tipLabel.text = @"请注意查收放款短信";
            [self arrivalAndRenewalUI:applicationStatusModel];
            
            break;
        case Repayment:
        {
            moenyViewing.labelProgress.text = @"还款中";
            moenyViewing.tipLabel.text = @"还款处理中,请稍后";
            moenyViewing.middleView.hidden = YES;
            moenyViewing.repayView.hidden = NO;
            moenyViewing.statusBottomView.hidden = YES;
            moenyViewing.stagingBgView.hidden = YES;
            InfoListModel *firstModel = applicationStatusModel.infoList[0];
            moenyViewing.repayMoneyLabel.text = [NSString stringWithFormat:@"%@%@元",firstModel.label,firstModel.value];
            InfoListModel *secondModel = applicationStatusModel.infoList[1];
            moenyViewing.repayMoneyTime.text = [NSString stringWithFormat:@"%@%@",secondModel.label,secondModel.value];
            NSRange range = NSMakeRange(firstModel.label.length, firstModel.value.length);
            moenyViewing.repayMoneyLabel.attributedText = [self changeAtr:moenyViewing.repayMoneyLabel.text color:UI_MAIN_COLOR range:range];
            NSRange rangeTime = NSMakeRange(secondModel.label.length, secondModel.value.length);
            moenyViewing.repayMoneyTime.attributedText = [self changeAtr:moenyViewing.repayMoneyTime.text color:UI_MAIN_COLOR range:rangeTime];
        }
            break;
        case Staging:
            
            moenyViewing.stagingBgView.hidden = YES;
            moenyViewing.labelProgress.text = @"续期处理中";
            moenyViewing.labelProgress.font = [UIFont systemFontOfSize:30];
            if (UI_IS_IPHONE5) {
                moenyViewing.labelProgress.font = [UIFont systemFontOfSize:25];
            }
            moenyViewing.tipLabel.text = @"续期处理中,请稍等";
            moenyViewing.statusBottomView.hidden = YES;
            moenyViewing.stagingBgView.hidden = YES;
            [self arrivalAndRenewalUI:applicationStatusModel];
            
            break;
        case RepaymentNormal:
            
            [self initializeRepaymentView:repayModel];
            [self initializeTheProtocolView];
            moenyViewing.statusBottomView.hidden = YES;
            if (_popAlert&&_isFirst) {
                _isFirst = NO;
                [self showFiveStarPraiseAlertview];
            }
            break;
            
        case ComplianceInLoan:
        case ComplianceRepayment:
        case ComplianceProcessing:
//            moenyViewing.labelProgress.text = @"处理中";
            moenyViewing.labelProgress.text = applicationStatusModel.userPendingMsg;
            moenyViewing.tipLabel.text = @"正在处理,请耐心等待";
            moenyViewing.middleView.hidden = YES;
            moenyViewing.repayBtnView.hidden = YES;
            moenyViewing.stagingBgView.hidden = YES;
            break;

        default:
            break;
    }
}

#pragma mark 我要还款视图加载
-(void)initializeRepaymentView:(RepayModel *)repayModel{

    moenyViewing.overdueFeeLabel.hidden = YES;
    moenyViewing.labelProgress.text = @"正常还款";
    if (![repayModel.overdueFee isEqualToString:@"0"] && repayModel.overdueFee != nil){
    
        moenyViewing.labelProgress.text = @"已逾期";
        moenyViewing.labelProgress.textColor = [UIColor redColor];
    }
    moenyViewing.tipLabel.text = @"请按时还款,保障信用";
    moenyViewing.repayBtnView.hidden = NO;
    moenyViewing.loanTitleLabel.text = @"借款金额";
    moenyViewing.labelLoan.text = [NSString stringWithFormat:@"%@元",repayModel.money];
    moenyViewing.labelLoan.attributedText = [self changeAtr:moenyViewing.labelLoan.text color:UI_MAIN_COLOR range:NSMakeRange(0, repayModel.money.length)];
    moenyViewing.loanTimeTitle.text = @"借款周期";
    
    moenyViewing.labelweek.text = [NSString stringWithFormat:@"%@周",repayModel.duration];
    if ([repayModel.productId isEqualToString:RapidLoan] || [repayModel.productId isEqualToString:DeriveRapidLoan]) {
        moenyViewing.labelweek.text = [NSString stringWithFormat:@"%@天",repayModel.duration];
    }
    moenyViewing.labelweek.attributedText = [self changeAtr:moenyViewing.labelweek.text color:UI_MAIN_COLOR range:NSMakeRange(0, repayModel.duration.length)];
    
    moenyViewing.payMoneyTitle.text = @"每周还款";
    if ([repayModel.productId isEqualToString:RapidLoan]||[repayModel.productId isEqualToString:DeriveRapidLoan]) {
        moenyViewing.payMoneyTitle.text = @"到期还款";
    }
    
    moenyViewing.labelWeekmoney.text = [NSString stringWithFormat:@"%@元",repayModel.repayment];
    moenyViewing.labelWeekmoney.attributedText = [self changeAtr:moenyViewing.labelWeekmoney.text color:UI_MAIN_COLOR range:NSMakeRange(0, repayModel.repayment.length)];
    
    if (UI_IS_IPHONE5) {
        moenyViewing.lableData.font = [UIFont systemFontOfSize:13];
        moenyViewing.overdueFeeLabel.font = [UIFont systemFontOfSize:13];
    }
    int start;
    
    NSString * strDesc = repayModel.overdueDesc != nil ?  repayModel.overdueDesc : @"";
    moenyViewing.lableData.text = [NSString stringWithFormat:@"最近一期还款日:%@%@",repayModel.billDate,strDesc];
    start = 8;
    if ([repayModel.productId isEqualToString:RapidLoan]|| [repayModel.productId isEqualToString:DeriveRapidLoan]) {
        start = 4;
        moenyViewing.lableData.text = [NSString stringWithFormat:@"账单日:%@%@",repayModel.billDate,strDesc];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:moenyViewing.lableData.text];
    [str addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(start,repayModel.billDate.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(moenyViewing.lableData.text.length-repayModel.overdueDesc.length,repayModel.overdueDesc.length)];
    if ([repayModel.overdueDesc containsString:@"续期中"]) {
        
        [str addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(moenyViewing.lableData.text.length-repayModel.overdueDesc.length,repayModel.overdueDesc.length)];
    }
    
    moenyViewing.lableData.attributedText = str;
    
    
    if (![repayModel.overdueFee isEqualToString:@"0"] && repayModel.overdueFee != nil) {
        moenyViewing.overdueFeeLabel.hidden = NO;
        moenyViewing.overdueFeeLabel.text = [NSString stringWithFormat:@"最近一期逾期费用:%@元",repayModel.overdueFee];
        moenyViewing.overdueFeeLabel.attributedText = [self changeAtr:moenyViewing.overdueFeeLabel.text color:UI_MAIN_COLOR range:NSMakeRange(9, repayModel.overdueFee.length)];
        
        if ([repayModel.productId isEqualToString:RapidLoan]|| [repayModel.productId isEqualToString:DeriveRapidLoan]) {
            
            moenyViewing.overdueFeeLabel.text = [NSString stringWithFormat:@"逾期费用:%@元",repayModel.overdueFee];
            moenyViewing.overdueFeeLabel.attributedText = [self changeAtr:moenyViewing.overdueFeeLabel.text color:UI_MAIN_COLOR range:NSMakeRange(5, repayModel.overdueFee.length)];
        }
        
    }
    moenyViewing.stagingView.hidden = YES;
    moenyViewing.stagingBgView.hidden = YES;
    if (repayModel.display) {
        moenyViewing.stagingView.hidden = NO;
        moenyViewing.stagingBgView.hidden = NO;
    }
 }

#pragma mark字体改变颜色
-(NSMutableAttributedString *)changeAtr:(NSString *)str color:(UIColor *)color range:(NSRange)range{

    NSMutableAttributedString *ssa = [[NSMutableAttributedString alloc] initWithString:str];
    [ssa addAttribute:NSForegroundColorAttributeName value:color range:range];
    return ssa;
}

#pragma mark放款中和续期处理中视图加载
-(void)arrivalAndRenewalUI:(ApplicationStatusModel *)applicationStatusModel{

    NSRange range;
    for (int i = 0; i<applicationStatusModel.infoList.count; i++) {
        
        InfoListModel *infoListModel = applicationStatusModel.infoList[i];
        
        range = NSMakeRange(0, infoListModel.value.length);
        if ([infoListModel.index isEqualToString:@"1"]) {
            moenyViewing.labelLoan.text = [NSString stringWithFormat:@"%@%@", infoListModel.value,infoListModel.unit];
            moenyViewing.labelLoan.attributedText = [self changeAtr:moenyViewing.labelLoan.text color:UI_MAIN_COLOR range:range];
            moenyViewing.loanTitleLabel.text = infoListModel.label;
            
        }else if ([infoListModel.index isEqualToString:@"2"]){
            
            moenyViewing.labelweek.text = [NSString stringWithFormat:@"%@%@",infoListModel.value,infoListModel.unit];
            moenyViewing.labelweek.attributedText = [self changeAtr:moenyViewing.labelweek.text color:UI_MAIN_COLOR range:range];
            moenyViewing.loanTimeTitle.text = infoListModel.label;
            
        }else if ([infoListModel.index isEqualToString:@"3"]){
            
            moenyViewing.labelWeekmoney.text = [NSString stringWithFormat:@"%@%@",infoListModel.value,infoListModel.unit];
            moenyViewing.labelWeekmoney.attributedText = [self changeAtr:moenyViewing.labelWeekmoney.text color:UI_MAIN_COLOR range:range];
            moenyViewing.payMoneyTitle.text = infoListModel.label;
        }
    }
}

@end
