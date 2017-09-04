//
//  MyCardsViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/14.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "MyCardsViewController.h"
#import "MyCardCell.h"
#import "BankCardInfoBaseClass.h"
#import "EditCardsController.h"
#import "BankModel.h"
#import "UserCardResult.h"
#import "RepayWeeklyRecordViewModel.h"
#import "SupportBankList.h"
@interface MyCardsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //    BankCardInfoBaseClass
    UserCardResult *_userCardModel;
    
    NSMutableArray *_dataImageListBank;
    NSMutableArray *_dataliat;
    NSMutableArray *_dataNumList;
    NSMutableArray *_bankWitch;
    //    NSIndexPath *_lastIndexPath;
    NSMutableArray *_bankWitchArray;
    
    //空白界面
    UIView *NoneView;
    
    NSInteger _defaultCardIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MyCardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem];
    self.title=@"我的银行卡";
    
    _defaultCardIndex = -1;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataliat =[[NSMutableArray alloc] init];
    _dataNumList = [[NSMutableArray alloc] init];
    _dataImageListBank = [[NSMutableArray alloc] init];
    _bankWitch = [[NSMutableArray alloc] init];
    _bankWitchArray = [[NSMutableArray alloc] init];
    [_tableView registerNib:[UINib nibWithNibName:@"MyCardCell" bundle:nil] forCellReuseIdentifier:@"MyCardCell"];
    //    [self addCardBtn];
    
    [self createMyCardUI];
    //请求银行卡列表信息
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    if ([Utility sharedUtility].networkState) {
        [self postUrlMessageandDictionary];
    } else {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"似乎没有连接到网络" ];
        
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        self.imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        self.tableView.hidden=YES;
    }
    [self createNoneView];
}

- (void)addCardBtn
{
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addCard)];
    btn.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = btn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)addCard
{
    EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:@"EditCardsController" bundle:nil];
    editCard.typeFlag = @"0";
    [self.navigationController pushViewController:editCard animated:YES];
}

-(void)createMyCardUI{
    
    self.title=@"我的银行卡";
    if (_dataliat.count == 0) {
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        self.imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        self.tableView.hidden=YES;
        NoneView.hidden=NO;
    }else{
        self.tableView.hidden=NO;
        NoneView.hidden=YES;
    }
}

-(void)createNoneView
{
    NoneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    NoneView.backgroundColor=RGBColor(245, 245, 245, 1);
    UIImageView *logoImg=[[UIImageView alloc]initWithFrame:CGRectMake((_k_w-130)/2, 132, 130, 130)];
    logoImg.image=[UIImage imageNamed:@"my-logo"];
    UILabel *lblNone=[[UILabel alloc]initWithFrame:CGRectMake((_k_w-180)/2, logoImg.frame.origin.y+logoImg.frame.size.height+25, 180, 25)];
    lblNone.numberOfLines=0;
    lblNone.text=@"您当前尚未添加银行卡";
    lblNone.textAlignment=NSTextAlignmentCenter;
    lblNone.font=[UIFont systemFontOfSize:16];
    lblNone.textColor=RGBColor(180, 180, 181, 1);
    [NoneView addSubview:logoImg];
    [NoneView addSubview:lblNone];
    NoneView.hidden=YES;
    [self.view addSubview:NoneView];
}

//网络请求
-(void)postUrlMessageandDictionary{
    //请求银行卡列表信息
    
    BankInfoViewModel * bankInfoVM = [[BankInfoViewModel alloc]init];
    [bankInfoVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *  baseResultM = [[BaseResultModel alloc]initWithDictionary:returnValue error:nil];
        if ([baseResultM.errCode isEqualToString:@"0"]){
            NSArray * array = (NSArray *)baseResultM.data;
            for (int  i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                CardInfo * cardInfo = [[CardInfo alloc]initWithDictionary:dic error:nil];
                if ([cardInfo.cardType isEqualToString:@"2"]) {
                    _defaultCardIndex = 0;
                    [_dataliat addObject:[self formatString:cardInfo.cardNo]];
                    [_dataNumList addObject:cardInfo.cardType];
                    [_dataImageListBank addObject:cardInfo.cardIcon];
                    [_bankWitch addObject:@"银行卡"];
                    [_bankWitchArray addObject:cardInfo.bankName];
                }
            }
            [_tableView reloadData];
            [self createMyCardUI];
        }else{
            NoneView.hidden=NO;
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:baseResultM.friendErrMsg];
        }
    } WithFaileBlock:^{
        NoneView.hidden=NO;
    }];
    [bankInfoVM obtainUserBankCardList];
    
}

- (NSString *)formatString:(NSString *)str
{
    NSMutableString *tempStr = [NSMutableString string];
    for (NSInteger i = 0; i < str.length - 5; i++) {
        [tempStr appendString:@"*"];
    }
    
    NSMutableString *returnStr = [NSMutableString stringWithString:[str stringByReplacingCharactersInRange:NSMakeRange(1, str.length - 5) withString:tempStr]];
    
    NSMutableString *ss = [NSMutableString string];
    for (NSInteger i = 0; i < returnStr.length; i++) {
        unichar c = [returnStr characterAtIndex:i];
        if (i > 0) {
            if (i%4 == 0) {
                [ss appendFormat:@" %C",c];
            } else {
                [ss appendFormat:@"%C",c];
            }
        } else {
            [ss appendFormat:@"%C",c];
        }
        
        if (i == returnStr.length) {
            [ss replaceCharactersInRange:NSMakeRange(returnStr.length, 1) withString:@""];
        }
    }
    
    return ss;
}
//6*** **** **** ***9 782

#pragma mark-----UItableview--delegete---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return _cardListParse.result.count+1;
    return _dataliat.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCardCell"];
//    cell.iconImage.image = [UIImage imageNamed:[_dataImageListBank objectAtIndex:indexPath.row]];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[_dataImageListBank objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRefreshCached];
    cell.bankCompanyLabel.text = _bankWitchArray[indexPath.row];
    cell.bankNum.text =_dataliat[indexPath.row];
    cell.banklist.text =_bankWitch[indexPath.row];
    if (_defaultCardIndex == indexPath.row) {
        cell.defaultFlag.hidden = NO;
    }
    
    if([_bankWitch[indexPath.row] isEqualToString:@"银行卡"])
    {
        cell.cardTypeFlag=0;
        cell.btnEdit.hidden=NO;
    }
    else
    {
        cell.cardTypeFlag=1;
        cell.btnEdit.hidden=YES;
        
    }
    cell.selected = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    cell.myBlock=^(int flag)
    //    {
    //        EditCardsController *editCard=[[EditCardsController alloc]initWithNibName:@"EditCardsController" bundle:nil];
    //        AccountCardResult *accountCardResult = _bankCardParse.result[indexPath.row];
    //        if(flag==0)
    //        {
    //
    //            editCard.typeFlag=@"0";
    //            editCard.cardName=_bankWitchArray[indexPath.row];
    //            editCard.cardNum=accountCardResult.cardNo;
    //            editCard.cardCode=accountCardResult.cardBank;
    //            editCard.accountId=accountCardResult.resultIdentifier;
    //            NSLog(@"%@ %@ %@",editCard.cardName,editCard.cardNum,editCard.cardCode);
    //        }
    //        else
    //        {
    //            editCard.typeFlag=@"1";
    //            editCard.cardName=_bankWitchArray[indexPath.row];
    //            editCard.cardNum=accountCardResult.cardNo;
    //            editCard.cardCode=accountCardResult.cardBank;
    //            editCard.accountId=accountCardResult.resultIdentifier;
    //        }
    //        [self.navigationController pushViewController:editCard animated:YES];
    //    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142.0;
}

//隐藏与现实tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


@end
