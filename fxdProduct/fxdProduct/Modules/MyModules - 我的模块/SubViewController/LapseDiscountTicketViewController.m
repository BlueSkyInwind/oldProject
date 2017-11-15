//
//  LapseDiscountTicketViewController.m
//  fxdProduct
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "LapseDiscountTicketViewController.h"
#import "TicketCell.h"
#import "DiscountTicketModel.h"

@interface LapseDiscountTicketViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int  pages;

}

@end

@implementation LapseDiscountTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"过期券";
    pages  = 1;
    [self addBackItem];
    [self createTableView];

}

#pragma mark 初始化tableView
-(void)createTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=rgba(245, 245, 245, 1);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(BarHeightNew);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"TicketCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    [self setupMJRefreshTableView];
}

#pragma mark 获取过期券列表
-(void)obtainDiscountTicket:(int)pageNum{
    ApplicationViewModel * applicationVM = [[ApplicationViewModel alloc]init];
    [applicationVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            if (self.invalidTicketArr.count > 0 && pages == 1) {
                [self.invalidTicketArr removeAllObjects];
            }
            DiscountTicketModel * discountTicketM = [[DiscountTicketModel alloc]initWithDictionary:(NSDictionary *)baseResultM.data error:nil];
            self.invalidTicketArr = [discountTicketM.notuselist mutableCopy];
            [self.tableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
        [self.tableView.mj_header endRefreshing];
    } WithFaileBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    [applicationVM new_obtainUserDiscountTicketListDisplayType:@"2" pageNum:[NSString stringWithFormat:@"%d",pageNum] pageSize:@"15"];
}
#pragma mark TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _invalidTicketArr.count;
} 
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    id resultParse = [_invalidTicketArr objectAtIndex:indexPath.section];
    if ([resultParse isKindOfClass:[RedpacketDetailModel class]]) {
        [cell setValues:resultParse];
    }
    if ([resultParse isKindOfClass:[DiscountTicketDetailModel class]]) {
        [cell setInvailsValues:resultParse];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_IS_IPHONE6P) {
        return 120;
    }
    return 110;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 30)];
        view.backgroundColor=kUIColorFromRGB(0xf2f2f2);
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _k_w, 10)];
        lbl.backgroundColor=rgba(245, 245, 245, 1);
        [view addSubview:lbl];
        return view;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 20)];
    view.backgroundColor=kUIColorFromRGB(0xf2f2f2);
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 20)];
    view.backgroundColor=kUIColorFromRGB(0xf2f2f2);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 30;
    }
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==3)
    {
        return 20;
    }
    
    return CGFLOAT_MIN;
}
#pragma mark ----------设置列表的可刷新性----------
-(void)setupMJRefreshTableView
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //    header.automaticallyChangeAlpha = YES;
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    footer.automaticallyChangeAlpha = YES;
    footer.mj_origin = CGPointMake(0, _k_h);
    self.tableView.mj_footer = footer;
    
}
-(void)headerRereshing
{
    //以下两种方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    pages = 1;
    [self obtainDiscountTicket:pages];
    
}

-(void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
    });
    pages += 1;
    [self obtainDiscountTicket:pages];
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
