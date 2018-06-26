//
//  SupermarketViewController.m
//  fxdProduct
//
//  Created by sxp on 2018/5/25.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "SupermarketViewController.h"
//UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate
@interface SupermarketViewController ()<UITableViewDelegate,UITableViewDataSource,SupermarketCellDelegate,SuperLoanCellDelegate,SupermarketHeaderViewDelegate,SortViewDelegate,FilterViewDelegate>

{
    
//    UICollectionView *_collectionView;
    UITableView *_tableView;
    //最大金额
    NSString *_maxAmount;
    //最大周期
    NSString *_maxDays;
    //最小金额
    NSString *_minAmount;
    //最小周期
    NSString *_minDays;
    //平台类型(贷款、游戏、旅游)
//    NSString *_type;
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
//    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = rgb(242, 242, 242);
    // 注册collectionViewcell:WWCollectionViewCell是我自定义的cell的类型
//    [self.collectionView registerClass:[SupermarketCell class] forCellWithReuseIdentifier:@"cell"];
//    _type = @"";
    _order = @"ASC";
    _dataArray = [NSMutableArray arrayWithCapacity:100];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:isSuperMark object:nil];
    [self getData];
    [self addHeaderView];
    [self createTab];
}

#pragma mark 添加头部视图
-(void)addHeaderView{
    
    if (UI_IS_IPHONEX) {
        
        _headerView = [[SupermarketHeaderView alloc]initWithFrame:CGRectMake(0, 84, _k_w, 36)];
    }else{
        _headerView = [[SupermarketHeaderView alloc]initWithFrame:CGRectMake(0, 64, _k_w, 36)];
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
    [_headerView.sortImageBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];

    _headerView.filterBtn.selected = NO;
    _headerView.filterImageBtn.selected = NO;
    [_headerView.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    [_headerView.filterImageBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
-(void)getData{
    
    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",_index] row:-1];
}
#pragma mark 获取数据
-(void)getDataMaxAmount:(NSString *)maxAmount maxDays:(NSString *)maxDays minAmount:(NSString *)minAmount minDays:(NSString *)minDays offset:(NSString *)offset order:(NSString *)order sort:(NSString *)sort row:(NSInteger)row{
    
    CompQueryViewModel *viewModel = [[CompQueryViewModel alloc]init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            [_dataArray removeAllObjects];
            CompQueryModel *model = [[CompQueryModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            for (RowsModel *rowModel in model.rows) {
                [_dataArray addObject:rowModel];
            }
            
//            _collectionView.scrollEnabled = true;
//            [_collectionView reloadData];
            _tableView.scrollEnabled = true;
            if (row == -1) {
                
                [_tableView reloadData];
            }else{
                
                //一个cell刷新
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:row inSection:0];
                [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }
            
            [_tableView.mj_header endRefreshing];
            
        }else{

            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{

    }];
    
    [viewModel compQueryLimit:@"100" maxAmount:maxAmount maxDays:maxDays minAmount:minAmount minDays:minDays offset:offset order:order sort:sort moduleType:@"1" location:@"5"];
    
}

//#pragma mark -- lazy load
//- (UICollectionView *)collectionView {
//    if (_collectionView == nil) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
//        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        // layout.minimumInteritemSpacing = 10;// 垂直方向的间距
//        // layout.minimumLineSpacing = 10; // 水平方向的间距
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, _k_w, _k_h - 120 - 49) collectionViewLayout:layout];
//        _collectionView.backgroundColor = rgb(242, 242, 242);
//        _collectionView.dataSource = self;
//        _collectionView.delegate = self;
//    }
//    return _collectionView;
//}


-(void)createTab{
    
    if (UI_IS_IPHONEX) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 140, _k_w, _k_h-140-85) style:UITableViewStylePlain];
    }else{
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, _k_w, _k_h-120-49) style:UITableViewStylePlain];
    }
    
    [_tableView registerClass:[SuperLoanCell class] forCellReuseIdentifier:@"SuperLoanCell"];
    [_tableView registerClass:[SuperLoanNoneCell class] forCellReuseIdentifier:@"SuperLoanNoneCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = true;
    _tableView.backgroundColor = rgb(242, 242, 242);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
//    _headerView = [[SuperLoanHeaderView alloc]init];
//    _headerView.delegate = self;
//    self.tableView.tableHeaderView = _headerView;

//    if (@available(iOS 11.0, *)) {
//        _tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
//        _tableView.contentInset = UIEdgeInsetsMake(BarHeightNew - 64, 0, 0, 0);
//    }else{
//        self.automaticallyAdjustsScrollViewInsets=NO;
//    }
    
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
//    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    //    [header beginRefreshing];
//    _tableView.mj_header = header;
    
}

//-(void)headerRefreshing{
//
//    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",_index] row:-1];
//}
#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataArray.count <= 0) {
        
        return _k_h - 215 - 80 - 64 - 49;
    }
    
//    RowsModel *model = _dataArray[indexPath.row];
//    if ([model.moduletype isEqualToString:@"1"]) {
//        return 90;
//    }
//    return 75;
    return 90;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
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
    
    SuperLoanCell *superLoanCell = [tableView dequeueReusableCellWithIdentifier:@"SuperLoanCell"];
    [superLoanCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    superLoanCell.backgroundColor = [UIColor whiteColor];
    superLoanCell.selected = NO;
    superLoanCell.delegate = self;
    
    RowsModel *model = _dataArray[indexPath.row];
//    if ([model.moduletype isEqualToString:@""] || model.moduletype == nil) {
//        superLoanCell.type = @"2";
//    }else{
//        superLoanCell.type = model.moduletype;
//    }
//    NSLog(@"%ld=============",indexPath.section);
    superLoanCell.type = @"1";
    superLoanCell.descLabel.text = model.applicantsCount;
    [superLoanCell.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.plantLogo] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRetryFailed];
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
    superLoanCell.feeLabel.text = [NSString stringWithFormat:@"费用:%@%%/%@",referenceRate,[self rateUnit: model.referenceMode]];
    
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
    
    [superLoanCell.descBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:width]);
    }];
//    [superLoanCell.descBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo([NSNumber numberWithFloat:width]);
//    }];
    if (indexPath.row % 2 == 0){
        
        [superLoanCell.descBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        superLoanCell.descBtn.layer.borderColor = [UIColor blueColor].CGColor;
    }
    
    superLoanCell.collectionBtn.tag = indexPath.row;
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

    RowsModel *model = _dataArray[indexPath.row];
    [self getCompLinkThirdPlatformId: model.id_];
}
//#pragma mark -- UICollectionViewDataSource
///** 每组cell的个数*/
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _dataArray.count;
//}
//
///** cell的内容*/
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    SupermarketCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.delegate = self;
//    RowsModel *model = _dataArray[indexPath.row];
//    cell.titleLabel.text = model.plantName;
//    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.plantLogo] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRetryFailed];
//    cell.collectionBtn.tag = indexPath.row;
//    [cell.collectionBtn setImage:[UIImage imageNamed:@"collection_icon"] forState:UIControlStateNormal];
//    if ([model.isCollect isEqualToString:@"0"]) {
//        [cell.collectionBtn setImage:[UIImage imageNamed:@"collection_selected_icon"] forState:UIControlStateNormal];
//    }
//    return cell;
//}
//
//
//#pragma mark -- UICollectionViewDelegateFlowLayout
///** 每个cell的尺寸*/
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((_k_w - 15)/2, 75);
//}
//
//
//#pragma mark -- UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
////    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
//
//    RowsModel *model = _dataArray[indexPath.row];
//    [self getCompLinkThirdPlatformId: model.id_];
//
//}

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
        [_headerView.filterImageBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
    }

    _headerView.sortBtn.selected = !_headerView.sortBtn.selected;
    _headerView.sortImageBtn.selected = !_headerView.sortImageBtn.selected;

    if (_headerView.sortBtn.selected || _headerView.sortImageBtn.selected) {

        [_headerView.sortBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
        [_headerView.sortImageBtn setImage:[UIImage imageNamed:@"sort_selected_icon"] forState:UIControlStateNormal];

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
//            _collectionView.scrollEnabled = false;
            _tableView.scrollEnabled = true;
        }];

    }else{

        [_headerView.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
        [_headerView.sortImageBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            [_sortView removeFromSuperview];
//            _collectionView.scrollEnabled = true;
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
        [_headerView.sortImageBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];

    }

    _headerView.filterBtn.selected = !_headerView.filterBtn.selected;
    _headerView.filterImageBtn.selected = !_headerView.filterImageBtn.selected;

    if (_headerView.filterBtn.selected || _headerView.filterImageBtn.selected) {

        [_headerView.filterBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
        [_headerView.filterImageBtn setImage:[UIImage imageNamed:@"filter_selected_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            
            if (UI_IS_IPHONEX) {
                _filterView = [[FilterView alloc]initWithFrame:CGRectMake(0, 140, _k_w, _k_h)];
            }else{
                _filterView = [[FilterView alloc]initWithFrame:CGRectMake(0, 110, _k_w, _k_h)];
            }
            
            _filterView.delegate = self;
            _filterView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
            [self.view addSubview:_filterView];
//            _collectionView.scrollEnabled = false;
            _tableView.scrollEnabled = true;
        }];

    }else{

        [_headerView.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
        [_headerView.filterImageBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            [_filterView removeFromSuperview];
//            _collectionView.scrollEnabled = true;
            _tableView.scrollEnabled = true;

        }];
    }
}

#pragma mark 切换贷款游戏旅游按钮
-(void)tabBtnClick:(UIButton *)sender{

//    NSInteger tag = sender.tag;
//    _type = [NSString stringWithFormat:@"%ld",tag - 100];
//    if ([_type isEqualToString:@"1"]) {
//        _order = @"ASC";
//        [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",_index]];
//    }else{
//        //        _pages = 0;
//        [self getDataMaxAmount:@"" maxDays:@"" minAmount:@"" minDays:@"" offset:@"0" order:_order sort:@"0"];
//    }
}


-(void)sortTabSelected:(NSInteger)selectedIndex{

    _index = selectedIndex;
    switch (_index) {
        case 0:
            _order = @"ASC";
            break;
        case 1:
            _order = @"DESC";
            break;
        case 2:
            _order = @"ASC";
            break;
        case 3:
            _order = @"ASC";
            break;
        default:
            break;
    }

    [_headerView.sortBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    [_headerView.sortImageBtn setImage:[UIImage imageNamed:@"sort_icon"] forState:UIControlStateNormal];
    _headerView.sortBtn.selected = NO;
    _headerView.sortImageBtn.selected = NO;
    [self getDataMaxAmount:@"" maxDays:@"" minAmount:@"" minDays:@"" offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",selectedIndex] row:-1];
//    [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",selectedIndex]row:-1];
    [UIView animateWithDuration:1 animations:^{
        [_sortView removeFromSuperview];

    }];
}


#pragma mark 筛选确认按钮
-(void)sureBtnClick:(NSString *)minLoanMoney maxLoanMoney:(NSString *)maxLoanMoney minLoanPeriod:(NSString *)minLoanPeriod maxLoanPeriod:(NSString *)maxLoanPeriod{

    _order = @"ASC";
    [_headerView.filterBtn setTitleColor:rgb(77, 77, 77) forState:UIControlStateNormal];
    [_headerView.filterImageBtn setImage:[UIImage imageNamed:@"filter_icon"] forState:UIControlStateNormal];
    _headerView.filterBtn.selected = NO;
    _headerView.filterImageBtn.selected = NO;

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

    [self getDataMaxAmount:maxLoanMoney maxDays:maxLoanPeriod minAmount:minLoanMoney minDays:minLoanPeriod offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",_index]row:-1];
    [UIView animateWithDuration:1 animations:^{

        [_filterView removeFromSuperview];

    }];

}

-(void)collectionBtn:(UIButton *)sender{
    
    if (![FXD_Utility sharedUtility].loginFlage){
        
        [self presentLoginVC:self];
        return;
    }
    RowsModel *model = _dataArray[sender.tag];
    CollectionViewModel *collectionVM = [[CollectionViewModel alloc]init];
    [collectionVM setBlockWithReturnBlock:^(id returnValue) {
        
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]) {
            
            [self getDataMaxAmount:_maxAmount maxDays:_maxDays minAmount:_minAmount minDays:_minDays offset:@"0" order:_order sort:[NSString stringWithFormat:@"%ld",_index] row:sender.tag];
            
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
        
    } WithFaileBlock:^{
        
    }];
    
    [collectionVM addMyCollectionInfocollectionType:model.moduletype platformId:model.id_];
    
}

/**
 跳转到登录页面
 
 @param vc 登录的VC
 */
- (void)presentLoginVC:(UIViewController *)vc
{
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
    [vc presentViewController:nav animated:YES completion:nil];
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
