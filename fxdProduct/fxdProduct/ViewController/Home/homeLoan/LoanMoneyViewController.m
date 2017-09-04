//
//  LoanMoneyViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/28.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "LoanMoneyViewController.h"
#import "MoneyIngView.h"
#import "RepaymentViewController.h"
#import "CheckViewController.h"
#import "ApprovalAmountBaseClass.h"
#import "RepayListViewController.h"
#import "Approval.h"
#import "YYText.h"
#import "P2PAgreeMentModel.h"
#import "AgreeMentListViewController.h"
#import "DataWriteAndRead.h"
#import "CustomerBaseInfoBaseClass.h"
#import "GetCustomerBaseViewModel.h"
#import "DetailViewController.h"
#import "UserCardResult.h"
#import "RepayListInfo.h"
#import "BankModel.h"
#import "RepayDetailViewController.h"
#import "RepayRequestManage.h"
#import "IdeaBackViewController.h"
#import "GetCaseInfo.h"
#import "RepayWeeklyRecordViewModel.h"
#import "LoanMoneyViewModel.h"
#import "CheckViewModel.h"
#import "QryUserStatusModel.h"
#import "RTRootNavigationController.h"
#import "GetCaseInfo.h"
#import "P2PViewController.h"
#import "ApplicationStatusModel.h"
#import "RepayModel.h"
@interface LoanMoneyViewController ()
{
    MoneyIngView *moenyViewing;
    UserStateModel *model;
    CustomerBaseInfoBaseClass *_customerBase;
    Approval *_approvalModel;
    NSString *_cardNo;
    NSString *_cardBank;
    BOOL _isFirst;//好评只弹出一次，再次刷新时，不弹对话框
    RepayModel *_repayModel;
}

@property (nonatomic, copy)NSString *platform;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic,strong)GetCaseInfo *caseInfo;
@property (nonatomic,strong)ApplicationStatusModel *applicationStatusModel;


@end

@implementation LoanMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"审核";
    [self addBackItemroot];
    moenyViewing = [[[NSBundle mainBundle] loadNibNamed:@"MoneyIngView" owner:self options:nil] lastObject];
    moenyViewing.frame = CGRectMake(0, 0, _k_w, _k_h);
    moenyViewing.repayBtnView.hidden = YES;
    moenyViewing.middleView.hidden = YES;
    moenyViewing.moneyImage.hidden = YES;
    moenyViewing.repayView.hidden = YES;
    [self.view addSubview:moenyViewing];

    [moenyViewing.stagingBtn addTarget:self action:@selector(stagingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [moenyViewing.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [moenyViewing.agreementBtn addTarget:self action:@selector(agreementBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _isFirst = _popAlert;

    _applicationStatus = InLoan;
    
  }

#pragma mark 续借一期点击按钮
-(void)stagingBtnClick{

    
    if (!_repayModel.continueStaging) {
        
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"一次借款最多续借三次"];
        return;
    }
        
    RenewalViewController *controller = [[RenewalViewController alloc]init];
    controller.stagingId = _repayModel.stagingId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 协议勾选按钮
-(void)agreementBtnClick:(UIButton *)btn{

    btn.selected = !btn.selected;
    if (moenyViewing.agreementBtn.selected) {
        
        [moenyViewing.agreementBtn setBackgroundImage:[UIImage imageNamed:@"Sign-in-icon06"] forState:UIControlStateNormal];
    }else{
    
        [moenyViewing.agreementBtn setBackgroundImage:[UIImage imageNamed:@"Sign-in-icon05"] forState:UIControlStateNormal];
    }
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

-(void)refresh{

    if ([self.applicationStatusModel.platformType isEqualToString:@"0"]) {
        _applicationStatus = Repayment;
        [self getApplicationStatus];
    }else{
        [self getFxdCaseInfo];
    }
}


- (void)addBackItemroot
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
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
}

- (void)popBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

//-(void)checkStatus
//{
//    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
//    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
//        
//        if([returnValue[@"flag"] isEqualToString:@"0000"])
//        {
//            model=[UserStateModel yy_modelWithJSON:returnValue[@"result"]];
//            _userStateModel = model;
//            [self postUrlMessageandDictionary];
//            //            [model setValuesForKeysWithDictionary:returnValue[@"result"]];
//            _platform = model.platform_type;
//            switch ([model.applyStatus integerValue]) {
//                    
//                case 5://放款中
//                case 4://待放款
//                {
//                    _intStautes = [model.applyStatus integerValue];
//                    [self createUIWith];
//                }
//                    break;
//                case 6://拒绝放款
//                {
//                    CheckViewController *checkVC = [CheckViewController new];
//                    checkVC.homeStatues = [model.applyStatus integerValue];
//                    [self.navigationController pushViewController:checkVC animated:YES];
//                }   break;
//                case 13://已结清
//                case 12://提前结清
//                case 11://已记坏账
//                case 10://委外催收
//                case 9://内部催收
//                case 8://逾期
//                case 7:
//                case 16: //还款中
//                {
//                    _intStautes = [model.applyStatus integerValue];
//                    [self createUIWith];
//
//                }
//                    break;
//                case 15:
//                    
//                    _intStautes = [model.applyStatus integerValue];
//                    [self createUIWith];
//
//                    break;
//                default:
//
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//
//                    break;
//            }
//        }
//        else {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
//        }
//    } WithFaileBlock:^{
//        
//    }];
//    [homeViewModel fetchUserState:_userStateModel.product_id];
//    
//}

#pragma mark  fxd用户状态查询，viewmodel
-(void)getUserStatus:(GetCaseInfo *)caseInfo{
    
    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        QryUserStatusModel *qryUserStatusModel = [QryUserStatusModel yy_modelWithJSON:returnValue];
        if ([qryUserStatusModel.flag isEqualToString:@"0000"]) {
            
            _qryUserStatusModel = qryUserStatusModel;
            _applicationStatus  = ComplianceInProcess;
//            [self checkStatus];

        }else{
            
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:qryUserStatusModel.msg];
        }
    } WithFaileBlock:^{
        
    }];
    
    [complianceViewModel getUserStatus:caseInfo];
}


#pragma mark 发标前查询进件
-(void)getFxdCaseInfo{

    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        GetCaseInfo *caseInfo = [GetCaseInfo yy_modelWithJSON:returnValue];
        if ([caseInfo.flag isEqualToString:@"0000"]) {
            [self.scrollView.mj_header endRefreshing];
            _caseInfo = caseInfo;
            [self getUserStatus:caseInfo];
        }
    } WithFaileBlock:^{
        [self.scrollView.mj_header endRefreshing];
    }];
    [complianceViewModel getFXDCaseInfo];
    
}


#pragma mark 请求银行卡列表信息
- (void)postUrlMessageandDictionary:(void(^)(CardResult *rate))finish{

    RepayWeeklyRecordViewModel *repayWeeklyRecordViewModel = [[RepayWeeklyRecordViewModel alloc]init];
    [repayWeeklyRecordViewModel setBlockWithReturnBlock:^(id returnValue) {
        UserCardResult *_userCardModel =[UserCardResult yy_modelWithJSON:returnValue];
        if([_userCardModel.flag isEqualToString:@"0000"]){
            for(NSInteger j=0;j<_userCardModel.result.count;j++)
            {
                CardResult *cardResult = _userCardModel.result[0];
                if([cardResult.card_type_ isEqualToString:@"2"])
                {
                    _cardNo = cardResult.card_no_;
                    _cardBank = cardResult.card_bank_;
                    finish(cardResult);
                    break;
                }
            }
        }
    } WithFaileBlock:^{
        
    }];
    [repayWeeklyRecordViewModel bankCardList];
    
}

-(void)postUrlMessageandDictionary{
    //请求银行卡列表信息
    
    RepayWeeklyRecordViewModel *repayWeeklyRecordViewModel = [[RepayWeeklyRecordViewModel alloc]init];
    [repayWeeklyRecordViewModel setBlockWithReturnBlock:^(id returnValue) {
        UserCardResult *_userCardModel =[UserCardResult yy_modelWithJSON:returnValue];
        if([_userCardModel.flag isEqualToString:@"0000"]){
            for(NSInteger j=0;j<_userCardModel.result.count;j++)
            {
                CardResult *cardResult = _userCardModel.result[0];
                if([cardResult.card_type_ isEqualToString:@"2"])
                {
                    _cardNo = cardResult.card_no_;
                    _cardBank = cardResult.card_bank_;
                    break;
                }
            }
        }
    } WithFaileBlock:^{
        
    }];
    [repayWeeklyRecordViewModel bankCardList];

}

- (void)getUserInfoData:(void(^)())completion
{
    DLog(@"%@",[Utility sharedUtility].userInfo.account_id);
    //    if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
    id data = [DataWriteAndRead readDataWithkey:UserInfomation];
    if (data) {
        DLog(@"%@",data);
        _customerBase = data;
        if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
            [Utility sharedUtility].userInfo.account_id = _customerBase.result.createBy;
        }
        [Utility sharedUtility].userInfo.userIDNumber = _customerBase.result.idCode;
        [Utility sharedUtility].userInfo.userMobilePhone = _customerBase.ext.mobilePhone;
        [Utility sharedUtility].userInfo.realName = _customerBase.result.customerName;
    } else {
        if ([Utility sharedUtility].loginFlage) {
            GetCustomerBaseViewModel *customBaseViewModel = [[GetCustomerBaseViewModel alloc] init];
            [customBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
                _customerBase = returnValue;
                if ([_customerBase.flag isEqualToString:@"0000"]) {
                    [DataWriteAndRead writeDataWithkey:UserInfomation value:_customerBase];
                    [Utility sharedUtility].userInfo.userIDNumber = _customerBase.result.idCode;
                    [Utility sharedUtility].userInfo.userMobilePhone = _customerBase.ext.mobilePhone;
                    [Utility sharedUtility].userInfo.realName = _customerBase.result.customerName;
                    if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
                        [Utility sharedUtility].userInfo.account_id = _customerBase.result.createBy;
                    }
                }
            } WithFaileBlock:^{
                
            }];
            [customBaseViewModel fatchCustomBaseInfo:nil];
        }
    }
    completion();
}

-(void)createUIWith
{

    moenyViewing.moneyImage.hidden = NO;
    
    switch (_intStautes) {
            
        case 4://待放款
        case 5://放款中
        {
//            moenyViewing = [[[NSBundle mainBundle] loadNibNamed:@"MoneyIngView" owner:self options:nil] lastObject];
//            moenyViewing.frame = CGRectMake(0, 0, _k_w, _k_h);
//            [self.view addSubview:moenyViewing];
            moenyViewing.sureBtn.hidden = YES;
            moenyViewing.labelProgress.text = @"到账中";
            moenyViewing.labelDetail.text = @"请注意查收到账短信";
            moenyViewing.lableData.hidden = YES;
            moenyViewing.sureBtn.hidden = YES;
            moenyViewing.middleView.hidden = NO;
            if (_popAlert&&_isFirst) {
                _isFirst = NO;
                [self showAlertview];
            }
        }
            break;
        case 13://已结清
        case 12://提前结清
        case 11://已记坏账
        case 10://委外催收
        case 9://内部催收
        case 8://逾期
        case 7://放款成功
        case 16://还款中
        {
            
            if ([_qryUserStatusModel.result.flg isEqualToString:@"11"]||[_qryUserStatusModel.result.flg isEqualToString:@"12"]) {
                
//                moenyViewing = [[[NSBundle mainBundle] loadNibNamed:@"MoneyIngView" owner:self options:nil] lastObject];
//                moenyViewing.frame = CGRectMake(0, 0, _k_w, _k_h);
//                [self.view addSubview:moenyViewing];
                moenyViewing.sureBtn.hidden = YES;
                moenyViewing.labelProgress.text = @"处理中";
                moenyViewing.labelDetail.text = @"正在处理，请耐心等待";
                moenyViewing.lableData.hidden = YES;
                moenyViewing.sureBtn.hidden = YES;
                moenyViewing.middleView.hidden = YES;
                
            }else{
            
                [self fxdStatus];
            }
            
        }
            break;
            
        case 15:
            
            if ([_qryUserStatusModel.result.flg isEqualToString:@"11"]||[_qryUserStatusModel.result.flg isEqualToString:@"12"]) {
                
//                moenyViewing = [[[NSBundle mainBundle] loadNibNamed:@"MoneyIngView" owner:self options:nil] lastObject];
//                moenyViewing.frame = CGRectMake(0, 0, _k_w, _k_h);
//                [self.view addSubview:moenyViewing];
                moenyViewing.sureBtn.hidden = YES;
                moenyViewing.labelProgress.text = @"处理中";
                moenyViewing.labelDetail.text = @"正在处理，请耐心等待";
                moenyViewing.lableData.hidden = YES;
                moenyViewing.sureBtn.hidden = YES;
                moenyViewing.middleView.hidden = YES;
                
            }
            if ([_qryUserStatusModel.result.flg isEqualToString:@"2"]||[_qryUserStatusModel.result.flg isEqualToString:@"6"]) {
                
                BOOL isHave = NO;
                CheckViewController *controller;
                for (UIViewController* vc in self.rt_navigationController.rt_viewControllers) {
                    if ([vc isKindOfClass:[CheckViewController class]]) {
                        controller = (CheckViewController *)vc;
                        isHave = YES;
                    }
                }
                
                if (isHave) {
                    [self.navigationController popToViewController:controller animated:YES];
                }else{
                    
                    controller = [CheckViewController new];
                    [self.navigationController pushViewController:controller animated:YES];
                }
            }

            break;
        default:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }

    [self PostGetCheckMoney];
}

#pragma mark 获取协议
-(void)fxdStatus{

    if ([_repayModel.platformType isEqualToString:@"0"]) {
        
        [self postUrlMessageandDictionary:^(CardResult *rate) {
            
            moenyViewing.lableData.textAlignment = NSTextAlignmentLeft;
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并认可发薪贷《银行自动转账授权书》、《借款协议》"];
            one.yy_font = [UIFont systemFontOfSize:13];
            [one yy_setTextHighlightRange:NSMakeRange(10, 11)
                                    color:UI_MAIN_COLOR
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                    DLog(@"授权书点击");
                                    
//                                    NSArray *paramArray = @[_userStateModel.applyID,_userStateModel.product_id,@"1",_cardNo,_cardBank];
                                    
                                    NSArray *paramArray = @[_userStateModel.applyID,_repayModel.productId,@"1",rate.card_no_,rate.card_bank_];
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
            [one yy_setTextHighlightRange:NSMakeRange(12, 6)
                                    color:UI_MAIN_COLOR
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                              DLog(@"三方协议");
                              
                              NSArray *paramArray = [NSArray array];
                              if ([_repayModel.productId isEqualToString:SalaryLoan]||[_repayModel.productId isEqualToString:WhiteCollarLoan]) {
                                  paramArray = @[_userStateModel.applyID,_repayModel.productId,@"2",_repayModel.duration];
                              }
                              if ([_repayModel.productId isEqualToString:RapidLoan]) {
                                  paramArray = @[_userStateModel.applyID,_repayModel.productId,@"2",@2];
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
            moenyViewing.agreeMentLabel.textColor = UI_MAIN_COLOR;
            moenyViewing.agreeMentLabel.textAlignment = NSTextAlignmentLeft;
        }];
    }
    
    if ([_repayModel.platformType isEqualToString:@"2"]) {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"查看合同"];
        one.yy_font = [UIFont systemFontOfSize:13];
        [one yy_setTextHighlightRange:NSMakeRange(0, one.length)
                                color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                      backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                DLog(@"合同查看");
                                
                                LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
                                [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
                                    P2PAgreeMentModel *agreeModel = [P2PAgreeMentModel yy_modelWithJSON:returnValue];
                                    if ([agreeModel.result.appcode isEqualToString:@"1"]) {
                                        AgreeMentListViewController *agreeMentListViewController = [[AgreeMentListViewController alloc] init];
                                        agreeMentListViewController.agreeMentArr = agreeModel.result.pactList;
                                        [self.navigationController pushViewController:agreeMentListViewController animated:true];
                                    } else {
                                        
                                    }
                                } WithFaileBlock:^{
                                    
                                }];
                                [loanMoneyViewModel getContractList:model.bid_id_];
                                
                            }];
        moenyViewing.agreeMentLabel.attributedText = one;
        moenyViewing.agreeMentLabel.textAlignment = NSTextAlignmentCenter;
    }
}
- (void)showAlertview
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

/**
 我要还款按钮
 */
-(void)sureBtnClick:(UIButton *)sender
{
    //platform_type 2、合规平台  0发薪贷平台
    if ([model.platform_type isEqualToString:@"2"]) {
        if ([_qryUserStatusModel.result.flg isEqualToString:@"3"]) {//待激活用户
            
            NSString *url = [NSString stringWithFormat:@"%@%@?page_type_=%@&ret_url_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"1",_transition_url,[Utility sharedUtility].userInfo.userMobilePhone];
            P2PViewController *p2pVC = [[P2PViewController alloc] init];
            //        p2pVC.isOpenAccount = NO;
            p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [self.navigationController pushViewController:p2pVC animated:YES];
            
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //platform_type 2、合规平台  0发薪贷平台
    if ([_userStateModel.platform_type isEqualToString:@"2"]) {
        //查询用户状态
        [self getFxdCaseInfo];
    }else{
    
        [self getRepayInfo];
//        if (_applicationStatus == RepaymentNormal) {
//            
//            [self getRepayInfo];
//            
//        }else{
//        
//            [self getApplicationStatus];
//        }

        if (_applicationStatus == RepaymentNormal) {
            [self getRepayInfo];
        }else{
            [self getApplicationStatus];
        }

        //发薪贷申请件状态查询
//        [self checkStatus];
    }
    
    [self getApplicationStatus];
//    [self addBid];
}


#pragma mark -> 2.22	放款中 还款中 展期中 状态实时获取
-(void)getApplicationStatus{

    __weak typeof (self) weakSelf = self;
    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            [weakSelf.scrollView.mj_header endRefreshing];
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
            weakSelf.applicationStatusModel = [[ApplicationStatusModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            switch (weakSelf.applicationStatusModel.status.integerValue) {
                case 1:
                    [weakSelf updateUI:weakSelf.applicationStatusModel repayModel:nil];
                    break;
                case 2:
                case 3:
                case 4:
                   [self.navigationController popToRootViewControllerAnimated:YES];
                default:
                    break;
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        [self.scrollView.mj_header endRefreshing];
    }];
    
    [loanMoneyViewModel getApplicationStatus:@"1"];
}

#pragma mark -> 2.22	待还款界面信息获取
-(void)getRepayInfo{

    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            [self.scrollView.mj_header endRefreshing];
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.errMsg];
            _applicationStatus = RepaymentNormal;
            _repayModel = [[RepayModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            [self updateUI:nil repayModel:_repayModel];
        }else{
        
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.errMsg];
        }
    } WithFaileBlock:^{
        [self.scrollView.mj_header endRefreshing];
    }];
    [loanMoneyViewModel getRepayInfo];
}


#pragma mark -> 2.22	放款中 还款中 展期中 状态实时获取
-(void)updateUI:(ApplicationStatusModel *)applicationStatusModel repayModel:(RepayModel *)repayModel{
    
    moenyViewing.repayBtnView.hidden = YES;
    moenyViewing.moneyImage.hidden = NO;
    moenyViewing.repayView.hidden = YES;
    moenyViewing.middleView.hidden = NO;
    switch (_applicationStatus) {
        case InLoan:
            
            moenyViewing.labelProgress.text = @"放款中";
            moenyViewing.tipLabel.text = @"请注意查收放款短信";
            [self arrivalAndRenewalUI:applicationStatusModel];
            
            break;
        case Repayment:
            moenyViewing.labelProgress.text = @"还款中";
            moenyViewing.tipLabel.text = @"还款处理中，请稍后";
            moenyViewing.middleView.hidden = YES;
            moenyViewing.repayView.hidden = NO;
            NSRange range = NSMakeRange(5, moenyViewing.repayMoneyLabel.text.length-6);
            moenyViewing.repayMoneyLabel.attributedText = [self changeAtr:moenyViewing.repayMoneyLabel.text color:UI_MAIN_COLOR range:range];
            NSRange rangeTime = NSMakeRange(5, moenyViewing.repayMoneyTime.text.length-5);
            moenyViewing.repayMoneyTime.attributedText = [self changeAtr:moenyViewing.repayMoneyTime.text color:UI_MAIN_COLOR range:rangeTime];
            
            break;
        case Staging:
            moenyViewing.labelProgress.text = @"续期处理中";
            moenyViewing.labelProgress.font = [UIFont systemFontOfSize:34];
            moenyViewing.tipLabel.text = @"续期处理中，请稍等";
            [self arrivalAndRenewalUI:applicationStatusModel];
            
            break;
        case RepaymentNormal:
            
            [self repayUI:repayModel];
            [self fxdStatus];
        case ComplianceInProcess:
            
        default:
            break;
    }
}

#pragma mark 我要还款视图加载
-(void)repayUI:(RepayModel *)repayModel{

    moenyViewing.overdueFeeLabel.hidden = YES;
    moenyViewing.labelProgress.text = @"正常还款";
    moenyViewing.tipLabel.text = @"请按时还款,保障信用";
    moenyViewing.repayBtnView.hidden = NO;
    moenyViewing.loanTitleLabel.text = @"借款金额";
    moenyViewing.labelLoan.text = [NSString stringWithFormat:@"%@元",repayModel.money];
    moenyViewing.labelLoan.attributedText = [self changeAtr:moenyViewing.labelLoan.text color:UI_MAIN_COLOR range:NSMakeRange(0, repayModel.money.length)];
    moenyViewing.loanTimeTitle.text = @"借款周期";
    moenyViewing.labelweek.text = [NSString stringWithFormat:@"%@周",repayModel.duration];
    moenyViewing.labelweek.attributedText = [self changeAtr:moenyViewing.labelweek.text color:UI_MAIN_COLOR range:NSMakeRange(0, repayModel.duration.length)];
    moenyViewing.payMoneyTitle.text = @"每周还款";
    if ([repayModel.productId isEqualToString:RapidLoan]) {
        moenyViewing.payMoneyTitle.text = @"到期还款";
    }
    
    moenyViewing.labelWeekmoney.text = [NSString stringWithFormat:@"%@元",repayModel.repayment];
    moenyViewing.labelWeekmoney.attributedText = [self changeAtr:moenyViewing.labelWeekmoney.text color:UI_MAIN_COLOR range:NSMakeRange(0, repayModel.repayment.length)];
    moenyViewing.lableData.text = [NSString stringWithFormat:@"最近一期还款日:%@",repayModel.billDate];
    moenyViewing.lableData.attributedText = [self changeAtr:moenyViewing.lableData.text color:UI_MAIN_COLOR range:NSMakeRange(8, moenyViewing.lableData.text.length-8)];
    if (![repayModel.overdueFee isEqualToString:@"0"] && repayModel.overdueFee != nil) {
        moenyViewing.overdueFeeLabel.hidden = NO;
        moenyViewing.overdueFeeLabel.text = [NSString stringWithFormat:@"逾期费用:%@元",repayModel.overdueFee];
        moenyViewing.overdueFeeLabel.attributedText = [self changeAtr:moenyViewing.overdueFeeLabel.text color:UI_MAIN_COLOR range:NSMakeRange(5, moenyViewing.lableData.text.length-6)];
        moenyViewing.lableData.text = [NSString stringWithFormat:@"最近一期还款日:%@%@",repayModel.billDate,repayModel.overdueDesc];
        moenyViewing.lableData.attributedText = [self changeAtr:moenyViewing.lableData.text color:UI_MAIN_COLOR range:NSMakeRange(8, moenyViewing.lableData.text.length-8)];
        moenyViewing.lableData.attributedText = [self changeAtr:moenyViewing.lableData.text color:[UIColor redColor] range:NSMakeRange(moenyViewing.lableData.text.length-6, repayModel.overdueDesc.length+2)];
    }
    moenyViewing.stagingBtn.hidden = YES;
    if (repayModel.display) {
        moenyViewing.stagingBtn.hidden = NO;
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
#pragma mark -> 2.22	审批金额查询接口

-(void)PostGetCheckMoney
{

    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        _approvalModel = [Approval yy_modelWithJSON:returnValue];
        //            approvalModel.result.loan_staging_amount.integerValue
        if ([_approvalModel.flag isEqualToString:@"0000"])
        {
            if (_approvalModel.result.approval_amount >0 && _approvalModel.result.loan_staging_amount.integerValue > 0) {
                //                    double approAmountSting = 0.0;
                //                    if (approvalModel.result.approval_amount >= 500) {
                //                        approAmountSting = approvalBaseClass.result.approvalAmount;
                //                    }
                moenyViewing.labelLoan.text = [NSString stringWithFormat:@"%.0f元", _approvalModel.result.approval_amount];
                
                if ([_userStateModel.product_id isEqualToString:RapidLoan]) {
                    moenyViewing.payMoneyTitle.text = @"到期还款";
                    moenyViewing.labelweek.text = [NSString stringWithFormat:@"%d周",_approvalModel.result.loan_staging_amount.intValue];
                    moenyViewing.loanTimeTitle.text = @"借款期限";
                    moenyViewing.labelWeekmoney.text = [NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount];
                } else {
                    moenyViewing.labelweek.text = [NSString stringWithFormat:@"%d周",_approvalModel.result.loan_staging_amount.intValue];
                    moenyViewing.labelWeekmoney.text = [NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount/_approvalModel.result.loan_staging_amount.integerValue + _approvalModel.result.approval_amount*_approvalModel.result.week_service_fee_rate];

                //                    [NSString stringWithFormat:@"%.2f元",approAmountSting/(approvalBaseClass.result.loanStagingAmount) + approAmountSting*0.021];
                moenyViewing.labelAllMoney.text = [NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount +_approvalModel.result.approval_amount*_approvalModel.result.week_service_fee_rate*_approvalModel.result.loan_staging_amount.integerValue];
                //                                                       approAmountSting +approAmountSting*approvalBaseClass.result.loanStagingAmount*0.021];
            }
            if (_approvalModel.result.first_repay_date !=nil && [_approvalModel.result.first_repay_date length] >= 10) {
                if (UI_IS_IPHONE5) {
                    moenyViewing.lableData.font = [UIFont systemFontOfSize:9.f];
                    //                        moenyViewing.lableData.backgroundColor = [UIColor redColor];
                    moenyViewing.lableData.numberOfLines = 0;
                    moenyViewing.lableData.text = [NSString stringWithFormat:@"第1期还款日:%@", [_approvalModel.result.first_repay_date substringToIndex:10]];
                }else {
                    moenyViewing.lableData.text = [NSString stringWithFormat:@"第1期还款日:%@", [_approvalModel.result.first_repay_date substringToIndex:10]];
                }
            }
        }
      }
    } WithFaileBlock:^{
        
    }];
    [loanMoneyViewModel getApprovalAmount];

    
}



@end
