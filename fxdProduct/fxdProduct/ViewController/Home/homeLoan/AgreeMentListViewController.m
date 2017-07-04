//
//  AgreeMentListViewController.m
//  fxdProduct
//
//  Created by dd on 2016/12/2.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "AgreeMentListViewController.h"
#import "P2PAgreeMentModel.h"
#import "DetailViewController.h"

@interface AgreeMentListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableview;

@end

NSString * const Identifier = @"cell";

@implementation AgreeMentListViewController

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
    NSDictionary *paramDic;
    if ([pact.status_ isEqualToString:@"1"]) {
        paramDic = @{@"pact_no_":pact.id_,
                     @"bid_id_":pact.bid_id_,
                     @"status_":@"2"};
    }
    if ([pact.status_ isEqualToString:@"2"]) {
        paramDic = @{@"pact_no_":pact.id_,
                     @"debt_id_":pact.debt_id_,
                     @"status_":@"2"};
    }
   
    [[FXDNetWorkManager sharedNetWorkManager] P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_contractStr_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        if ([[object objectForKey:@"appcode"] isEqualToString:@"1"]) {
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            detailVC.content = [[object objectForKey:@"data"] objectForKey:@"content"];
            detailVC.navTitle = pact.name_;
            [self.navigationController pushViewController:detailVC animated:true];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"获取失败"];
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
