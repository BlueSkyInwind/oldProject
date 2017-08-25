//
//  UserBankCardListViewController.m
//  fxdProduct
//
//  Created by admin on 2017/8/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UserBankCardListViewController.h"
#import "BankListCell.h"
#import "EditCardsController.h"
#import "BaseNavigationViewController.h"
#import "UserCardResult.h"
#import "CardInfo.h"
@interface UserBankCardListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UserCardResult *_userCardsModel;
    CardInfo *_cardInfo;
    NSMutableArray *_datalist;
    
}
@property (nonatomic,strong)UITableView * tableView;
@end


static NSString * const bankListCellIdentifier = @"BankListCell";

@implementation UserBankCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _datalist = [[NSMutableArray alloc] init];
    if (_payMethod == PayMethodSelectBankCad) {
        self.navigationItem.title = @"选择银行卡";
    } else {
        self.navigationItem.title = @"选择付款方式";
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addBackItem];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fatchBankList)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
}

-(void)configuireView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BankListCell class]) bundle:nil] forCellReuseIdentifier:bankListCellIdentifier];
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
        backItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        [backItem setTintColor:rgb(94, 94, 94)];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"addBankCardIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addCardClick)];
    self.navigationItem.rightBarButtonItem = aBarbi;
    
}
-(void)addCardClick{
    
    EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:NSStringFromClass([EditCardsController class]) bundle:nil];
    editCard.typeFlag = @"0";
    editCard.addCarSuccess = ^{
        DLog(@"添加卡成功");
        [self.tableView.mj_header beginRefreshing];
    };
    BaseNavigationViewController *addCarNC = [[BaseNavigationViewController alloc] initWithRootViewController:editCard];
    [self presentViewController:addCarNC animated:YES completion:nil];
}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)fatchBankList
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_cardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        _userCardsModel = [UserCardResult yy_modelWithJSON:object];
        if([_userCardsModel.flag isEqualToString:@"0000"]){
            if (_datalist.count > 0) {
                [_datalist removeAllObjects];
            }
            for(NSInteger j=0;j<_userCardsModel.result.count;j++)
            {
                CardResult *cardResult = [_userCardsModel.result objectAtIndex:j];
                if([cardResult.card_type_ isEqualToString:@"2"])
                {
                    for (SupportBankList *banlist in _supportBankListArr) {
                        CardInfo *cardInfo = [[CardInfo alloc] init];
                        cardInfo.tailNumber = [self formatTailNumber:cardResult.card_no_];
                        cardInfo.bankName = banlist.bank_name_;
                        cardInfo.cardIdentifier = cardResult.id_;
                        cardInfo.cardIcon = banlist.icon_url_;
                        if ([cardResult.card_bank_ isEqualToString: banlist.bank_code_]) {
                            if (j==0) {
                                _cardInfo = cardInfo;
                            }
                            [_datalist addObject:cardInfo];
                        }
                    }
                }
            }
            [self.tableView.mj_header endRefreshing];
            [_tableView reloadData];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:_userCardsModel.msg];
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(EnumServerStatus status, id object) {
        [self.tableView.mj_header endRefreshing];
    }];
}
- (NSString *)formatTailNumber:(NSString *)str
{
    return [str substringWithRange:NSMakeRange(str.length - 4, 4)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _userCardsModel.result.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BankListCell *cell = [tableView dequeueReusableCellWithIdentifier:bankListCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CardInfo *cardInfo = [_datalist objectAtIndex:indexPath.row];
    [cell.bankLogo sd_setImageWithURL:[NSURL URLWithString:cardInfo.cardIcon] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRefreshCached];
    cell.bankCardInfoLabel.text = [NSString stringWithFormat:@"%@ 尾号(%@)",cardInfo.bankName,cardInfo.tailNumber];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.bankCardInfoLabel.textColor = [UIColor grayColor];
    if (_currentIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.bankCardInfoLabel.textColor = [UIColor blackColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    _currentIndex = indexPath.row;
    CardInfo *cardInfo = [_datalist objectAtIndex:indexPath.row];
    _cardInfo = cardInfo;
    [self.tableView reloadData];
    
    self.bankSelectBlock(_cardInfo,_currentIndex);
    [self.navigationController popViewControllerAnimated:YES];
    
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
