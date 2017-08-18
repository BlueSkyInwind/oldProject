//
//  RegDetailViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/11/2.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "RegDetailViewController.h"

@interface RegDetailViewController ()
{
    UIScrollView *_scrollview;
    UIImageView *_imageview;
}
@end

@implementation RegDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackItem];
    [self createUI];
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets= NO;
}

-(void)createUI{
    self.title= @"发薪贷注册协议";
    UIWebView *vebView=[[UIWebView alloc] initWithFrame:CGRectMake(10, 64, _k_w-20, _k_h-64)];
    vebView.backgroundColor=[UIColor whiteColor];
    [vebView loadHTMLString:@"<h3 align=center>注册协议</h3><p>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp本服务协议双方为憨分数据科技（上海）有限公司（下称“发薪贷”）与发薪贷用户，本服务协议具有合同效力。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp本网站由憨分数据科技（上海）有限公司负责运营，用户注册成为发薪贷用户前请务必仔细阅读以下条款。一旦注册，则用户接受发薪贷的服务时必须接受以下条款的约束，您在本网站的融资行为所需的中介服务由本网站合作方上海中赢金融信息服务有限公司负责提供；若用户不接受以下条款，请立即停止使用发薪贷。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp本服务协议内容包括以下条款及发薪贷已经发布的或将来可能发布的各类规则。所有规则为协议不可分割的一部分，与协议正文具有同等法律效力。本协议是由用户与发薪贷共同签订的，适用于用户在发薪贷的全部活动。在用户注册时，视为用户已经阅读、理解并接受本协议的全部条款及各类规则，并承诺遵守中国现行的法律、法规、规章及其他政府规定，如因违反而导致有任何法律后果发生，用户将以自己的名义独立承担所有相应的法律责任。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp发薪贷有权根据需要不时地制定、修改本协议或各类规则，如本协议及规则有任何变更，发薪贷将在网站、手机客户端上刊载公告，经修订的协议、规则一经公布后，立即自动生效。用户应不时地注意本协议及附属规则地变更，若用户继续使用发薪贷，即视为用户接受经修订的协议与规则。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户确认本服务协议后，本服务协议即在用户和发薪贷之间产生法律效力。用户按照发薪贷规定的注册程序成功注册为用户，既表示同意并签署了本服务协议。本服务协议不涉及用户与发薪贷的其他用户之间因网上交易而产生的法律关系及法律纠纷，但用户在此同意将全面接受和履行与发薪贷其他用户在发薪贷签订的任何电子法律文本，并承诺按该法律文本享有和/或放弃相应的权利、承担和/或豁免相应的义务。</p><p><b>一、使用限制<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户承诺合法使用发薪贷提供的服务及网站内容。禁止在发薪贷从事任何可能违反中国现行的法律、法规、规章和政府规范性文件的行为或者任何未经授权的行为，如擅自进入发薪贷未公开系统、不正当地使用密码和网站任何内容等。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp发薪贷只接受中华人民共和国（不包括香港特区、澳门特区及台湾地区）的18周岁以上的具有完全民事行为能力的自然人成为网站用户。如用户不符合资格，请勿注册。发薪贷保留中止或终止用户身份的权利。 用户注册成功后，不得将发薪贷的用户名转让给第三方或者授权给第三方使用。用户确认，使用其本人的用户名和密码登陆发薪贷后的一切操作均代表用户本人的行为，并由用户本人承担相应的法律后果。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户有义务在注册时提供自己的真实资料，并保证诸如电子邮件地址、联系电话、联系地址、邮政编码等内容的有效性及安全性。如用户因网上交易与其他用户产生纠纷的，发薪贷可根据隐私规则披露相关用户资料。经国家生效法律文书或行政处罚决定书确认用户存在违法行为，或发薪贷有足够事实依据可以认定用户存在违法或违反本服务协议的行为，或用户存在借款逾期未还情形的，用户在此同意并授权发薪贷在因特网络上公布用户的违法、违约行为及用户事先提供给发薪贷的信息和资料，并将该等内容记入与用户相关的信用资料和档案中。</p><p><b>二、涉及第三方网站<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp发薪贷的手机客户端、网站内容可能涉及由第三方所有、控制或者运营的其他网站（以下称“第三方网站”）。发薪贷不能保证也没有义务保证第三方网站上的信息的真实性和有效性。用户确认按照第三方网站的服务协议或规则使用第三方网站，第三方网站上披露的内容、产品、广告及其他任何信息均由用户自行判断与承担风险，与发薪贷无关。</p><p><b>三、不保证<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户确认，除发薪贷明确表示提供担保的业务外，发薪贷不对提供的服务中的任何用户、任何交易承担任何保证责任。</p><p><b>四、责任限制<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp在任何情况下，发薪贷对用户在使用发薪贷服务过程中产生的任何形式的损失均不承担保证责任，包括但不限于资金损失、利润损失、营业中断损失等。因发薪贷或者第三方网站的设备、系统存在缺陷或因计算机病毒造成的损失，除中国现行法律、法规另有规定外，发薪贷不承担任何责任。</p><p><b>五、网站内容监测<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp发薪贷没有义务监测网站、手机端内容，但是用户确认并同意发薪贷有权不时地根据法律、法规、政府要求等透露、修改或者删除相应信息，以便更好地运营发薪贷及维护其他合法用户的权益。</p><p><b>六、隐私规则<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp发薪贷对于用户提供的、自行收集的、经认证的个人信息将按照本规则予以保护、使用或者披露。当用户作为借入方借款逾期未还时，用户同意发薪贷及作为出借方的其他用户可以采取发布借入方用户个人信息的方式追索债权，并不承担任何违约责任。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp1、用户身份限制<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp发薪贷不接受未成年人（年龄18周岁以下人士）、中国港澳台地区人士、自然人以外的组织、法人等向发薪贷提交任何个人资料。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp2、涉及的个人资料<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户提供给发薪贷的个人资料及用户同意发薪贷自行收集的资料，主要用于发薪贷向用户提供一个顺利、有效和度身订造的交易经历。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 发薪贷可能自公开来源了解用户的情况，并为其度身订造相应的安全交易。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 发薪贷按照用户在发薪贷的行为自动追踪用户的相关资料。用户同意发薪贷可使用这些资料进行发薪贷用户的数量统计、兴趣及行为的内部研究等，以便发薪贷更好地了解用户及向用户提供更好的服务。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户同意发薪贷将在发薪贷的某些网页上使用诸如“Cookies”的资料收集装置。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp如用户将个人通讯信息（例如：手机短信、电邮或信件）提交给发薪贷，或其他用户或第三方向发薪贷发出关于用户在发薪贷上的活动或登录事项的通讯信息，用户同意发薪贷有权将这些资料收集在用户的个人档案中。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp3、发薪贷对用户的资料的使用<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户同意发薪贷使用其个人资料（包括但不限于发薪贷持有的用户个人档案中的资料，及发薪贷在用户目前或以前在发薪贷上的活动所获取的其他资料）以便发薪贷提供相应的服务。为避免用户在发薪贷上通过欺诈或其他非法手段，使发薪贷遭受损害，用户同意发薪贷可通过人工或自动程序对用户的个人资料进行评价。用户同意发薪贷可以使用用户的个人资料以改善发薪贷的服务内容与推广形式、分析网站的使用率，以便发薪贷网站的内容、设计和服务更能符合用户的要求，从而使用户在使用发薪贷服务时得到更为顺利、有效、安全的交易体验。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户同意发薪贷可利用用户的资料与用户联络并向用户传递（在某些情况下）针对用户的兴趣而提供的信息，例如：有针对性的广告条、行政管理方面的通知、产品提供以及有关用户使用发薪贷的通讯。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp4、发薪贷对用户的资料的披露<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp发薪贷保证采用行业标准惯例保护用户的个人资料，但因不可归责于发薪贷的技术问题等导致资料外泄的，发薪贷不承担任何责任。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 用户确认，发薪贷有义务根据有关法律法规、政府部门及司法机关的要求提供用户的个人资料。在用户未能按照与发薪贷签订的服务协议或者与发薪贷其他用户签订的借款协议等相关法律文本的约定履行自己应尽的义务时，发薪贷有权根据自己的判断或者与该笔交易有关的其他用户的请求披露用户的个人资料，并做出评论。用户借款逾期超过30天的，发薪贷有权对用户提供的及发薪贷自行收集的用户个人资料编辑入网站黑名单，并将该黑名单向与发薪贷有合作关系的第三方披露，且发薪贷有权将用户相关资料与任何第三方进行数据共享，以便网站和第三方向用户催收逾期借款及对用户的其他申请进行审核之用，由此因第三方的行为造成用户损失，发薪贷不承担法律责任。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp5、用户对其他用户的资料的使用<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 在发薪贷提供的交易活动中，用户无权要求发薪贷提供其他用户的个人资料，除非符合以下条件：<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp（a）用户基于其他用户的违约行为已向法院起诉；<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp（b）接受用户资金的借款人逾期未归还借款本息；<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp（c）发薪贷被吊销营业执照、解散、清算、宣告破产或者其他有碍于用户收回借款本息的情形。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp6、电子邮件和群组<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 用户不得使用发薪贷提供的站内信服务、群组服务或其他电子邮件转发服务发出垃圾邮件、信息或其他可能违反发薪贷服务协议的内容。如果用户利用发薪贷服务向未在发薪贷注册的电子邮件地址发出电子邮件，发薪贷承诺除利用该电子邮件地址发出用户电子邮件之外将不作任何其他用途。<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp7.密码的安全性<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp用户须对使用其用户名和密码所进行的一切操作负责。用户承诺会严格保管自己的用户名与密码，如果发现任何人不当使用您的账户或有任何其他可能危及您的账户安全的情形时，应当立即以有效方式通知发薪贷，并要求发薪贷暂停相关服务。用户理解发薪贷采取行动需要合理时间，发薪贷对在采取行动前已经产生的后果（包括但不限于任何损失）不承担任何责任。</p><p><b>七、补偿<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp就任何第三方向发薪贷提出的，由于用户违反本协议及纳入本协议的条款和规则或用户违反任何法律、法规或侵害第三方的权利而引起的任何索赔、要求、诉讼、损失和损害（实际的、特别的及有后果的），造成发薪贷及其关联方损失的，用户同意进行赔偿。</p><p><b>八、终止<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp除非发薪贷终止本协议或者用户停止使用发薪贷提供的服务，否则本协议对用户始终有效。</p><p><b>九、适用法律和管辖<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp因发薪贷提供服务所产生的争议均适用中华人民共和国法律，并由发薪贷实际运营地上海市杨浦区人民法院管辖（其他协议另有约定的按约定的条款指定管辖）。</p><p><b>十、附加条款<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp在发薪贷的某些部分或页面中可能存在除本协议以外的单独附加服务条款，当这些附加条款与本协议存在冲突时，附加条款优先适用。</p><p><b>十一、条款的独立性<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp若本协议的部分条款被认定为无效或者无法实施时，本协议中的其他条款仍然有效。</p><p><b>十二、投诉与建议<br></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 用户对发薪贷有任何投诉和建议，请致电4008-678-655或在发薪贷APP平台联络客服。</p><br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" baseURL:nil];
    [self.view addSubview:vebView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

@end
