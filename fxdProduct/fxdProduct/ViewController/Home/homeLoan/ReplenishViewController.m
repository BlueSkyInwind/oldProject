//
//  ReplenishViewController.m
//  fxdProduct
//
//  Created by dd on 2016/11/3.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "ReplenishViewController.h"
#import "MoreInfoCell.h"
#import "MoxieSDK.h"
#import "UserStateModel.h"
#import "AuthStatus.h"

@interface ReplenishViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_imageArr;
    NSArray *_titleArr;
    MoxieSDK *_moxieSDK;
    NSMutableArray *_describeArr;
    AuthStatus *_authStateModel;
}
@end

NSString * const CellIdentifier = @"MoreOnfoCell";

@implementation ReplenishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"补充资料";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _imageArr = @[@"approve_alipay",@"approve_qq"];
    _titleArr = @[@"支付宝认证",@"QQ认证"];
    _describeArr = [NSMutableArray arrayWithObjects:@"未认证",@"未认证", nil];
    self.tableview.scrollEnabled = NO;
    [self.tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MoreInfoCell class]) bundle:nil] forCellReuseIdentifier:CellIdentifier];
    [self addBackItem];
    [Tool setCorner:self.nextBtn borderColor:[UIColor clearColor]];
    [self fatchUserState];
    
}

/**
 0:未认证;1:认证中;2:认证成功;3:认证失败
 */
- (void)fatchUserState
{
    __weak ReplenishViewController *weakself = self;
    NSDictionary *paramDic = @{@"case_info_id_":_userStateModel.case_info_id};
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_queryAuthStatus_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
        _authStateModel = [AuthStatus yy_modelWithJSON:object];
        if ([_authStateModel.flag isEqualToString:@"0000"]) {
            [_describeArr replaceObjectAtIndex:0 withObject:_authStateModel.result.alipay_dec];
            [_describeArr replaceObjectAtIndex:1 withObject:_authStateModel.result.qq_dec];
            [weakself.tableview reloadData];
        }else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:weakself.view message:_authStateModel.msg];
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    if (![_authStateModel.result.qq_status isEqualToString:@"0"] || ![_authStateModel.result.alipay_status isEqualToString:@"0"]) {
        [self.delegate refreshUI];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"不认证将无法获取借款额度" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *reject = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *goState = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:reject];
        [alert addAction:goState];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//- (void)viewWillAppear:(BOOL)animated{
//    
//}

#pragma mark -TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.imageView.image = [UIImage imageNamed:[_imageArr objectAtIndex:indexPath.row]];
    cell.title.text = [_titleArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 1) {
        cell.lineView.hidden = YES;
    }
    cell.describe.text = [_describeArr objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([_authStateModel.result.alipay_status isEqualToString:@"0"]) {
            [self initMXSDK];
            [_moxieSDK startFunction:MXSDKFunctionalipay];
        }
//        else {
//            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"当前不可进行认证操作"];
//        }
    }
    if (indexPath.row == 1) {
        if ([_authStateModel.result.qq_status isEqualToString:@"0"]) {
            [self initMXSDK];
            [_moxieSDK startFunction:MXSDKFunctionqq];
        }
    }
}


-(void)initMXSDK{
    //设置公司和用户参数
    if (_moxieSDK == nil) {
        _moxieSDK = [[MoxieSDK shared] initWithUserID:_userStateModel.case_info_id mApikey:theMoxieApiKey controller:self];
    }
    DLog(@"%@",_moxieSDK.mxSDKVersion);
    //修改内部参数
    [self editSDKInfo];
    //添加结果回调
    [self listenForResult];
}

-(void)listenForResult{
    __weak ReplenishViewController *weakself = self;
    [MoxieSDK shared].resultBlock=^(int code,MXSDKFunction funciton,NSString *taskid,NSString *searchid){
        DLog(@"get import result---statusCode:%d,function:%d,taskid:%@,searchid:%@",code,funciton,taskid,searchid);
        if (funciton == MXSDKFunctionalipay) {
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (code == 1) {
//                        [_describeArr replaceObjectAtIndex:0 withObject:@"认证中"];
//                        [weakself.tableview reloadData];
//                    }
                    [weakself fatchUserState];
                });
            });
        }
        
        if (MXSDKFunctionqq) {
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (code == 1) {
//                        [_describeArr replaceObjectAtIndex:1 withObject:@"认证中"];
//                        [weakself.tableview reloadData];
//                    }
                    [weakself fatchUserState];
                });
            });
        }
    };
}

-(void)editSDKInfo{
    _moxieSDK.mxNavigationController.navigationBar.translucent = YES;
    _moxieSDK.mxNavigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [_moxieSDK.mxNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation"] forBarMetrics:UIBarMetricsDefault];
    _moxieSDK.backImage = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
