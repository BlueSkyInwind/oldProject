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
#import "FindViewModel.h"
#import "HotRecommendModel.h"
#import "FXDWebViewController.h"
#import "CollectionViewModel.h"

@interface FXD_SuperLoanViewController ()<UITableViewDelegate,UITableViewDataSource,SuperLoanHeaderCellDelegate,SortViewDelegate,FilterViewDelegate,SuperLoanHeaderViewDelegate,SuperLoanCellDelegate>{
    
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
    NSString *_type;
    NSMutableArray *_hotDataArray;
    SuperLoanHeaderView *_headerView;
    NSMutableArray *_recentDataArray;

}

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation FXD_SuperLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    _dataArray = [NSMutableArray arrayWithCapacity:100];
    _hotDataArray = [NSMutableArray arrayWithCapacity:100];
    _recentDataArray = [NSMutableArray arrayWithCapacity:100];
    _type = @"1";
    [self createTab];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)createTab{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64-49) style:UITableViewStylePlain];
    [self.tableView registerClass:[SuperLoanCell class] forCellReuseIdentifier:@"SuperLoanCell"];
    [self.tableView registerClass:[SuperLoanHeaderCell class] forCellReuseIdentifier:@"SuperLoanHeaderCell"];
    [self.tableView registerClass:[SuperLoanNoneCell class] forCellReuseIdentifier:@"SuperLoanNoneCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = true;
    self.tableView.backgroundColor = rgb(242, 242, 242);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    _headerView = [[SuperLoanHeaderView alloc]init];
    _headerView.delegate = self;
    self.tableView.tableHeaderView = _headerView;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
//    [header beginRefreshing];
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

#pragma mark 最流浏览数据
-(void)getRecentData{
    
    FindViewModel *findVM = [[FindViewModel alloc]init];
    [findVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            [_recentDataArray removeAllObjects];
            NSArray * array = (NSArray *)baseResultM.data;
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                HotRecommendModel * model = [[HotRecommendModel alloc]initWithDictionary:dic error:nil];
                [_recentDataArray addObject:model];
            }
            
            _headerView.recentImageNameArray = _recentDataArray;
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    
    [findVM recent];
}

#pragma mark 热门推荐数据
-(void)hotRecommendData{
    
    FindViewModel *findVM = [[FindViewModel alloc]init];
    [findVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            [_hotDataArray removeAllObjects];
            NSArray * array = (NSArray *)baseResultM.data;
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                HotRecommendModel * model = [[HotRecommendModel alloc]initWithDictionary:dic error:nil];
                [_hotDataArray addObject:model];
            }
            
            _headerView.hotImageNameArray = _hotDataArray;
            
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    
    [findVM hotRecommend];
}

-(void)headerRefreshing{
    
    _pages = 0;
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:[NSString stringWithFormat:@"%d",_pages] order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
}

-(void)footerRereshing{
    
    _pages++;
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_maxDays offset:[NSString stringWithFormat:@"%d",_pages] order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if (_filterView) {
        [_filterView removeFromSuperview];
    }
    if (_sortView) {
        [_sortView removeFromSuperview];
    }
    
    _superLoanHeaderCell.sortBtn.selected = NO;
    _superLoanHeaderCell.sortImageBtn.selected = NO;
    [_superLoanHeaderCell.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    [_superLoanHeaderCell.sortImageBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
    
    _superLoanHeaderCell.filterBtn.selected = NO;
    _superLoanHeaderCell.filterImageBtn.selected = NO;
    [_superLoanHeaderCell.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    [_superLoanHeaderCell.filterImageBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
    
    [self getRecentData];
    
    [self hotRecommendData];
    
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:[NSString stringWithFormat:@"%d",_pages] order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
}

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
            
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
    [viewModel compQueryLimit:@"15" maxAmount:maxAmount maxDays:maxDays minAmount:minAmount minDays:minDays offset:offset order:order sort:sort moduleType:_type];

}
#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_dataArray.count > 0) {
        
        return _dataArray.count + 1;
    }
    
    return  2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }
    
    if (_dataArray.count <= 0) {
        
        return _k_h - 215 - 80 - 64 - 49;
    }
    if ([_type isEqualToString:@"1"]) {
        
        return 110;
    }
    return 75;
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
    
    if (_dataArray.count <= 0) {
        
        SuperLoanNoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperLoanNoneCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selected = NO;
        return cell;
    }
    
    SuperLoanCell *superLoanCell = [tableView dequeueReusableCellWithIdentifier:@"SuperLoanCell"];
    [superLoanCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    superLoanCell.backgroundColor = [UIColor whiteColor];
    superLoanCell.selected = NO;
    superLoanCell.delegate = self;
    superLoanCell.type = _type;
    
    RowsModel *model = _dataArray[indexPath.row-1];
    [superLoanCell.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.plantLogo] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRefreshCached];
    superLoanCell.titleLabel.text = model.plantName;

    NSString *maximumAmount = model.maximumAmount != nil?model.maximumAmount:@"";
    superLoanCell.qutaLabel.text = [NSString stringWithFormat:@"额度:最高%@%@",maximumAmount,model.maximumAmountUnit];
    NSString *term = model.unitStr != nil?model.unitStr:@"";
    superLoanCell.termLabel.text = [NSString stringWithFormat:@"期限:%@",term];
    if (![term isEqualToString:@""]) {
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:superLoanCell.termLabel.text];
        [attriStr addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3,attriStr.length-4)];
        superLoanCell.termLabel.attributedText = attriStr;
    }
    
    NSString *referenceRate = model.referenceRate != nil?model.referenceRate:@"";
    superLoanCell.feeLabel.text = [NSString stringWithFormat:@"费用:%%%@/%@",referenceRate,[self rateUnit: model.referenceMode]];
    
    if (![referenceRate isEqualToString:@""]) {
        NSMutableAttributedString *attriStr1 = [[NSMutableAttributedString alloc] initWithString:superLoanCell.feeLabel.text];
        [attriStr1 addAttribute:NSForegroundColorAttributeName value:UI_MAIN_COLOR range:NSMakeRange(3,attriStr1.length-4)];
        superLoanCell.feeLabel.attributedText = attriStr1;
    }
    [superLoanCell.descBtn setTitle:model.platformIntroduction forState:UIControlStateNormal];
    
    [superLoanCell.descBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    superLoanCell.descBtn.layer.borderColor = [UIColor purpleColor].CGColor;
    NSDictionary *dic = @{NSFontAttributeName : [UIFont yx_systemFontOfSize:12]};
    CGFloat width = [model.platformIntroduction boundingRectWithSize:CGSizeMake(_k_h, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width + 20;
    
    [superLoanCell.descBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:width]);
    }];
    if (indexPath.row % 2 == 0){
        
        [superLoanCell.descBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        superLoanCell.descBtn.layer.borderColor = [UIColor blueColor].CGColor;
    }
    
    superLoanCell.collectionBtn.tag = indexPath.row - 1;
    [superLoanCell.collectionBtn setImage:[UIImage imageNamed:@"collection_icon"] forState:UIControlStateNormal];
    if ([model.isCollect isEqualToString:@"0"]) {
        [superLoanCell.collectionBtn setImage:[UIImage imageNamed:@"collection_selected_icon"] forState:UIControlStateNormal];
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
    
    if (_superLoanHeaderCell.filterBtn.selected || _superLoanHeaderCell.filterImageBtn.selected) {
        
        _superLoanHeaderCell.filterBtn.selected = NO;
        _superLoanHeaderCell.filterImageBtn.selected = NO;
        [_superLoanHeaderCell.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
        [_superLoanHeaderCell.filterImageBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
    }
    
    _superLoanHeaderCell.sortBtn.selected = !_superLoanHeaderCell.sortBtn.selected;
    _superLoanHeaderCell.sortImageBtn.selected = !_superLoanHeaderCell.sortImageBtn.selected;

    if (_superLoanHeaderCell.sortBtn.selected || _superLoanHeaderCell.sortImageBtn.selected) {
        
        [_superLoanHeaderCell.sortBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
        [_superLoanHeaderCell.sortImageBtn setImage:[UIImage imageNamed:@"sort_selected_icon"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:1 animations:^{
            _sortView = [[SortView alloc]initWithFrame:CGRectMake(0, 360-self.tableView.contentOffset.y, _k_w, _k_h)];
            _sortView.delegate = self;
            _sortView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
            _sortView.index = _index;
            [self.view addSubview:_sortView];
            self.tableView.scrollEnabled = false;
        }];
        
    }else{
        
        [_superLoanHeaderCell.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
        [_superLoanHeaderCell.sortImageBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            [_sortView removeFromSuperview];
            self.tableView.scrollEnabled = true;
            
        }];
    }
}


-(void)filterBtnClick:(UIButton *)sender{
    
    if (_sortView) {
        [_sortView removeFromSuperview];
    }
    
    if (_superLoanHeaderCell.sortBtn.selected || _superLoanHeaderCell.sortImageBtn.selected) {
        
        _superLoanHeaderCell.sortBtn.selected = NO;
        _superLoanHeaderCell.sortImageBtn.selected = NO;
        [_superLoanHeaderCell.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
        [_superLoanHeaderCell.sortImageBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
        
    }
    
    _superLoanHeaderCell.filterBtn.selected = !_superLoanHeaderCell.filterBtn.selected;
    _superLoanHeaderCell.filterImageBtn.selected = !_superLoanHeaderCell.filterImageBtn.selected;

    if (_superLoanHeaderCell.filterBtn.selected || _superLoanHeaderCell.filterImageBtn.selected) {
        
        [_superLoanHeaderCell.filterBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
        [_superLoanHeaderCell.filterImageBtn setImage:[UIImage imageNamed:@"filter_selected_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            _filterView = [[FilterView alloc]initWithFrame:CGRectMake(0, 360-self.tableView.contentOffset.y, _k_w, _k_h)];
            _filterView.delegate = self;
            _filterView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
            [self.view addSubview:_filterView];
            self.tableView.scrollEnabled = false;
        }];
        
    }else{
        
        [_superLoanHeaderCell.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
        [_superLoanHeaderCell.filterImageBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            [_filterView removeFromSuperview];
            self.tableView.scrollEnabled = true;
            
        }];
    }
}

-(void)tabBtnClick:(UIButton *)sender{
    
    NSInteger tag = sender.tag;
    _type = [NSString stringWithFormat:@"%ld",tag - 100];
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:[NSString stringWithFormat:@"%d",_pages] order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
//    [_tableView reloadData];
    switch (tag) {
        case 101:
            [_superLoanHeaderCell.loanBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
            [_superLoanHeaderCell.gameBtn setTitleColor:rgb(25.5, 25.5, 25.5) forState:UIControlStateNormal];
            [_superLoanHeaderCell.tourismBtn setTitleColor:rgb(25.5, 25.5, 25.5) forState:UIControlStateNormal];
//            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"贷款"];
            break;
        case 102:
            [_superLoanHeaderCell.loanBtn setTitleColor:rgb(25.5, 25.5, 25.5) forState:UIControlStateNormal];
            [_superLoanHeaderCell.gameBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
            [_superLoanHeaderCell.tourismBtn setTitleColor:rgb(25.5, 25.5, 25.5) forState:UIControlStateNormal];
//            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"游戏"];
            break;
        case 103:
            [_superLoanHeaderCell.loanBtn setTitleColor:rgb(25.5, 25.5, 25.5) forState:UIControlStateNormal];
            [_superLoanHeaderCell.gameBtn setTitleColor:rgb(25.5, 25.5, 25.5) forState:UIControlStateNormal];
            [_superLoanHeaderCell.tourismBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
//            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"旅游"];
            break;
        default:
            break;
    }
}

-(void)sortTabSelected:(NSInteger)selectedIndex{
    
    _index = selectedIndex;
    
    [_superLoanHeaderCell.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    [_superLoanHeaderCell.sortImageBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
    _superLoanHeaderCell.sortBtn.selected = NO;
    _superLoanHeaderCell.sortImageBtn.selected = NO;
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:@"0" order:@"ASC" sort:[NSString stringWithFormat:@"%ld",selectedIndex]];
    [UIView animateWithDuration:1 animations:^{
        [_sortView removeFromSuperview];
        
    }];
}

-(void)sureBtnClick:(NSString *)minLoanMoney maxLoanMoney:(NSString *)maxLoanMoney minLoanPeriod:(NSString *)minLoanPeriod maxLoanPeriod:(NSString *)maxLoanPeriod{
    
    
    [_superLoanHeaderCell.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    [_superLoanHeaderCell.filterImageBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
    _superLoanHeaderCell.filterBtn.selected = NO;
    _superLoanHeaderCell.filterImageBtn.selected = NO;
    
//    NSLog(@"%@==%@==%@==%@==",minLoanMoney,maxLoanMoney,minLoanPeriod,maxLoanPeriod);
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


-(void)hotBtnClick:(UIButton *)sender{
    
    NSInteger tag = sender.tag;
    HotRecommendModel *model = _hotDataArray[tag - 101];
    FXDWebViewController *webView = [[FXDWebViewController alloc]init];
    webView.urlStr = model.linkAddress;
    [self.navigationController pushViewController:webView animated:true];

}

-(void)recentBtnClcik:(UIButton *)sender{
    
    NSInteger tag = sender.tag;
    if (((_recentDataArray.count - 1) == (tag - 101)) && _recentDataArray.count > 0) {
        
        HotRecommendModel *model = _recentDataArray[tag - 101];
        FXDWebViewController *webView = [[FXDWebViewController alloc]init];
        webView.urlStr = model.linkAddress;
        [self.navigationController pushViewController:webView animated:true];
    }
    
//    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:[NSString stringWithFormat:@"最近使用第%ld个按钮",tag]];
}

-(void)moreBtnClcik{
    
    RecentViewController *controller = [[RecentViewController alloc]init];
    controller.dataArray = _recentDataArray;
    [self.navigationController pushViewController:controller animated:true];
//    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"更多按钮"];
}

-(void)collectionBtn:(UIButton *)sender{
    
//    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:[NSString stringWithFormat:@"%ld",sender.tag]];
    RowsModel *model = _dataArray[sender.tag];

    CollectionViewModel *collectionVM = [[CollectionViewModel alloc]init];
    [collectionVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:@"0" order:@"ASC" sort:[NSString stringWithFormat:@"%ld",_index]];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
        
    } WithFaileBlock:^{
        
    }];
    
    [collectionVM addMyCollectionInfocollectionType:_type platformId:model.id_];

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
