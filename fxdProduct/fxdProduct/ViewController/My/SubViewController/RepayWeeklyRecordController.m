//
//  RepayWeeklyRecordController.m
//  fxdProduct
//
//  Created by zy on 16/1/20.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "RepayWeeklyRecordController.h"
#import "weeklyRecordCell.h"
#import "RepayWeeklyRecord.h"
@interface RepayWeeklyRecordController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataAry;
    UIView *NoneView;
    UITableView *MyTableView;
}
@end

@implementation RepayWeeklyRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"还款记录";
    dataAry=[[NSMutableArray alloc]init];
    [self addBackItem];
    [self getRecord];
    [self createTable];
    [self createNoneView];
    
    
}
-(void)getRecord
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getRepayHistory_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        if([object[@"flag"] isEqualToString:@"0000"])
        {
            if(object[@"result"])
            {
            for(NSDictionary *dict in object[@"result"])
            {
                RepayWeeklyRecord *weekModel=[RepayWeeklyRecord new];
                [weekModel setValuesForKeysWithDictionary:dict];
                [dataAry addObject:weekModel];
            }
            }
            if(dataAry.count==0)
            {
                NoneView.hidden = NO;
            }
            else
            {
                NoneView.hidden = YES;
                [MyTableView reloadData];
            }
        }
        else
        {
        NoneView.hidden = NO;
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:object[@"msg"]];
        }
    } failure:^(EnumServerStatus status, id object) {
        NoneView.hidden = NO;
    }];
}
-(void)createNoneView
{
    NoneView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    NoneView.backgroundColor = RGBColor(245, 245, 245, 1);
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((_k_w-130)/2, 132, 130, 130)];
    logoImg.image=[UIImage imageNamed:@"my-logo"];
    UILabel *lblNone=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-180)/2, logoImg.frame.origin.y+logoImg.frame.size.height+25, 180, 25)];
    lblNone.numberOfLines=0;
    lblNone.text=@"您当前暂无还款记录";
    lblNone.textAlignment = NSTextAlignmentCenter;
    lblNone.font=[UIFont systemFontOfSize:16];
    lblNone.textColor=RGBColor(180, 180, 181, 1);
    [NoneView addSubview:logoImg];
    [NoneView addSubview:lblNone];
    NoneView.hidden = YES;
    [self.view addSubview:NoneView];
}
-(void)createTable
{
    MyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    MyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    MyTableView.delegate=self;
    MyTableView.dataSource=self;
    MyTableView.backgroundColor=RGBColor(245, 245, 245, 1);
    [self.view addSubview:MyTableView];
    [MyTableView registerClass:[weeklyRecordCell class] forCellReuseIdentifier:@"weeklyRecord"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataAry.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"weeklyRecord";
    weeklyRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    RepayWeeklyRecord *weekymodel=(RepayWeeklyRecord*)dataAry[dataAry.count-indexPath.row-1];
    [cell setCellValues:weekymodel];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *ary=[[NSArray alloc]initWithObjects:@"期数",@"本金",@"利息",@"罚息",@"违约金",@"日期",nil];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(15*_k_WSwitch, 0, _k_w-15*_k_WSwitch, 40)];
    view.backgroundColor=RGBColor(245, 245, 245, 1);
    for(int i=0;i<6;i++)
    {
        if(i==0)
        {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15*_k_WSwitch, 0, 40*_k_WSwitch, 40)];
            label.text=ary[i];
            [view addSubview:label];
        }
        else
        {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(55*_k_WSwitch+(_k_w-70*_k_WSwitch)/5*(i-1), 0, (_k_w-70*_k_WSwitch)/5, 40)];
        label.text=ary[i];
        [view addSubview:label];
//        if(i==4)
//        {
            label.textAlignment=NSTextAlignmentCenter;
//        }
        if(i==5)
        {
            label.textAlignment=NSTextAlignmentRight;
        }
        }
        
    }
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
