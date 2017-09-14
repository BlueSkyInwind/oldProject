//
//  LoanSureSecondViewController.m
//  fxdProduct
//
//  Created by dd on 2017/1/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanSureSecondViewController.h"
#import "ReturnMsgBaseClass.h"
#import "UserStateModel.h"
#import "CheckViewController.h"
#import "telphoneView.h"
#import "FMDeviceManager.h"
#import "RateModel.h"

@interface LoanSureSecondViewController ()
{
    ReturnMsgBaseClass *_mobileParse;
    NSString *telNum;
}

@property (nonatomic, strong) YYTextView *textView;

@end

@implementation LoanSureSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"借款确认";
    [self addBackItem];
    [Tool setCorner:self.sureBtn borderColor:[UIColor clearColor]];
    [Tool setCorner:self.passView borderColor:UI_MAIN_COLOR];
    [Tool setCorner:self.smsCodeView borderColor:UI_MAIN_COLOR];
    self.smsCodeView.hidden = YES;
    
    [self getOperator];
    [self featchTel];
    
    [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if ([self.productId isEqualToString:SalaryLoan]) {
        [self setUpProductCredit];
    }
    if ([self.productId isEqualToString:RapidLoan]) {
        [self setUpProductQuickly];
    }
    if ([self.productId isEqualToString:WhiteCollarLoan]) {
        [self setUpProductWhiteCollar];
    }
    if (UI_IS_IPHONE5) {
        self.TopViewBottom.constant = 30;
        self.productTitle.font = [UIFont systemFontOfSize:15.0];
        [self.TopView updateConstraintsIfNeeded];
        [self.TopView updateConstraints];
    }
    [self fatchRate];
}

- (IBAction)helpBtnClick:(UIButton *)sender {
    telphoneView *telview = [[[NSBundle mainBundle] loadNibNamed:@"telphoneView" owner:self options:nil] lastObject];
    telview.frame = CGRectMake(0, 0, _k_w, _k_h);
}


- (void)sureBtnClick
{
    if ([self checkData]) {
        NSDictionary *dicParam = @{@"mobile_phone_":telNum,
                                   @"service_password_":self.passwordField.text
                                   };
        NSDictionary *dicParma2 = @{@"mobile_phone_":telNum,
                                    @"service_password_":self.passwordField.text,
                                    @"verify_code_":self.smsField.text
                                    };
        if (self.passView.hidden) {
            [self getcreateApplication];
        } else {
            if (self.smsCodeView.hidden) {
                [self postTelSecory:dicParam];
            }else {
                [self postTelSecory:dicParma2];
            }
        }
    }
}

- (BOOL)checkData
{
    BOOL passBool = false;
    BOOL smsBool = false;
    if (self.passView.hidden) {
        passBool =  true;
    }else {
        if (self.passwordField.text == nil || [self.passwordField.text isEqualToString:@""]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的服务密码"];
            passBool = false;
        } else {
            passBool = true;
        }
    }
    
    if (self.smsCodeView.hidden) {
        smsBool = true;
    } else {
        if (self.smsField.text == nil || [self.smsField.text isEqualToString:@""]) {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请填写正确的验证码"];
            smsBool = false;
        } else {
            smsBool = true;
        }
    }
    return passBool&&smsBool;
}

-(void)featchTel
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_checkMobilePhoneAuth_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            //            _checkMobileDic = object;
            //            _telNum = [[object objectForKey:@"ext"] objectForKey:@"mobile_phone_"];
            if ([[object objectForKey:@"flag"]isEqualToString:@"0000"])
            {
                if ([[object objectForKey:@"result"] isEqualToString:@"1"]) {
                    self.passView.hidden = YES;
                }else {
                    self.passView.hidden = NO;
                }
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
    
}

- (void)getOperator
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getMobileOpera_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                telNum = [[object objectForKey:@"ext"] objectForKey:@"mobile_phone_"];
                self.phoneNumLabel.text = [self formatString:telNum];
                NSString *result = [object objectForKey:@"result"];
                self.operatorLabel.text = result;
            }else{
                DLog(@"获取失败");
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"运营商信息获取失败"];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}


-(void)postTelSecory:(NSDictionary *)dicParam{
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_Certification_url] parameters:dicParam finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            _mobileParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
            if ([_mobileParse.flag isEqualToString:@"0000"])
            {
                //                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                [self getcreateApplication];
            }else if ([_mobileParse.flag isEqualToString:@"0006"]) {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
                self.smsCodeView.hidden =NO;//错误时 验证码显示
            }else{
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_mobileParse.msg];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

#pragma mark -> 进件接口
-(void)getcreateApplication
{
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    NSString *blackBox = manager->getDeviceInfo();
    NSDictionary *dict;
    if ([_productId isEqualToString:RapidLoan]) {
        dict = @{@"plantform_source":PLATFORM,
                 @"product_id_":_productId,
                 @"req_loan_amt_":_req_loan_amt,
                 @"loan_staging_amount_":@1,
                 @"third_tongd_code":blackBox};
    } else {
         dict = @{@"plantform_source":PLATFORM,
                  @"product_id_":_productId,
                  @"third_tongd_code":blackBox};
    }
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_createApplication_jhtml] parameters:dict finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
                
                CheckViewController *checkView = [CheckViewController new];
                [self.navigationController pushViewController:checkView animated:YES];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
            }
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (NSString *)formatString:(NSString *)str
{
    NSMutableString *returnStr = [NSMutableString stringWithString:str];
    
    NSMutableString *formatStr = [NSMutableString string];
    for (NSInteger i = 0; i < returnStr.length; i++) {
        unichar c = [returnStr characterAtIndex:i];
        if (i > 0) {
            if (i == 2) {
                [formatStr appendFormat:@"%C ",c];
                
            }else if (i == 6){
                [formatStr appendFormat:@"%C ",c];
            }else {
                [formatStr appendFormat:@"%C",c];
            }
        } else {
            [formatStr appendFormat:@"%C",c];
        }
    }
    
    return formatStr;
}

- (YYTextView *)textView
{
    if (_textView == nil) {
        _textView = [YYTextView new];
        [self.explainView addSubview:_textView];
        _textView.scrollEnabled = NO;
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

- (void)fatchRate
{
    NSDictionary *dic = @{@"priduct_id_":_productId};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_fatchRate_url] parameters:dic finished:^(EnumServerStatus status, id object) {
        RateModel *rateParse = [RateModel yy_modelWithJSON:object];
        
        if ([rateParse.flag isEqualToString:@"0000"]) {
//            if ([_productId isEqualToString:@"P001002"]) {
//                NSString *str = [NSString stringWithFormat:@""]
//            }
//            if ([_productId isEqualToString:@"P001004"]) {
//                
//            }
            
            NSString *str = [NSString stringWithFormat:@"额度:%ld-%ld元\n期限:%ld-%ld周\n利息:固定费率%.2f%%/日\n服务费:固定费率%.2f%%/日",rateParse.result.principal_bottom_,rateParse.result.principal_top_,rateParse.result.staging_bottom_,rateParse.result.staging_top_,rateParse.result.out_day_interest_fee_*100,rateParse.result.out_day_service_fee_*100];
            NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:str];
            contentText.yy_font = [UIFont systemFontOfSize:14];
            contentText.yy_color = rgb(122, 131, 139);
            self.textView.attributedText = contentText;
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:rateParse.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (void)setUpProductCredit
{
    self.productLogo.image = [UIImage imageNamed:@"icon_Product1"];
    self.productTitle.text = @"工薪贷";
}

- (void)setUpProductQuickly
{
    self.productLogo.image = [UIImage imageNamed:@"icon_Product2"];
    self.productTitle.text = @"急速贷";
}

#pragma mark -> 白领贷页面显示
- (void)setUpProductWhiteCollar
{

    self.productLogo.image = [UIImage imageNamed:@"home10"];
    self.productTitle.text = @"白领贷";
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
