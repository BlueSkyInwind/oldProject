//
//  SelectTableViewController.m
//  present
//
//  Created by dd on 16/5/20.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "SelectTableViewController.h"
#import "RepayMentAvailableRedpackets.h"
#import "UIViewController+KNSemiModal.h"
#import "RepayListInfo.h"

@interface SelectTableViewController ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation SelectTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.view.frame = CGRectMake(0, 0, 320, 200);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.index = -1;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)setData:(NSArray *)dataArr
{
    self.dataArr = dataArr;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _k_w, 60)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headView.frame.size.width, 59)];
    headView.backgroundColor = rgb(243, 243, 243);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"选择红包";
    [headView addSubview:label];
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:rgb(94, 94, 94) forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleCilck) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@50);
        make.left.equalTo(@8);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, _k_w, 1)];
    lineView.backgroundColor = rgba(214, 214, 214 ,0.5);
    [headView addSubview:lineView];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    RepayMentAvailableRedpackets *redPacket = [self.dataArr objectAtIndex:indexPath.row];
    Available_Redpackets *redPacket = [_dataArr objectAtIndex:indexPath.row];
    NSString *strValidPeriod = [redPacket.validity_period_to substringToIndex:10];
    cell.textLabel.text = [NSString stringWithFormat:@"红包%.2f元   有效期至:%@",redPacket.residual_amount,strValidPeriod];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (self.index >= 0 && indexPath.row == _index) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
    // Configure the cell...
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [tableView.visibleCells objectAtIndex:indexPath.row].accessoryType = UITableViewCellAccessoryCheckmark;
    self.index = indexPath.row;
    [self.tableView reloadData];
    [self.delegate selectIndex:indexPath.row];
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)cancleCilck
{
    [self dismissSemiModalView];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
