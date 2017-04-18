//
//  AuthorizationViewController.m
//  fxdProduct
//
//  Created by dd on 16/7/15.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "AuthorizationViewController.h"
#import <WebKit/WKWebView.h>
#import "DataWriteAndRead.h"
#import "CustomerBaseInfoBaseClass.h"

@interface AuthorizationViewController ()

{
    WKWebView *_wkWebView;
}

@end

@implementation AuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 74, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self addBackItem];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"银行自动转账授权书";
//    style='font-size:200%'
    id data = [DataWriteAndRead readDataWithkey:UserInfomation];
    CustomerBaseInfoBaseClass *userInfo = data;
    NSString *htmlString = [NSString stringWithFormat:@"<html style='font-size:40px'><p><b>《银行自动转账授权书》</b></p>憨分数据科技（上海）有限公司</br>本账户所有人现将本人所开立的银行账户.<br/><b>账户姓名:%@</b><br/><b>账户账号：%@</b><br/><b>账户开户银行名称：%@</b><br/><b>账户开户证件：身份证</b><br/><b>账户开户证件号码：%@</b><p>授权贵司使用第三方支付公司的银联跨行网上代收系统，按照本人在贵司<b>【发薪贷】</b>平台的交易申请金额，自上述账户中进行合同资金的代收。代收用途：账户充值、投资借款项目或理财项目、偿还投资本金或收益等。<p><b>本人在此声明已经清楚并知悉本次授权代收的性质与后果。未经本人签署《银行自动转账授权终止通知书》之前，本授权书持续有效。</b><p align='right'>立授权人：%@</p></html>",userInfo.result.customerName,self.cardNum,self.bankName,userInfo.result.idCode,userInfo.result.customerName];
    [_wkWebView loadHTMLString:htmlString baseURL:nil];
    [self.view addSubview:_wkWebView];
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
