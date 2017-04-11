//
//  UserInfoViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/27.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ChangePWViewController.h"
#import "UIImageView+WebCache.h"
#import "UserInfoCell.h"
#import "BasicInfoViewController.h"
#import "ProfessViewController.h"
#import "CustomerBaseInfoBaseClass.h"
#import "CustomerCareerBaseClass.h"
#import "GetCareerInfoViewModel.h"
#import "GetCustomerBaseViewModel.h"
#import "DataWriteAndRead.h"
#import "UserStateModel.h"

@interface UserInfoViewController () <UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    
}
@property (nonatomic, strong) CustomerBaseInfoBaseClass *customerBase;
@property (nonatomic, strong) CustomerCareerBaseClass *carrerInfo;

@property (strong, nonatomic) IBOutlet UITableView *InfoTableView;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //    self.InfoTableView.scrollEnabled = NO;
    self.InfoTableView.delegate = self;
    self.InfoTableView.dataSource = self;
    self.InfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //    [self.InfoTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.InfoTableView registerClass:[UserInfoCell class] forCellReuseIdentifier:@"userInfoCell"];
    
    self.navigationItem.title = @"个人资料";
    [self addBackItem];
}


#pragma mark - TableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 60)];
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 59, _k_w, 1)];
    bottomLine.backgroundColor = RGBColor(214, 214, 214, 1);
    [headView addSubview:bottomLine];
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 50, 30)];
    titLab.text = @"账户";
    titLab.textAlignment = NSTextAlignmentCenter;
    [titLab setFont:[UIFont systemFontOfSize:20]];
    [headView addSubview:titLab];
    UILabel *userIdLab = [[UILabel alloc]initWithFrame:CGRectMake(_k_w - 165, 15, 150, 30)];
    NSString *telString = @"";
    if ([Utility sharedUtility].userInfo.userName) {
        telString = [self formatString:[Utility sharedUtility].userInfo.userName];
    }
    userIdLab.text = telString;
    userIdLab.textColor = RGBColor(158, 158, 159, 1);
    [userIdLab setFont:[UIFont systemFontOfSize:20]];
    userIdLab.textAlignment = NSTextAlignmentRight;
    [headView addSubview:userIdLab];
    headView.backgroundColor = [UIColor whiteColor];
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 650;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"loanRecord"];
    if (!cell) {
        cell = [[UserInfoCell alloc] init];
    }
    //    cell.customerBaseClass = _customerBase;
    //    cell.carrerInfoModel = _carrerInfo;
    [cell CustomBaseinfoModel:_customerBase andcustomCareerBaseModel:_carrerInfo];
    if (_userStateModel.applyStatus == nil || [_userStateModel.applyStatus isEqualToString:@""]) {
        _userStateModel.applyStatus = @"0";
    }
    switch (_userStateModel.applyStatus.integerValue) {
        case 14:
        case 17:
        case 2:
        case 6:
        case 0:
        {
            [[cell.basicEditBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                BasicInfoViewController *basicInfoEditView = [BasicInfoViewController new];
                [self.navigationController pushViewController:basicInfoEditView animated:YES];
            }];
            
            [[cell.professEditBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                ProfessViewController *professEditView = [ProfessViewController new];
                [self.navigationController pushViewController:professEditView animated:YES];
            }];
        }
            break;
            
        default:
        {
            cell.basicEditBtn.hidden = true;
            cell.professEditBtn.hidden = true;
        }
            break;
    }
    return  cell;
}


- (NSString *)formatString:(NSString *)str
{
    NSMutableString *returnStr = [NSMutableString stringWithString:str];
    
    NSMutableString *zbc = [NSMutableString string];
    for (NSInteger i = 0; i < returnStr.length; i++) {
        unichar c = [returnStr characterAtIndex:i];
        if (i > 0) {
            if (i == 2) {
                [zbc appendFormat:@"%C ",c];
                
            }else if (i == 6){
                [zbc appendFormat:@"%C ",c];
            }else {
                [zbc appendFormat:@"%C",c];
            }
        } else {
            [zbc appendFormat:@"%C",c];
        }
    }
    
    return zbc;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self PostPersonInfoMessage];
    [self PostgetCustomerCarrer_jhtml];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark-> PostgetCustomerCarrer_jhtml 获取职业信息

-(void)PostgetCustomerCarrer_jhtml
{
    GetCareerInfoViewModel *careerInfoViewModel = [[GetCareerInfoViewModel alloc] init];
    [careerInfoViewModel setBlockWithReturnBlock:^(id returnValue) {
        _carrerInfo = returnValue;
        if ([_carrerInfo.flag isEqualToString:@"0000"]) {
            //给职业信息赋值
            [_InfoTableView reloadData];
        }
    } WithFaileBlock:^{
        
    }];
    [careerInfoViewModel fatchCareerInfo:nil];
    
}

#pragma mark->获取个人信息
-(void)PostPersonInfoMessage
{
    GetCustomerBaseViewModel *customBaseViewModel = [[GetCustomerBaseViewModel alloc] init];
    [customBaseViewModel setBlockWithReturnBlock:^(id returnValue) {
        _customerBase = returnValue;
        if ([_customerBase.flag isEqualToString:@"0000"]) {
            [DataWriteAndRead writeDataWithkey:UserInfomation value:_customerBase];
            [_InfoTableView reloadData];
        }
    } WithFaileBlock:^{
        
    }];
    [customBaseViewModel fatchCustomBaseInfo:nil];
}

@end
