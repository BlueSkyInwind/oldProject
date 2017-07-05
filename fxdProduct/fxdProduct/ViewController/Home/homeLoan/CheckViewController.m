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
#import "DrawService.h"
#import "P2PViewController.h"
#import "GetCaseInfo.h"
#import "DataWriteAndRead.h"
#import "CustomerBaseInfoBaseClass.h"
#import "GetCustomerBaseViewModel.h"
#import "ReplenishViewController.h"
#import "Approval.h"
#import "DetailViewController.h"
#import "IdeaBackViewController.h"
#import "FXDWebViewController.h"
#import "PayLoanChooseController.h"
#import "RateModel.h"
#import "FXDWebViewController.h"
#import "DataDicParse.h"
#import "UserDataViewController.h"
#import "AccountHSServiceModel.h"
#import "QueryCardInfo.h"
#import "UnbundlingBankCardViewController.h"
#import "QryUserStatusModel.h"
#import "CheckViewModel.h"
#import "SaveLoanCaseModel.h"
#import "QryUserStatusModel.h"
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
    NSString *_purposeSelect;
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
    NSString *_userFlag;
    GetCaseInfo *_caseInfo;
    QryUserStatusModel *_qryUserStatusModel;

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
    
    
    if ([_userStateModel.product_id isEqualToString:RapidLoan]) {
        for (int i = 1; i < 2; i++) {
            [_datalist addObject:[NSNumber numberWithInt:(i+1)]];
        }
    }
    _dateArray = [NSArray array];
//    _dateArray = @[@"资金周转",@"购物",@"旅游",@"医疗",@"教育",@"其他"];
    _userSelectNum = @0;
    _purposeSelect = @"0";
    //    [self createScroll];
    
    [self createUI];
    
    [_checking.receiveImmediatelyBtn addTarget:self action:@selector(imageTap) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark 审核中，量子互助链接
-(void)imageTap{

    FXDWebViewController *webView = [[FXDWebViewController alloc] init];
    //http://www.liangzihuzhu.com.cn/xwh5/pages/plan/quotaRecharge.html?id=222767
    webView.urlStr = _liangzihuzhu_url;
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
    //platform_type  2、合规平台   0、发薪贷平台
    if ([_userStateModel.platform_type isEqualToString:@"2"]) {
    
        [self getFxdCaseInfo];
    }else{
    
        [self checkState];
    }
//    [self getUserStatus];
    
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
            [_checking.receiveImmediatelyBtn addTarget:self action:@selector(imageTap) forControlEvents:UIControlEventTouchUpInside];
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
                if ([_userStateModel.product_id isEqualToString:SalaryLoan]||[_userStateModel.product_id isEqualToString:WhiteCollarLoan]) {
                    
//                    if ([_userStateModel.merchant_status isEqualToString:@"1"]) {
                        if ([_userStateModel.product_id isEqualToString:SalaryLoan]) {
                            checkFalse.seeView.hidden = NO;
                            [checkFalse.seeBtn addTarget:self action:@selector(clickSeeBtn) forControlEvents:UIControlEventTouchUpInside];
                        }else{
                        
                            [self getContent];
                            checkFalse.jsdView.hidden = NO;
                            [checkFalse.applyImmediatelyBtn addTarget:self action:@selector(clickApplyImmediate) forControlEvents:UIControlEventTouchUpInside];
                        }
                        
//                    }else{
//                    
//                        checkFalse.seeView.hidden = YES;
//                        checkFalse.jsdView.hidden = YES;
//                    }
//                    checkFalse.jsdView.hidden = NO;
                    
                }else{
                
                    if ([_userStateModel.merchant_status isEqualToString:@"1"]) {
                        
                        checkFalse.seeView.hidden = NO;
                        checkFalse.jsdView.hidden = YES;
                        [checkFalse.seeBtn addTarget:self action:@selector(clickSeeBtn) forControlEvents:UIControlEventTouchUpInside];
                    }else{
                    
                        checkFalse.seeView.hidden = YES;
                        checkFalse.jsdView.hidden = YES;
                    }
                   

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
            [self getDataDic:^{
                
            }];
            checkSuccess =[[[NSBundle mainBundle] loadNibNamed:@"CheckSuccessView" owner:self options:nil] lastObject];
            checkSuccess.frame = CGRectMake(0, 0,_k_w, _k_h);
            checkSuccess.purposePicker.delegate = self;
            checkSuccess.purposePicker.dataSource = self;
            checkSuccess.purposePicker.tag = 101;
            checkSuccess.pickweek.hidden = YES;
            checkSuccess.toolBar.hidden = YES;
            checkSuccess.purposePicker.hidden = YES;
            checkSuccess.pickweek.delegate = self;
            checkSuccess.pickweek.dataSource = self;
            //选项框的确定取消按钮
            checkSuccess.toolCancleBtn.tag = 103;
            checkSuccess.toolCancleBtn.action =@selector(shareBtn:);
            checkSuccess.toolCancleBtn.target = self;
            
            checkSuccess.toolsureBtn.tag = 104;
            checkSuccess.toolsureBtn.action =@selector(shareBtn:);
            checkSuccess.toolsureBtn.target = self;
            
            if ([_userStateModel.product_id isEqualToString:RapidLoan]) {
                checkSuccess.weekBtn.hidden = true;
                checkSuccess.textFiledWeek.hidden = true;
                checkSuccess.purposeTextField.text = @"请选择借款用途";
                [Tool setCorner:checkSuccess.purposeView borderColor:UI_MAIN_COLOR];
                checkSuccess.purposeTextField.delegate = self;
           
                checkSuccess.sureBtn.backgroundColor = rgb(158, 158, 159);
                UILabel *daysLabel = [[UILabel alloc] init];
                daysLabel.text = [NSString stringWithFormat:@"借款期限: %@天", [Utility sharedUtility].rateParse.result.ext_attr_.period_desc_];
                daysLabel.textAlignment = NSTextAlignmentCenter;
                daysLabel.font = [UIFont systemFontOfSize:16.f];
                daysLabel.textColor = UI_MAIN_COLOR;
                
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
                checkSuccess.purposeTextField.text = @"请选择借款用途";
                [Tool setCorner:checkSuccess.bgView borderColor:UI_MAIN_COLOR];
                [Tool setCorner:checkSuccess.purposeView borderColor:UI_MAIN_COLOR];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:0元"];
                [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(attStr.length-2, 2)];
                checkSuccess.weekMoney.attributedText = attStr;
                checkSuccess.allMoney.text = @"0元";
                checkSuccess.textFiledWeek.delegate = self;
                checkSuccess.purposeTextField.delegate = self;
     
            }
            //[NSString stringWithFormat:@"%d周",_datalist.firstObject.intValue];
//            checkSuccess.sureBtn.enabled = NO;
            checkSuccess.sureBtn.tag = 101;
            [checkSuccess.sureBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
            checkSuccess.weekBtn.tag = 102;
            [checkSuccess.weekBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
            checkSuccess.purposeBtn.tag = 105;
            [checkSuccess.purposeBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
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
            
            [attributeStr yy_setTextHighlightRange:range color:UI_MAIN_COLOR backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
                [self getUserInfoData:^{
                    if ([_userStateModel.platform_type isEqualToString:@"0"]) {
                        NSDictionary *paramDic;
                        if ([_userStateModel.product_id isEqualToString:SalaryLoan]||[_userStateModel.product_id isEqualToString:WhiteCollarLoan]) {
                            if (_userSelectNum.integerValue == 0) {
                                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择借款周期"];
                                return;
                            }
                            paramDic = @{@"apply_id_":_userStateModel.applyID,
                                         @"product_id_":_userStateModel.product_id,
                                         @"protocol_type_":@"2",
                                         @"periods_":_userSelectNum};
                        }
                        if ([_userStateModel.product_id isEqualToString:RapidLoan]) {
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
            if ([_userStateModel.product_id isEqualToString:SalaryLoan]||[_userStateModel.product_id isEqualToString:WhiteCollarLoan]) {
                if (_userSelectNum.integerValue == 0) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请选择借款周期"];
                    return;
                }
                if (_purposeSelect.integerValue == 0) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请选择借款用途"];
                    return;
                }
                if (!checkSuccess.userCheckBtnState) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请勾选借款协议"];
                    return;
                }
                
                [self getMoney];
            }
            if ([_userStateModel.product_id isEqualToString:RapidLoan]) {
                
                if (_purposeSelect.integerValue == 0) {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请选择借款用途"];
                    return;
                }
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
            checkSuccess.purposePicker.hidden = YES;
        }
            break;
        case 103:
        {
            DLog(@"取消");
            checkSuccess.pickweek.hidden = YES;
            checkSuccess.toolBar.hidden = YES;
            checkSuccess.purposePicker.hidden = YES;
        }
            break;
        case 104:
        {
            checkSuccess.pickweek.hidden = YES;
            checkSuccess.toolBar.hidden = YES;
            checkSuccess.purposePicker.hidden = YES;
            DLog(@"%d",_userSelectNum.intValue);
            //借款周期隐藏后面直接结束
            if ( checkSuccess.textFiledWeek.hidden) {
                return;
            }
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
                [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(attStr.length-2, 2)];
                checkSuccess.weekMoney.attributedText = attStr;
                checkSuccess.allMoney.text = @"0元";
            }
            DLog(@"确定");
        }
            break;
        case 105:
        {
            DLog(@"选择借款用途");
            checkSuccess.pickweek.hidden = YES;
            checkSuccess.toolBar.hidden = NO;
            checkSuccess.purposePicker.hidden = NO;
            
        }
        default:
            break;
    }
}

- (void)getMoney
{
    //  platform_type  2、合规平台    0、发薪贷平台
    if([_userStateModel.platform_type isEqualToString:@"2"] || [_userStateModel.platform_type isEqualToString:@"0"]){
        if ([_userStateModel.platform_type isEqualToString:@"2"]) {
            [self integrationP2PUserState];
        }
        if ([_userStateModel.platform_type isEqualToString:@"0"]) {
            [self fatchCardInfo];
        }
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"产品类型错误"];
    }
}


#pragma mark 新的合规
-(void)integrationP2PUserState{
    
    if ([_qryUserStatusModel.result.flg isEqualToString:@"2"]) {//未开户
        
        [self saveLoanCase:@"20" caseInfo:_caseInfo];
        
    }else if ([_qryUserStatusModel.result.flg isEqualToString:@"3"]){//待激活
        
        [self saveLoanCase:@"10" caseInfo:_caseInfo];
        
        
    }else if ([_qryUserStatusModel.result.flg isEqualToString:@"6"]){//正常用户
        
        //选择银行卡
        
        [self queryCardInfo];
        
    }else if ([_qryUserStatusModel.result.flg isEqualToString:@"11"]||[_qryUserStatusModel.result.flg isEqualToString:@"12"]){
    
        LoanMoneyViewController *controller = [LoanMoneyViewController new];
        controller.userStateModel = _userStateModel;
        controller.qryUserStatusModel = _qryUserStatusModel;
        controller.popAlert = true;
        [self.navigationController pushViewController:controller animated:YES];
    }
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
                payVC.isP2P = NO;
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
                        bankVC.purposeSelect = _purposeSelect;
                        bankVC.userStateModel = _userStateModel;
                        bankVC.isP2P = NO;
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
    if ([_userStateModel.product_id isEqualToString:RapidLoan]) {
        paramDic = @{@"periods_":@1,
                     @"loan_for_":_purposeSelect,
                     @"drawing_amount_":@(_approvalModel.result.approval_amount),
                     @"account_card_id_":_selectCard.cardIdentifier
                     };
    }
    if ([_userStateModel.product_id isEqualToString:SalaryLoan]||[_userStateModel.product_id isEqualToString:WhiteCollarLoan]) {
        paramDic = @{@"periods_":[NSString stringWithFormat:@"%d",_userSelectNum.intValue],
                     @"drawing_amount_":@(_approvalModel.result.approval_amount),
                     @"account_card_id_":_selectCard.cardIdentifier,
                     @"loan_for_":_purposeSelect,
                     };
    }
    
    //二次提款
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_drawApplyAgain_jhtml] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"]) {
                
                LoanMoneyViewController *loanVC =[LoanMoneyViewController new];
                loanVC.userStateModel = _userStateModel;
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
    if (pickerView.tag == 101) {
        
      return _dateArray.count + 1;
    }else{
        return _datalist.count + 1;
    }
    
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 101) {
        if (row == 0) {
            return @"选择用途";
        } else {
            DataDicResult * dataDicResult =  _dateArray[row - 1];
            return  dataDicResult.desc_;
//         return [NSString stringWithFormat:@"%d周",[_datalist objectAtIndex:row-1].intValue];
            
        }
    }else{
    
        if (row == 0) {
            return @"选择周期";
        } else {
            return [NSString stringWithFormat:@"%d周",[_datalist objectAtIndex:row-1].intValue];
        }
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //    DLog(@"%@",datalist[row]);
    if (pickerView.tag == 101) {
        if (row !=0) {
            DataDicResult * dataDicResult =  _dateArray[row - 1];
            checkSuccess.purposeTextField.text = dataDicResult.desc_;
            _purposeSelect = dataDicResult.code_;
        }
        if (row ==0) {
            _purposeSelect = @"0";
            checkSuccess.purposeTextField.text = @"请选择用途";
        }
    }else{
    
        if (row != 0) {
            _userSelectNum = [_datalist objectAtIndex:row-1];
            checkSuccess.textFiledWeek.text = [NSString stringWithFormat:@"%d周",_userSelectNum.intValue];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:"];
            [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
            NSString *amountStr = [NSString stringWithFormat:@"%.2f元",(_approvalModel.result.approval_amount +_approvalModel.result.approval_amount*_userSelectNum.intValue*_approvalModel.result.week_service_fee_rate)/_userSelectNum.intValue];
            [attStr yy_appendString:amountStr];
            [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(attStr.length-amountStr.length, amountStr.length)];
            checkSuccess.weekMoney.attributedText = attStr;
            checkSuccess.allMoney.text =[NSString stringWithFormat:@"%.2f元",_approvalModel.result.approval_amount +_approvalModel.result.approval_amount*_userSelectNum.intValue*_approvalModel.result.week_service_fee_rate];
        }
        if (row == 0) {
            _userSelectNum = @0;
            checkSuccess.textFiledWeek.text = @"请选择周期";
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:0元"];
            [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
            [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(attStr.length-2, 2)];
            checkSuccess.weekMoney.attributedText = attStr;
            checkSuccess.allMoney.text = @"0元";
        }
    }
    if ([_userStateModel.product_id isEqualToString:SalaryLoan]||[_userStateModel.product_id isEqualToString:WhiteCollarLoan]) {
        if (![_userSelectNum isEqual:@0]&&![_purposeSelect isEqualToString:@"0"]) {
            checkSuccess.sureBtn.backgroundColor = UI_MAIN_COLOR;
        }else{
            checkSuccess.sureBtn.backgroundColor = rgb(158, 158, 159);
        }
    }else if ([_userStateModel.product_id isEqualToString:RapidLoan]){
        if (![_purposeSelect isEqualToString:@"0"]) {
            checkSuccess.sureBtn.backgroundColor = UI_MAIN_COLOR;
        }else{
            checkSuccess.sureBtn.backgroundColor = rgb(158, 158, 159);
        }
    }
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
    [homeViewModel fetchUserState:_userStateModel.product_id];
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


#pragma mark 更改工薪贷和白领贷的周期
-(void)getCycle:(CGFloat)money{

    [_datalist removeAllObjects];
    int j = 0;
    int k = 0;
    if ([_userStateModel.product_id isEqualToString:SalaryLoan]) {
        
        if (money>=0&&money<=1999) {
            j=11;
            k=0;
        }else if (money>=2000&&money<=2999){
        
            j=16;
            k=0;
        }else if (money>=3000&&money<=3999){
        
            j=21;
            k=3;
        }else if (money>=4000&&money<=5000){
        
            j=26;
            k=5;
        }
        
        for (int i = k; i < j; i++) {
            [_datalist addObject:[NSNumber numberWithInt:(i+5)]];
        }
    }
    
    if ([_userStateModel.product_id isEqualToString:WhiteCollarLoan]) {
        
        if (money>=5000&&money<=30000) {
            j=46;
        }
        for (int i = 5; i < j; i++) {
            [_datalist addObject:[NSNumber numberWithInt:(i+5)]];
        }
    }
    
    [checkSuccess.pickweek reloadAllComponents];
}
#pragma mark -> 2.22	审批金额查询接口

-(void)PostGetCheckMoney
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_approvalAmount_jhtml] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            _approvalModel = [Approval yy_modelWithJSON:object];
            
            
            if ([_approvalModel.flag isEqualToString:@"0000"])
            {
                
                [self getCycle:_approvalModel.result.approval_amount];
                
                //                _loanMountMoney= [[[object objectForKey:@"result"] objectForKey:@"approval_amount_"] doubleValue];
                checkSuccess.loadMoney.text =[NSString stringWithFormat:@"¥%.0f元",_approvalModel.result.approval_amount];
                //[NSString stringWithFormat:@"%.2f元",(_loanMountMoney +_loanMountMoney*_userSelectNum.intValue*0.021)/_userSelectNum.intValue];
                if ([_userStateModel.product_id isEqualToString:RapidLoan]) {
                    NSString *amountText = [NSString stringWithFormat:@"%.0f元",_approvalModel.result.approval_amount];
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"到期还款:"];
                    [attStr yy_appendString:amountText];
                    [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                    [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(4, amountText.length)];
                    checkSuccess.weekMoney.attributedText = attStr;
                }else {
                    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:0元"];
                    [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
                    [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(attStr.length-2, 2)];
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
                NSString *attributeStr = [NSString stringWithFormat:@"实际到账%@元,详情见费用说明",factMoneyStr];
                NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:attributeStr];
                one.yy_font = [UIFont systemFontOfSize:16];
                [one addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(4,factMoneyStr.length)];
                [one yy_setTextHighlightRange:NSMakeRange(one.length-4, 4)
                                        color:UI_MAIN_COLOR
                              backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                    tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                        DLog(@"费用说明");
                                        FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
                                        webVC.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_loanDetial_url];
                                        [self.navigationController pushViewController:webVC animated:true];
                                    }];
                checkSuccess.moneyLabel.attributedText = one;
                checkSuccess.moneyLabel.textAlignment = NSTextAlignmentCenter;
                checkSuccess.tipLabel.text = _approvalModel.result.payMessage;
                
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
                        bankVC.purposeSelect = _purposeSelect;
                        bankVC.periodSelect = _userSelectNum.intValue;
                        //            bankVC.idString = _idString;
                        bankVC.drawAmount = [NSString stringWithFormat:@"%.0f",_approvalModel.result.approval_amount];
                        bankVC.flagString = @"1";
                        bankVC.bankMobile = cardResult.bank_reserve_phone_;
                        bankVC.isP2P = NO;
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


#pragma  mark - 工薪贷拒绝导流
-(void)clickSeeBtn{

    FXDWebViewController *webView = [[FXDWebViewController alloc] init];
    webView.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_selectPlatform_url];
    [self.navigationController pushViewController:webView animated:true];

}

#pragma  mark - 白领贷拒绝导流
-(void)clickApplyImmediate{

    UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
    userDataVC.product_id = SalaryLoan;
    [self.navigationController pushViewController:userDataVC animated:true];
}

#pragma  mark - 白领贷拒绝导流工薪贷的详情
-(void)getContent{
    
     NSDictionary *dic = @{@"priduct_id_":SalaryLoan};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
        
        if ([rateParse.flag isEqualToString:@"0000"]) {
            
            checkFalse.nameLabel.text = rateParse.result.name_;
            checkFalse.quotaLabel.text = [NSString stringWithFormat:@"%ld-%ld元",rateParse.result.principal_bottom_,rateParse.result.principal_top_];
            checkFalse.termLabel.text = [NSString stringWithFormat:@"%ld-%ld%@",rateParse.result.staging_bottom_,rateParse.result.staging_top_,rateParse.result.remark_];
            
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:rateParse.msg];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

-(void)clickApplyImmediatelyBtn{

    [self fatchRate:^(RateModel *rate) {
        PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
        payLoanview.product_id = RapidLoan;
        payLoanview.userState = _userStateModel;
        payLoanview.rateModel = rate;
        [self.navigationController pushViewController:payLoanview animated:true];
    }];
    
}

- (void)fatchRate:(void(^)(RateModel *rate))finish
{
    NSDictionary *dic = @{@"priduct_id_":RapidLoan};
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


#pragma  mark - 获取借款用途接口

- (void)getDataDic:(void(^)())finish
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getDicCode_url] parameters:@{@"dict_type_":@"LOAN_FOR_"} finished:^(EnumServerStatus status, id object) {
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            _dataDicModel = [DataDicParse yy_modelWithJSON:object];
            _dateArray = [_dataDicModel.result copy];
            [checkSuccess.purposePicker reloadAllComponents];
            if (finish) {
                finish();
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}
#pragma mark  fxd用户状态查询，viewmodel
-(void)getUserStatus:(GetCaseInfo *)caseInfo{

    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        QryUserStatusModel *model = [QryUserStatusModel yy_modelWithJSON:returnValue];
        if ([model.flag isEqualToString:@"0000"]) {
            
            _qryUserStatusModel = model;
            if ([model.result.flg isEqualToString:@"11"]||[model.result.flg isEqualToString:@"12"]) {
                
                LoanMoneyViewController *controller = [LoanMoneyViewController new];
                controller.userStateModel = _userStateModel;
                controller.qryUserStatusModel = _qryUserStatusModel;
                controller.popAlert = true;
                [self.navigationController pushViewController:controller animated:YES];
                
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
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
            
            _caseInfo = caseInfo;
            [self getUserStatus:caseInfo];

        }
    } WithFaileBlock:^{
        
    }];
    [complianceViewModel getFXDCaseInfo];

}

#pragma mark 提款申请件记录
-(void)saveLoanCase:(NSString *)type caseInfo:(GetCaseInfo *)caseInfo{

    ComplianceViewModel *complianceViewModel = [[ComplianceViewModel alloc]init];
    [complianceViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        SaveLoanCaseModel *model = [SaveLoanCaseModel yy_modelWithJSON:returnValue];
        if ([model.flag isEqualToString:@"0000"]) {
            if ([type isEqualToString:@"20"]) {//未开户
                //绑定银行卡
                [self getBankListInfo];
            }else if ([type isEqualToString:@"10"]){//待激活
            
                NSString *url = [NSString stringWithFormat:@"%@%@?page_type_=%@&ret_url_=%@&from_mobile_=%@",_P2P_url,_bosAcctActivate_url,@"1",_transition_url,[Utility sharedUtility].userInfo.userMobilePhone];
                P2PViewController *p2pVC = [[P2PViewController alloc] init];
                p2pVC.isCheck = YES;
                p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [self.navigationController pushViewController:p2pVC animated:YES];
                
            }else if ([type isEqualToString:@"30"]){
                
                LoanMoneyViewController *controller = [LoanMoneyViewController new];
                controller.userStateModel = _userStateModel;
                controller.popAlert = true;
                [self.navigationController pushViewController:controller animated:YES];

            }
            
        }else{
        
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
        }
    } WithFaileBlock:^{
        
//        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
    }];
    [complianceViewModel saveLoanCase:type CaseInfo:caseInfo Period:_userSelectNum.description PurposeSelect:_purposeSelect];
}

#pragma mark 获取银行卡列表信息
-(void)getBankListInfo{

    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        BankModel *bankModel = [BankModel yy_modelWithJSON:returnValue];
        if ([bankModel.flag isEqualToString:@"0000"]) {
            
            NSArray *bankArray = @[@"中国银行",@"中国工商银行",@"中国建设银行",@"中国农业银行",@"中信银行",@"兴业银行",@"中国光大银行"];
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i<bankModel.result.count; i++) {
                BankList *bankList = bankModel.result[i];
                for (int j = 0; j<bankArray.count; j++) {
                    if ([bankList.desc isEqualToString:bankArray[j]]) {
                        [array addObject:bankList];
                        
                    }
                }
            }
            [bankModel.result removeAllObjects];
            for (BankList *bank in array) {
                
                [bankModel.result addObject:bank];
            }
            BankCardViewController *bankVC = [BankCardViewController new];
            bankVC.bankModel = bankModel;
            bankVC.periodSelect = _userSelectNum.integerValue;
            bankVC.purposeSelect = _purposeSelect;
            bankVC.userStateModel = _userStateModel;
            bankVC.isP2P = YES;
            bankVC.uploadP2PUserInfo = _uploadP2PUserInfo;
            //            bankVC.idString = _idString;
            bankVC.drawAmount = [NSString stringWithFormat:@"%.0f",_approvalModel.result.approval_amount];
            [self.navigationController pushViewController:bankVC animated:YES];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:bankModel.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getBankListInfo];
}


#pragma mark 弹出合规银行卡列表viewmodel
-(void)queryCardInfo{

    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        QueryCardInfo *model = [QueryCardInfo yy_modelWithJSON:returnValue];
        NSString *bankName = [self bankName:model.result.UsrCardInfolist.BankId];
        PayViewController *payVC = [[PayViewController alloc] init];
        payVC.payType = PayTypeGetMoneyToCard;
        payVC.isP2P = YES;
        payVC.bankName = bankName;
        NSString *bank = model.result.UsrCardInfolist.CardId;
        payVC.banNum = [bank substringFromIndex:bank.length-4];
        
        payVC.makesureBlock = ^(PayType payType,CardInfo *cardInfo,NSInteger currentIndex){
            
            [self dismissSemiModalViewWithCompletion:^{
                
                [self saveLoanCase:@"30" caseInfo:_caseInfo];

            }];
        };
        
        payVC.changeBankBlock = ^(){
            
            UnbundlingBankCardViewController *controller = [[UnbundlingBankCardViewController alloc]initWithNibName:@"UnbundlingBankCardViewController" bundle:nil];
            controller.queryCardInfo = model;
            controller.isCheck = YES;
            [self.navigationController pushViewController:controller animated:YES];
        };
        PayNavigationViewController *payNC = [[PayNavigationViewController alloc] initWithRootViewController:payVC];
        payNC.view.frame = CGRectMake(0, 0, _k_w, 200);
        [self presentSemiViewController:payNC withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO), KNSemiModalOptionKeys.parentAlpha : @(0.8)}];
        
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel queryCardInfo];
}


#pragma mark 银行卡名字的转换
-(NSString *)bankName:(NSString *)bankCode{
    
    NSString *name = @"";
    if([bankCode isEqualToString:@"BOC"]){
    
        name = @"中国银行";
        
    }else if ([bankCode isEqualToString:@"ICBC"]){
    
        name = @"中国工商银行";
    }else if ([bankCode isEqualToString:@"CCB"]){
    
        name = @"中国建设银行";
    }else if ([bankCode isEqualToString:@"ABC"]){
    
        name = @"中国农业银行";
    }else if ([bankCode isEqualToString:@"CITIC"]){
    
        name = @"中信银行";
    }else if ([bankCode isEqualToString:@"CIB"]){
    
        name = @"兴业银行";
    }else if ([bankCode isEqualToString:@"CEB"]){
    
        name = @"中国光大银行";
    }
    
    return name;
}


@end
