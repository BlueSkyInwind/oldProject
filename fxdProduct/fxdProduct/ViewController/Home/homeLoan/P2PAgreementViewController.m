//
//  P2PAgreementViewController.m
//  fxdProduct
//
//  Created by dd on 2016/11/29.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "P2PAgreementViewController.h"
#import <WebKit/WebKit.h>
#import "CustomerBaseInfoBaseClass.h"
#import "DataWriteAndRead.h"

@interface P2PAgreementViewController ()
{
    UIProgressView *progressView;
}
@property (nonatomic, strong)WKWebView *webView;

@end


@implementation P2PAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"信用咨询管理服务协议";
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self createProUI];
    [self addBackItem];
    _webView.scrollView.showsVerticalScrollIndicator = false;
    CustomerBaseInfoBaseClass *info = [DataWriteAndRead readDataWithkey:UserInfomation];
    NSString *infoManager = [NSString stringWithFormat:@"%.2f",_amount.floatValue*0.005];
    NSString *accountManager = [NSString stringWithFormat:@"%.2f",_amount.floatValue*0.055];
//    info.result.homeAddress
    [_webView loadHTMLString:[NSString stringWithFormat:@"<html><body><h1 style='text-align:center'>信用咨询及管理服务协议（借款人)</h1>甲方 服务提供商）：上海中赢金融信息服务有限公司 <br/>地址：上海市杨浦区政府路波司登大厦18号8楼<br/>乙方（资金借入方）: %@ <br/>身份证号: %@ <br/>现居住地址: %@<br/>乙方手机号码 : 13156819076<br/>丙方：中赢普诚信用管理（北京）有限公司<br/>地址：北京市丰台区黄土岗高扬村2号A座六层60392室<br/>鉴于：乙方有一定的资金需求；甲方凭借其自身或通过其业务合作伙伴的业务资质、业务专业能力为乙方办理借款咨询、申请、还款管理等系列服务；<br/>丙方具有信用管理服务专业资质和能力，并开展信用咨询管理服务工作；丙方为乙方提供信用咨询、信用评审等系列信用管理服务，现各方就相应服务达成一致，特订立本协议。<br/>第一条 、乙方权利与义务<br/>1)乙方有权通过甲方向丙方了解其在丙方的信用评审进度及结果；<br/>2)乙方在申请及实现借款的全过程中，必须如实向甲方与丙方提供其所要求提供的个人信息；<br/>3)乙方在丙方建立个人信用账户，授权丙方基于乙方提供的信息及甲方与丙方独立获取的信息管理乙方的信用信息；<br/>4)乙方经甲方推荐，与特定的出借人于 %@ 签署了<br/>《第三方借款协议》借款合同金额为人民币 %@ 元 %@（大写），合同编号：  ，下文所提到的《借款协议》即指本特定的《第三方借款协议》，需按照本协议规定向甲方与丙方支付服务费。 第二条、甲方权利与义务<br/>1)甲方有权根据对乙方的评审结果，决定是否将乙方的借款需求向出借人进行推荐，以协助乙方取得资金来源； <br/>2)甲方与丙方须为乙方提供借款及还款相关的全程咨询及管理服务；<br/>3)甲方与丙方有权向乙方收取双方约定的服务费，有权以借款咨询服务为目的使用乙方个人信用信息。<br/>第三条、丙方权利与义务<br/>1)丙方有权获得乙方的个人信用信息，但该信息仅用于信用审核目的；<br/>2)丙方有权通过乙方提供的个人信用信息及行为记录来评定乙方所拥有的个人信用等级；<br/>3)丙方有权将乙方个人信用等级结果告知甲方。<br/>4)丙方需为乙方提供相应信用审核服务，并有权收取相应的服务费用；<br/>第四条、服务费<br/>在本协议中，“服务费”是指因甲方为乙方提供业务咨询、评估、推荐出借人、还款提醒、账户管理、还款特殊情况沟通等系列相关服务和丙方为乙方提供信用审核等服务而由乙方支付给甲方、丙方的报酬。对于甲方与丙方向乙方提供的系列服务，乙方同意在获得《第三方借款协议》约定的借款资金后，按照人民币%@元/日向甲方支付信息服务费，并一次性支付账户管理费人民币：%@元（大写：%@），向丙方一次性支付信用管理服务费人民币：%@元整（大写：%@）。乙方支付给丙方的服务费，由甲方代为收取。<br/>乙方可随时提前还款，乙方提前还款只需将剩余本金和当期服务费结清即可，无其它费用，但提前结清最少需支付5期（每期7日）的服务费用。乙方提前还款的，账户管理费及信用管理服务费不退。<br/>第五条、违约规定<br/>任何一方违反本协议的约定，使得本协议的全部或部分不能履行，均应承担违约责任，并赔偿对方因此遭受的损失（包括由此产生的诉讼费和律师费）；如双方违约，根据实际情况各自承担相应的责任。<br/>甲方保留将乙方违约失信的相关信息在媒体披露的权利。因乙方未还款而带来的调查费、差旅费、诉讼费、律师费等实现债权的费用将由乙方承担。<br/>第六条、变更通知<br/>本协议签订之日起至借款全部清偿之日止，乙方有义务在下列信息变更三日内提供更新后的信息给甲方和出借人，包含但不限于乙方本人、乙方的家庭联系人及紧急联系人工作单位、居住地址、住所电话、手机号码、电子邮件的变更。若因乙方不及时提供上述变更信息而导致的甲方或丙方调查费、差旅费、诉讼费、律师费等实现债权的费用将由乙方承担。<br/>第七条、其他<br/>1）甲乙丙各方签署本协议后，本协议成立并生效。乙方与特定的出借人的《借款协议》失效的同时，本协议第一条第三款、第二条第一款有关对乙方信用信息管理、保密等规定长期有效。<br/>2）本协议及其附件的任何修改、补充均须以书面形式作出。<br/>3）本协议的传真件、复印件、扫描件等有效副本的效力与本协议原件效力一致。<br/>4）甲乙丙各方均确认，本协议的签署、生效和履行以不违反中国的法律法规为前提。如果本协议中任何一条或多条违反中国的法律法规，则该条将被视为无效，但该无效条款并不影响本协议其他条款的效力。<br/>5）如果甲乙丙各方在本协议履行过程中发生任何争议，应友好协商解决；如协商不成，则须提交该协议签署地上海市杨浦区人民法院进行诉讼。<br/>6）本协议一式三份，甲乙丙各执一份，具有同等法律效力。<br/><br/><br/>甲方（盖章）：上海中赢金融信息服务有限公司<br/>日期： %@<br/><br/>乙方（签字）：%@ <br/>日期： %@<br/><br/>丙方（盖章）：中赢普诚信用管理（北京）有限公司<br/>日期： %@ </body></html>",info.result.customerName,info.result.idCode,info.result.homeAddress,[Tool getToday],_amount,[Tool toCapitalLetters:_amount],[NSString stringWithFormat:@"%.2f",_amount.floatValue*0.0028],accountManager,[Tool toCapitalLetters:accountManager],infoManager,[Tool toCapitalLetters:infoManager],[Tool getToday],info.result.customerName,[Tool getToday],[Tool getToday]] baseURL:nil];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == _webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            progressView.hidden = YES;
            [progressView setProgress:0 animated:NO];
        }else {
            progressView.hidden = NO;
            [progressView setProgress:newprogress animated:YES];
        }
    }
}

-(void)createProUI
{
    CGFloat progressBarHeight = 0.7f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    progressView=[[UIProgressView alloc] initWithFrame:barFrame];
    progressView.tintColor=RGBColor(49, 152, 199, 1);
    progressView.trackTintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:progressView];
}

-(void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [progressView removeFromSuperview];
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
