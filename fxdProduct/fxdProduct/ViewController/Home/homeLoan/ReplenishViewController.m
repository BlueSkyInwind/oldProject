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

@interface ReplenishViewController ()<UITableViewDelegate,UITableViewDataSource,MoxieSDKDelegate>
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
            [self configMoxieSDK];
            [MoxieSDK shared].taskType = @"qq";
            [[MoxieSDK shared] startFunction];
        }

    }
    if (indexPath.row == 1) {
        if ([_authStateModel.result.qq_status isEqualToString:@"0"]) {
            [self configMoxieSDK];
            [MoxieSDK shared].taskType = @"alipay";
            [[MoxieSDK shared] startFunction];
        }
    }
}

-(void)configMoxieSDK{
    /***必须配置的基本参数*/
    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].userId = [Utility sharedUtility].userInfo.juid;
    [MoxieSDK shared].apiKey = theMoxieApiKey;
    [MoxieSDK shared].fromController = self;
    //-------------更多自定义参数，请参考文档----------------//
};

#pragma MoxieSDK Result Delegate
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    int code = [resultDictionary[@"code"] intValue];
    NSString *taskType = resultDictionary[@"taskType"];
    NSString *taskId = resultDictionary[@"taskId"];
    NSString *message = resultDictionary[@"message"];
    NSString *account = resultDictionary[@"account"];
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d",code,taskType,taskId,message,account,loginDone);
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        if ([taskType isEqualToString:@"qq"]) {
            [self fatchUserState];

        }
        if ([taskType isEqualToString:@"alipay"]) {
            [self fatchUserState];
        }
        NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        NSLog(@"用户未登录");
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    //0 其他失败原因
    //-2平台方不可用（如中国移动维护等）
    //-3魔蝎数据服务异常
    //-4用户输入出错（密码、验证码等输错后退出）
    else{
        NSLog(@"任务失败");
    }
}

-(void)editSDKInfo{
    _moxieSDK.navigationController.navigationBar.translucent = YES;
    _moxieSDK.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    [_moxieSDK.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation"] forBarMetrics:UIBarMetricsDefault];
    _moxieSDK.backImageName = @"return";
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
