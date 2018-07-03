//
//  MoreViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutMainViewController.h"
#import "AboutViewController.h"
#import "IdeaBackViewController.h"
#import "NextViewCell.h"
#import "HelpViewCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "LoginViewController.h"
#import "BaseNavigationViewController.h"
#import "testView.h"
#import "FXDWebViewController.h"
#import "UIImage+Color.h"
#import "ChangePasswordViewController.h"
#import "LoginViewModel.h"
#import "MineViewModel.h"

@interface MoreViewController () <UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate>
{
    NSArray *imgAry;
    NSArray *titleAry;
    UIView *lineView;
    //子功能视图
    AboutMainViewController *aboutUs;//关于视图
    IdeaBackViewController *ideaBack;//反馈视图
    testView *_alertView;
}
@property (weak, nonatomic) IBOutlet UITableView *MyTabView;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@end

@implementation MoreViewController

- (IBAction)exitBtnClick:(id)sender {
    
    [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:nil content:@"您确定要退出登录吗？" attributeDic:nil TextAlignment:NSTextAlignmentCenter cancelTitle:@"取消" sureTitle:@"确定" compleBlock:^(NSInteger index) {
        if (index == 1) {
            [self userLoginOut];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_MyTabView reloadData];
    self.exitBtn.hidden = true;
    if([FXD_Utility sharedUtility].loginFlage){
        
        self.exitBtn.hidden = false;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"设置";
    self.view.backgroundColor = rgb(242, 242, 242);
    [self addBackItem];
    titleAry=@[@"清除缓存",@"修改密码"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _MyTabView.backgroundColor = rgb(242, 242, 242);
    [_MyTabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_MyTabView registerNib:[UINib nibWithNibName:@"NextViewCell" bundle:nil] forCellReuseIdentifier:@"moreFunction"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"moreFunction";
    NextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.lblTitle.text=titleAry[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==titleAry.count-1) {
        cell.lineView.hidden=YES;
    }
    else
    {
        cell.lineView.hidden=NO;
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            [self clearCache];
            break;
        case 1:
        {
            if ([FXD_Utility sharedUtility].loginFlage) {
                ChangePasswordViewController *   changePassVC =[[ChangePasswordViewController alloc]init];
                [self.navigationController pushViewController:changePassVC animated:YES];
            } else {
                [self presentLoginVCCompletion:nil];
            }
        }
            break;
        default:
            break;
    }

}

#pragma mark 退出登录
- (void)userLoginOut
{
    [_alertView hide];
    if (![FXD_Utility sharedUtility].networkState) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"似乎没有连接到网络"];
        return;
    }
    
    LoginViewModel * loginVM = [[LoginViewModel alloc]init];
    [loginVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseVM = returnValue;
        if ([baseVM.errCode isEqualToString:@"0"]) {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0/*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            [self presentLoginVCCompletion:^{
                [_alertView hide];
                [FXD_Utility EmptyData];
            }];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view.window message:baseVM.friendErrMsg];
        }
    } WithFaileBlock:^{
    }];
    [loginVM userLoginOut];
}

-(void)deleteUserRegisterID{
    
    LoginViewModel * loginVM = [[LoginViewModel alloc]init];
    [loginVM deleteUserRegisterID];
    
}

#pragma mark 清除缓存
-(void)clearCache{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    for (NSString *p in files) {
        NSError *error;
        NSString *Path = [path stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
            //清理缓存，保留Preference，里面含有NSUserDefaults保存的信息
            if (![Path containsString:@"Preferences"]) {
                [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
            }
        }else{
            
        }
    }
    
    [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:@"清除缓存完成"];
}

@end
