//
//  MessageCenterViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/13.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MsgViewCell.h"
#import "DataBaseManager.h"
#import "testModelFmdb.h"
@interface MessageCenterViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    FMDatabase *_db;
    NSMutableArray *dataArray;
    NSArray *locationAry;
    UIImageView *backImg;
    UILabel *lblMsg;
    UIAlertView *DeleAlert;
    
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataAry;
@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem];
    [self addRightItme];
    self.navigationItem.title = @"消息中心";
    self.view.backgroundColor=RGBColor(245, 245, 245, 1);
    self.dataAry=[[NSMutableArray alloc]init];
    [self createTable];
    [self fmdbTest];
}
- (void)addRightItme
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    UIImage *img = [[UIImage imageNamed:@"home-news-4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [btn setImage:img forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn addTarget:self action:@selector(DeleAllMsg) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //    修改距离,距离边缘的
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.navigationItem.rightBarButtonItems = @[spaceItem,item];
}
-(void)createTable
{
    backImg=[[UIImageView alloc]initWithFrame:CGRectMake(_k_w/2-60, 200, 120, 120)];
    backImg.image=[UIImage imageNamed:@"my-logo"];
    [self.view addSubview:backImg];
    
    lblMsg=[[UILabel alloc]initWithFrame:CGRectMake(_k_w/2-75, backImg.frame.origin.y+backImg.frame.size.height+5, 150, 30)];
    lblMsg.text=@"亲~暂无消息哦~";
    lblMsg.textColor=RGBColor(180, 180, 180, 1);
    lblMsg.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lblMsg];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64)];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=RGBColor(239, 239, 244, 1);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight=100.0;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:@"msg"];
}

-(void)fmdbTest
{
    //数据库创建
//    if(![userTableName isEqualToString:@""])
//    {
//        testModelFmdb *msg=[[testModelFmdb alloc]init];
//        msg.title=@"通知";
//        msg.date=[Tool getNowTime];
//        msg.content=@"111111111";
//        [[DataBaseManager shareManager]insertWithModel:msg:userTableName];
//    }

    //查询
    self.dataAry=[NSMutableArray array];
    self.dataAry.array=[[DataBaseManager shareManager]selectAllModel:userTableName];
    if(self.dataAry.count==0)
    {
        self.tableView.hidden=YES;
    }
    else
    {
        self.tableView.hidden=NO;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"msg"];
    testModelFmdb *msg=[self.dataAry objectAtIndex:self.dataAry.count-1-indexPath.row];
    cell.lblTitle.text=msg.title;
    cell.lblContent.text=msg.content;
    cell.lblDate.text=msg.date;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%ld",(long)indexPath.row);
}

#pragma mark UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    testModelFmdb *msg=[self.dataAry objectAtIndex:self.dataAry.count-indexPath.row-1];
    [[DataBaseManager shareManager] deleteWithModel:msg :userTableName ];
    //删除数组中得对象
    [self.dataAry removeObjectAtIndex:self.dataAry.count-indexPath.row-1];
    if(self.dataAry.count==0)
    {
        self.tableView.hidden=YES;
    }
    //删除tableview中的行
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}
-(void)DeleAllMsg
{
    DeleAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"是否清空消息通知?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [DeleAlert show];
    
}
#pragma mark  alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
    for(int i=0;i<self.dataAry.count;i++)
    {
        testModelFmdb *msg=[self.dataAry objectAtIndex:self.dataAry.count-i-1];
        [[DataBaseManager shareManager] deleteWithModel:msg :userTableName];
    }
    [self.dataAry removeAllObjects];
    self.tableView.hidden=YES;
    [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
