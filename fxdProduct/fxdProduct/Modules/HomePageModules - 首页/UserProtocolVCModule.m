//
//  ExpressViewController.m
//  fxdProduct
//
//  Created by dd on 16/8/3.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "UserProtocolVCModule.h"

@interface UserProtocolVCModule ()

@end

@implementation UserProtocolVCModule

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"费用说明";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addBackItem];
    [self setUpWebView];
    
}

- (void)setUpWebView
{
    NSString *htmlStr = @"";
    if ([_productId isEqualToString:SalaryLoan]) {
        htmlStr = @"<html style='font-size:14px'><body><p style='color:rgb(0,150,238)'><b>借款费用</b></p>按日收取，日费率0.3%，包括两部分：<br/>1、利息，固定利率0.03%/天；<br/>2、服务费，固定费率0.27%/天。服务费包括：身份认证费、学历认证费、手机验证费、银行卡验证费、提现手续费、征信审核费等。<br/>例如：借款3000元，借款周期2周，借款费用是126元【3000*0.3%*7天*2周】<br/><p style='color:rgb(0,150,238)'><b>逾期费用</b></p>发生逾期未还款时，将收取逾期费用，包括两个部分：<br/>1、滞纳金：10元/笔；<br/>2、逾期手续费：按日收取，逾期小于等于15天，按逾期当期本金的0.5%/天收取，逾期大于15天，按逾期金额的0.75%/天收取；<br/>例如：借款3000元，借款周期2周，逾期2天，逾期费用25元【10+(3000/2)*0.5%*2】；逾期17天，逾期费用145元【10+（1500*0.5%*15）+（1500*0.75%*2）】<br/><p style='color:rgb(0,150,238)'><b>平台运营费</b></p>按笔收取，每笔收取提款金额的6%。例如：提款3000元，发薪贷收取3000*6%=180元平台运营费，实际到账2820元。</body></html>";
    }
    if ([_productId isEqualToString:RapidLoan]) {
        htmlStr = @"<html style='font-size:14px'><body><p style='color:rgb(0,150,238)'><b>借款费用</b></p>固定期限14天，提前收取费用在到账金额中扣除，曰总费率1%,包括两部分：<br> 1、利息，固定利率0.03%/天；<br/>2、服务费，固定费率0.97%/天。服务费包括:身份认证费、学历认证费、手机验证费、银行卡验证费、提现手续费、征信审核费等。 例如：借款1000元，借款周期14天，借款费用是140元【1000*1% *14(天)】<p style='color:rgb(0,150,238)'><b>逾期费用</b></p>发生逾期未还款是，将收取逾期费用，包括两个部分：<br /> 1、滞纳金：10元/笔；<br/> 2、逾期手续费:按日收取,按逾期本金的 2%/天收取;<br/>例如：借款1000元，借款周期14天，逾期2天，逾期费用50元【10+ 1000*2%*2】；<p style='color:rgb(0,150,238)'><b>平台运营费</b></p>按笔收取，每笔收取提款金额的6%。<br /> 例如：提款1000元，发薪贷收取1000*6%=60元平台运营费。</body></html>";
    }
    
    if ([_productId isEqualToString:@"operInfo"]||[_productId isEqualToString:@"agreement"]) {
        if ([_productId isEqualToString:@"operInfo"]) {
            self.navigationItem.title = @"运营商信息授权协议";
        }else{
            self.navigationItem.title = @"用户信息授权服务协议";
        }
        __weak typeof(self)weakSelf = self;
        [self operatorsAgreementRquestContent:^(NSString *resultStr) {
            
            [weakSelf.webView loadHTMLString:resultStr baseURL:nil];

        }];
    }
    
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}

/**
 请求运营商协议

 @return 返回协议内容
 */
-(void)operatorsAgreementRquestContent:(void(^)(NSString *resultStr))content{
    
    NSDictionary *paramDic;
    if ([_productId isEqualToString:@"operInfo"]) {
        
        paramDic = @{@"product_id_":@"operInfo",
                                   @"protocol_type_":@"4"};
    }
    if ([_productId isEqualToString:@"agreement"]) {
        paramDic = @{@"product_id_":@"fxd_userpro",
                     @"protocol_type_":@"5"};
    }
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_newproductProtocol_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if ([[object objectForKey:@"flag"] isEqualToString:@"0000"]) {
            
            NSString * str = [[object objectForKey:@"result"] objectForKey:@"protocol_content_"];
            content(str);
            
        } else {
            
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:[object objectForKey:@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
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
