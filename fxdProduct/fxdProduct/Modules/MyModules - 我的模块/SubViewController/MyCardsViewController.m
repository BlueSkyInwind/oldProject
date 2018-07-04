//
//  MyCardsViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/14.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "MyCardsViewController.h"
#import "MyCardCell.h"
#import "SupportBankList.h"
@interface MyCardsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray *_dataImageListBank;
    NSMutableArray *_dataliat;
    NSMutableArray *_dataNumList;
    NSMutableArray *_bankWitch;
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
    [_tableView registerClass:[BankCell class] forCellReuseIdentifier:@"BankCell"];
    
    [self createMyCardUI];
    //请求银行卡列表信息
        
    if ([FXD_Utility sharedUtility].networkState) {
        [self postUrlMessageandDictionary];
    } else {
        [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"似乎没有连接到网络" ];
        
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        self.imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        self.tableView.hidden=YES;

    }
    [self createNoneView];
}

- (void)addCard
{
    
    BillingMessageViewController *controller=[[BillingMessageViewController alloc]init];
    controller.type = @"1";
    [self.navigationController pushViewController:controller animated:true];
    
}


-(void)createMyCardUI{
    
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
    logoImg.image=[UIImage imageNamed:@"none_icon"];
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
    [bankInfoVM obtainUserBankCardListPlatformType:@""];
    
}

- (NSString *)formatString:(NSString *)str
{
    NSMutableString *tempStr = [NSMutableString string];
    for (NSInteger i = 0; i < str.length - 5; i++) {
        [tempStr appendString:@"*"];
    }
    
    NSMutableString *returnStr = [NSMutableString stringWithString:[str stringByReplacingCharactersInRange:NSMakeRange(0, str.length - 4) withString:tempStr]];
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataliat.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCell"];
    cell.selected = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (indexPath.section == _dataliat.count) {
//
//        cell.type = @"2";
//        cell.backgroundColor = rgb(82, 87, 89);
//        return cell;
//    }
    
    cell.type = @"1";
    [cell.bankImageView sd_setImageWithURL:[NSURL URLWithString:[_dataImageListBank objectAtIndex:indexPath.section]] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRefreshCached];
    cell.bankNameLabel.text = _bankWitchArray[indexPath.section];
    cell.bankNumLabel.text = _dataliat[indexPath.section];
    cell.backgroundColor = UIColor.clearColor;

    return cell;
//    MyCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCardCell"];
//    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[_dataImageListBank objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder_Image"] options:SDWebImageRefreshCached];
//    cell.bankCompanyLabel.text = _bankWitchArray[indexPath.row];
//    cell.bankNum.text =_dataliat[indexPath.row];
//    cell.banklist.text =_bankWitch[indexPath.row];
//    if (_defaultCardIndex == indexPath.row) {
//        cell.defaultFlag.hidden = NO;
//    }
//
//    if([_bankWitch[indexPath.row] isEqualToString:@"银行卡"])
//    {
//        cell.cardTypeFlag=0;
//        cell.btnEdit.hidden=NO;
//    }
//    else
//    {
//        cell.cardTypeFlag=1;
//        cell.btnEdit.hidden=YES;
//    }
//    cell.selected = NO;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 14;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 102;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//隐藏与现实tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


@end
