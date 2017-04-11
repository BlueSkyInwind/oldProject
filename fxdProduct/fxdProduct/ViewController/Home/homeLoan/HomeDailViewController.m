//
//  HomeDailViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/29.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeDailViewController.h"
#import "CustomerBaseInfoBaseClass.h"
#import "GetCareerInfoViewModel.h"
#import "CustomerCareerBaseClass.h"
#import <WebKit/WebKit.h>
#import "BankModel.h"
#import "UserCardResult.h"

@interface HomeDailViewController ()<UIScrollViewDelegate>
{
    CustomerCareerBaseClass *_carrerInfo;
}
@property (nonatomic, strong)WKWebView *webView;

@property (nonatomic, copy) NSString *cardNo;

@property (nonatomic, copy) NSString *bankName;

@end

@implementation HomeDailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.view.backgroundColor=[UIColor whiteColor];
    //    self.tabBarController.tabBar.barTintColor =[UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.title = @"发薪贷第三方借款协议";
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64)];
    _webView.scrollView.showsVerticalScrollIndicator = false;
    [self addBackItem];
    GetCareerInfoViewModel *careerInfoViewModel = [[GetCareerInfoViewModel alloc] init];
    [careerInfoViewModel setBlockWithReturnBlock:^(id returnValue) {
        _carrerInfo = returnValue;
        if ([_carrerInfo.flag isEqualToString:@"0000"]) {
            [self fatchCardInfo];
        }
    } WithFaileBlock:^{
        
    }];
    [careerInfoViewModel fatchCareerInfo:nil];
    
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
            [self createWebView];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardModel.msg];
        }
    } failure:^(EnumServerStatus status, id object) {
    }];
}


-(void)createWebView
{
    NSString *feeStr = [NSString stringWithFormat:@"%.2f",_amount.floatValue * _fee_rate];
    [_webView loadHTMLString:[NSString stringWithFormat:@"<h2 align=center>发薪贷第三方借款协议</h2><p><b><br>甲方（资金出借方）:马林宇<br>身份证号:340321198002177356<br>单位地址:上海市杨浦区政府路18号8楼<br>甲方手机号码:<br>乙方（资金借入方）:%@<br>身份证号:%@<br>单位地址:%@<br>乙方手机号码:%@<br>丙方（服务提供商）：<u>上海中赢金融信息服务有限公司</u><br>实际经营地：<u>上海市杨浦区政府路18号波司登国际大厦8楼</u></b><p><br>鉴于：<br>1.丙方是一家在上海市杨浦区合法成立并有效存在的公司，公司名称为：上海中赢金融信息服务有限公司（“发薪贷”），拥有APP软件发薪贷的经营权，提供投资和信用咨询，为交易提供信息服务、企业管理服务、广告信息发布、商务信息咨询服务资质。<br>2.甲乙双方确认本协议是通过丙方签署。<br>基于上述事实，甲乙双方就借款事宜达成协议如下。<p><br><b>一、借款及偿还方式</b><br>1.1 甲方资金来源如下：<br>&nbsp&nbsp&nbsp&nbsp甲方的收支账户为：<br>&nbsp&nbsp&nbsp&nbsp户名：马林宇<br>&nbsp&nbsp&nbsp&nbsp开户行 ：中国光大银行上海松江新城支行<br>&nbsp&nbsp&nbsp&nbsp账号：6214920600771131<br>1.2 乙方承诺借款不用于炒股、买卖期货等及法律禁止的不合法用途。<br>1.3 乙方的收支账户为：<br>&nbsp&nbsp&nbsp&nbsp户名：%@<br>&nbsp&nbsp&nbsp&nbsp开户行 ：%@<br>&nbsp&nbsp&nbsp&nbsp账号：%@<br>1.4 借款本金：人民币（大写）%@（人民币%@元整）。<br>1.5 借款期限：自%@至%@止；还款周期为%@周。<br>1.6 ①乙方确认：就本次借款乙方应向丙方支付3元每千元每天的服务费，服务费由手机验证费、银行卡验证费、身份验证费、账户管理费、征信审核费、信息发布费、撮合服务费、电话客户服务费、客户端使用费、逾期准备金计提成本等组成。乙方同意上述服务费从借款本金中先行扣除。②乙方确认:就本次借款乙方向丙方支付借款本金*6%%的平台运营费，乙方同意上述平台运营费从借款本金中先行扣除。 <br>1.7 乙方还款金额为等额借款本息：人民币（大写）%@[人民币（小写）%@元]，还款日期为每周约定还款期限。<br>1.8 乙方须确保收支账户为乙方名下合法有效的银行账户，乙方变更账户时必须向丙方申请签署《借款人客户信息变更书》并经丙方认可后方可变更。如因乙方未及时书面通知丙方引发的支付延迟，乙方应按照协议内容，支付逾期手续费。<p><br><b>二、借款的获取来源</b><br>2.1 乙方所获借款可能会来自于多位出借人，丙方或第三方支付机构会按照出借人列表所明示的出借比例对该笔还款为相应的出借人进行还款分配。<p><br><b>三、结算和支付方式</b><br>乙方应在签署本协议的同时授权丙方指定的有支付结算资质的第三方支付机构，出具委托手续并签订《委托扣款授权书》。<br>3.1 甲方同意由具有支付结算资质的第三方支付机构按照下列规定划转支付款项给乙方。<br>3.1.1 一次划转：甲方于%@前将借款金额存入1.1条约定的乙方收支账户内，由具有支付结算资质的第三方支付机构于%@前将借款金额全部划入乙方在1.3条约定的乙方收支账户内。第三方账户的转账费用由甲方承担。<br>3.2 乙方同意由具有支付结算资质的第三方支付机构按照1.7条约定的金额和时间划转支付款项给甲方。乙方于还款期内前将还款金额存入1.3条约定的乙方收支账户内。第三方账户的转账费用由乙方承担。<br>3.3 若乙方在还款期限之前未按照合同约定的收支账户存入还款金额或存入金额不足，致使还款逾期的，甲、乙双方均同意并确认：自乙方还款逾期之日起，该等债权即时转让予丙方，且无需甲方再行通知乙方。自此。丙方有权以其自身名义向乙方追讨该等欠款金额及本协议约定的违约责任。<p><br><b>四、提前还款</b><br>4.1 可随时提前还款，乙方提前还款只需将剩余本金和当期服务费结清即可，无其它费用;提前结清时，尚不足5周的按5周计算所有费用。<p><br><b>五、违约责任</b><br>5.1 若乙方在还款期限之前未按照合同约定的收支账户存入还款金额或存入金额不足的，即构成违约，并向丙方承担以下违约责任：<br>5.1.1 自应还款日起按每日借款金额的0.5%%收取逾期手续费，并支付10元/笔的滞纳金。<br>5.1.2 逾期超过15日，甲方仍未实际还款的，则应每日借款金额的0.75%%计收逾期手续费。<br>5.1.3 逾期超过30日，乙方有权对乙方提供的及发薪贷自行收集的乙方个人信息和资料编辑入网站黑名单，并将该黑名单对第三方披露，并与任何第三方数据共享，以便丙方和丙方委托的第三方催收逾期借款及对乙方的其他申请进行审核之用，由此因第三方的行为可能造成甲方的损失，乙方不承担法律责任。<br>5.2 守约方为追回损失而支付的包括但不限于律师费、诉讼费、公证费、交通通讯费等费用，由违约方承担。<p><br><b>六、 税务</b><br>协议各方在资金出借、转让过程产生的税费，自行向主管税务机关申报、缴纳。<p><br><b>七、通知及送达</b><br>7.1 在本协议有效期内，因法律、法规、政策的变化，或任一方丧失履行本协议的资格和/或能力，影响本协议履行的，该方应承担在合理时间内通知其他各方的义务。<br>7.2 协议各方同意，与本协议有关的任何通知，以书面方式送达方为有效。书面形式包括但不限于：传真、快递、邮件、电子邮件。上述通知应当被视为在下列时间送达：以传真发送，为该传真成功发送并由收件方收到之日；以快递或专人发送，为收件人收到该通知之日；以挂号邮件发送，为发出后7个工作日；以电子邮件发送，以电子邮件成功发出之日。<p> <br><b>八、协议的变更、解除和终止</b><br>除本协议或法律另有规定外，协议的变更、解除和终止以下列约定为准。<br>8.1本协议的任何修改、变更应经协议各方另行协商，并就修改、变更事项共同签署书面协议后方可成立。<br>8.2 本协议在下列情况下解除：<br>8.2.1 经各方协商一致解除。<br>8.2.2 任何一方发生违约行为并在守约方向其发出书面通知之日起 15 日内不予履行合同的，或累计发生两次或两次以上违约行为的，守约方有权单方面通知解除本协议。<br>8.2.3 因法律规定的不可抗力造成本协议无法继续履行的。<br>8.3 提出解除协议的一方，应当以书面形式通知其他各方。<br>8.4 本协议解除后，不影响守约方要求违约方支付违约金并赔偿损失的权利。<br>8.5 除本协议另有约定外，非经本协议各方协商一致并达成书面协议，任何一方不得转让其在本协议或本协议项下的全部或部分权利义务。<br>8.6 如果一方出现出借资产的继承或赠与等权利变更需要对方协助办理的，必须由主张权利的继承人或受赠人等相关人员向对方出示经国家权威机关（公证处或使领馆）公证认证的继承或赠与等权利归属证明的文件，对方确认后方予协助办理。由此产生的相关税费，由主张权利的一方负责向相关税务机关申报、缴纳。<p><br><b>九、 争议解决</b><br>9.1 本协议的效力、解释以及履行适应中华人民共和国的法律。<br>9.2 本协议各方因本协议履行发生争议的，均应首先通过友好协商的方式解决，协商不成的，任何一方均可把争议提交丙方实际经营所在人民法院暨上海市杨浦区人民法院诉讼管辖。<p><br><b>十、 保密条款</b><br>10.1 保密人员：任何接触本协议约定的保密信息的人员，均为保密人员。<br>10.2 保密信息的范围：<br>10.2.1 保密信息：指信息提供方向接受方提供的，属于提供方或其股东及其他关联公司所有或专有的，或提供方负有保密义务的有关第三方的资料及所有在信息载体上明确标示“保密”的材料和信息。需保密材料包括但不限于：合同文本正本、副本、附件、复印件及记载的内同，服务项目、收费标准，经营管理模式，客户信息等非公开的、保密的或专业的信息和数据。<br>10.2.2 保密信息不包括下列信息：<br>10.2.2.1 在接受保密信息之时，接受方已经通过其他来源获悉的、无保密限制信息。<br>10.2.2.2 一方通过合法行为获悉已经或即将公诸于众的信息。<br>10.2.2.3  根据政府要求、命令和司法条例所披露的信息。<br>10.3  保密义务：<br>10.3.1 对保密信息谨慎、妥善持有，并严格保密，没有提供方事先书面同意，不得向任何第三方披露。<br>10.3.2 接受方仅可为双方合作之必需，将保密信息披露给其指定的第三方公司，并且该公司应首先以书面形式承诺保守该保密信息。<br>10.3.3 接受方仅可为双方合作业务之必需，将保密信息披露给其直接或间接参与合作事项的管理人员、职员、顾问和其他雇员（统称“有关人员”），但应保证该类有关人员对保密信息严格保密。<br>10.3.4 若具有权力的法庭或其他司法、行政、立法机构要求一方披露保密信息，接受方将<br>（1）立即通知提供方此类要求；<br>（2）若接受方按上述要求必须提供保密信息，接受方将配合提供方采取合法及合理的措施，要求所提供的保密信息能得到保密的待遇。<br>10.3.5若接受方或有关人员违反本协议的保密义务，接受方须承担相应责任，并赔偿提供方由此造成的损失。<br>10.4 保密期限：本条规定的保密期限为本协议有效期内和有效期满后的5年。<p><br><b>十一、 附则</b><br>11.1 本协议附件作为本协议的有效组成部分，与本协议效力一致。<br>11.2 本协议的电子件、传真件、复印件、扫描件等经双方确认的有效复本的效力与本协议原件效力一致。<br>11.3 双方确认，本协议的签署、生效和履行以不违反中国的法律法规为前提。如果本协议中的任何一条或多条违反适用的法律法规，则该条将被视为无效，但该无效条款并不影响本协议其他条款的效力。<br>11.4 本协议自协议各方确认后即生效，本协议的文件具有法律效力。<br>【以下无正文】<br>请在本页进行签署，并确认已经清楚知晓并了解本合同的所有相关内容。<p><br>甲方：马林宇<br>日期： %@<br>乙方：%@<br>日期：%@<br>丙方：上海中赢金融信息服务有限公司<br>日期：%@",_userBaseInfo.result.customerName,_userBaseInfo.result.idCode,_carrerInfo.result.organizationAddress,_userBaseInfo.ext.mobilePhone,_userBaseInfo.result.customerName,_bankName,_cardNo,[Tool toCapitalLetters:_amount],_amount,[Tool countDate:_first_repay_date and:-7],[Tool countDate:_first_repay_date and:7*_loan_staging_amount.intValue],_loan_staging_amount,[Tool toCapitalLetters:feeStr],feeStr,[Tool countDate:_first_repay_date and:-7],[Tool countDate:_first_repay_date and:-7],[Tool countDate:_first_repay_date and:-7],_userBaseInfo.result.customerName,[Tool countDate:_first_repay_date and:-7],[Tool countDate:_first_repay_date and:-7]] baseURL:nil];

    [self.view addSubview:_webView];
    
}

-(void)pinchGestureClidckd:(UIPinchGestureRecognizer *)pinchGesture
{
    //    if (pinchGesture.state == UIGestureRecognizerStateChanged) {
    //        _imageview.transform = CGAffineTransformMakeScale(pinchGesture.scale, pinchGesture.scale);
    //
    //    }
    //
    //    if (pinchGesture.state == UIGestureRecognizerStateEnded) {
    //        [UIView animateWithDuration:0.5 animations:^{
    //            _imageview.transform = CGAffineTransformIdentity;
    //        }];
    //    }
}


@end
