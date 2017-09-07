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
#import "BankInfoViewModel.h"

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

//    _currentIndex = 0;
    self.navigationItem.title = @"选择银行卡";

    [self addBackItem];
    [self addBanckCard];
    [self configuireView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fatchBankList)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
}
-(void)viewWillAppear:(BOOL)animated{
    
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
- (void)addBanckCard
{

    UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"addBankCardIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addCardClick)];
    self.navigationItem.rightBarButtonItem = aBarbi;
    
}
-(void)addCardClick{
    
    EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:NSStringFromClass([EditCardsController class]) bundle:nil];
    editCard.typeFlag = @"0";
    editCard.addCarSuccess = ^{
        DLog(@"添加卡成功");
        _currentIndex = 0;
        [self.tableView.mj_header beginRefreshing];
        if (self.bankSelectBlock) {
            self.bankSelectBlock(_cardInfo,_currentIndex);
        }
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
    
    BankInfoViewModel * bankInfoVM = [[BankInfoViewModel alloc]init];
    [bankInfoVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            if (_datalist.count > 0) {
                [_datalist removeAllObjects];
            }
            for (NSDictionary *dic in (NSDictionary *)baseResultM.data) {
                CardInfo * cardInfo = [[CardInfo alloc]initWithDictionary:dic error:nil];
                if ([cardInfo.cardType isEqualToString:@"2"]) {
                    [_datalist addObject:cardInfo];
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
    return  _datalist.count;
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
    cell.bankCardInfoLabel.text = [NSString stringWithFormat:@"%@ 尾号(%@)",cardInfo.bankName,[self formatTailNumber:cardInfo.cardNo]];
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
    if (self.bankSelectBlock) {
        self.bankSelectBlock(_cardInfo,_currentIndex);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)userSelectedBankCard:(BankSelectBlock)block{
    
    self.bankSelectBlock = ^(CardInfo *cardInfo, NSInteger currentIndex) {
        block(cardInfo,currentIndex);
    };
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
