//
//  AddDetailViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/12/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "AddDetailViewController.h"

@interface AddDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSArray *_cityArray;
    NSArray *_selectArray;
    NSArray *_subPickerArray;
    NSArray *_thirdPickeArray;
    
    UITableView *_tableView;
    UITableView *_tableView1;
    UITableView *_tableView2;
    NSDictionary *_dictory;
    UIScrollView *_scrollview;
    NSString *_cityString;
    NSString *_cityTwoString;

}

@end

@implementation AddDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"选择单位地址";
    [self createJSon];
}

-(void)createJSon{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
//    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    _dictory = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    _cityArray = [_dictory allKeys];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

#pragma ->UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return _cityArray.count;

    }
    if (tableView == _tableView1) {
        return _subPickerArray.count;
    }
    if (tableView == _tableView2) {
        return _thirdPickeArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        static NSString *indexcell= @"celll";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: indexcell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexcell];
        }
        cell.textLabel.text = [_cityArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (tableView == _tableView1) {
        static NSString *indexcell= @"twocelll";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: indexcell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexcell];
        }
        cell.textLabel.text = [_subPickerArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }
    if (tableView == _tableView2) {
        static NSString *indexcell= @"ttwocelll";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: indexcell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indexcell];
        }
        cell.textLabel.text = [_thirdPickeArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        
        if (!_scrollview) {
            _scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(_k_w/4, 64, (_k_w/4*3), _k_h-64)];
            
        }
        
        [self.view addSubview:_scrollview];
        _scrollview.delegate=self;
        _scrollview.contentSize=CGSizeMake((_k_w/4*3)*2, _k_h-64);
        _scrollview.contentOffset=CGPointMake(_k_w/4*3, 0);
        _scrollview.bounces=NO;
        _scrollview.backgroundColor=[UIColor clearColor];
        _cityString = [_cityArray objectAtIndex:indexPath.row];
        _selectArray = [_dictory objectForKey:[[_dictory allKeys] objectAtIndex:indexPath.row]];
        if ([_selectArray count]>0) {
            _subPickerArray = [[_selectArray objectAtIndex:0] allKeys];
        }
        if (_tableView1) {
            [_tableView1 removeFromSuperview];
        }
        if (!_tableView1) {
            _tableView1 =[[UITableView alloc] initWithFrame:CGRectMake(_k_w/4*3, 0, _k_w/4*3, _k_h-64) style:UITableViewStyleGrouped];
        }
        _tableView1.frame=CGRectMake(_k_w/4*3, 0, _k_w/4*3, _k_h-64);
//        _tableView1.backgroundColor=[UIColor grayColor];
        _tableView1.delegate=self;
        _tableView1.dataSource=self;
        [_scrollview addSubview:_tableView1];
        [_tableView1 reloadData];
    }
    if (tableView == _tableView1) {
        if ([_subPickerArray count]>0) {
            _cityTwoString = [_subPickerArray objectAtIndex:indexPath.row];
            _thirdPickeArray = [[_selectArray objectAtIndex:0] objectForKey:[_subPickerArray objectAtIndex:indexPath.row]];
        }
        if (!_tableView2) {
            _tableView2 =[[UITableView alloc] initWithFrame:CGRectMake(_k_w/4*3+100, 0, _k_w-_k_w/4-100, _k_h-64) style:UITableViewStyleGrouped];
        }
        _tableView2.frame=CGRectMake(_k_w/4*3+100, 0, _k_w/4*3, _k_h-64);
        _tableView2.delegate=self;
        _tableView2.dataSource=self;
        [_scrollview addSubview:_tableView2];
        [_tableView2 reloadData];
    }
    if (tableView == _tableView2) {
        if ([self.delegate respondsToSelector:@selector(setMultible:andshi:andQu:)]) {
            [self.delegate setMultible:_cityString andshi:_cityTwoString andQu:[_thirdPickeArray objectAtIndex:indexPath.row]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return @"选择省";
    }
    if(tableView == _tableView1)
    {
        return @"选择市";
    }
    if (tableView == _tableView2) {
        return @"选择区";
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(_tableView == tableView)
    return 30;
    if(_tableView1 == tableView)
        return 30;
    if(_tableView2 == tableView)
        return 30;
    return 1;
}

#pragma ->UIscroViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //    NSLog(@"y=%f",scrollView.contentOffset.y);
    CGFloat x=scrollView.contentOffset.x;
    //    NSLog(@"x=%f",x);
    //    NSLog(@"%f",scrollView.contentOffset.y);
    
    if (x<40 && x>0) {
        
        [self.view bringSubviewToFront:_tableView];
    }
}



//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
