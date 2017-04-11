//
//  HelpViewController.m
//  fxdProduct
//
//  Created by dd on 15/10/27.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpViewCell.h"

@interface HelpViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArr;
    NSArray *detailArr;
    NSMutableArray *isOpen;
}
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title=@"常见问题";
    [self addBackItem];

    self.helpTableView.showsVerticalScrollIndicator = NO;

    isOpen=[[NSMutableArray alloc]init];
    dataArr=@[@"借款需要具备哪些基本条件？",@"借款的额度范围和期限？",@"借款费用有哪些？",@"可否同时申请2个产品？",@"如何还款？",@"借款步骤有哪些？",@"什么情况会导致申请失败？",@"可否多次申请借款？",@"如何提额？",@"借款申请提交之后，审批时间多久？到账时间多久？",@"如果审核未通过，还能再次申请借款吗？",@"发薪贷支持哪些银行的借记卡？",@"如果有逾期发生，需要支付哪些费用？",@"如何保护借款人提交的信息？"];
    detailArr=@[
                @"1、本人手机号及手机服务密码；\n2、本人有效身份证；\n3、持卡人姓名、身份证、手机号都是您本人的银行卡。",
                @"工薪贷 \n 额度：1000-5000元\n借款周期：5周-50周\n\n急速贷 \n额度：500、800、1000元\n借款周期：2周",
                @"工薪贷 \n利息：按借款金额的0.03%/天收取。\n服务费：按借款金额的0.27%每天收取。\n平台运营费：按借款金额的6%每笔收取\n\n急速贷\n利息：按借款金额的0.03%/天提前收取；\n服务费：按借款金额的0.97%/天提前收取；\n平台运营费：按借款金额的6%每笔收取。",
                @"不可以，同时只能申请一个产品。结清后可续借此前产品或申请另一产品。",
                @"1、自动扣款：账单日发薪贷自动从绑定银行卡中扣除当期欠款。\n2、主动还款：点击我要还款，系统将从绑定银行卡中扣除当期欠款。如果有逾期，会连同逾期欠款一起还款。您也可以自行选择其它银行卡还款。\n3、结清：客户可以点击结清借款，结清当期欠款和剩余本金。\n4、逾期欠款：一旦发生逾期，系统会发短信提醒客户当前应还金额，请确保扣款银行卡中有足够金额，系统会自动扣除逾期欠款。\n5、强制结清：客户逾期超过30天，我们将强制结清客户全部欠款和剩余本金，请客户保障扣款银行卡中有足够余额，系统会自动扣除",
                @"        注册——登录——申请——审核——提款——到账",
                @"1、姓名、身份证、手机服务密码不正确；\n2、使用非本人身份证申请；\n3、手机号使用时间不超过六个月；\n4、结清当天无法申请，第二天才可以再次申请。",
                @"还清当前欠款后，第二天即可再次申请，而且还款记录良好还可以提升额度。",
                @"申请借款并结清后，您就有机会提升额度了，录入您的常用银行卡请保持良好的还款记录哦。",
                @"审批时间：一般情况下审核需要2-3个工作日，借款高峰期审核时间可能增加。\n到账时间：一般审核通过后客户提款当天即刻到账，17:00后提款客户第二天到账。",
                @"如果借款申请审核未通过，如果您录入银行卡信息，还有机会再次审核，通过后即可提款。如果还是没有能通过审核，那么60天后即可再次进行申请。",
                @"1、中国银行\n2、中国工商银行\n3、中国农业银行\n4、中国建设银行\n5、中国光大银行\n6、兴业银行\n7、中信银行\n8、邮政储蓄",
                @"        如果借款人未能按期足额还款，除了偿还欠款，还应支付逾期罚息。每日收取当期应还本金的0.5%作为罚息，并支付10元/笔的滞纳金。 逾期超过15日，甲方仍未实际还款的，则每日收取当期应还本金的0.75%作为罚息。 逾期超过30日的，我方将强制借款人结清全部逾期金额及剩余本金。逾期超过30天执行强制结清还不能还款的，借款人会被拉入网站黑名单，并将该黑名单对第三方披露，并与任何第三方数据共享，由此造成借款人的损失，我司不承担法律责任。",
                @"        发薪贷遵守国家法律法规，对用户的隐私信息进行严格保护。发薪贷承诺绝不出售、出租或以任何其他形式泄漏发薪贷用户的信息，同时发薪贷会采取多种加密措施，防止任何人盗取用户信息。"];
    for(int i=0;i<dataArr.count;i++)
    {
        [isOpen addObject:[NSNumber numberWithBool:NO]];
    }
    self.helpTableView.delegate=self;
    self.helpTableView.dataSource=self;
    self.helpTableView.estimatedRowHeight=44.0;
    self.helpTableView.rowHeight=UITableViewAutomaticDimension;
    [self.helpTableView registerNib:[UINib nibWithNibName:@"HelpViewCell" bundle:nil] forCellReuseIdentifier:@"help"];
}


#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(![isOpen[section] boolValue])
    {
        return 0;
    }
    else
    {
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"help"];
    cell.lblContent.text=detailArr[indexPath.section];
    return  cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    HelpDetaliViewController *helpDetaiVC=[HelpDetaliViewController new];
//    helpDetaiVC.indexRow=indexPath.row;
//    
//    [self.navigationController pushViewController:helpDetaiVC animated:YES];
}
//创建按钮
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *Subview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    Subview.backgroundColor=[UIColor whiteColor];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(18, 0, Subview.frame.size.width-40, 50)];
    lbl.numberOfLines=0;
    lbl.text=dataArr[section];
    lbl.textColor=RGBColor(89, 87, 87, 1);
    
    lbl.numberOfLines=0;
    lbl.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(on_click:)];
    [Subview addGestureRecognizer:tap];
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 49.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineView.backgroundColor=RGBColor(180, 180, 181, 1);
    ;
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(_k_w-14-18,17, 14, 14)];
    BOOL b=[isOpen[section] boolValue];
    if(b)
    {
        imgView.image=[UIImage imageNamed:@"more-arrow-2"];
    }
    else
    {
        imgView.image=[UIImage imageNamed:@"more-arrow-3"];
    }
    Subview.tag=section+1;
    imgView.tag=section+1000;
    [Subview addSubview:lineView];
    [Subview addSubview:lbl];
    [Subview addSubview:imgView];
    return Subview;
}
-(void)on_click:(UITapGestureRecognizer *)tap
{
    //获取点击的那一段的展开状态
    BOOL b=[isOpen[[tap view].tag-1] boolValue];
    UIImageView *imgView=(UIImageView*)[self.view viewWithTag:[tap view].tag-1+1000];
    if(b)
    {
        imgView.image=[UIImage imageNamed:@"more-arrow-3"];
    }
    else
    {
        imgView.image=[UIImage imageNamed:@"more-arrow-2"];
    }
    //修改展开状态
    [isOpen replaceObjectAtIndex:[tap view].tag-1 withObject:[NSNumber numberWithBool:!b]];
    
    //刷新表格视图的某个分区
    //第一个参数是类似于 数组的一个集合
    [self.helpTableView reloadSections:[NSIndexSet indexSetWithIndex:[tap view].tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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
