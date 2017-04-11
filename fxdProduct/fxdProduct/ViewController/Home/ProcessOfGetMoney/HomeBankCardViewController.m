//
//  HomeBankCardViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/30.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "HomeBankCardViewController.h"

@interface HomeBankCardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    NSArray *_dataInfoArray;
    NSArray *_createBankArray;
    NSArray *_createBankNumArray;
    NSArray *_bankImageArray;
    //    NSArray *_createIageArray;
}
@end

@implementation HomeBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackItem];
    [self createUI];
}


-(void)createUI{
    //    _cardMethodTag=87;
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:_tableView];
    
//    if (_bankFlag == 100) {
//        self.title=@"银行卡类别";
//        _bankImageArray = @[@"bank_ICBC",@"bank_boc",@"bank_CBC",
//                            @"bank_CEB",@"bank_CMSZ",@"bank_CIB",
//                            @"bank_CITIC",@"bank_spd",@"pinganbank"];
//        _dataArray=@[@"中国工商银行",@"中国银行",@"中国建设银行",
//                     @"中国光大银行",@"中国民生银行",@"兴业银行",
//                     @"中信银行",@"浦发银行",@"平安银行"];
//        _dataInfoArray=@[@"2",@"1",@"3",
//                         @"10",@"6",@"9",
//                         @"8",@"5",@"28"];
//    }
//    if (_bankFlag == 99) {
//        self.title=@"银行卡类别";
//        _bankImageArray = @[@"bank_ICBC",@"bank_ABC",@"bank_boc",@"bank_CBC",
//                            @"bank_CEB",@"bank_CMSZ",@"bank_CIB",
//                            @"bank_CITIC",@"bank_spd",@"pinganbank"];
//        _dataArray=@[@"中国工商银行",@"中国农业银行",@"中国银行",@"中国建设银行",
//                     @"中国光大银行",@"中国民生银行",@"兴业银行",
//                     @"中信银行",@"浦发银行",@"平安银行"];
//        _dataInfoArray=@[@"2",@"4",@"1",@"3",
//                         @"10",@"6",@"9",
//                         @"8",@"5",@"28"];
//    }
    //    8、中信银行(需开通银联无卡业务)
    //    9、浦发银行(需开通银联无卡业务)
    //    10、平安银行(需开通银联无卡业务)
}


#pragma mark-UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bankModel.result.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellinditior=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellinditior];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellinditior];
    }

    BankList *bankListInfo = [_bankModel.result objectAtIndex:indexPath.row];
//    DLog(@"%@",[NSString stringWithFormat:@"bank_code%@",bankListInfo.code]);
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bank_code_%@",bankListInfo.code]];
    cell.textLabel.text = bankListInfo.desc;
    if (self.cardTag == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    //    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.cardTag=indexPath.row;
    if ([self.delegate respondsToSelector:@selector(BankSelect:andSectionRow:)]) {
//        [self.delegate BankTableViewSelect:[_dataArray objectAtIndex:self.cardTag] andBankInfoList:[_dataInfoArray objectAtIndex:_cardTag] andSectionRow:_cardTag];
        BankList *bankListInfo = [_bankModel.result objectAtIndex:indexPath.row];
        [self.delegate BankSelect:bankListInfo andSectionRow:_cardTag];
    }
    [tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
