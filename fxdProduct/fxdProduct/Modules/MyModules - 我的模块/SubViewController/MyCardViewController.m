//
//  MyCardViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/27.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "MyCardViewController.h"
#import "AddCardViewController.h"
#import "CardListBaseClass.h"
#import "CardListResult.h"

@interface MyCardViewController ()<UITableViewDataSource,UITableViewDelegate,addcardToMycard>
{
    UITableView *_tableview;
    CardListBaseClass *_cardListParse;
    CardListResult *_cardListModel;
    
    NSArray *_dataImageArray;
    NSMutableArray *_dataliat;
}
@end

@implementation MyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem];
   _dataImageArray=@[@"cib",@"cmb",@"icbc",@"ccb"];
    
    [self createMyCardUI];
    [self postUrlMessage];
}

-(void)createMyCardUI{
    self.navigationItem.title=@"我的银行卡";
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    [self.view addSubview:_tableview];
    
}

-(void)postUrlMessage{
    NSDictionary *paramDic = @{@"token":[Utility sharedUtility].userInfo.tokenStr};
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        _cardListParse=[CardListBaseClass modelObjectWithDictionary:object];
        [_tableview reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-----UItableview--delegete---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cardListParse.result.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indexcell=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indexcell];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indexcell];
    }
    if (indexPath.row==_cardListParse.result.count) {
        cell.textLabel.text=@"请添加银行卡";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        _cardListModel=[_cardListParse.result objectAtIndex:indexPath.row];
        NSLog(@"index=%ld,%@",indexPath.row,_cardListModel.theBank);
        if ([_cardListModel.theBank isEqualToString:@"3003"]) {
            cell.imageView.image=[UIImage imageNamed:_dataImageArray[0]];
            cell.textLabel.text=@"建设银行";
        }else if([_cardListModel.theBank isEqualToString:@"3001"]){
            cell.imageView.image=[UIImage imageNamed:_dataImageArray[1]];
            cell.textLabel.text=@"中国银行";
        }
        cell.detailTextLabel.text=[NSString stringWithFormat:@"尾号%@  储蓄卡",[_cardListModel.bankNum substringToIndex:4]];
        cell.detailTextLabel.alpha=0.5;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"银行卡:";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _cardListParse.result.count) {
        AddCardViewController *addcardVC=[[AddCardViewController alloc] init];
        addcardVC.delegate=self;
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:addcardVC animated:YES];
    }
}

#pragma mark---addcard返回的delegate
-(void)sendToMycardString:(NSString *)cardtextfield andTel:(NSString *)teleTextField
{
    [self postUrlMessage];
    [_tableview reloadData];
}
@end
