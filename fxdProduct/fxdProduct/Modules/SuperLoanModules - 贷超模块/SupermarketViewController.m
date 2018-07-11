//
//  SupermarketViewController.m
//  fxdProduct
//
//  Created by sxp on 2018/5/25.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "SupermarketViewController.h"

@interface SupermarketViewController ()<UITableViewDelegate,UITableViewDataSource,SupermarketHeaderViewDelegate,SortViewDelegate,FilterViewDelegate>

{
    
    UITableView *_tableView;
    //最大金额
    NSString *_maxAmount;
    //最大周期
    NSString *_maxDays;
    //最小金额
    NSString *_minAmount;
    //最小周期
    NSString *_minDays;
    //排序view
    SortView *_sortView;
    //筛选view
    FilterView *_filterView;
    //头部视图
    SupermarketHeaderView *_headerView;
    //降序、升序
    NSString *_order;
    //排序选择标识
    NSInteger _index;
    //数据
    NSMutableArray *_dataArray;
    
}
@end

@implementation SupermarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgb(242, 242, 242);
    _order = @"ASC";
    _dataArray = [NSMutableArray arrayWithCapacity:100];
    self.view.userInteractionEnabled = true;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:isSuperMark object:nil];
    [self getData];
    [self addHeaderView];
    [self createTab];
}

#pragma mark 添加头部视图
-(void)addHeaderView{
    
    if (UI_IS_IPHONEX) {
        
        _headerView = [[SupermarketHeaderView alloc]initWithFrame:CGRectMake(0, 84, _k_w, 45)];
        
    }else{
        _headerView = [[SupermarketHeaderView alloc]initWithFrame:CGRectMake(0, 64, _k_w, 45)];
    }
    _headerView.delegate = self;
    [self.view addSubview:_headerView];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (_filterView) {
        [_filterView removeFromSuperview];
    }
    if (_sortView) {
        [_sortView removeFromSuperview];
    }

    _headerView.sortBtn.selected = NO;
    _headerView.sortImageBtn.selected = NO;
    [_headerView.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];

    _headerView.filterBtn.selected = NO;
    _headerView.filterImageBtn.selected = NO;
    [_headerView.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];

}

-(void)getData{
    
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",_index]];
}
#pragma mark 获取数据
-(void)getDataMaxAmount:(NSString *)maxAmount maxDays:(NSString *)maxDays minAmount:(NSString *)minAmount minDays:(NSString *)minDays offset:(NSString *)offset order:(NSString *)order sort:(NSString *)sort{
    
    CompQueryViewModel *viewModel = [[CompQueryViewModel alloc]init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            [_dataArray removeAllObjects];
            CompQueryModel *model = [[CompQueryModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            for (RowsModel *rowModel in model.rows) {
                [_dataArray addObject:rowModel];
            }

            _tableView.scrollEnabled = true;
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            
        }else{

            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{

    }];
    
    [viewModel compQueryLimit:@"100" maxAmount:maxAmount maxDays:maxDays minAmount:minAmount minDays:minDays offset:offset order:order sort:sort moduleType:@"1" location:@"5"];
    
}


-(void)createTab{
    
    if (UI_IS_IPHONEX) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h-170) style:UITableViewStylePlain];
    }else{
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h-49-64) style:UITableViewStylePlain];
    }
    
    [_tableView registerClass:[SupermarketTabCell class] forCellReuseIdentifier:@"SupermarketTabCell"];
    [_tableView registerClass:[SuperLoanNoneCell class] forCellReuseIdentifier:@"SuperLoanNoneCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = true;
    _tableView.backgroundColor = rgb(242, 242, 242);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataArray.count <= 0) {
        
        return _k_h - 215 - 80 - 64 - 49;
    }
    
    return 119;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count <= 0) {
        
        SuperLoanNoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperLoanNoneCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selected = NO;
        return cell;
    }
    
    SupermarketTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupermarketTabCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = rgb(242, 242, 242);;
    cell.selected = NO;
    
    RowsModel *model = _dataArray[indexPath.section];

    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.plantLogo] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRetryFailed];
    cell.nameLabel.text = model.plantName;
    cell.downloadsLabel.text = model.applicantsCount;
    cell.quotaLabel.text = [NSString stringWithFormat:@"%@%@",model.maximumAmount,model.maximumAmountUnit];
    if ([model.maximumAmountUnit isEqualToString:@"万元"]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:cell.quotaLabel.text];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(attriStr.length -2,2)];
        cell.quotaLabel.attributedText = attriStr;
    }else{
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:cell.quotaLabel.text];
        [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(attriStr.length -1,1)];
        cell.quotaLabel.attributedText = attriStr;
    }

    cell.termLabel.text = model.unitStr;
    cell.descLabel.text = model.platformIntroduction;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    RowsModel *model = _dataArray[indexPath.section];
    [self getCompLinkThirdPlatformId: model.id_];
}

-(void)getCompLinkThirdPlatformId:(NSString *)third_platform_id{
    
    CompQueryViewModel *viewModel = [[CompQueryViewModel alloc]init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            NSDictionary * dic =  (NSDictionary *)baseResultM.data;
            if ([dic.allKeys containsObject:@"url"]) {
                NSString *linkUrl = dic[@"url"];
                FXDWebViewController *controller = [[FXDWebViewController alloc]init];
                controller.urlStr = linkUrl;
                [self.navigationController pushViewController:controller animated:true];
            }
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message: baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [viewModel getCompLinkThirdPlatformId:third_platform_id location:@"5"];
}

#pragma mark 排序
-(void)sortBtnClick:(UIButton *)sender{

    if (_filterView) {
        [_filterView removeFromSuperview];
    }

    if (_headerView.filterBtn.selected || _headerView.filterImageBtn.selected) {

        _headerView.filterBtn.selected = NO;
        _headerView.filterImageBtn.selected = NO;
        [_headerView.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    }

    _headerView.sortBtn.selected = !_headerView.sortBtn.selected;
    _headerView.sortImageBtn.selected = !_headerView.sortImageBtn.selected;

    if (_headerView.sortBtn.selected || _headerView.sortImageBtn.selected) {

        [_headerView.sortBtn setTitleColor:rgb(75, 135, 233) forState:UIControlStateNormal];

        [UIView animateWithDuration:1 animations:^{
            if (UI_IS_IPHONEX) {
                _sortView = [[SortView alloc]initWithFrame:CGRectMake(0, 140, _k_w, _k_h)];
            }else{
                _sortView = [[SortView alloc]initWithFrame:CGRectMake(0, 110, _k_w, _k_h)];
            }
            
            _sortView.delegate = self;
            _sortView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
            _sortView.index = _index;
            [self.view addSubview:_sortView];
            _tableView.scrollEnabled = true;
        }];

    }else{

        [_headerView.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            [_sortView removeFromSuperview];
            _tableView.scrollEnabled = true;

        }];
    }
}

#pragma mark 筛选
-(void)filterBtnClick:(UIButton *)sender{

    if (_sortView) {
        [_sortView removeFromSuperview];
    }

    if (_headerView.sortBtn.selected || _headerView.sortImageBtn.selected) {

        _headerView.sortBtn.selected = NO;
        _headerView.sortImageBtn.selected = NO;
        [_headerView.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];

    }

    _headerView.filterBtn.selected = !_headerView.filterBtn.selected;
    _headerView.filterImageBtn.selected = !_headerView.filterImageBtn.selected;

    if (_headerView.filterBtn.selected || _headerView.filterImageBtn.selected) {

        [_headerView.filterBtn setTitleColor:rgb(75, 135, 233) forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            
            if (UI_IS_IPHONEX) {
                _filterView = [[FilterView alloc]initWithFrame:CGRectMake(0, 140, _k_w, _k_h)];
            }else{
                _filterView = [[FilterView alloc]initWithFrame:CGRectMake(0, 110, _k_w, _k_h)];
            }
            
            _filterView.delegate = self;
            _filterView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
            [self.view addSubview:_filterView];
            _tableView.scrollEnabled = true;
        }];

    }else{

        [_headerView.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            [_filterView removeFromSuperview];
            _tableView.scrollEnabled = true;

        }];
    }
}


-(void)sortTabSelected:(NSInteger)selectedIndex{

    _index = selectedIndex;
    switch (_index) {
        case 0:
        case 2:
        case 3:
            _order = @"ASC";
            break;
        case 1:
            _order = @"DESC";
            break;
        default:
            break;
    }

    [_headerView.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    _headerView.sortBtn.selected = NO;
    _headerView.sortImageBtn.selected = NO;
    [self getDataMaxAmount:@"" maxDays:@"" minAmount:@"" minDays:@"" offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",selectedIndex]];
    [UIView animateWithDuration:1 animations:^{
        [_sortView removeFromSuperview];

    }];
}


#pragma mark 筛选确认按钮
-(void)sureBtnClick:(NSString *)minLoanMoney maxLoanMoney:(NSString *)maxLoanMoney minLoanPeriod:(NSString *)minLoanPeriod maxLoanPeriod:(NSString *)maxLoanPeriod{

    _order = @"ASC";
    [_headerView.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    _headerView.filterBtn.selected = NO;
    _headerView.filterImageBtn.selected = NO;

    if (maxLoanMoney.integerValue < minLoanMoney.integerValue) {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"借款金额输入不合法"];
        return;
    }

    if (maxLoanPeriod.integerValue < minLoanPeriod.integerValue) {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"借款周期输入不合法"];
        return;
    }

    _maxAmount = maxLoanMoney;
    _maxDays = maxLoanPeriod;
    _minAmount = minLoanMoney;
    _minDays = minLoanPeriod;

    [self getDataMaxAmount:maxLoanMoney maxDays:maxLoanPeriod minAmount:minLoanMoney minDays:minLoanPeriod offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",_index]];
    [UIView animateWithDuration:1 animations:^{

        [_filterView removeFromSuperview];

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
