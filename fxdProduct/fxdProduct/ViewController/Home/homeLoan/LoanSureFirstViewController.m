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
#import "ApplicationViewModel.h"
#import "ApplicaitonModel.h"

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
    [Tool setCorner:self.sureBtn borderColor:[UIColor clearColor]];
    NSString *str = self.agreementLabel.text;
    NSMutableAttributedString *ssa = [[NSMutableAttributedString alloc] initWithString:str];
    [ssa addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3,13)];
    self.agreementLabel.attributedText = ssa;
    self.agreementLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreement)];
    [self.agreementLabel addGestureRecognizer:tap1];
    [self.sureBtn addTarget:self action:@selector(getcreateApplication) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated{

    [self fatchRate];
}

- (void)fatchRate
{
    ApplicationViewModel * applicationVM = [[ApplicationViewModel alloc]init];
    [applicationVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            ApplicaitonViewInfoModel * applicationVM = [[ApplicaitonViewInfoModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            [self setUpProductData:applicationVM];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [applicationVM queryApplicationInfo:_productId];
    
    
//    NSDictionary *dic = @{@"priduct_id_":_productId};
//    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) { 
//        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
//        _rateModel = rateParse;
//        
//        if ([rateParse.flag isEqualToString:@"0000"]) {
//            if ([self.productId isEqualToString:SalaryLoan]) {
//                [self setUpProductCredit];
//            }
//            if ([self.productId isEqualToString:RapidLoan]) {
//                [self setUpProductQuickly];
//            }
//            if ([_productId isEqualToString:SalaryLoan]) {
//                NSString *str = [NSString stringWithFormat:@"工薪贷产品：\n纯信用，无抵押借款，用户可提前结清不额外收费\n利息：固定费率%.2f%%/日\n服务费：固定费率%.2f%%/日",rateParse.result.out_day_interest_fee_*100,rateParse.result.out_day_service_fee_*100];
//                NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:str];
//                if (UI_IS_IPHONE5) {
//                    contentText.yy_font = [UIFont systemFontOfSize:10];
//                } else {
//                    contentText.yy_font = [UIFont systemFontOfSize:14];
//                }
//                contentText.yy_color = rgb(122, 131, 139);
//                self.textView.attributedText = contentText;
//            }
//            if ([_productId isEqualToString:RapidLoan]) {
//                NSString *str = [NSString stringWithFormat:@"急速贷产品：\n5分钟申请,30分钟下款,极速体验\n利息：固定费率%.2f%%/日\n服务费：固定费率%.2f%%/日",rateParse.result.out_day_interest_fee_*100,rateParse.result.out_day_service_fee_*100];
//                NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:str];
//                contentText.yy_font = [UIFont systemFontOfSize:14];
//                contentText.yy_color = rgb(122, 131, 139);
//                self.textView.attributedText = contentText;
//                self.specialLabel.text = @"用户在申请急速贷产品后不得同时继续申请其他产品";
//            }
//            if ([_productId isEqualToString:WhiteCollarLoan]) {
//                NSString *str = [NSString stringWithFormat:@"白领贷产品：\n专为高端人群设计，超低费用，提前结清不额外收费\n利息：固定费率%.2f%%/日\n服务费：固定费率%.2f%%/日",rateParse.result.out_day_interest_fee_*100,rateParse.result.out_day_service_fee_*100];
//                NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:str];
//                if (UI_IS_IPHONE5) {
//                    contentText.yy_font = [UIFont systemFontOfSize:10];
//                } else {
//                    contentText.yy_font = [UIFont systemFontOfSize:14];
//                }
//                contentText.yy_color = rgb(122, 131, 139);
//                self.textView.attributedText = contentText;
//            }
//        } else {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:rateParse.msg];
//        }
//    } failure:^(EnumServerStatus status, id object) {
//        
//    }];
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
-(void)setUpProductData:(ApplicaitonViewInfoModel *)applicationVM{
    
//    [self.productLogo sd_setImageWithURL:[NSURL URLWithString:applicationVM.icon] placeholderImage:[UIImage imageNamed:@"placeholderImage_Icon"] options:SDWebImageRefreshCached];
    [self.productLogo sd_setImageWithURL:[NSURL URLWithString:applicationVM.icon] placeholderImage:[UIImage imageNamed:@"placeholderImage_Icon"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    
    self.productTitle.text = applicationVM.productName;
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"当前额度:"];
    NSString *amountStr = [NSString stringWithFormat:@"%@",applicationVM.amount];
    [attriStr yy_appendString:amountStr];
    [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 5)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(5, amountStr.length-1)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(5, amountStr.length)];
    self.amountLabel.attributedText = attriStr;
    
    NSString *str = [NSString stringWithFormat:@"期限:%@",applicationVM.period];
    NSMutableAttributedString * attriStr2 = [[NSMutableAttributedString alloc] initWithString:str];
    [attriStr2 addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 2)];
    [attriStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 2)];
    [attriStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(3, str.length-3)];
    [attriStr2 addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, str.length-3)];
    self.timeLabel.attributedText = attriStr2;
     NSString * detailStr = @"";
    for (NSString *str1  in applicationVM.detail) {
        detailStr = [detailStr stringByAppendingString:str1];
    } 
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:detailStr];
    if (UI_IS_IPHONE5) {
        contentText.yy_font = [UIFont systemFontOfSize:12];
    } else {
        contentText.yy_font = [UIFont systemFontOfSize:14];
    }
    contentText.yy_color = rgb(122, 131, 139);
    self.textView.attributedText = contentText;
    
    NSString * specialStr = @"";
    for (NSString *str2  in applicationVM.special) {
        specialStr = [specialStr stringByAppendingString:str2];
    }
    self.specialLabel.text = specialStr;
}

- (void)setUpProductCredit
{
    self.productLogo.image = [UIImage imageNamed:@"icon_Product1"];
//    self.productTitle.text = @"工薪贷";
    self.productTitle.text = _rateModel.result.name_;
    if ([_model.applyFlag isEqualToString:@"0002"]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"当前额度:"];
        NSString *amountStr = [NSString stringWithFormat:@"%@元",_model.pre_prove_amt_];
//     NSString *amountStr = _rateModel.result.ext_attr_.amt_desc_;
        [attriStr yy_appendString:amountStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(5, amountStr.length-1)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(5, amountStr.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }else {
        NSString *str = [NSString stringWithFormat:@"额度:%ld-%ld元",_rateModel.result.principal_bottom_,_rateModel.result.principal_top_];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(3, attriStr.length-4)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, attriStr.length-3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"期限:%ld-%ld%@",_rateModel.result.staging_bottom_,_rateModel.result.staging_top_,_rateModel.result.remark_];
//    self.timeLabel.text = @"期限:5-50周";
    self.specialLabel.text = @"用户在申请工薪贷产品后不得同时继续申请其他产品";
}

#pragma mark -> 白领贷页面显示

- (void)setUpProductWhiteCollar
{
    self.productLogo.image = [UIImage imageNamed:@"home10"];
    self.productTitle.text = _rateModel.result.name_;
    if ([_model.applyFlag isEqualToString:@"0002"]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"当前额度:"];
        NSString *amountStr = [NSString stringWithFormat:@"%@元",_model.pre_prove_amt_];
        [attriStr yy_appendString:amountStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 5)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(5, amountStr.length-1)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(5, amountStr.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }else {
        
        NSString *str = [NSString stringWithFormat:@"额度:%ld-%ld元",_rateModel.result.principal_bottom_,_rateModel.result.principal_top_];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(3, attriStr.length-4)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, attriStr.length-3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;

    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"期限:%ld-%ld%@",_rateModel.result.staging_bottom_,_rateModel.result.staging_top_,_rateModel.result.remark_];
//    self.timeLabel.text = @"期限:5-52周";
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
        [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(5, amountStr.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }else {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:@"额度:"];
        NSString *amountStr = [NSString stringWithFormat:@"%@元",_req_loan_amt];
        [attriStr yy_appendString:amountStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:rgb(122, 131, 139) range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(3, amountStr.length - 1)];
        [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3, amountStr.length)];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(attriStr.length-1, 1)];
        self.amountLabel.attributedText = attriStr;
    }
    
    self.timeLabel.text =  [NSString stringWithFormat:@"%@天",_rateModel.result.ext_attr_.period_desc_];;
}

#pragma mark -> 进件接口
-(void)getcreateApplication
{
    DLog(@"首次进件")
    ApplicationViewModel * applicationVM = [[ApplicationViewModel alloc]init];
    [applicationVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){

            [self checkState];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [applicationVM userCreateApplication:_productId];
    
}

- (void)secondLoanMoney
{
    DLog(@"二次进件");
    
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    NSString *blackBox = manager->getDeviceInfo();
    
    NSDictionary *paramDic = @{@"product_id_":_productId,
                               @"third_tongd_code":blackBox};
    __weak LoanSureFirstViewController *weakSelf = self;
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_secondApply_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            if ([[[object objectForKey:@"result"] objectForKey:@"apply_flag_"] isEqualToString:@"0002"]) {
                [weakSelf checkState];
            }else if([[[object objectForKey:@"result"] objectForKey:@"apply_flag_"] isEqualToString:@"0001"]){
                [weakSelf checkState];
            }else if([[[object objectForKey:@"result"] objectForKey:@"apply_flag_"] isEqualToString:@"0003"]){
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
            }else{
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
    [homeViewModel fetchUserState:_model.product_id];
}

-(void)failed{

    CheckViewController *checkVC = [CheckViewController new];
    checkVC.isSecondFailed = YES;
    checkVC.product_id = _productId;
    [self.navigationController pushViewController:checkVC animated:YES];
    
}

- (void)goCheckVC:(UserStateModel *)model
{
    CheckViewController *checkVC = [CheckViewController new];
    checkVC.userStateModel = model;
    checkVC.task_status = model.taskStatus;
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
