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
#import "HGBankListModel.h"
#import "SupportBankList.h"
#import "DrawingsInfoModel.h"
#import "UserBankCardListViewController.h"
#import "BankInfoViewModel.h"
#import "FeesDescriptionViewController.h"
#import "EditCardsController.h"
#import "ThirdWebViewController.h"

//#error 以下需要修改为您平台的信息
//启动SDK必须的参数
//Apikey,您的APP使用SDK的API的权限
//6149056c09e1498ca9b1bcd534b5ad0c

//用户ID,您APP中用以识别的用户ID，魔蝎数据后台会将最终导入结果的用户ID和数据一起返回，以便您的数据入库

typedef NS_ENUM(NSUInteger, PromoteType) {
    PromoteCredit = 1,
    PromoteLimit,
};

@interface CheckViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ReplenishDoneDelegate,MoxieSDKDelegate>
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
    BankModel *_bankCardModel;
    NSMutableArray *_supportBankListArr;
//    UserCardResult *_userCardsModel;
    CardInfo *_selectCard;
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
    NSArray * feeArray; //费用说明

    BOOL _isOpen;
    BOOL _isBankCard;    //用户是否有银行卡

}

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger flag;
@property (strong,nonatomic)MoxieSDK *moxieSDK;
@property (nonatomic,strong)NSArray * dateArray;
@property (nonatomic,strong)CardInfo *selectCard;


@property (nonatomic,strong)DrawingsInfoModel * drawingsInfoModel;


@end

@implementation CheckViewController


-(void)setSelectCard:(CardInfo *)selectCard{
    _selectCard = selectCard;
    if (checkSuccess) {
        checkSuccess.bankTextField.text = [NSString stringWithFormat:@"%@ 尾号(%@)",_selectCard.bankName,[self formatTailNumber:_selectCard.cardNo]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"待提款";
    _promoteType = -1;
    _flag = 1;
    _datalist = [NSMutableArray array];
    userSelectIndex = 0;
    self.rt_disableInteractivePop = YES;
    [self addBackItemRoot];
    [self configMoxieSDK];
    DLog(@"%@",_moxieSDK.version);

    if ([_drawingsInfoModel.productId isEqualToString:RapidLoan] || [_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
        for (int i = 1; i < 2; i++) {
            [_datalist addObject:[NSNumber numberWithInt:(i+1)]];
        }
    }
    _dateArray = [NSArray array];
    _userSelectNum = @0;
    _purposeSelect = @"0";
    //    [self createScroll];
    [self createUI];

    _isOpen = NO;
    [_checking.receiveImmediatelyBtn addTarget:self action:@selector(imageTap) forControlEvents:UIControlEventTouchUpInside];

}

-(void)clickAgreementView{

    _isOpen = !_isOpen;
    if (_isOpen) {
        checkSuccess.agreementDescLabel.text = @"收起";
        checkSuccess.agreementsView.hidden = NO;
        checkSuccess.agreementImage.image = [UIImage imageNamed:@"icon_down"];
    }else{
    
        checkSuccess.agreementDescLabel.text = @"展开";
        checkSuccess.agreementsView.hidden = YES;
        checkSuccess.agreementImage.image = [UIImage imageNamed:@"more-arrow-3"];
    }
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
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshUI)];
    header.automaticallyChangeAlpha = YES;
    view.mj_header = header;
    if (@available(iOS 11.0, *)) {
        view.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
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
    __weak typeof (self) weakSelf = self;
    [self obtainDrawingInformation:^(DrawingsInfoModel *drawingsInfo) {
//        if ([_drawingsInfoModel.platformType isEqualToString:@"2"]) {
//            [weakSelf getUserStatus:drawingsInfo.applicationId];
//        }
        //急速贷产品费率获取
        if ([_drawingsInfoModel.productId isEqualToString:RapidLoan] || [_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
            [self obtainProductFee];
        }
        //获取默认银行卡
        [self fatchCardInfo];
        [weakSelf loadWithdrawalsView:drawingsInfo];
    }];
}

//刷新UI
- (void)refreshUI{
    [self createUI];
}

-(void)loadIntermediateStateView{
    
    _checking = [[[NSBundle mainBundle] loadNibNamed:@"CheckViewIng" owner:self options:nil] lastObject];
    _checking.layer.anchorPoint = CGPointMake(0.5, 1.0);
    _checking.frame =CGRectMake(0, 0,_k_w, _k_h);
    [_checking setContentMode:UIViewContentModeScaleAspectFit];
    [_checking.receiveImmediatelyBtn addTarget:self action:@selector(imageTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_checking];
    
}

/**
 导流失败的视图，展示不用
 */
-(void)loadFailedStateView{
    
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
        checkFalse.seeView.hidden = YES;
        checkFalse.jsdView.hidden = YES;
        if ([_userStateModel.product_id isEqualToString:SalaryLoan]||[_userStateModel.product_id isEqualToString:WhiteCollarLoan]){
            [self getContent];
            checkFalse.jsdView.hidden = NO;
            [checkFalse.applyImmediatelyBtn addTarget:self action:@selector(clickApplyImmediate) forControlEvents:UIControlEventTouchUpInside];
        }else{
            //1表示不是渠道用户 0是渠道用户
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

#pragma mark 改变实际到账和总费用的文字颜色
-(void)changeDisplayLabelTextColor:(NSString *)feeStr{
    
//    NSArray *strArr = [feeStr componentsSeparatedByString:@"."];
//    NSString *str1 = strArr[0];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:checkSuccess.displayLabel.text];
    [str addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(4,_drawingsInfoModel.actualAmount.length)];

//    [str addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(checkSuccess.displayLabel.text.length-1-str1.length,str1.length)];
//    if (feeStr.floatValue == 0) {
//
//        [str addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(checkSuccess.displayLabel.text.length-1-1,1)];
//    }

    checkSuccess.displayLabel.attributedText = str;
}

#pragma mark - 提款视图
-(void)loadWithdrawalsView:(DrawingsInfoModel *) drawingsInfo{
    
    checkSuccess =[[[NSBundle mainBundle] loadNibNamed:@"CheckSuccessView" owner:self options:nil] lastObject];
    checkSuccess.frame = CGRectMake(0, 0,_k_w, _k_h);
//    checkSuccess.displayLabel.text = [NSString stringWithFormat:@"实际到账%.0f元,总费用%.0f元",[_drawingsInfoModel.actualAmount floatValue],[_drawingsInfoModel.totalFee floatValue]];

    checkSuccess.displayLabel.text = [NSString stringWithFormat:@"实际到账%.0f元,费用详情见协议",[_drawingsInfoModel.actualAmount floatValue]];
    
    [self changeDisplayLabelTextColor:_drawingsInfoModel.totalFee];

//    [checkSuccess.feeBtn addTarget:self action:@selector(shareBtn:)forControlEvents:UIControlEventTouchUpInside];
//    checkSuccess.feeBtn.tag = 107;
    //用途
    checkSuccess.purposePicker.delegate = self;
    checkSuccess.purposePicker.dataSource = self;
    checkSuccess.purposePicker.tag = 101;
    //周期
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
    checkSuccess.bankTextField.enabled = NO;
    //区别不同产品
    if ([_drawingsInfoModel.productId isEqualToString:RapidLoan] || [_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
        //周期
        checkSuccess.weekBtn.hidden = true;
        checkSuccess.textFiledWeek.hidden = true;
        //用途
        checkSuccess.purposeTextField.text = @"请选择借款用途";
        [Tool setCorner:checkSuccess.purposeView borderColor:UI_MAIN_COLOR];
        checkSuccess.purposeTextField.delegate = self;
        //到账银行
        checkSuccess.bankTextField.text = @"收款方式";
        checkSuccess.bankTextField.delegate = self;
        checkSuccess.sureBtn.backgroundColor = rgb(158, 158, 159);
        
        NSString *timeLimitText = [NSString stringWithFormat:@"借款期限: %@", _drawingsInfoModel.period];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:timeLimitText];
        [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(5,timeLimitText.length - 5)];
        checkSuccess.termLabel.attributedText = attStr;
        
        NSString *amountText = [NSString stringWithFormat:@"到期还款: %.0f元", [_drawingsInfoModel.repaymentAmount floatValue]];
        NSMutableAttributedString *amountStr = [[NSMutableAttributedString alloc] initWithString:amountText];
        [amountStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(5,amountText.length - 5)];
        checkSuccess.jsdMonayLabel.attributedText = amountStr;
    }else {
        checkSuccess.jsdDescView.hidden = YES;
        checkSuccess.textFiledWeek.text = @"请选择借款周期";
        checkSuccess.purposeTextField.text = @"请选择借款用途";
        checkSuccess.bankTextField.text = @"收款方式";
        [Tool setCorner:checkSuccess.bgView borderColor:UI_MAIN_COLOR];
        [Tool setCorner:checkSuccess.purposeView borderColor:UI_MAIN_COLOR];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:0元"];
        [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
        [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(attStr.length-2, 2)];
        checkSuccess.weekMoney.attributedText = attStr;
        checkSuccess.allMoney.text = @"0元";
        checkSuccess.textFiledWeek.delegate = self;
        checkSuccess.purposeTextField.delegate = self;
        checkSuccess.bankTextField.delegate = self;
    }
    checkSuccess.sureBtn.tag = 101;
    [checkSuccess.sureBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    checkSuccess.weekBtn.tag = 102;
    [checkSuccess.weekBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    checkSuccess.purposeBtn.tag = 105;
    [checkSuccess.purposeBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    checkSuccess.bankButton.tag = 106;
    [checkSuccess.bankButton addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    //技术服务协议，风险管理与数据服务
    [checkSuccess.firstAgreemwntBtn addTarget:self action:@selector(clickFirstAgreementBtn) forControlEvents:UIControlEventTouchUpInside];
    [checkSuccess.secondAgreemwntBtn addTarget:self action:@selector(clickSecondAgreementBtn) forControlEvents:UIControlEventTouchUpInside];
    
    checkSuccess.loadMoney.text =[NSString stringWithFormat:@"¥%.0f元",[_drawingsInfoModel.repayAmount floatValue]];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:checkSuccess.loadMoney.text];
    [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30] range:NSMakeRange(0, 1)];
    [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange([checkSuccess.loadMoney.text length]-1, 1)];
    if (UI_IS_IPHONE5) {
        [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, 1)];
        [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10] range:NSMakeRange([checkSuccess.loadMoney.text length]-1, 1)];
    }
    checkSuccess.loadMoney.attributedText = att;
    
    //移除 收款方式 的视图
    if ([_drawingsInfoModel.platformType isEqualToString:@"2"]) {
//        [checkSuccess.bankView removeFromSuperview];
        [checkSuccess.bankView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    //提款按钮处理事件
    [checkSuccess.promote addTarget:self action:@selector(promote) forControlEvents:UIControlEventTouchUpInside];
    _promoteType = PromoteLimit;
    [self.view addSubview:checkSuccess];
    if (UI_IS_IPHONE5) {
        [checkSuccess.bottomBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.top.equalTo(checkSuccess.userCheckView.mas_bottom).offset(0);
        }];
    }
    
    if (![drawingsInfo.userAgain boolValue] || ![drawingsInfo.taskStatus isEqualToString:@"1"] ) {
        [checkSuccess.promote setHidden:YES];
        checkSuccess.surBtnLeadRight.constant = .0f;
        [checkSuccess.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(checkSuccess.bottomBtnView.mas_right).offset(-21);
            make.top.equalTo(checkSuccess.bottomBtnView.mas_top).offset(0);
            make.height.equalTo(@50);
            if (UI_IS_IPHONE5) {
                make.height.equalTo(@44);
            }
        }];
        [checkSuccess.sureBtn layoutIfNeeded];
        [checkSuccess.sureBtn updateConstraints];
    }
    [self withdrawalsViewAgreement:drawingsInfo];
    
    //协议点击
    __weak typeof (self) weakSelf = self;
    checkSuccess.agreementStatus = ^(UIButton *button) {
        [weakSelf productIsDrawingsStatus];
    };
}
//提款协议
-(void)withdrawalsViewAgreement:(DrawingsInfoModel *) drawingsInfo{
    
    NSMutableAttributedString *attributeStr;
    NSRange range;
    
    //协议分为合规  和发薪贷
    if ([drawingsInfo.platformType isEqualToString:@"0"]) {
        attributeStr = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并认可发薪贷《借款协议》"];
        range = NSMakeRange(attributeStr.length - 6, 6);
    }else if([drawingsInfo.platformType isEqualToString:@"2"]){
        attributeStr = [[NSMutableAttributedString alloc]initWithString:@"我已阅读并认可发薪贷《信用咨询及管理服务协议》"];
        if (UI_IS_IPHONE5) {
            attributeStr.yy_font = [UIFont systemFontOfSize:11];
        }
        range = NSMakeRange(attributeStr.length - 13, 13);
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"产品类型错误"];
    }

    [attributeStr yy_setTextHighlightRange:range color:UI_MAIN_COLOR backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        //协议点击
        [self getUserInfoData:^{
            if ([_drawingsInfoModel.platformType isEqualToString:@"0"]) {
                [self LoanAgreementRequest];
            }
            if ([_drawingsInfoModel.platformType isEqualToString:@"2"]) {
                [self heguiAgreementRequest];
            }
        }];
    }];
    checkSuccess.agreementLabel.attributedText = attributeStr;
}

//每周还款的视图
-(void)refreshWeekAmount:(SalaryDrawingsFeeInfoModel *)feeInfoModel{
    
//    checkSuccess.displayLabel.text = [NSString stringWithFormat:@"实际到账%.0f元,总费用%.0f元",[_drawingsInfoModel.actualAmount floatValue],[feeInfoModel.totalFee floatValue]];
    checkSuccess.displayLabel.text = [NSString stringWithFormat:@"实际到账%.0f元,费用详情见协议",[_drawingsInfoModel.actualAmount floatValue]];
    [self changeDisplayLabelTextColor:feeInfoModel.totalFee];
    checkSuccess.textFiledWeek.text = [NSString stringWithFormat:@"%d周",_userSelectNum.intValue];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"每周还款:"];
    [attStr addAttribute:NSForegroundColorAttributeName value:rgb(164, 164, 164) range:NSMakeRange(0, 5)];
    NSString *amountStr = [NSString stringWithFormat:@"%.2f元",[feeInfoModel.repaymentAmount floatValue]];
    [attStr yy_appendString:amountStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(attStr.length-amountStr.length, amountStr.length)];
    checkSuccess.weekMoney.attributedText = attStr;
    checkSuccess.allMoney.text =[NSString stringWithFormat:@"%.2f元",[feeInfoModel.repaymentAmount floatValue]];
    
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
            if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]||[_drawingsInfoModel.productId  isEqualToString:WhiteCollarLoan]) {
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
            if ([_drawingsInfoModel.productId  isEqualToString:RapidLoan] || [_drawingsInfoModel.productId  isEqualToString:DeriveRapidLoan]) {
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
                
                [self obtainProductFee];
                
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
            break;
        case 106:{
            if (!_isBankCard) {
                [self pushAddBanckCard];
                return;
            }
            [self pushUserBankListVC];
        }
            break;
        case 107:{
            [self pushFeeDescription];
        }
            break;
        default:
            break;
    }
}
/**
 跳转到银行卡
 */
-(void)pushUserBankListVC{
    
    UserBankCardListViewController * userBankCardListVC = [[UserBankCardListViewController alloc]init];
    userBankCardListVC.currentIndex = userSelectIndex;
    userBankCardListVC.payPatternSelectBlock = ^(CardInfo *cardInfo, NSInteger currentIndex) {
        self.selectCard = cardInfo;
        if (cardInfo == nil) {
            [self  fatchCardInfo];
        }
        userSelectIndex = currentIndex;
    };
    [self.navigationController pushViewController:userBankCardListVC animated:true];
}

-(void)pushAddBanckCard{
    
    EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:@"EditCardsController" bundle:nil];
    editCard.typeFlag = @"0";
    editCard.addCarSuccess = ^{
        DLog(@"添加卡成功");
        [self  fatchCardInfo];
    };
    BaseNavigationViewController *addCarNC = [[BaseNavigationViewController alloc] initWithRootViewController:editCard];
    [self presentViewController:addCarNC animated:YES completion:nil];
}
-(void)pushFeeDescription{
    
    if (!feeArray && [_drawingsInfoModel.productId isEqualToString:SalaryLoan] ) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请选择周期"];
        return;
    }
    FeesDescriptionViewController * feeDescVC = [[FeesDescriptionViewController alloc]init];
    feeDescVC.feeArray = [feeArray mutableCopy];
    [self.navigationController pushViewController:feeDescVC animated:true];
    
}

#pragma mark 提款
- (void)getMoney
{
    //  platform_type  2、合规平台    0、发薪贷平台    3、善林金融
    if([_drawingsInfoModel.platformType isEqualToString:@"2"] || [_drawingsInfoModel.platformType isEqualToString:@"0"]){
        if ([_drawingsInfoModel.platformType isEqualToString:@"2"]) {
            [self integrationP2PUserState];
        }
        if ([_drawingsInfoModel.platformType isEqualToString:@"0"]) {
            if (_isBankCard == NO) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请添加收款方式！"];
                return;
            }
            [self PostGetdrawApplyAgain];
        }
    }else{
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"产品类型错误"];
    }
}

#pragma mark 善林金融放款
-(void)capitalLoan{
    ApplicationViewModel *applicationMV = [[ApplicationViewModel alloc]init];
    [applicationMV setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]||[baseResultM.errCode isEqualToString:@"1"]||[baseResultM.errCode isEqualToString:@"2"]) {
            
            NSString *content = (NSString *)baseResultM.data;
            [self result:baseResultM.errCode url:content message:baseResultM.friendErrMsg];
            
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [applicationMV capitalLoan:_selectCard.cardId loanfor:_purposeSelect periods:@"1"];
}

#pragma mark 善林金融跳转页面
-(void)result:(NSString *)errCode url:(NSString *)url message:(NSString *)message{
    switch (errCode.integerValue) {
        case 0:
        {
            LoanMoneyViewController *loanVC =[LoanMoneyViewController new];
            loanVC.applicationStatus = InLoan;
            loanVC.popAlert = true;
            [self.navigationController pushViewController:loanVC animated:YES];
        }
            break;
        case 1:
            [[MBPAlertView sharedMBPTextView]showTextOnly:[UIApplication sharedApplication].keyWindow message:message];
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 2:
            
        {
            ThirdWebViewController *webView = [[ThirdWebViewController alloc] init];
//            webView.name = @"银行卡认证";
            webView.loadContent = url;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark 新的合规
-(void)integrationP2PUserState{
    
    if ([_drawingsInfoModel.userStatus isEqualToString:@"2"]) {//未开户
        
        [self saveLoanCase:@"20"];
        
    }else if ([_drawingsInfoModel.userStatus isEqualToString:@"3"]){//待激活
        
        [self saveLoanCase:@"10"];
        
    }else if ([_drawingsInfoModel.userStatus isEqualToString:@"6"]){//正常用户
        //选择银行卡
        [self queryCardInfo];
    }else if ([_drawingsInfoModel.userStatus isEqualToString:@"11"]||[_drawingsInfoModel.userStatus isEqualToString:@"12"]){
    
        LoanMoneyViewController *controller = [LoanMoneyViewController new];
        controller.applicationStatus = ComplianceInLoan;
        controller.popAlert = true;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

/**
 发薪贷银行卡信息
 */
- (void)fatchCardInfo
{
    BankInfoViewModel * bankInfoVM = [[BankInfoViewModel alloc]init];
    [bankInfoVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            NSArray * array = (NSArray *)baseResultM.data;
            if (array.count <= 0){
                _isBankCard = NO;
                return;
            }
            _isBankCard = YES;
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                CardInfo * cardInfo = [[CardInfo alloc]initWithDictionary:dic error:nil];
                if ([cardInfo.cardType isEqualToString:@"2"]) {
                    self.selectCard = cardInfo;
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

- (NSString *)formatTailNumber:(NSString *)str
{
    return [str substringWithRange:NSMakeRange(str.length - 4, 4)];
}

#pragma mrak - 提款
-(void)PostGetdrawApplyAgain
{
    NSDictionary *paramDic;
    if ([_drawingsInfoModel.productId  isEqualToString:RapidLoan] || [_drawingsInfoModel.productId  isEqualToString:DeriveRapidLoan]) {
        paramDic = @{@"periods_":@1,
                     @"loan_for_":_purposeSelect,
                     @"drawing_amount_":_drawingsInfoModel.repayAmount,
                     @"account_card_id_":_selectCard.cardId
                     };
    }
    if ([_drawingsInfoModel.productId  isEqualToString:SalaryLoan]||[_drawingsInfoModel.productId  isEqualToString:WhiteCollarLoan]) {
        paramDic = @{@"periods_":[NSString stringWithFormat:@"%d",_userSelectNum.intValue],
                     @"drawing_amount_":_drawingsInfoModel.repayAmount,
                     @"account_card_id_":_selectCard.cardId,
                     @"loan_for_":_purposeSelect,
                     };
    }
    //二次提款
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_drawApplyAgain_jhtml] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"]) {
                
                LoanMoneyViewController *loanVC =[LoanMoneyViewController new];
                loanVC.applicationStatus = InLoan;
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
            LoanForModel * loanForM =  _dateArray[row - 1];
            return  loanForM.desc;
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
            LoanForModel * loanForM =  _dateArray[row - 1];
            checkSuccess.purposeTextField.text = loanForM.desc;
            _purposeSelect = loanForM.code;
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
    [self productIsDrawingsStatus];
}

/**
 提款按钮颜色
 */
-(void)productIsDrawingsStatus{
    BOOL result = false;
    if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]||[_drawingsInfoModel.productId isEqualToString:WhiteCollarLoan]) {
        if ([_drawingsInfoModel.platformType isEqualToString:@"2"]) {
            if (![_userSelectNum isEqual:@0]&&![_purposeSelect isEqualToString:@"0"] && checkSuccess.userCheckBtnState) {
                result = true;
            }
        }else{
            if (![_userSelectNum isEqual:@0]&&![_purposeSelect isEqualToString:@"0"]&&_isBankCard == true && checkSuccess.userCheckBtnState) {
                result = true;
            }
        }
    }else if ([_drawingsInfoModel.productId  isEqualToString:RapidLoan] || [_drawingsInfoModel.productId  isEqualToString:DeriveRapidLoan]){
        if (![_purposeSelect isEqualToString:@"0"] && _isBankCard == true && checkSuccess.userCheckBtnState) {
            result = true;
        }
    }    if (result) {
        checkSuccess.sureBtn.backgroundColor = UI_MAIN_COLOR;
        return;
    }
    checkSuccess.sureBtn.backgroundColor = rgb(158, 158, 159);
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.f;
}

#pragma mark -

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
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
    if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]) {
        
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
    if ([_drawingsInfoModel.productId isEqualToString:WhiteCollarLoan]) {
        if (money>=5000&&money<=30000) {
            j=46;
        }
        for (int i = 5; i < j; i++) {
            [_datalist addObject:[NSNumber numberWithInt:(i+5)]];
        }
    }
    [checkSuccess.pickweek reloadAllComponents];
}

#pragma mark - 产品费用获取
-(void)obtainProductFee{
    CheckViewModel * checkVM = [[CheckViewModel alloc]init];
    [checkVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            SalaryDrawingsFeeInfoModel * salaryDrawingM = [[SalaryDrawingsFeeInfoModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            feeArray = salaryDrawingM.feeInfo;
            if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]) {
                [self refreshWeekAmount:salaryDrawingM];
            }
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]) {
        [checkVM obtainSalaryProductFeeOfperiod:[NSString stringWithFormat:@"%@",_userSelectNum]];
        return;
    }
    [checkVM obtainSalaryProductFeeOfperiod:@"1"];
}

#pragma  mark - 工薪贷拒绝导流
-(void)clickSeeBtn{

    FXDWebViewController *webView = [[FXDWebViewController alloc] init];
    webView.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_selectPlatform_url];
    [self.navigationController pushViewController:webView animated:true];

}

#pragma  mark - 白领贷拒绝导流
-(void)clickApplyImmediate{

    if([_userStateModel.product_id isEqualToString:SalaryLoan]){
        
        [self fatchRate:^(RateModel *rate) {
            PayLoanChooseController *payLoanview = [[PayLoanChooseController alloc] init];
            payLoanview.product_id = RapidLoan;
            payLoanview.userState = _userStateModel;
            payLoanview.rateModel = rate;
            [self.navigationController pushViewController:payLoanview animated:true];
        }];
    }else{
        UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
        userDataVC.product_id = SalaryLoan;
        [self.navigationController pushViewController:userDataVC animated:true];
    }
}

#pragma  mark - 白领贷拒绝导流工薪贷的详情
-(void)getContent{
    NSString *product;
    if ([_userStateModel.product_id isEqualToString:SalaryLoan]) {
        product = RapidLoan;
    }else{
        product = SalaryLoan;
    }
     NSDictionary *dic = @{@"priduct_id_":product};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
        
        if ([rateParse.flag isEqualToString:@"0000"]) {
            
            checkFalse.nameLabel.text = rateParse.result.name_;
            if ([product isEqualToString:RapidLoan]) {
                checkFalse.nameImage.image = [UIImage imageNamed:@"home_02"];
                checkFalse.homeImage.image = [UIImage imageNamed:@"home_05"];
                checkFalse.quotaLabel.text = @"500-1000元";
                checkFalse.termLabel.text = @"14天";
            }else{
            
                checkFalse.homeImage.image = [UIImage imageNamed:@"home_04"];
                checkFalse.nameImage.image = [UIImage imageNamed:@"home_01"];
                checkFalse.quotaLabel.text = [NSString stringWithFormat:@"%ld-%ld元",rateParse.result.principal_bottom_,rateParse.result.principal_top_];
                checkFalse.termLabel.text = [NSString stringWithFormat:@"%ld-%ld%@",rateParse.result.staging_bottom_,rateParse.result.staging_top_,rateParse.result.remark_];
            }
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

#pragma  mark - 获取提款页信息
-(void)obtainDrawingInformation:(void(^)(DrawingsInfoModel * drawingsInfo))finish{
    
    CheckViewModel * checkVM = [[CheckViewModel alloc]init];
    [checkVM setBlockWithReturnBlock:^(id returnValue) {
        [self.scrollView.mj_header endRefreshing];
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            //删除视图
            if (checkSuccess) {
                [checkSuccess removeFromSuperview];
                _userSelectNum = @0;
            }
            DrawingsInfoModel * drawingsInfoM = [[DrawingsInfoModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            self.drawingsInfoModel = drawingsInfoM;
            self.dateArray = drawingsInfoM.loanFor;
            [self getCycle:[drawingsInfoM.repayAmount floatValue]];
            finish(drawingsInfoM);
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        [self.scrollView.mj_header endRefreshing];
    }];
    [checkVM obtainDrawingInformation];
}

#pragma mark - 提款协议网络请求
//风险管理与数据服务协议
-(void)clickSecondAgreementBtn{
    
    NSDictionary *paramDic;
    if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]||[_drawingsInfoModel.productId isEqualToString:WhiteCollarLoan]) {
        if (_userSelectNum.integerValue == 0) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择借款周期"];
            return;
        }
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"7",
                     @"periods_":_userSelectNum};
    }
    
    /**
    if ([_drawingsInfoModel.productId isEqualToString:RapidLoan]||[_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"7",
                     @"periods_":@1};
    }
    */
    if ([_drawingsInfoModel.productId isEqualToString:RapidLoan]) {
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"7",
                     @"periods_":@2};
    }
    
  
    if ( [_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"7",
                     @"periods_":@1};
    }
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_agreement_url,_productProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
//技术服务协议
-(void)clickFirstAgreementBtn{
    
    NSDictionary *paramDic;
    if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]||[_drawingsInfoModel.productId isEqualToString:WhiteCollarLoan]) {
        if (_userSelectNum.integerValue == 0) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择借款周期"];
            return;
        }
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"6",
                     @"periods_":_userSelectNum};
    }
    /**
    if ([_drawingsInfoModel.productId isEqualToString:RapidLoan]||[_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
        paramDic = @{ @"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"6",
                     @"periods_":@1};
    }
    */
    if ([_drawingsInfoModel.productId isEqualToString:RapidLoan]) {
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"6",
                     @"periods_":@2};
    }
  
    if ([_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"6",
                     @"periods_":@1};
    }
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_agreement_url,_productProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

//发薪提款协议
-(void)LoanAgreementRequest{
    
    NSDictionary *paramDic;
    if ([_drawingsInfoModel.productId isEqualToString:SalaryLoan]||[_drawingsInfoModel.productId isEqualToString:WhiteCollarLoan]) {
        if (_userSelectNum.integerValue == 0) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择借款周期"];
            return;
        }
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"2",
                     @"periods_":_userSelectNum};
    }
    if ([_drawingsInfoModel.productId isEqualToString:RapidLoan]) {
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"2",
                     @"periods_":@2};
    }
    
    if ([_drawingsInfoModel.productId isEqualToString:DeriveRapidLoan]) {
        paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                     @"product_id_":_drawingsInfoModel.productId,
                     @"protocol_type_":@"2",
                     @"periods_":@1};
    }
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_agreement_url,_productProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

//合规
-(void)heguiAgreementRequest{
    if (_userSelectNum.integerValue == 0) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请选择借款周期"];
        return;
    }
    
    NSDictionary *paramDic = @{@"apply_id_":_drawingsInfoModel.applicationId,
                               @"product_id_":_drawingsInfoModel.productId,
                               @"protocol_type_":@"3",
                               @"periods_":_userSelectNum};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_agreement_url,_productProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

#pragma mark 提款申请件记录
-(void)saveLoanCase:(NSString *)type{

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
                p2pVC.applicationId = _drawingsInfoModel.applicationId;
                p2pVC.urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [self.navigationController pushViewController:p2pVC animated:YES];
                
            }else if ([type isEqualToString:@"30"]){
                LoanMoneyViewController *controller = [LoanMoneyViewController new];
                controller.applicationStatus = ComplianceProcessing;
                controller.popAlert = true;
                [self.navigationController pushViewController:controller animated:YES];
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [complianceViewModel saveLoanCase:type ApplicationID:_drawingsInfoModel.applicationId Period:_userSelectNum.description PurposeSelect:_purposeSelect];
}

#pragma mark 获取银行卡列表信息
-(void)getBankListInfo{

    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResult.flag isEqualToString:@"0000"]) {
            NSMutableArray * bankArr = [NSMutableArray array];
            NSArray * array  = (NSArray *)baseResult.result;
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [bankArr addObject:bankList];
            }
            BankCardViewController *bankVC = [BankCardViewController new];
            bankVC.bankArray = bankArr;
            bankVC.periodSelect = _userSelectNum.integerValue;
            bankVC.purposeSelect = _purposeSelect;
            bankVC.drawingsInfoModel = _drawingsInfoModel;
            bankVC.drawAmount = [NSString stringWithFormat:@"%.0f",_approvalModel.result.approval_amount];
            [self.navigationController pushViewController:bankVC animated:YES];

        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    [checkBankViewModel getSupportBankListInfo:@"4"];
}

#pragma mark 弹出合规银行卡列表viewmodel
-(void)queryCardInfo{
 
    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        QueryCardInfo *model = [QueryCardInfo yy_modelWithJSON:returnValue];
        NSString *bankName = model.result.UsrCardInfolist.bankName;
        PayViewController *payVC = [[PayViewController alloc] init];
        payVC.payType = PayTypeGetMoneyToCard;
        payVC.isP2P = YES;
        payVC.bankName = bankName;
        NSString *bank = model.result.UsrCardInfolist.CardId;
        payVC.banNum = [bank substringFromIndex:bank.length-4];
        payVC.makesureBlock = ^(PayType payType) {
            [self dismissSemiModalViewWithCompletion:^{
                [self saveLoanCase:@"30"];
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
#pragma mark - 提额时的魔蝎配置
-(void)configMoxieSDK{
    /***必须配置的基本参数*/
    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].userId = [Utility sharedUtility].userInfo.juid;
    [MoxieSDK shared].apiKey = theMoxieApiKey;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].useNavigationPush = NO;
    [self editSDKInfo];
};
-(void)editSDKInfo{
    [MoxieSDK shared].navigationController.navigationBar.translucent = YES;
    [MoxieSDK shared].backImageName = @"return";
    [MoxieSDK shared].navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [MoxieSDK shared].navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[MoxieSDK shared].navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
}
- (void)promote
{
    [MoxieSDK shared].taskType = @"bank";
    [[MoxieSDK shared] startFunction];
}
#pragma MoxieSDK Result Delegate
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    int code = [resultDictionary[@"code"] intValue];
    NSString *taskType = resultDictionary[@"taskType"];
    NSString *taskId = resultDictionary[@"taskId"];
    NSString *message = resultDictionary[@"message"];
    NSString *account = resultDictionary[@"account"];
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d",code,taskType,taskId,message,account,loginDone);
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        for (UIView *view in self.view.subviews) {
            if (![[view class] isSubclassOfClass:[MJRefreshNormalHeader class]]) {
                [view removeFromSuperview];
            }
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUserState];
            });
        });
        
        [self updateUserState];
        NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        NSLog(@"用户未登录");
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    //0 其他失败原因
    //-2平台方不可用（如中国移动维护等）
    //-3魔蝎数据服务异常
    //-4用户输入出错（密码、验证码等输错后退出）
    else{
        NSLog(@"任务失败");
    }
}
- (void)updateUserState
{
    NSDictionary *dic;
    if (_promoteType == PromoteCredit) {
        dic = @{@"task_type_":@"2",
                @"request_type_":@"2",
                @"apply_id_":_drawingsInfoModel.applicationId,
                @"old_task_status_":@"1"};
    }
    if (_promoteType == PromoteLimit) {
        dic = @{@"task_type_":@"1",
                @"request_type_":@"2",
                @"apply_id_":_drawingsInfoModel.applicationId,
                @"old_task_status_":@"1"};
    }
    
    //    __weak CheckViewController *weakSelf = self;
    @weakify(self);
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_caseStatusUpdateApi_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            DLog(@"%@",object);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
           //刷新视图
            [self.scrollView.mj_header beginRefreshing];
        });
    } failure:^(EnumServerStatus status, id object) {
        
    }];
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
        
        [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"发薪贷只专注于网络小额贷款。是一款新型网络小额贷款神器, 尽可能优化贷款申请流程，申请步骤更便捷，轻完成网上贷款。链接:http://www.faxindai.com 链接:%@",@"https://itunes.apple.com/cn/app/id1089086853"] title:@"发薪贷" image:imageArr url:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"] latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];

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


@end
