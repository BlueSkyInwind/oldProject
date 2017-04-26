//
//  CheckViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 16/1/27.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "CheckViewController.h"
#import "CheckViewIng.h"
#import "CheckFalseView.h"
#import "CheckSuccessView.h"
#import "BankCardViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "HomeViewModel.h"
#import "CheckInfoView.h"
#import "EnterAgainController.h"
#import "UserCardResult.h"
#import "MoxieSDK.h"
#import "PayViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "PayNavigationViewController.h"
#import "BankModel.h"
#import "CardInfo.h"
#import "LoanMoneyViewController.h"
#import "YYText.h"
#import "ExpressViewController.h"
#import "DrawService.h"
#import "P2PViewController.h"
#import "GetCaseInfo.h"
#import "P2PBindCardViewController.h"
#import "HomeDailViewController.h"
#import "DataWriteAndRead.h"
#import "CustomerBaseInfoBaseClass.h"
#import "GetCustomerBaseViewModel.h"
#import "ReplenishViewController.h"
#import "Approval.h"
#import "P2PAgreementViewController.h"
#import "DetailViewController.h"
#import "IdeaBackViewController.h"
#import "FXDWebViewController.h"
#import "PayLoanChooseController.h"
#import "RateModel.h"
#import "DataDicParse.h"

//#error 以下需要修改为您平台的信息
//启动SDK必须的参数
//Apikey,您的APP使用SDK的API的权限
//6149056c09e1498ca9b1bcd534b5ad0c

//用户ID,您APP中用以识别的用户ID，魔蝎数据后台会将最终导入结果的用户ID和数据一起返回，以便您的数据入库

typedef NS_ENUM(NSUInteger, PromoteType) {
    PromoteCredit = 1,
    PromoteLimit,
};

@interface CheckViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ReplenishDoneDelegate>
{
    CheckViewIng *_checking;
    CheckSuccessView *checkSuccess;
    CheckFalseView *checkFalse;
    int sectionState[20];   //标志分区的状态
    //    int textFieldstring;
    NSNumber *_userSelectNum;
    //    int datalist[60];
    NSMutableArray<NSNumber *> *_datalist;
    UserCardResult *_userCardModel;
    BankModel *_bankCardModel;
    UserCardResult *_userCardsModel;
    CardInfo *_selectCard;
    NSInteger defaultBankIndex;
    NSInteger userSelectIndex;
    PromoteType _promoteType;
    NSDictionary *_uploadP2PUserInfo;
    CustomerBaseInfoBaseClass *_customerBase;
    Approval *_approvalModel;
    //借款用途
    DataDicParse *_dataDicModel;

}

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger flag;
@property (strong,nonatomic)MoxieSDK *moxieSDK;
@property (nonatomic,strong)NSArray * dateArray;

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"审核";
    _promoteType = -1;
    _flag = 1;
    _datalist = [NSMutableArray array];
    defaultBankIndex = -1;
    userSelectIndex = defaultBankIndex;
    self.rt_disableInteractivePop = YES;
    [self addBackItemRoot];
    DLog(@"%@",[Utility sharedUtility].userInfo.juid);
    _moxieSDK = [[MoxieSDK shared] initWithUserID:[NSString stringWithFormat:@"%@_1",[Utility sharedUtility].userInfo.juid] mApikey:theMoxieApiKey controller:self];
    DLog(@"%@",_moxieSDK.mxSDKVersion);
    [self listenForResult];
    
    if ([_userStateModel.product_id isEqualToString:@"P001002"]) {
        for (int i = 0; i < 46; i++) {
            [_datalist addObject:[NSNumber numberWithInt:(i+5)]];
        }
    }
    if ([_userStateModel.product_id isEqualToString:@"P001004"]) {
        for (int i = 1; i < 2; i++) {
            [_datalist addObject:[NSNumber numberWithInt:(i+1)]];
        }
    }
    
    _userSelectNum = @0;
    //    [self createScroll];
    
    [self createUI];
    
    _checking.ReceiveImmediatelyImage.userInteractionEnabled = true;
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    [_checking.ReceiveImmediatelyImage addGestureRecognizer:tapImage];
    
}

-(void)imageTap{

    FXDWebViewController *webView = [[FXDWebViewController alloc] init];
    webView.urlStr = @"http://www.liangzihuzhu.com.cn//xwh5/pages/hignway/faxindai.html";
    [self.navigationController pushViewController:webView animated:true];
}

- (void)loadView
{
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.contentSize = CGSizeMake(_k_w, _k_h);
    view.backgroundColor = [UIColor whiteColor];
    // 去掉滚动条
    view.showsVerticalScrollIndicator = NO;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(checkState)];
    header.automaticallyChangeAlpha = YES;
    view.mj_header = header;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view = view;
    self.scrollView = view;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

-(void)createUI
{
    
    switch (_homeStatues) {
        case 1://系统审核中
        case 3: //人工审核中
        case 17: //准入规则失败
        {
            _checking = [[[NSBundle mainBundle] loadNibNamed:@"CheckViewIng" owner:self options:nil] lastObject];
            _checking.layer.anchorPoint = CGPointMake(0.5, 1.0);
            _checking.frame =CGRectMake(0, 0,_k_w, _k_h);
            [_checking setContentMode:UIViewContentModeScaleAspectFit];
            [self.view addSubview:_checking];
        }
            break;
        case 6:
        case 14://人工审 核未通过
        case 2://系统审核未通过
        {
            if (_checking) {
                [_checking removeFromSuperview];
            }
            checkFalse =[[[NSBundle mainBundle] loadNibNamed:@"CheckFalseView" owner:self options:nil] lastObject];
            checkFalse.layer.anchorPoint = CGPointMake(0.5, 2.0);
            checkFalse.frame = CGRectMake(0, 0,_k_w, _k_h);
            checkFalse.labelday.text = @"您的信用评分不够";
            
            [[checkFalse.moreInfoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                ReplenishViewController *replenVC = [[ReplenishViewController alloc] init];
                replenVC.userStateModel = _userStateModel;
                replenVC.delegate = self;
                [self.navigationController pushViewController:replenVC animated:YES];
            }];
            if (_userStateModel.if_add_documents) {
                checkFalse.moreInfoLabel.hidden = NO;
                checkFalse.moreInfoBtn.hidden = NO;
                checkFalse.promoteLabel.hidden = NO;
                checkFalse.seeView.hidden = YES;
                checkFalse.jsdView.hidden = YES;
            }else {
                checkFalse.moreInfoLabel.hidden = YES;
                checkFalse.moreInfoBtn.hidden = YES;
                checkFalse.promoteLabel.hidden = YES;
                if ([_userStateModel.product_id isEqualToString:@"P001002"]) {
                    
                    checkFalse.jsdView.hidden = NO;
                    checkFalse.seeView.hidden = YES;
                    [checkFalse.applyImmediatelyBtn addTarget:self action:@selector(clickApplyImmediatelyBtn) forControlEvents:UIControlEventTouchUpInside];
                }else{
                
                    checkFalse.seeView.hidden = NO;
                    checkFalse.jsdView.hidden = YES;
                    [checkFalse.seeBtn addTarget:self action:@selector(clickSeeBtn) forControlEvents:UIControlEventTouchUpInside];

                }
                
            }
            
            [self.view addSubview:checkFalse];
        }
            break;
        case 13: //结清
        case 12: //提前结清
        case 15:// 人工审核通过
        {
            [self PostGetCheckMoney];
            checkSuccess =[[[NSBundle mainBundle] loadNibNamed:@"CheckSuccessView" owner:self options:nil] lastObject];
            checkSuccess.frame = CGRectMake(0, 0,_k_w, _k_h);
            checkSuccess.pickweek.hidden = YES;
            checkSuccess.toolBar.hidden = YES;
            checkSuccess.pickweek.delegate = self;
            checkSuccess.pickweek.dataSource = self;
            if ([_userStateModel.product_id isEqualToString:@"P001004"]) {
                checkSuccess.weekBtn.hidden = true;
                checkSuccess.textFiledWeek.hidden = true;
                UILabel *daysLabel = [[UILabel alloc] init];
                daysLabel.text = @"借款期限: 14天";
                daysLabel.textAlignment = NSTextAlignmentCenter;
                daysLabel.font = [UIFont systemFontOfSize:16.f];
                daysLabel.textColor = [UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000];
                [checkSuccess.bgView addSubview:daysLabel];
                [daysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@0);
                    make.top.equalTo(@0);
                    make.right.equalTo(@0);
                    make.bottom.equalTo(@0);
                }];
                NSString *amountText = [NSString stringWithFormat:@"%.0f元",_approvalModel.result.approval_amount];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"到期还款:"];
                [attStr yy_appendString:amountText];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(3, 154, 238) range:NSMakeRange(4, amountText.length)];
                checkSuccess.weekMoney.attributedText = attStr;
            }else {
                checkSuccess.textFiledWeek.text = @"请选择借款周期";
                [Tool setCorner:checkSuccess.bgView borderColor:rgb(0, 170, 238)];
                
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:0元"];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(3, 154, 238) range:NSMakeRange(attStr.length-2, 2)];
                checkSuccess.weekMoney.attributedText = attStr;
                checkSuccess.allMoney.text = @"0元";
                checkSuccess.textFiledWeek.delegate = self;
                checkSuccess.toolCancleBtn.tag = 103;
                checkSuccess.toolCancleBtn.action =@selector(shareBtn:);
                checkSuccess.toolCancleBtn.target = self;
                
                checkSuccess.toolsureBtn.tag = 104;
                checkSuccess.toolsureBtn.action =@selector(shareBtn:);
                checkSuccess.toolsureBtn.target = self;
            }
            //[NSString stringWithFormat:@"%d周",_datalist.firstObject.intValue];
            checkSuccess.sureBtn.tag = 101;
            [checkSuccess.sureBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
            checkSuccess.weekBtn.tag = 102;
            [checkSuccess.weekBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
            checkSuccess.loadMoney.text =[NSString stringWithFormat:@"¥%.0f元",_approvalModel.result.approval_amount];
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:checkSuccess.loadMoney.text];
            [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0, 1)];
            [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange([checkSuccess.loadMoney.text length]-1, 1)];
            checkSuccess.loadMoney.attributedText = att;
            
            
            
            [checkSuccess.promote addTarget:self action:@selector(promote) forControlEvents:UIControlEventTouchUpInside];
            _promoteType = PromoteLimit;
            [self.view addSubview:checkSuccess];
            DLog(@"%d",[_userStateModel.applyAgain boolValue]);
            if (![_userStateModel.applyAgain boolValue] || ![_userStateModel.taskStatus isEqualToString:@"1"] || ![_userStateModel.applyStatus isEqualToString:@"15"]) {
                [checkSuccess.promote setHidden:YES];
                checkSuccess.surBtnLeadRight.constant = .0f;
                [checkSuccess.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(checkSuccess.bottomBtnView.mas_right).offset(-21);
                }];
                [checkSuccess.sureBtn layoutIfNeeded];
                [checkSuccess.sureBtn updateConstraints];
            }
            NSMutableAttributedString *attributeStr;
            NSRange range;
            
            if([_userStateModel.platform_type isEqualToString:@"2"] || [_userStateModel.platform_type isEqualToString:@"0"]){
                if ([_userStateModel.platform_type isEqualToString:@"0"]) {
                    attributeStr = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并认可发薪贷《三方借款协议》"];
                    range = NSMakeRange(attributeStr.length - 8, 8);
                }
                if ([_userStateModel.platform_type isEqualToString:@"2"]) {
                    attributeStr = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并认可发薪贷《信用咨询及管理服务协议》"];
                    range = NSMakeRange(attributeStr.length - 13, 13);
                }
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"产品类型错误"];
            }
            
            [attributeStr yy_setTextHighlightRange:range color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000] backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
                [self getUserInfoData:^{
                    if ([_userStateModel.platform_type isEqualToString:@"0"]) {
                        NSDictionary *paramDic;
                        if ([_userStateModel.product_id isEqualToString:@"P001002"]) {
                            if (_userSelectNum.integerValue == 0) {
                                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择借款周期"];
                                return;
                            }
                            paramDic = @{@"apply_id_":_userStateModel.applyID,
                                         @"product_id_":_userStateModel.product_id,
                                         @"protocol_type_":@"2",
                                         @"periods_":_userSelectNum};
                        }
                        if ([_userStateModel.product_id isEqualToString:@"P001004"]) {
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
                    }
                    if ([_userStateModel.platform_type isEqualToString:@"2"]) {
                        if (_userSelectNum.integerValue == 0) {
                            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择借款周期"];
                            return;
                        }
                        
                        NSDictionary *paramDic = @{@"apply_id_":_userStateModel.applyID,
                                                   @"product_id_":_userStateModel.product_id,
                                                   @"protocol_type_":@"3",
                                                   @"periods_":_userSelectNum};
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
                    }
                    
                }];
            }];
            checkSuccess.agreementLabel.attributedText = attributeStr;
            
        }
            break;
        default:
            break;
    }
}



- (void)refreshUI{
    [self updateUserState];
}


- (void)promote
{
    [_moxieSDK startFunction:MXSDKFunctionbank];
}

#pragma mark -- 魔蝎回调
-(void)listenForResult{
    //    __weak CheckViewController *weakSelf = self;
    @weakify(self);
    self.moxieSDK.resultBlock=^(int code,MXSDKFunction funciton,NSString *taskid,NSString *searchid){
        DLog(@"get import result---statusCode:%d,function:%d,taskid:%@,searchid:%@",code,funciton,taskid,searchid);
        
        if(funciton == MXSDKFunctionbank){
            if(code == 1){
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self);
                    for (UIView *view in self.view.subviews) {
                        if (![[view class] isSubclassOfClass:[MJRefreshNormalHeader class]]) {
                            [view removeFromSuperview];
                        }
                    }
                });
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [NSThread sleepForTimeInterval:1];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self);
                        [self updateUserState];
                    });
                });
            }
        }
    };
}



- (void)updateUserState
{
    NSDictionary *dic;
    if (_promoteType == PromoteCredit) {
        dic = @{@"task_type_":@"2",
                @"request_type_":@"2",
                @"apply_id_":_userStateModel.applyID,
                @"old_task_status_":@"1"};
    }
    if (_promoteType == PromoteLimit) {
        dic = @{@"task_type_":@"1",
                @"request_type_":@"2",
                @"apply_id_":_userStateModel.applyID,
                @"old_task_status_":@"1"};
    }
    
    //    __weak CheckViewController *weakSelf = self;
    @weakify(self);
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_caseStatusUpdateApi_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            DLog(@"%@",object);
        }
        //                            [weakself.navigationController popViewControllerAnimated:true];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self checkState];
        });
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


- (void)addBackItemRoot
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
    //    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
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

-(void)shareBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 101:
        {
            DLog(@"提款")
            DLog(@"%d",_userSelectNum.intValue);
            if ([_userStateModel.product_id isEqualToString:@"P001002"]) {
                if (_userSelectNum.integerValue == 0) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请选择周期"];
                }else {
                    if (checkSuccess.userCheckBtnState) {
                        [self getMoney];
                    } else {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请勾选借款协议"];
                    }
                }
            }
            if ([_userStateModel.product_id isEqualToString:@"P001004"]) {
                if (checkSuccess.userCheckBtnState) {
                    [self getMoney];
                } else {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请勾选借款协议"];
                }
            }
        }
            break;
        case 102:
        {
            DLog(@"选择周期")
            checkSuccess.pickweek.hidden = NO;
            checkSuccess.toolBar.hidden = NO;
        }
            break;
        case 103:
        {
            DLog(@"取消");
            checkSuccess.pickweek.hidden = YES;
            checkSuccess.toolBar.hidden = YES;
        }
            break;
        case 104:
        {
            checkSuccess.pickweek.hidden = YES;
            checkSuccess.toolBar.hidden = YES;
            DLog(@"%d",_userSelectNum.intValue);
            if (_userSelectNum.integerValue > 0) {
                checkSuccess.textFiledWeek.text = [NSString stringWithFormat:@"%d周",_userSelectNum.intValue];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:"];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                NSString *amountStr = [NSString stringWithFormat:@"%.2f元",(_approvalModel.result.approval_amount +_approvalModel.result.approval_amount*_userSelectNum.intValue*_approvalModel.result.week_service_fee_rate)/_userSelectNum.intValue];
                [attStr yy_appendString:amountStr];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(3, 154, 238) range:NSMakeRange(attStr.length-amountStr.length, amountStr.length)];
                checkSuccess.weekMoney.attributedText = attStr;
                checkSuccess.allMoney.text =[NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount +_approvalModel.result.approval_amount*_userSelectNum.intValue*_approvalModel.result.week_service_fee_rate];
            }else {
                checkSuccess.textFiledWeek.text = @"请选择周期";
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:"];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(3, 154, 238) range:NSMakeRange(attStr.length-2, 2)];
                checkSuccess.weekMoney.attributedText = attStr;
                
                checkSuccess.allMoney.text = @"0元";
            }
            DLog(@"确定");
            
        }
            break;
        default:
            break;
    }
}

- (void)getMoney
{
    if([_userStateModel.platform_type isEqualToString:@"2"] || [_userStateModel.platform_type isEqualToString:@"0"]){
        if ([_userStateModel.platform_type isEqualToString:@"2"]) {
            [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_ValidESB_url,_getFXDUserInfo_url] parameters:nil finished:^(EnumServerStatus status, id object) {
                DLog(@"%@",object);
                _uploadP2PUserInfo = object;
                [self checkP2PUserState];
            } failure:^(EnumServerStatus status, id object) {
                
            }];
        }
        if ([_userStateModel.platform_type isEqualToString:@"0"]) {
            [self fatchCardInfo];
        }
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"产品类型错误"];
    }
}

- (void)checkP2PUserState
{
    NSDictionary *paramDic = @{@"user_info":[Tool objextToJSON:[[_uploadP2PUserInfo objectForKey:@"result"] objectForKey:@"user_info"]],
                               @"user_contacter":[Tool objextToJSON:[[_uploadP2PUserInfo objectForKey:@"result"] objectForKey:@"user_contacter"]],
                               @"mobile_":[[_uploadP2PUserInfo objectForKey:@"result"] objectForKey:@"mobile_"],
                               @"id_number_":[Utility sharedUtility].userInfo.userIDNumber};
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_drawService_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        DrawService *drawServiceParse = [DrawService yy_modelWithJSON:object];
        //                        drawServiceParse.data.flg = @"4";
        //        if ([drawServiceParse.appcode isEqualToString:@"0"]) {
        DLog(@"%@",[Utility sharedUtility].userInfo.account_id);
        if ([[Utility sharedUtility].userInfo.account_id isEqualToString:@""] || [Utility sharedUtility].userInfo.account_id == nil) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"参数缺失,请退出重新登陆"];
        } else {
            //开户
            if ([drawServiceParse.data.flg isEqualToString:@"2"]) {
                NSString *url = [NSString stringWithFormat:@"%@%@?from_user_id_=%@&from_mobile_=%@&id_number_=%@&user_name_=%@&PageType=1&RetUrl=%@",_P2P_url,_register_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone,[Utility sharedUtility].userInfo.userIDNumber,[Utility sharedUtility].userInfo.realName,_transition_url];
                P2PViewController *p2pVC = [[P2PViewController alloc] init];
                p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                p2pVC.uploadP2PUserInfo = _uploadP2PUserInfo;
                p2pVC.userSelectNum = _userSelectNum;
                [self.navigationController pushViewController:p2pVC animated:YES];
            }
            //绑卡
            if ([drawServiceParse.data.flg isEqualToString:@"3"]) {
                P2PBindCardViewController *p2pBindCardVC = [[P2PBindCardViewController alloc] init];
                p2pBindCardVC.uploadP2PUserInfo = _uploadP2PUserInfo;
                p2pBindCardVC.userSelectNum = _userSelectNum;
                [self.navigationController pushViewController:p2pBindCardVC animated:YES];
            }
            //发标
            if ([drawServiceParse.data.flg isEqualToString:@"4"]) {
                [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_ValidESB_url,_getFXDCaseInfo_url] parameters:nil finished:^(EnumServerStatus status, id object) {
                    DLog(@"%@",object);
                    GetCaseInfo *caseInfo = [GetCaseInfo yy_modelWithJSON:object];
                    if ([caseInfo.flag isEqualToString:@"0000"]) {
                        [self addBildInfo:caseInfo];
                    }
                    
                } failure:^(EnumServerStatus status, id object) {
                    
                }];
            }
        }
        
        //        } else {
        //            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:drawServiceParse.appmsg];
        //        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


- (void)addBildInfo:(GetCaseInfo *)caseInfo
{
    NSDictionary *paramDic = @{@"product_id_":caseInfo.result.product_id_,
                               @"auditor_":caseInfo.result.auditor_,
                               @"desc_":caseInfo.result.desc_,
                               @"amount_":caseInfo.result.amount_,
                               @"period_":_userSelectNum,
                               @"title_":caseInfo.result.title_,
                               @"from_":caseInfo.result.from_,
                               @"client_":caseInfo.result.client_,
                               @"start_date_":caseInfo.result.start_date_,
                               @"from_case_id_":caseInfo.result.from_case_id_,
                               @"user_id_":caseInfo.result.user_id_,
                               @"description_":caseInfo.result.description_,
                               @"invest_days_":caseInfo.result.invest_days_};
    
    NSString *url = [NSString stringWithFormat:@"%@%@&from_user_id_=%@&from_mobile_=%@",_P2P_url,_addBidInfo_url,[Utility sharedUtility].userInfo.account_id,[Utility sharedUtility].userInfo.userMobilePhone];
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:url parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DrawService *model = [DrawService yy_modelWithJSON:object];
        if ([model.appcode isEqualToString:@"1"]) {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"发标成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        if ([model.appcode isEqualToString:@"-1"]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:model.appmsg];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"发标成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


- (void)fatchCardInfo
{
    NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        _bankCardModel = [BankModel yy_modelWithJSON:object];
        if ([_bankCardModel.flag isEqualToString:@"0000"]) {
            [self fatchUserCardList];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_bankCardModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

- (void)fatchUserCardList
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        _userCardsModel = [UserCardResult yy_modelWithJSON:object];
        if([_userCardsModel.flag isEqualToString:@"0000"]){
            if (_userCardsModel.result.count > 0) {
                for(NSInteger j=0;j<_userCardsModel.result.count;j++)
                {
                    CardResult *cardResult = [_userCardsModel.result objectAtIndex:j];
                    if([cardResult.card_type_ isEqualToString:@"2"])
                    {
                        if ([cardResult.if_default_ isEqualToString:@"1"]) {
                            defaultBankIndex = j;
                            for (BankList *banlist in _bankCardModel.result) {
                                if ([cardResult.card_bank_ isEqualToString: banlist.code]) {
                                    //                                _selectCard
                                    CardInfo *cardInfo = [[CardInfo alloc] init];
                                    cardInfo.tailNumber = [self formatTailNumber:cardResult.card_no_];
                                    cardInfo.bankName = banlist.desc;
                                    cardInfo.cardIdentifier = cardResult.id_;
                                    _selectCard = cardInfo;
                                }
                            }
                        }
                    }
                }
                PayViewController *payVC = [[PayViewController alloc] init];
                payVC.payType = PayTypeGetMoneyToCard;
                
                payVC.cardInfo = _selectCard;
                payVC.bankCardModel = _bankCardModel;
                if (userSelectIndex == -1) {
                    payVC.banckCurrentIndex = defaultBankIndex;
                } else {
                    payVC.banckCurrentIndex = userSelectIndex;
                }
                payVC.makesureBlock = ^(PayType payType,CardInfo *cardInfo,NSInteger currentIndex){
                    userSelectIndex = currentIndex;
                    if (cardInfo) {
                        _selectCard = cardInfo;
                    }
                    
                    if (payType == PayTypeGetMoneyToCard) {
                        if (_selectCard != nil) {
                            [self dismissSemiModalViewWithCompletion:^{
                                [self PostGetdrawApplyAgain];
                            }];
                        } else {
                            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择或添加一张可用银行卡"];
                        }
                    }
                    DLog(@"确认提款");
                };
                PayNavigationViewController *payNC = [[PayNavigationViewController alloc] initWithRootViewController:payVC];
                payNC.view.frame = CGRectMake(0, 0, _k_w, 200);
                [self presentSemiViewController:payNC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)}];
            } else {
                NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
                [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
                    BankModel *bankModel = [BankModel yy_modelWithJSON:object];
                    if ([bankModel.flag isEqualToString:@"0000"]) {
                        BankCardViewController *bankVC = [BankCardViewController new];
                        bankVC.bankModel = bankModel;
                        bankVC.periodSelect = _userSelectNum.integerValue;
                        bankVC.userStateModel = _userStateModel;
                        //            bankVC.idString = _idString;
                        bankVC.drawAmount = [NSString stringWithFormat:@"%.0f",_approvalModel.result.approval_amount];
                        [self.navigationController pushViewController:bankVC animated:YES];
                    } else {
                        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:bankModel.msg];
                    }
                } failure:^(EnumServerStatus status, id object) {
                    DLog(@"%@",object);
                }];
            }
            
            
            //            PayViewController *payVC = [[PayViewController alloc] init];
            //                payVC.payType = PayTypeGetMoneyToCard;
            //                payVC.makesureBlock = ^(PayType payType){
            //                    DLog(@"确认支付");
            //                };
            //                PayNavigationViewController *payNC = [[PayNavigationViewController alloc] initWithRootViewController:payVC];
            //                payNC.view.frame = CGRectMake(0, 0, _k_w, 200);
            //                [self presentSemiViewController:payNC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)}];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardsModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
    }];
}

- (NSString *)formatTailNumber:(NSString *)str
{
    return [str substringWithRange:NSMakeRange(str.length - 4, 4)];
}

-(void)PostGetdrawApplyAgain
{
    NSDictionary *paramDic;
    if ([_userStateModel.product_id isEqualToString:@"P001004"]) {
        paramDic = @{@"periods_":@1,
                     @"drawing_amount_":@(_approvalModel.result.approval_amount),
                     @"account_card_id_":_selectCard.cardIdentifier
                     };
    }
    if ([_userStateModel.product_id isEqualToString:@"P001002"]) {
        paramDic = @{@"periods_":[NSString stringWithFormat:@"%d",_userSelectNum.intValue],
                     @"drawing_amount_":@(_approvalModel.result.approval_amount),
                     @"account_card_id_":_selectCard.cardIdentifier
                     };
    }
    
    //二次提款
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_drawApplyAgain_jhtml] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"]) {
                
                LoanMoneyViewController *loanVC =[LoanMoneyViewController new];
                loanVC.popAlert = true;
                [self.navigationController pushViewController:loanVC animated:YES];
                
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


#pragma mark->UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _datalist.count+1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        return @"选择周期";
    } else {
        return [NSString stringWithFormat:@"%d周",[_datalist objectAtIndex:row-1].intValue];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    DLog(@"%@",datalist[row]);
    if (row != 0) {
        _userSelectNum = [_datalist objectAtIndex:row-1];
        checkSuccess.textFiledWeek.text = [NSString stringWithFormat:@"%d周",_userSelectNum.intValue];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:"];
        [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
        NSString *amountStr = [NSString stringWithFormat:@"%.2f元",(_approvalModel.result.approval_amount +_approvalModel.result.approval_amount*_userSelectNum.intValue*_approvalModel.result.week_service_fee_rate)/_userSelectNum.intValue];
        [attStr yy_appendString:amountStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:rgb(3, 154, 238) range:NSMakeRange(attStr.length-amountStr.length, amountStr.length)];
        checkSuccess.weekMoney.attributedText = attStr;
        checkSuccess.allMoney.text =[NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount +_approvalModel.result.approval_amount*_userSelectNum.intValue*_approvalModel.result.week_service_fee_rate];
    }
    if (row == 0) {
        _userSelectNum = @0;
        checkSuccess.textFiledWeek.text = @"请选择周期";
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:0元"];
        [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
        [attStr addAttribute:NSForegroundColorAttributeName value:rgb(3, 154, 238) range:NSMakeRange(attStr.length-2, 2)];
        checkSuccess.weekMoney.attributedText = attStr;
        checkSuccess.allMoney.text = @"0元";
    }
    
    
    //    checkSuccess.pickweek.hidden = YES;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.f;
}
#pragma mark-
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    DLog(@"%@",string);
//    return NO;
//}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}


//分享函数
-(void)shareContent:(UIButton*)tableView
{
    NSArray *imageArr = @[[UIImage imageNamed:@"logo_60"]];
    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"发薪贷只专注于网络小额贷款。是一款新型网络小额贷款神器, 尽可能优化贷款申请流程，申请步骤更便捷，轻完成网上贷款。链接:http://www.faxindai.com"
                                         images:imageArr
                                            url:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]
                                          title:@"发薪贷"
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享成功"];
                               break;
                               
                           case SSDKResponseStateFail:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享失败"];
                           default:
                               break;
                       }
                   }];
    }
}

//查询状态
-(void)checkState{
    
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    
    //    __weak CheckViewController *weakSelf = self;
    @weakify(self);
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        if([returnValue[@"flag"] isEqualToString:@"0000"])
        {
            UserStateModel *model=[UserStateModel yy_modelWithJSON:returnValue[@"result"]];
            _userStateModel = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self);
                [self.scrollView.mj_header endRefreshing];
                if (model.days) {
                    _days = model.days;
                }
                
                if (_homeStatues != [model.applyStatus integerValue]) {
                    _homeStatues = [model.applyStatus integerValue];
                    for (UIView *view in self.view.subviews) {
                        if (![[view class] isSubclassOfClass:[MJRefreshNormalHeader class]]) {
                            [view removeFromSuperview];
                        }
                    }
                    [_datalist removeAllObjects];
                    if ([_userStateModel.product_id isEqualToString:@"P001002"]) {
                        for (int i=0; i < 46; i++) {
                            [_datalist addObject:[NSNumber numberWithInt:(i+5)]];
                        }
                    }
                    if ([_userStateModel.product_id isEqualToString:@"P001004"]) {
                        for (int i=1; i < 2; i++) {
                            [_datalist addObject:[NSNumber numberWithInt:(i+1)]];
                        }
                    }
                    _userSelectNum = @0;
                    [self createUI];
                }
            });
        }
        else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
            [self.scrollView.mj_header endRefreshing];
        }
    } WithFaileBlock:^{
        @strongify(self);
        [self.scrollView.mj_header endRefreshing];
    }];
    [homeViewModel fetchUserState:nil];
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

#pragma mark -> 2.22	审批金额查询接口

-(void)PostGetCheckMoney
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_approvalAmount_jhtml] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            _approvalModel = [Approval yy_modelWithJSON:object];
            
            
            if ([_approvalModel.flag isEqualToString:@"0000"])
            {
                //                _loanMountMoney= [[[object objectForKey:@"result"] objectForKey:@"approval_amount_"] doubleValue];
                checkSuccess.loadMoney.text =[NSString stringWithFormat:@"¥%.0f元",_approvalModel.result.approval_amount];
                //[NSString stringWithFormat:@"%.2f元",(_loanMountMoney +_loanMountMoney*_userSelectNum.intValue*0.021)/_userSelectNum.intValue];
                if ([_userStateModel.product_id isEqualToString:@"P001004"]) {
                    NSString *amountText = [NSString stringWithFormat:@"%.0f元",_approvalModel.result.approval_amount];
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"到期还款:"];
                    [attStr yy_appendString:amountText];
                    [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                    [attStr addAttribute:NSForegroundColorAttributeName value:rgb(3, 154, 238) range:NSMakeRange(4, amountText.length)];
                    checkSuccess.weekMoney.attributedText = attStr;
                }else {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:0元"];
                    [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                    [attStr addAttribute:NSForegroundColorAttributeName value:rgb(3, 154, 238) range:NSMakeRange(attStr.length-2, 2)];
                    checkSuccess.weekMoney.attributedText = attStr;
                }
                
                //[NSString stringWithFormat:@"%.2f元",_loanMountMoney +_loanMountMoney*_userSelectNum.intValue*0.021];
                checkSuccess.allMoney.text = @"0元";
                NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:checkSuccess.loadMoney.text];
                [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0, 1)];
                [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange([checkSuccess.loadMoney.text length]-1, 1)];
                checkSuccess.loadMoney.attributedText = att;
                //                CGFloat factMoney = [[[object objectForKey:@"result"] objectForKey:@"approval_amount_"] doubleValue] * 0.94;
                //                DLog(@"%f",_approvalModel.result.actual_loan_amount.floatValue);
                CGFloat factMoney = _approvalModel.result.actual_loan_amount;
                //                [[[object objectForKey:@"result"] objectForKey:@"actual_loan_amount_"] doubleValue] ;
                NSString  *factMoneyStr = [NSString stringWithFormat:@"%.2f",factMoney];
                NSString *attributeStr = [NSString stringWithFormat:@"实际到账%@元,详情见借款说明",factMoneyStr];
                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:attributeStr];
                one.yy_font = [UIFont systemFontOfSize:16];
                [one addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000] range:NSMakeRange(4,factMoneyStr.length)];
                [one yy_setTextHighlightRange:NSMakeRange(one.length-4, 4)
                                        color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                              backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                    tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                        ExpressViewController *expressVC = [[ExpressViewController alloc] init];
                                        expressVC.productId = _userStateModel.product_id;
                                        [self.navigationController pushViewController:expressVC animated:YES];
                                    }];
                checkSuccess.moneyLabel.attributedText = one;
                checkSuccess.moneyLabel.textAlignment = NSTextAlignmentCenter;
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}

#pragma mark -> 银行卡读取接口
-(void)PostGetBankCardCheck
{
    NSDictionary *paramDic = @{@"card_id_":@""
                               };
    //银行卡四要素验证
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"]) {
                
                _userCardModel = [UserCardResult yy_modelWithJSON:object];
                if (_userCardModel.result.count >0) {
                    CardResult *cardResult = _userCardModel.result[0];
                    //4
                    if ([cardResult.card_bank_ integerValue] == 4) {
                        BankCardViewController *bankVC = [BankCardViewController new];
                        bankVC.periodSelect = _userSelectNum.intValue;
                        //            bankVC.idString = _idString;
                        bankVC.drawAmount = [NSString stringWithFormat:@"%.0f",_approvalModel.result.approval_amount];
                        bankVC.flagString = @"1";
                        bankVC.bankMobile = cardResult.bank_reserve_phone_;
                        [self.navigationController pushViewController:bankVC animated:YES];
                    }else{
                        EnterAgainController *again=[EnterAgainController new];
                        again.periods_ = [NSString stringWithFormat:@"%d",_userSelectNum.intValue];
                        again.drawing_amount_ = [NSString stringWithFormat:@"%.0f",_approvalModel.result.approval_amount];
                        again.userCardModel = _userCardModel;
                        [self.navigationController pushViewController:again animated:YES];
                    }
                }
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardModel.msg];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


-(void)clickSeeBtn{


}


-(void)clickApplyImmediatelyBtn{

    [self fatchRate:^(RateModel *rate) {
        PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
        payLoanview.product_id = @"P001004";
        payLoanview.userState = _userStateModel;
        payLoanview.rateModel = rate;
        [self.navigationController pushViewController:payLoanview animated:true];
    }];
    
}

- (void)fatchRate:(void(^)(RateModel *rate))finish
{
    NSDictionary *dic = @{@"priduct_id_":@"P001004"};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
        if ([rateParse.flag isEqualToString:@"0000"]) {
            finish(rateParse);
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:rateParse.msg];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}





@end
