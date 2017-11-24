//
//  AgreeMentListViewController.m
//  fxdProduct
//
//  Created by dd on 2016/12/2.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "HG_ContractListVCModules.h"
#import "P2PAgreeMentModel.h"
#import "DetailViewController.h"
#import "LoanMoneyViewModel.h"
#import "P2PContactContentModel.h"
@interface HG_ContractListVCModules ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableview;

@end

NSString * const Identifier = @"cell";

@implementation HG_ContractListVCModules

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"合同列表";
    
    [self addBackItem];
    self.tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.agreeMentArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    Pact *pact = self.agreeMentArr[indexPath.row];
    cell.textLabel.text = pact.name_;
    cell.textLabel.font = [UIFont systemFontOfSize:15.f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Pact *pact = self.agreeMentArr[indexPath.row];
    
    LoanMoneyViewModel *loanMoneyViewModel = [[LoanMoneyViewModel alloc]init];
    [loanMoneyViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)returnValue error:nil];
        if ([baseResultM.flag isEqualToString:@"0000"]) {
            P2PContactContentModel * p2PContactConM = [[P2PContactContentModel alloc]initWithDictionary:(NSDictionary *)baseResultM.result error:nil];
            if ([p2PContactConM.appcode integerValue] == 1) {
                DetailViewController *detailVC = [[DetailViewController alloc] init];
                detailVC.content = p2PContactConM.content;
                detailVC.navTitle = pact.name_;
                [self.navigationController pushViewController:detailVC animated:true];
            } else {
                [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"获取失败"];
            }
        }
    } WithFaileBlock:^{
        
    }];
    
    if ([pact.status_ isEqualToString:@"1"]) {
        [loanMoneyViewModel getContactCon:pact.id_ Bid_id_:pact.bid_id_ Debt_id_:pact.debt_id_];
    }
    if ([pact.status_ isEqualToString:@"2"]) {
        [loanMoneyViewModel getContactCon:pact.id_ Bid_id_:pact.bid_id_ Debt_id_:pact.debt_id_];
    }
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
