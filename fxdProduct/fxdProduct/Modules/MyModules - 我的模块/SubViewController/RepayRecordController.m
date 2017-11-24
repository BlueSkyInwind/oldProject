//
//  RepayRecordController.m
//  fxdProduct
//
//  Created by zy on 15/12/15.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "RepayRecordController.h"
#import "GetMoneyHistoryBaseClass.h"
#import "RepayRecord.h"
#import "loanRecordCell.h"
#import "RepayWeeklyRecordViewModel.h"
@interface RepayRecordController ()<UITableViewDataSource,UITableViewDelegate>
{
    //无借款记录视图
    UIView *NoneView;
    //借款记录数组
    NSMutableArray *_repayHistoryArr;
}
@end

@implementation RepayRecordController
//隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    self.title=@"借款记录";
    [self addBackItem];
    _repayHistoryArr = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[loanRecordCell class] forCellReuseIdentifier:@"loanRecord"];
    [self getLoadRecrod];
    [self createNoneView];
    
}

#pragma mark 获取借款记录列表
-(void)getLoadRecrod
{
    
    RepayWeeklyRecordViewModel *repayWeeklyRecordViewModel = [[RepayWeeklyRecordViewModel alloc]init];
    [repayWeeklyRecordViewModel setBlockWithReturnBlock:^(id returnValue) {
        
        if ([[returnValue objectForKey:@"flag"]  isEqual: @"0000"]) {
            if(returnValue[@"result"])
            {
                for (NSDictionary *dic in returnValue[@"result"]) {
                    RepayRecord *repayModel=[RepayRecord new];
                    NSLog(@"%@",dic);
                    [repayModel setValuesForKeysWithDictionary:dic];
                    //                GetMoneyHistoryResult *result = [GetMoneyHistoryResult modelObjectWithDictionary:dic];
                    [_repayHistoryArr addObject:repayModel];
                }
            }
            if (_repayHistoryArr.count > 0) {
                NoneView.hidden = YES;
                [self.tableView reloadData];
            } else {
                NoneView.hidden = NO;
            }
        }
        else
        {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:returnValue[@"msg"]];
            NoneView.hidden=NO;
        }
        
    } WithFaileBlock:^{
         NoneView.hidden=NO;
    }];
    
    [repayWeeklyRecordViewModel getMoneyHistoryList];
    
}

#pragma mark 创建无借款记录视图
-(void)createNoneView
{
    NoneView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    NoneView.backgroundColor = RGBColor(245, 245, 245, 1);
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((_k_w-130)/2, 132, 130, 130)];
    logoImg.image=[UIImage imageNamed:@"my-logo"];
    UILabel *lblNone=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-180)/2, logoImg.frame.origin.y+logoImg.frame.size.height+25, 180, 25)];
    lblNone.numberOfLines=0;
    lblNone.text=@"您当前暂无借款记录";
    lblNone.textAlignment = NSTextAlignmentCenter;
    lblNone.font=[UIFont systemFontOfSize:16];
    lblNone.textColor=RGBColor(180, 180, 181, 1);
    [NoneView addSubview:logoImg];
    [NoneView addSubview:lblNone];
    NoneView.hidden = YES;
    [self.view addSubview:NoneView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _repayHistoryArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//自定义头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 45)];
        view.backgroundColor=[UIColor whiteColor];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _k_w, 20)];
        lbl.backgroundColor=rgba(245, 245, 245, 1);
        [view addSubview:lbl];
        return view;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 25)];
    view.backgroundColor=[UIColor whiteColor];
    return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 25)];
    view.backgroundColor=[UIColor whiteColor];
    return view;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    loanRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:@"loanRecord"];
    //    GetMoneyHistoryResult *result = [_repayHistoryArr objectAtIndex:indexPath.section];
    RepayRecord *repayModel=_repayHistoryArr[indexPath.section];
    [cell setCellValue:repayModel];
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 45;
    }
    return 25;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==_repayHistoryArr.count-1)
    {
        return 25;
    }
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 245;
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
