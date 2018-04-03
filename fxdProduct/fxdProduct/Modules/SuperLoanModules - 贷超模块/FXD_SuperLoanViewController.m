//
//  FXD_SuperLoanViewController.m
//  fxdProduct
//
//  Created by sxp on 2018/3/27.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "FXD_SuperLoanViewController.h"
#import "CompQueryViewModel.h"
#import "CompQueryModel.h"
@interface FXD_SuperLoanViewController ()<UITableViewDelegate,UITableViewDataSource,SuperLoanHeaderCellDelegate,SortViewDelegate,FilterViewDelegate>{
    
    SuperLoanHeaderCell *_superLoanHeaderCell;
    SortView *_sortView;
    FilterView *_filterView;
    NSInteger _index;
    NSMutableArray *_dataArray;
    int  _pages;
    NSString *_maxAmount;
    NSString *_maxDays;
    NSString *_minAmount;
    NSString *_minDays;
}

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation FXD_SuperLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    _dataArray = [NSMutableArray arrayWithCapacity:100];
    
    [self createTab];
    
    // Do any additional setup after loading the view.
}

-(void)createTab{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64-49) style:UITableViewStylePlain];
    [self.tableView registerClass:[SuperLoanCell class] forCellReuseIdentifier:@"SuperLoanCell"];
    [self.tableView registerClass:[SuperLoanHeaderCell class] forCellReuseIdentifier:@"SuperLoanHeaderCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = true;
    self.tableView.backgroundColor = rgb(250, 250, 250);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    footer.automaticallyChangeAlpha = YES;
    footer.mj_origin = CGPointMake(0, _k_h);
    self.tableView.mj_footer = footer;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(BarHeightNew - 64, 0, 0, 0);
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
}


-(void)headerRefreshing{
    
    _pages = 0;
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:[NSString stringWithFormat:@"%d",_pages] order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
}

-(void)footerRereshing{
    
    _pages++;
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_maxDays offset:[NSString stringWithFormat:@"%d",_pages] order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
}
//-(void)viewWillAppear:(BOOL)animated{
//
//    [super viewWillAppear:animated];
//    [self getDataMaxAmount:@"10000" maxDays:@"25" minAmount:@"100" minDays:@"3" offset:@"0" order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
//}

-(void)getDataMaxAmount:(NSString *)maxAmount maxDays:(NSString *)maxDays minAmount:(NSString *)minAmount minDays:(NSString *)minDays offset:(NSString *)offset order:(NSString *)order sort:(NSString *)sort{
    
    CompQueryViewModel *viewModel = [[CompQueryViewModel alloc]init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if (_pages == 0) {
            [_dataArray removeAllObjects];
        }
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
//            [_dataArray removeAllObjects];
            CompQueryModel *model = [[CompQueryModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            for (RowsModel *rowModel in model.rows) {
                [_dataArray addObject:rowModel];
            }
            
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            [_tableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    
    [viewModel compQueryLimit:@"15" maxAmount:maxAmount maxDays:maxDays minAmount:minAmount minDays:minDays offset:offset order:order sort:sort];
}
#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        _superLoanHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"SuperLoanHeaderCell"];
        _superLoanHeaderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _superLoanHeaderCell.backgroundColor = rgb(242, 242, 242);
        _superLoanHeaderCell.selected = NO;
        _superLoanHeaderCell.delegate = self;
        return _superLoanHeaderCell;
        
    }
    
    SuperLoanCell *superLoanCell = [tableView dequeueReusableCellWithIdentifier:@"SuperLoanCell"];
    [superLoanCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    superLoanCell.backgroundColor = rgb(242, 242, 242);
    superLoanCell.selected = NO;
    
    RowsModel *model = _dataArray[indexPath.row-1];
    [superLoanCell.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.plantLogo] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRefreshCached];
    superLoanCell.titleLabel.text = model.plantName;
    superLoanCell.qutaLabel.text = [NSString stringWithFormat:@"额度:最高%@%@",model.maximumAmount,model.maximumAmountUnit];
    
    superLoanCell.termLabel.text = [NSString stringWithFormat:@"期限:%@",model.unitStr];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:superLoanCell.termLabel.text];
    [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3,attriStr.length-4)];
    superLoanCell.termLabel.attributedText = attriStr;
    
    superLoanCell.feeLabel.text = [NSString stringWithFormat:@"费用:%%%@/%@",model.referenceRate,[self rateUnit: model.referenceMode]];
    NSMutableAttributedString *attriStr1 = [[NSMutableAttributedString alloc] initWithString:superLoanCell.feeLabel.text];
    [attriStr1 addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3,attriStr1.length-4)];
    superLoanCell.feeLabel.attributedText = attriStr1;
    
    [superLoanCell.descBtn setTitle:model.platformIntroduction forState:UIControlStateNormal];
    
    [superLoanCell.descBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    superLoanCell.descBtn.layer.borderColor = [UIColor purpleColor].CGColor;
    if (indexPath.row % 2 == 0){
        
        [superLoanCell.descBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        superLoanCell.descBtn.layer.borderColor = [UIColor blueColor].CGColor;
    }
    
    return superLoanCell;
    
}

-(NSString *)rateUnit:(NSString *)referenceMode{
    
    switch (referenceMode.integerValue) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"月";
            break;
        case 3:
            return @"年";
            break;
            
        default:
            break;
    }
    
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.row == 0) {
        return;
    }
    RowsModel *model = _dataArray[indexPath.row-1];
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
    [viewModel getCompLinkThirdPlatformId:third_platform_id];
}
-(void)sortBtnClick:(UIButton *)sender{
    
    if (_filterView) {
        [_filterView removeFromSuperview];
    }
    
    if (_superLoanHeaderCell.filterBtn.selected) {
        
        _superLoanHeaderCell.filterBtn.selected = NO;
        _superLoanHeaderCell.filterLabel.textColor = rgb(77, 77, 77);
        [_superLoanHeaderCell.filterBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        _superLoanHeaderCell.sortLabel.textColor = UI_MAIN_COLOR;
        [sender setImage:[UIImage imageNamed:@"sort_selected_icon"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:1 animations:^{
            _sortView = [[SortView alloc]init];
            _sortView.delegate = self;
            _sortView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
            _sortView.index = _index;
            [self.view addSubview:_sortView];
        }];
        
    }else{
        _superLoanHeaderCell.sortLabel.textColor = rgb(77, 77, 77);
        [sender setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            [_sortView removeFromSuperview];
            
        }];
    }
}


-(void)filterBtnClick:(UIButton *)sender{
    
    if (_sortView) {
        [_sortView removeFromSuperview];
    }
    
    if (_superLoanHeaderCell.sortBtn.selected) {
        
        _superLoanHeaderCell.sortBtn.selected = NO;
        _superLoanHeaderCell.sortLabel.textColor = rgb(77, 77, 77);
        [_superLoanHeaderCell.sortBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
        
    }
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        _superLoanHeaderCell.filterLabel.textColor = UI_MAIN_COLOR;
        [sender setImage:[UIImage imageNamed:@"filter_selected_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            _filterView = [[FilterView alloc]init];
            _filterView.delegate = self;
            _filterView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
            [self.view addSubview:_filterView];
        }];
        
    }else{
        _superLoanHeaderCell.filterLabel.textColor = rgb(77, 77, 77);
        [sender setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            [_filterView removeFromSuperview];
            
        }];
    }
}

-(void)sortTabSelected:(NSInteger)selectedIndex{
    
    _index = selectedIndex;
    
    _superLoanHeaderCell.sortLabel.textColor = rgb(77, 77, 77);
    [_superLoanHeaderCell.sortBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
    _superLoanHeaderCell.sortBtn.selected = NO;
    [self getDataMaxAmount:@"10000" maxDays:@"25" minAmount:@"100" minDays:@"3" offset:@"0" order:@"ASC" sort:[NSString stringWithFormat:@"%ld",selectedIndex]];
    [UIView animateWithDuration:1 animations:^{
        [_sortView removeFromSuperview];
        
    }];
}

-(void)sureBtnClick:(NSString *)minLoanMoney maxLoanMoney:(NSString *)maxLoanMoney minLoanPeriod:(NSString *)minLoanPeriod maxLoanPeriod:(NSString *)maxLoanPeriod{
    
    _superLoanHeaderCell.filterLabel.textColor = rgb(77, 77, 77);
    [_superLoanHeaderCell.filterBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
    _superLoanHeaderCell.filterBtn.selected = NO;
    
    NSLog(@"%@==%@==%@==%@==",minLoanMoney,maxLoanMoney,minLoanPeriod,maxLoanPeriod);
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
    
    [self getDataMaxAmount:maxLoanMoney maxDays:maxLoanPeriod minAmount:minLoanMoney minDays:minLoanPeriod offset:@"0" order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
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
