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
#import "AutoTransferAccountsAgreement.h"
#import "DataWriteAndRead.h"
#import "CustomerBaseInfoBaseClass.h"
#import "GetCustomerBaseViewModel.h"
#import "HomeDailViewController.h"
#import "DetailViewController.h"
#import "UserCardResult.h"
#import "RepayListInfo.h"
#import "BankModel.h"
#import "RepayDetailViewController.h"
#import "RepayRequestManage.h"
#import "IdeaBackViewController.h"


@interface LoanMoneyViewController ()
{
    MoneyIngView *moenyViewing;
    UserStateModel *model;
    CustomerBaseInfoBaseClass *_customerBase;
    Approval *_approvalModel;
    NSString *_cardNo;
    NSString *_cardBank;
}

@property (nonatomic, copy)NSString *platform;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation LoanMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"审核";
    self.automaticallyAdjustsScrollViewInsets = false;
    [self addBackItemroot];
    //    int flag = 1;
    
    [self checkStatus];
    //    [self PostGetCheckMoney];
    //    [self createUIWith];
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

-(void)checkStatus
{
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if([returnValue[@"flag"] isEqualToString:@"0000"])
        {
            model=[UserStateModel yy_modelWithJSON:returnValue[@"result"]];
            _userStateModel = model;
            [self postUrlMessageandDictionary];
            //            [model setValuesForKeysWithDictionary:returnValue[@"result"]];
            _platform = model.platform_type;
            switch ([model.applyStatus integerValue]) {
                    
                case 5://放款中
                case 4://待放款
                {
                    _intStautes = [model.applyStatus integerValue];
                    [self createUIWith];
                }
                    break;
                case 6://拒绝放款
                {
                    CheckViewController *checkVC = [CheckViewController new];
                    checkVC.homeStatues = [model.applyStatus integerValue];
                    [self.navigationController pushViewController:checkVC animated:YES];
                }   break;
                case 13://已结清
                case 12://提前结清
                case 11://已记坏账
                case 10://委外催收
                case 9://内部催收
                case 8://逾期
                case 7:
                case 16: //还款中
                {
                    _intStautes = [model.applyStatus integerValue];
                    [self createUIWith];
                }
                    break;
                default:
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    break;
            }
        }
        else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState:nil];
    
}

-(void)postUrlMessageandDictionary{
    //请求银行卡列表信息
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        UserCardResult *_userCardModel =[UserCardResult yy_modelWithJSON:object];
        if([_userCardModel.flag isEqualToString:@"0000"]){
            for(NSInteger j=0;j<_userCardModel.result.count;j++)
            {
                CardResult *cardResult = _userCardModel.result[j];
                if([cardResult.card_type_ isEqualToString:@"2"])
                {
                    if ([cardResult.if_default_ isEqualToString:@"1"]) {
                        _cardNo = cardResult.card_no_;
                        _cardBank = cardResult.card_bank_;
                    }
                }
            }
        }
    } failure:^(EnumServerStatus status, id object) {
    }];
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
    switch (_intStautes) {
        case 4://待放款
        case 5://放款中
        {
            moenyViewing = [[[NSBundle mainBundle] loadNibNamed:@"MoneyIngView" owner:self options:nil] lastObject];
            moenyViewing.frame = CGRectMake(0, 0, _k_w, _k_h);
            [self.view addSubview:moenyViewing];
            moenyViewing.sureBtn.hidden = YES;
            moenyViewing.labelProgress.text = @"到账中";
            moenyViewing.labelDetail.text = @"请注意查收到账短信";
            moenyViewing.lableData.hidden = YES;
            moenyViewing.sureBtn.hidden = YES;
            if (_popAlert) {
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
            moenyViewing = [[[NSBundle mainBundle] loadNibNamed:@"MoneyIngView" owner:self options:nil] lastObject];
            moenyViewing.frame = self.view.bounds;
            [self.view addSubview:moenyViewing];
            moenyViewing.labelProgress.text = @"已到账";
            moenyViewing.labelDetail.text = @"请按时还款,保障信用";
            
            
            [moenyViewing.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            if ([model.platform_type isEqualToString:@"0"]) {
                moenyViewing.lableData.textAlignment = NSTextAlignmentLeft;
                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"《银行自动转账授权书》、《三方借款协议》"];
                one.yy_font = [UIFont systemFontOfSize:13];
                [one yy_setTextHighlightRange:NSMakeRange(0, 11)
                                        color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                              backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                    tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                        DLog(@"授权书点击");
                                        
                                        NSDictionary *paramDic = @{@"apply_id_":_userStateModel.applyID,
                                                                   @"product_id_":_userStateModel.product_id,
                                                                   @"protocol_type_":@"1",
                                                                   @"card_no_":_cardNo,
                                                                   @"card_bank_":_cardBank};
                                        [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_productProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
                                            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                                                DetailViewController *detailVC = [[DetailViewController alloc] init];
                                                detailVC.content = [[object objectForKey:@"result"] objectForKey:@"protocol_content_"];
                                                [self.navigationController pushViewController:detailVC animated:YES];
                                            } else {
                                                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
                                            }
                                        } failure:^(EnumServerStatus status, id object) {
                                            
                                        }];
//                                        AutoTransferAccountsAgreement *autoTransfer = [[AutoTransferAccountsAgreement alloc] init];
//                                        [self.navigationController pushViewController:autoTransfer animated:true];
                                    }];
                [one yy_setTextHighlightRange:NSMakeRange(12, 8)
                                        color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                              backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                  DLog(@"三方协议");
                                  NSDictionary *paramDic;
                                  if ([model.product_id isEqualToString:@"P001002"]||[model.product_id isEqualToString:@"P001005"]) {
                                      paramDic = @{@"apply_id_":_userStateModel.applyID,
                                                   @"product_id_":_userStateModel.product_id,
                                                   @"protocol_type_":@"2",
                                                   @"periods_":_approvalModel.result.loan_staging_amount};
                                  }
                                  if ([model.product_id isEqualToString:@"P001004"]) {
                                      paramDic = @{@"apply_id_":_userStateModel.applyID,
                                                   @"product_id_":_userStateModel.product_id,
                                                   @"protocol_type_":@"2",
                                                   @"periods_":@2};
                                  }
                                  
                                  [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_productProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
                                      if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                                          DetailViewController *detailVC = [[DetailViewController alloc] init];
                                          detailVC.content = [[object objectForKey:@"result"] objectForKey:@"protocol_content_"];
                                          [self.navigationController pushViewController:detailVC animated:YES];
                                      } else {
                                          [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
                                      }
                                  } failure:^(EnumServerStatus status, id object) {
                                      
                                  }];
                              }];
                moenyViewing.agreeMentLabel.attributedText = one;
                moenyViewing.agreeMentLabel.textColor = [UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000];
                moenyViewing.agreeMentLabel.textAlignment = NSTextAlignmentLeft;
            }
            
            if ([model.platform_type isEqualToString:@"2"]) {
                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"查看合同"];
                one.yy_font = [UIFont systemFontOfSize:13];
                [one yy_setTextHighlightRange:NSMakeRange(0, one.length)
                                        color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                              backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                    tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                        DLog(@"合同查看");
                                        NSDictionary *dicParam = @{@"bid_id_":model.bid_id_};
                                        [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_P2P_url,_contractList_url] parameters:dicParam finished:^(EnumServerStatus status, id object) {
                                            DLog(@"%@",object);
                                            P2PAgreeMentModel *agreeModel = [P2PAgreeMentModel yy_modelWithJSON:object];
                                            if ([agreeModel.appcode isEqualToString:@"1"]) {
                                                AgreeMentListViewController *agreeMentListViewController = [[AgreeMentListViewController alloc] init];
                                                agreeMentListViewController.agreeMentArr = agreeModel.data.pactList;
                                                [self.navigationController pushViewController:agreeMentListViewController animated:true];
                                            } else {
                                                
                                            }
                                        } failure:^(EnumServerStatus status, id object) {
                                            
                                        }];
                                    }];
                moenyViewing.agreeMentLabel.attributedText = one;
                moenyViewing.agreeMentLabel.textAlignment = NSTextAlignmentCenter;
            }
            
        }
            break;
        default:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
    [self PostGetCheckMoney];
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

-(void)sureBtnClick:(UIButton *)sender
{
    RepayRequestManage *repayRequest = [[RepayRequestManage alloc] init];
    repayRequest.targetVC = self;
    [repayRequest repayRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark -> 2.22	审批金额查询接口

-(void)PostGetCheckMoney
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_approvalAmount_jhtml] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            _approvalModel = [Approval yy_modelWithJSON:object];
            //            approvalModel.result.loan_staging_amount.integerValue
            if ([_approvalModel.flag isEqualToString:@"0000"])
            {
                if (_approvalModel.result.approval_amount >0 && _approvalModel.result.loan_staging_amount.integerValue > 0) {
                    //                    double approAmountSting = 0.0;
                    //                    if (approvalModel.result.approval_amount >= 500) {
                    //                        approAmountSting = approvalBaseClass.result.approvalAmount;
                    //                    }
                    moenyViewing.labelLoan.text = [NSString stringWithFormat:@"%.0f元", _approvalModel.result.approval_amount];
                    
                    if ([_userStateModel.product_id isEqualToString:@"P001004"]) {
                        moenyViewing.payMoneyTitle.text = @"到期还款";
                        moenyViewing.labelweek.text = @"14天";
                        moenyViewing.loanTimeTitle.text = @"借款期限";
                        moenyViewing.labelWeekmoney.text = [NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount];
                    } else {
                        moenyViewing.labelweek.text = [NSString stringWithFormat:@"%d周",_approvalModel.result.loan_staging_amount.intValue];
                        moenyViewing.labelWeekmoney.text = [NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount/_approvalModel.result.loan_staging_amount.integerValue + _approvalModel.result.approval_amount*_approvalModel.result.week_service_fee_rate];
                    }
                    
                    
                    
                    
                    //                    [NSString stringWithFormat:@"%.2f元",approAmountSting/(approvalBaseClass.result.loanStagingAmount) + approAmountSting*0.021];
                    moenyViewing.labelAllMoney.text = [NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount +_approvalModel.result.approval_amount*_approvalModel.result.week_service_fee_rate*_approvalModel.result.loan_staging_amount.integerValue];
                    //                                                       approAmountSting +approAmountSting*approvalBaseClass.result.loanStagingAmount*0.021];
                }
                if (_approvalModel.result.first_repay_date !=nil && [_approvalModel.result.first_repay_date length] >= 10) {
                    if (UI_IS_IPHONE5) {
                        moenyViewing.lableData.font = [UIFont systemFontOfSize:9.f];
//                        moenyViewing.lableData.backgroundColor = [UIColor redColor];
                        moenyViewing.lableData.numberOfLines = 0;
                        moenyViewing.lableData.text = [NSString stringWithFormat:@"\n第1期还款日:%@", [_approvalModel.result.first_repay_date substringToIndex:10]];
                    }else {
                        moenyViewing.lableData.text = [NSString stringWithFormat:@"第1期还款日:%@", [_approvalModel.result.first_repay_date substringToIndex:10]];
                    }
                }
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}

@end
