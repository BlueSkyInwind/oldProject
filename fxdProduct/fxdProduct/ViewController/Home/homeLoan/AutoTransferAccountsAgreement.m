//
//  AutoTransferAccountsAgreement.m
//  fxdProduct
//
//  Created by dd on 2016/12/5.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "AutoTransferAccountsAgreement.h"
#import <WebKit/WebKit.h>
#import "CustomerBaseInfoBaseClass.h"
#import "DataWriteAndRead.h"
#import "BankModel.h"
#import "UserCardResult.h"

@interface AutoTransferAccountsAgreement ()

@property (nonatomic, strong)WKWebView *webView;

@property (nonatomic, copy) NSString *cardNo;

@property (nonatomic, copy) NSString *bankName;

@end

@implementation AutoTransferAccountsAgreement

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"银行自动转账授权书";
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self addBackItem];
    _webView.scrollView.showsVerticalScrollIndicator = false;
    
    [self fatchCardInfo];
    [self.view addSubview:_webView];
}

- (void)fatchCardInfo
{
    NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        BankModel *_bankCardModel = [BankModel yy_modelWithJSON:object];
        if ([_bankCardModel.flag isEqualToString:@"0000"]) {
            [self postUrlMessageandDictionary:_bankCardModel];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_bankCardModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
}

-(void)postUrlMessageandDictionary:(BankModel *)bankModel{
    //请求银行卡列表信息
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        UserCardResult *_userCardModel =[UserCardResult yy_modelWithJSON:object];
        if([_userCardModel.flag isEqualToString:@"0000"]){
            for(NSInteger j=0;j<_userCardModel.result.count;j++)
            {
                CardResult *cardResult = _userCardModel.result[j];
                if([cardResult.card_type_ isEqualToString:@"2"])
                {
                    for (BankList *banlist in bankModel.result) {
                        if ([cardResult.card_bank_ isEqualToString: banlist.code]) {
                            if ([cardResult.if_default_ isEqualToString:@"1"]) {
                                _cardNo = cardResult.card_no_;
                                _bankName = banlist.desc;
                            }
                        }
                    }
                }
            }
            CustomerBaseInfoBaseClass *info = [DataWriteAndRead readDataWithkey:UserInfomation];
            [_webView loadHTMLString:[NSString stringWithFormat:@"<html><body><h1 style='text-align:center'>银行自动转账授权书</h1>憨分数据科技（上海）有限公司：<br/>本账户所有人现将本人所开立的银行账户<br/>账户姓名： %@ <br/>账户账号： %@ <br/>账户开户银行简称：%@<br/>账户开户证件：身份证<br/>账户开户证件号码：%@<br/>授权贵司使用第三方支付公司的银联跨行网上代收系统，按照本人在贵司【发薪贷】平台的交易申请金额，自上述账户中进行合同资金的代收。代收用途：账户充值、投资借款项目或理财项目、偿还投资本金或收益等。<br/><br/>本人在此声明已经清楚并知悉本次授权代收的性质与后果。<br/>未经本人签署《银行自动转账授权终止通知书》之前，本授权书持续有效。<br/><br/>立授权人：%@</body></html>",info.result.customerName,_cardNo,_bankName,info.result.idCode,info.result.customerName] baseURL:nil];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardModel.msg];
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
