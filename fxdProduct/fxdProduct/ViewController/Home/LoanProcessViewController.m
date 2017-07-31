//
//  LoanProcessViewController.m
//  fxdProduct
//
//  Created by dd on 2017/2/7.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LoanProcessViewController.h"
#import "LoanProcessCell.h"
#import "LoanProcessModel.h"
#import "RefuseView.h"
#import "FXDWebViewController.h"
#import "WhiteRefuseView.h"
#import "UserDataViewController.h"
#import "HomeViewModel.h"
#import "UserStateModel.h"
#import "ExpressCreditRefuseView.h"
@interface LoanProcessViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_noneView;
    UIView *_toopLine;
    CGFloat _leadingSpacingOfLines;
    BOOL _isRefuse;
    UserStateModel *_userStateModel;
}

@property (nonatomic,strong)ExpressCreditRefuseView *expressView;
@end

@implementation LoanProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的借款进度";
    self.automaticallyAdjustsScrollViewInsets = false;
    
    _isRefuse = NO;
    _toopLine = [[UIView alloc] init];
    [self.view addSubview:_toopLine];
    [self addBackItem];
    [self setUpTableView];
    [self createNoneView];
    
    [self nonFatch];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self getApplyStatus];
}

-(void)getApplyStatus{

    HomeViewModel *homeViewModel = [[HomeViewModel alloc] init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if([returnValue[@"flag"] isEqualToString:@"0000"])
        {
            _userStateModel = [UserStateModel yy_modelWithJSON:returnValue[@"result"]];
            
//            if ([_userStateModel.merchant_status isEqualToString:@"1"]) {
            
                LoanProcessResult *loanProcess  =  _loanProcessParse.result.lastObject;
                if ([loanProcess.apply_status_ isEqualToString:@"已拒绝"]) {
                    _isRefuse = YES;
                }
//            }
//           _isRefuse = YES;
            [self.tableView reloadData];
            
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
        }
    } WithFaileBlock:^{
        
    }];
    [homeViewModel fetchUserState:nil];
    
}
-(void)createNoneView
{
    _noneView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    _noneView.backgroundColor = RGBColor(245, 245, 245, 1);
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((_k_w-130)/2, 132, 130, 130)];
    logoImg.image=[UIImage imageNamed:@"my-logo"];
    UILabel *lblNone=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-180)/2, logoImg.frame.origin.y+logoImg.frame.size.height+25, 180, 25)];
    lblNone.numberOfLines = 0;
    lblNone.text=@"您当前暂无借款进度";
    lblNone.textAlignment = NSTextAlignmentCenter;
    lblNone.font=[UIFont systemFontOfSize:16];
    lblNone.textColor=RGBColor(180, 180, 181, 1);
    [_noneView addSubview:logoImg];
    [_noneView addSubview:lblNone];
    _noneView.hidden = YES;
    [self.view addSubview:_noneView];
}

- (void)nonFatch
{
    if (_loanProcessParse.result.count > 0) {
        _noneView.hidden = YES;
    } else {
        _noneView.hidden = NO;
    }
}

- (void)setUpTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LoanProcessCell class]) bundle:nil] forCellReuseIdentifier:@"LoanProcessCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _loanProcessParse.result.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (_isRefuse) {
        if ([_userStateModel.product_id isEqualToString:SalaryLoan]) {
            return 100;
        }else if([_userStateModel.product_id isEqualToString:WhiteCollarLoan]){
        
            return 190;
        }else{
        
            return 0;
        }
        
    }else{
        return 0;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if ([_userStateModel.product_id isEqualToString:WhiteCollarLoan]) {//白领贷
        
        WhiteRefuseView *refuseView = [[[NSBundle mainBundle] loadNibNamed:@"WhiteRefuseView" owner:self options:nil]lastObject];
        refuseView.frame = CGRectZero;
        [Tool setCorner:refuseView.applyBtn borderColor:UI_MAIN_COLOR];
        [refuseView.applyBtn addTarget:self action:@selector(applyBtn) forControlEvents:UIControlEventTouchUpInside];
        return refuseView;
        
    }else if([_userStateModel.product_id isEqualToString:SalaryLoan]){//工薪贷

        RefuseView *refuseView = [[[NSBundle mainBundle] loadNibNamed:@"RefuseView" owner:self options:nil]lastObject];
        refuseView.frame = CGRectZero;
        [Tool setCorner:refuseView.seeBtn borderColor:UI_MAIN_COLOR];
        [refuseView.seeBtn addTarget:self action:@selector(refuseBtn) forControlEvents:UIControlEventTouchUpInside];
        return refuseView;
        
    }
    return nil;
    
}

/**
 点击view
 */
-(void)clickView:(NSString *)url{

    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = url;
    [self.navigationController pushViewController:webVC animated:true];
    
}

/**
 点击更多
 */
-(void)moreClick{

    FXDWebViewController *webVC = [[FXDWebViewController alloc] init];
    webVC.urlStr = @"http:www.baidu.com";
    [self.navigationController pushViewController:webVC animated:true];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanProcessCell"];
    cell.loanProcess = _loanProcessParse.result[indexPath.row];
    
    CGFloat contentViewWidth = CGRectGetWidth(self.tableView.bounds);
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    [cell.contentView addConstraint:widthFenceConstraint];
    // Auto layout engine does its math
    CGFloat fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [cell.contentView removeConstraint:widthFenceConstraint];
    
    CGFloat cellHeight = fittingHeight+2*1/[UIScreen mainScreen].scale;
    
    DLog(@"%lf",cellHeight);
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[LoanProcessCell class]]) {
        LoanProcessCell *loanCell = (LoanProcessCell *)cell;
        _toopLine.backgroundColor = loanCell.topLine.backgroundColor;
        _leadingSpacingOfLines = [loanCell convertPoint:loanCell.topLine.frame.origin toView:self.view].x;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanProcessCell"];
    cell.loanProcess = _loanProcessParse.result[indexPath.row];

    if (indexPath.row == _loanProcessParse.result.count-1) {
        cell.bottomLine.hidden = true;
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _toopLine.frame = CGRectMake(_leadingSpacingOfLines, 64, 1, -scrollView.contentOffset.y);
    
}

#pragma mark ->去看看
-(void)refuseBtn{
    
    FXDWebViewController *webView = [[FXDWebViewController alloc] init];
    webView.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_selectPlatform_url];
    [self.navigationController pushViewController:webView animated:true];
}


-(void)applyBtn{

    UserDataViewController *userDataVC = [[UserDataViewController alloc] init];
    userDataVC.product_id = SalaryLoan;
    [self.navigationController pushViewController:userDataVC animated:true];
    
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
