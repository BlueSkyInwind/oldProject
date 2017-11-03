//
//  HomeBankCardViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/30.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "BankCardNameVCModules.h"

@interface BankCardNameVCModules ()<UITableViewDataSource,UITableViewDelegate>
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

@implementation BankCardNameVCModules

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addBackItem];
    [self createUI];
    if (!self.bankArray) {
        [self fatchCardInfo];
    }
}


-(void)createUI{
    //    _cardMethodTag=87;
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, _k_w, _k_h-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:_tableView];
    
}


#pragma mark-UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bankArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellinditior=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellinditior];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellinditior];
    }

    SupportBankList * supportBankList = [_bankArray objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:supportBankList.icon_url_] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRefreshCached];
    cell.textLabel.text = supportBankList.bank_name_;
    if (self.cardTag == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
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
        SupportBankList * supportBankList = [_bankArray objectAtIndex:indexPath.row];
        [self.delegate BankSelect:supportBankList andSectionRow:_cardTag];
    }
    [tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)fatchCardInfo
{
    CheckBankViewModel *checkBankViewModel = [[CheckBankViewModel alloc]init];
    [checkBankViewModel setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseResult = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResult.flag isEqualToString:@"0000"]) {
            NSArray * array  = (NSArray *)baseResult.result;
            _bankArray = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                SupportBankList * bankList = [[SupportBankList alloc]initWithDictionary:array[i] error:nil];
                [_bankArray addObject:bankList];
            }
            [_tableView reloadData];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResult.msg];
        }
    } WithFaileBlock:^{
        
    }];
    if (_isP2P) {
        [checkBankViewModel getSupportBankListInfo:@"4"];
        return;
    }
    [checkBankViewModel getSupportBankListInfo:@"2"];
}

@end
