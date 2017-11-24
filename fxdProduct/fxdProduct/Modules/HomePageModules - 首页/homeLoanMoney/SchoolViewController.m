//
//  SchoolViewController.m
//  fxdProduct
//
//  Created by dd on 15/12/15.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "SchoolViewController.h"
#import "AddressViewController.h"

@interface SchoolViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating>
{
    //table数据源
    NSMutableArray *_dataArr;
    
    //搜索控制器
    UISearchController *_searchControl;
    
    //保存搜索结果
    NSMutableArray *_resultArr;
}
@property (strong, nonatomic) IBOutlet UITableView *schoolTable;

@end

@implementation SchoolViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _resultArr = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    [self addBackItem];
    self.navigationItem.title = @"学校选择";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.schoolTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSDictionary *paraDic = @{@"token":[Utility sharedUtility].userInfo.tokenStr};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_schoolList_url] parameters:paraDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        NSData * data = [[object objectForKey:@"result"] dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for (NSDictionary *dic in jsonArr) {
            [_dataArr addObject:dic];
        }
        [self.schoolTable reloadData];
        
    } failure:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
    
    _searchControl = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    _searchControl.searchResultsUpdater = self;
    
    _searchControl.dimsBackgroundDuringPresentation = NO;
    _searchControl.hidesNavigationBarDuringPresentation = NO;
    _searchControl.searchBar.frame = CGRectMake(_searchControl.searchBar.frame.origin.x, _searchControl.searchBar.frame.origin.y, _searchControl.searchBar.frame.size.width, 44.0);
    self.schoolTable.tableHeaderView = _searchControl.searchBar;
    [_searchControl.searchBar sizeToFit];
    _searchControl.searchBar.placeholder = @"查找";
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_searchControl.active) {
        return _resultArr.count;
    } else {
        return _dataArr.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_searchControl.active) {
        return @"搜索结果";
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (_searchControl.active) {
        cell.textLabel.text = [[_resultArr objectAtIndex:indexPath.row] objectForKey:@"name"];
    } else {
        cell.textLabel.text = [[_dataArr objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_searchControl.active) {
        DLog(@"%@",[[_resultArr objectAtIndex:indexPath.row] objectForKey:@"name"]);
        [self.delegate setSelectSchool:[[_resultArr objectAtIndex:indexPath.row] objectForKey:@"name"]];
    } else {
        DLog(@"%@",[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"name"]);
        [self.delegate setSelectSchool:[[_dataArr objectAtIndex:indexPath.row] objectForKey:@"name"]];
    }
    [_searchControl.searchBar endEditing:YES];
    _searchControl.searchBar.hidden = YES;
    _searchControl.searchBar.text = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = _searchControl.searchBar.text;
    if (_resultArr != nil) {
        [_resultArr removeAllObjects];
    }
    
    if (![searchString isEqualToString:@""]) {
        NSDictionary *paramDci = @{@"token":[Utility sharedUtility].userInfo.tokenStr,
                                   @"name":searchString};
        [self.view endEditing:YES];
        [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_schoolList_url] parameters:paramDci finished:^(EnumServerStatus status, id object) {
            NSData * data = [[object objectForKey:@"result"] dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            for (NSDictionary *dic in jsonArr) {
                [_resultArr addObject:dic];
            }
            [self.schoolTable reloadData];
        } failure:^(EnumServerStatus status, id object) {
            
        }];
    }
    
    //过滤数据
    //    深度遍历数据源
    for (NSDictionary *dic in _dataArr) {
        NSRange range = [[dic objectForKey:@"name"] rangeOfString:searchString];
        if (range.length) {
            [_resultArr addObject:dic];
        }
    }
    [self.schoolTable reloadData];
}

#pragma mark - SearchBar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchControl.searchBar removeFromSuperview];
    _searchControl.active = NO;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
