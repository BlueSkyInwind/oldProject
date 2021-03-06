//
//  PayMethodViewController.m
//  fxdProduct
//
//  Created by dd on 16/7/18.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "PayMethodViewController.h"
#import "BankModel.h"
#import "BankListCell.h"
#import "EditCardsController.h"
#import "BaseNavigationViewController.h"
#import "UserCardResult.h"
#import "CardInfo.h"
#import "UIViewController+KNSemiModal.h"

@interface PayMethodViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UserCardResult *_userCardsModel;
    
    NSMutableArray *_cardListArr;

    NSMutableArray *_dataliat;
    NSMutableArray *_dataNumList;
    NSMutableArray *_dataImageListBank;
    NSMutableArray *_bankWitchArray;
    CardInfo *_cardInfo;
}
@end

@implementation PayMethodViewController

static NSString * const bankListCellIdentifier = @"BankListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _cardListArr = [NSMutableArray array];
    _dataliat =[[NSMutableArray alloc] init];
    _dataNumList = [[NSMutableArray alloc] init];
    _dataImageListBank = [[NSMutableArray alloc] init];
    _bankWitchArray = [[NSMutableArray alloc] init];
    if (_payMethod == PayMethodSelectBankCad) {
        self.navigationItem.title = @"选择银行卡";
    } else {
        self.navigationItem.title = @"选择付款方式";
    }
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    [self addBackItem];
    [FXD_Tool setCorner:self.sureBtn borderColor:UI_MAIN_COLOR];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fatchBankList)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BankListCell class]) bundle:nil] forCellReuseIdentifier:bankListCellIdentifier];
}

- (void)fatchBankList
{
    
    BankInfoViewModel * bankInfoVM = [[BankInfoViewModel alloc]init];
    [bankInfoVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            if (_dataliat.count > 0 || _dataNumList.count > 0 || _dataImageListBank.count > 0 || _bankWitchArray.count > 0) {
                [_dataliat removeAllObjects];
                [_dataNumList removeAllObjects];
                [_dataImageListBank removeAllObjects];
                [_bankWitchArray removeAllObjects];
                [_cardListArr removeAllObjects];
            }
            NSArray *array = (NSMutableArray *)baseResultM.data;
            if (array.count <= 0){
                
            }
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                CardInfo * cardInfo = [[CardInfo alloc]initWithDictionary:dic error:nil];
                if ([cardInfo.cardType isEqualToString:@"2"]) {
                    if (i==0) {
//                        _currentIndex =0;
                        _cardInfo = cardInfo;
                    }
                    [_cardListArr addObject:cardInfo];
                    [_dataliat addObject:[self formatTailNumber:cardInfo.cardNo]];
                    [_dataNumList addObject:cardInfo.cardType];
                    [_dataImageListBank addObject:cardInfo.cardIcon];
                    [_bankWitchArray addObject:cardInfo.bankName];
                 }
            }
            [self.tableView.mj_header endRefreshing];
            [_tableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardsModel.msg];
            [self.tableView.mj_header endRefreshing];
        }
    } WithFaileBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    [bankInfoVM obtainUserBankCardList];
    
    
//    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
//        _userCardsModel = [UserCardResult yy_modelWithJSON:object];
//        if([_userCardsModel.flag isEqualToString:@"0000"]){
//            if (_dataliat.count > 0 || _dataNumList.count > 0 || _dataImageListBank.count > 0 || _bankWitchArray.count > 0) {
//                [_dataliat removeAllObjects];
//                [_dataNumList removeAllObjects];
//                [_dataImageListBank removeAllObjects];
//                [_bankWitchArray removeAllObjects];
//            }
//            for(NSInteger j=0;j<_userCardsModel.result.count;j++)
//            {
//                CardResult *cardResult = [_userCardsModel.result objectAtIndex:j];
//                if([cardResult.card_type_ isEqualToString:@"2"])
//                {
//                    for (SupportBankList *banlist in _supportBankListArr) {
//                        if ([cardResult.card_bank_ isEqualToString: banlist.bank_code_]) {
//                            if (j==0) {
////                                _currentIndex = j;
//                                CardInfo *cardInfo = [[CardInfo alloc] init];
//                                cardInfo.tailNumber = [self formatTailNumber:cardResult.card_no_];
//                                cardInfo.bankName = banlist.bank_name_;
//                                cardInfo.cardIdentifier = cardResult.id_;
//                                _cardInfo = cardInfo;
//                            }
//                            [_dataliat addObject:[self formatTailNumber:cardResult.card_no_]];
//                            [_dataNumList addObject:cardResult.card_type_];
////                            [_dataImageListBank addObject:[NSString stringWithFormat:@"bank_code_%@",banlist.bank_code_]];
//                            [_dataImageListBank addObject:banlist.icon_url_];
//                            [_bankWitchArray addObject:banlist.bank_name_];
//                        }
//                    }
//                }
//            }
//            [self.tableView.mj_header endRefreshing];
//            [_tableView reloadData];
//        }else{
//            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardsModel.msg];
//            [self.tableView.mj_header endRefreshing];
//        }
//    } failure:^(EnumServerStatus status, id object) {
//        [self.tableView.mj_header endRefreshing];
//    }];
}

- (NSString *)formatTailNumber:(NSString *)str
{
    return [str substringWithRange:NSMakeRange(str.length - 4, 4)];
}

- (void)addBackItem
{
    UIBarButtonItem *backItem;
    if (_payMethod == PayMethodSelectBankCad) {
        self.navigationItem.title = @"选择银行卡";
        backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_arrowLeft"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = -10;
        self.navigationItem.leftBarButtonItems = @[spaceItem,backItem];
        
    } else {
        self.navigationItem.title = @"选择付款方式";
        backItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
//        [backItem setTitleColor:rgb(94, 94, 94) forState:UIControlStateNormal];
        [backItem setTintColor:rgb(94, 94, 94)];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}
- (void)dismissSelf
{
    [self dismissSemiModalView];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)surePayMethod:(UIButton *)sender {
    
    if (self.bankSelectBlock) {
        self.bankSelectBlock(_cardInfo,_currentIndex);
    }
    if (_payMethod == PayMethodNormal) {
        [self dismissSelf];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)tranferValue:(BankSelectBlock)block{
    
    self.bankSelectBlock = ^(CardInfo *cardInfo, NSInteger currentIndex) {
        block(cardInfo,currentIndex);
    };
}


#pragma mark -TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (_payMethod == PayMethodSelectBankCad) {
    //        return  _userCardsModel.result.count;
    //    } else {
    //        return  _userCardsModel.result.count+1;
    //    }
    return  _cardListArr.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==  _cardListArr.count) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"添加新银行卡";
        return cell;
    } else {
        BankListCell *cell = [tableView dequeueReusableCellWithIdentifier:bankListCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.bankLogo.image = [UIImage imageNamed:[_dataImageListBank objectAtIndex:indexPath.row]];
        [cell.bankLogo sd_setImageWithURL:[NSURL URLWithString:[_dataImageListBank objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRefreshCached];

        cell.bankCardInfoLabel.text = [NSString stringWithFormat:@"%@ 尾号(%@)",[_bankWitchArray objectAtIndex:indexPath.row],[_dataliat objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.bankCardInfoLabel.textColor = [UIColor grayColor];
        if (_currentIndex == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.bankCardInfoLabel.textColor = [UIColor blackColor];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _cardListArr.count) {
        EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:NSStringFromClass([EditCardsController class]) bundle:nil];
        editCard.typeFlag = @"0";
        editCard.addCarSuccess = ^{
            DLog(@"添加卡成功");
            [self.tableView.mj_header beginRefreshing];
        };
        BaseNavigationViewController *addCarNC = [[BaseNavigationViewController alloc] initWithRootViewController:editCard];
        [self presentViewController:addCarNC animated:YES completion:nil];
    } else {
        _currentIndex = indexPath.row;
        CardInfo *cardInfo = [_cardListArr objectAtIndex:indexPath.row];
        _cardInfo = cardInfo;
        [self.tableView reloadData];
    }
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
