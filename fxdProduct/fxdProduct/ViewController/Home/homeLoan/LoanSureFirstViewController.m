//
//  LoanSureFirstViewController.m
//  fxdProduct
//
//  Created by dd on 2017/1/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanSureFirstViewController.h"
#import "CheckViewController.h"
#import "HomeViewModel.h"
#import "FMDeviceManager.h"
#import "RateModel.h"
#import "ExpressViewController.h"
@interface LoanSureFirstViewController ()

@property (nonatomic, strong) YYTextView *textView;
@property (nonatomic,strong) RateModel *rateModel;

@end

@implementation LoanSureFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"借款申请确认";
    [self addBackItem];
//    [self setUpProductCredit];
    [Tool setCorner:self.sureBtn borderColor:[UIColor clearColor]];
    NSString *str = self.agreementLabel.text;
    NSMutableAttributedString *ssa = [[NSMutableAttributedString alloc] initWithString:str];
    [ssa addAttribute:NSForegroundColorAttributeName value:rgb(0, 170, 238) range:NSMakeRange(3,13)];
    self.agreementLabel.attributedText = ssa;
    self.agreementLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreement)];
    [self.agreementLabel addGestureRecognizer:tap1];
    
    if ([self.productId isEqualToString:@"P001002"]) {
        [self setUpProductCredit];
    }
    if ([self.productId isEqualToString:@"P001004"]) {
        [self setUpProductQuickly];
    }
    if ([self.productId isEqualToString:@"P001005"]) {
        [self setUpProductWhiteCollar];
    }
    if ([_model.applyFlag isEqualToString:@"0002"] && [_model.applyAgain isEqualToString:@"1"]) {
        [self.sureBtn addTarget:self action:@selector(secondLoanMoney) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.sureBtn addTarget:self action:@selector(getcreateApplication) forControlEvents:UIControlEventTouchUpInside];
    }

    
}

-(void)viewWillAppear:(BOOL)animated{

    [self fatchRate];
}

- (void)fatchRate
{
    NSDictionary *dic = @{@"priduct_id_":_productId};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
        _rateModel = rateParse;
        
        if ([rateParse.flag isEqualToString:@"0000"]) {
            
            
            if ([_productId isEqualToString:@"P001002"]) {
                NSString *str = [NSString stringWithFormat:@"工薪贷产品：\n纯信用，无抵押借款，用户可提前结清不额外收费\n利息：固定费率%.2f%%/日\n服务费：固定费率%.2f%%/日",rateParse.result.out_day_interest_fee_*100,rateParse.result.out_day_service_fee_*100];
                NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:str];
                if (UI_IS_IPHONE5) {
                    contentText.yy_font = [UIFont systemFontOfSize:10];
                } else {
                    contentText.yy_font = [UIFont systemFontOfSize:14];
                }
                contentText.yy_color = rgb(122, 131, 139);
                self.textView.attributedText = contentText;
            }
            if ([_productId isEqualToString:@"P001004"]) {
                NSString *str = [NSString stringWithFormat:@"急速贷产品：\n5分钟申请,30分钟下款,极速体验\n利息：固定费率%.2f%%/日\n服务费：固定费率%.2f%%/日",rateParse.result.out_day_interest_fee_*100,rateParse.result.out_day_service_fee_*100];
                NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:str];
                contentText.yy_font = [UIFont systemFontOfSize:14];
                contentText.yy_color = rgb(122, 131, 139);
                self.textView.attributedText = contentText;
                self.specialLabel.text = @"用户在申请急速贷产品后不得同时继续申请其他产品";
            }
            if ([_productId isEqualToString:@"P001005"]) {
                NSString *str = [NSString stringWithFormat:@"白领贷产品：\n专为高端人群设计，超低费用，提前结清不额外收费\n利息：固定费率%.2f%%/日\n服务费：固定费率%.2f%%/日",rateParse.result.out_day_interest_fee_*100,rateParse.result.out_day_service_fee_*100];
                NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:str];
                if (UI_IS_IPHONE5) {
                    contentText.yy_font = [UIFont systemFontOfSize:10];
                } else {
                    contentText.yy_font = [UIFont systemFontOfSize:14];
                }
                contentText.yy_color = rgb(122, 131, 139);
                self.textView.attributedText = contentText;
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:rateParse.msg];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (YYTextView *)textView
{
    if (_textView == nil) {
        _textView = [YYTextView new];
        [self.detailView addSubview:_textView];
        if (UI_IS_IPHONE5) {
            _textView.scrollEnabled = YES;
            _textView.showsVerticalScrollIndicator = false;
        }else {
            _textView.scrollEnabled = NO;
        }
        
        _textView.editable = NO;
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.bottom.equalTo(@0);
            make.right.equalTo(@0);
        }];
    }
    return _textView;
}

- (void)setUpProductCredit
{
    self.productLogo.image = [UIImage imageNamed:@"icon_Product1"];
    self.productTitle.text = @"工薪贷";
//    self.productTitle.text = _rateModel.result.name_;
    if ([_model.applyFlag isEqualToString:@"0002"]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"当前额度:"];
        NSString *amountStr = [NSString stringWithFormat:@"%@元",_model.pre_prove_amt_];
//        NSString *amountStr = _rateModel.result.ext_attr_.amt_desc_;
        [attriStr yy_appendString:amountStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(5, amountStr.length-1)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(18, 148, 255) range:NSMakeRange(5, amountStr.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }else {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"额度:1000-5000元"];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(3, 9)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(18, 148, 255) range:NSMakeRange(3, 10)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }
    
//    self.timeLabel.text = [NSString stringWithFormat:@"期限:%@",_rateModel.result.ext_attr_.period_desc_];
    self.timeLabel.text = @"期限:5-50周";
    self.specialLabel.text = @"用户在申请工薪贷产品后不得同时继续申请其他产品";
}

#pragma mark -> 白领贷页面显示

- (void)setUpProductWhiteCollar
{
    self.productLogo.image = [UIImage imageNamed:@"home10"];
    self.productTitle.text = @"白领贷";
//    self.productTitle.text = _rateModel.result.name_;
    if ([_model.applyFlag isEqualToString:@"0002"]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"当前额度:"];
        NSString *amountStr = [NSString stringWithFormat:@"%@元",_model.pre_prove_amt_];
//        NSString *amountStr = _rateModel.result.ext_attr_.amt_desc_;
        [attriStr yy_appendString:amountStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(5, amountStr.length-1)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(18, 148, 255) range:NSMakeRange(5, amountStr.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }else {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"额度:1000-5000元"];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(3, 9)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(18, 148, 255) range:NSMakeRange(3, 10)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }
    
//    self.timeLabel.text = [NSString stringWithFormat:@"期限:%@",_rateModel.result.ext_attr_.period_desc_];
    self.timeLabel.text = @"期限:5-52周";
    self.specialLabel.text = @"用户在申请白领贷产品后不得同时继续申请其他产品";
}

- (void)setUpProductQuickly
{
    self.productLogo.image = [UIImage imageNamed:@"icon_Product2"];
    self.productTitle.text = @"急速贷";
    if ([_model.applyFlag isEqualToString:@"0002"]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"当前额度:"];
        NSString *amountStr = [NSString stringWithFormat:@"%@元",_model.pre_prove_amt_];
        [attriStr yy_appendString:amountStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(5, amountStr.length-1)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(18, 148, 255) range:NSMakeRange(5, amountStr.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }else {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"额度:"];
        NSString *amountStr = [NSString stringWithFormat:@"%@元",_req_loan_amt];
        [attriStr yy_appendString:amountStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(3, amountStr.length - 1)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(18, 148, 255) range:NSMakeRange(3, amountStr.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }
    
    self.timeLabel.text = @"期限:14天";
    
    
}

#pragma mark -> 进件接口
-(void)getcreateApplication
{
    DLog(@"首次进件")
    NSDictionary *dict;
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    NSString *blackBox = manager->getDeviceInfo();
    if ([_productId isEqualToString:@"P001004"]) {
        dict = @{@"plantform_source":PLATFORM,
                 @"product_id_":_productId,
                 @"if_family_know_":_if_family_know,
                 @"resultcode":_resultCode,
                 @"rulesid":_rulesId,
                 @"req_loan_amt_":_req_loan_amt,
                 @"loan_staging_amount_":@1,
                 @"third_tongd_code":blackBox};
    }
    if ([_productId isEqualToString:@"P001002"]||[_productId isEqualToString:@"P001005"]) {
        dict = @{@"plantform_source":PLATFORM,
                   @"product_id_":_productId,
                   @"if_family_know_":_if_family_know,
                   @"resultcode":_resultCode,
                   @"rulesid":_rulesId,
                   @"third_tongd_code":blackBox};
    }
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_createApplication_jhtml] parameters:dict finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                
                CheckViewController *checkView = [CheckViewController new];
                checkView.homeStatues = 1;
                [self.navigationController pushViewController:checkView animated:YES];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)secondLoanMoney
{
    DLog(@"二次进件");
    
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    NSString *blackBox = manager->getDeviceInfo();
    
    NSDictionary *paramDic = @{@"product_id_":[Utility sharedUtility].userInfo.pruductId,
                               @"third_tongd_code":blackBox};
    __weak LoanSureFirstViewController *weakSelf = self;
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_secondApply_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            if ([[[object objectForKey:@"result"] objectForKey:@"apply_flag_"] isEqualToString:@"0002"]) {
                [weakSelf checkState];
            }
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)checkState
{
    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    __weak LoanSureFirstViewController *weakSelf = self;
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        if([returnValue[@"flag"] isEqualToString:@"0000"])
        {
            UserStateModel *model=[UserStateModel yy_modelWithJSON:returnValue[@"result"]];
            [weakSelf goCheckVC:model];
            
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState:nil];
}

- (void)goCheckVC:(UserStateModel *)model
{
    CheckViewController *checkVC = [CheckViewController new];
    checkVC.homeStatues = [model.applyStatus integerValue];
    checkVC.userStateModel = model;
    checkVC.task_status = model.taskStatus;
    checkVC.apply_again_ = model.applyAgain;
    if (model.days) {
        checkVC.days = model.days;
    }
    [self.navigationController pushViewController:checkVC animated:YES];
}


#pragma mark -> 跳转到用户信息授权服务协议
-(void)clickAgreement{

    ExpressViewController *controller = [[ExpressViewController alloc]init];
    controller.productId = @"agreement";
    [self.navigationController pushViewController:controller animated:YES];
    
    
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

@end
