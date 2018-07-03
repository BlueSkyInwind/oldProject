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
//    if(indexPath.section==0)
//    {
//        if(indexPath.row==0){
//            [self obtainQuestionWebUrl:@"11"];
////            aboutUs=[[AboutMainViewController alloc]initWithNibName:@"AboutMainViewController" bundle:nil];
////            [self.navigationController pushViewController:aboutUs animated:YES];
//        }
//        else if(indexPath.row==1){
//            if ([FXD_Utility sharedUtility].loginFlage) {
//                ideaBack=[[IdeaBackViewController alloc]initWithNibName:@"IdeaBackViewController" bundle:nil];
//                [self.navigationController pushViewController:ideaBack animated:YES];
//            } else {
//                [self presentLogin:self];
//            }
//        }
//        else if(indexPath.row==2){
//            
//            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"欢迎给出评价!" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                dispatch_after(0.2, dispatch_get_main_queue(), ^{
//                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
//                });
//            }];
//            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            [alertView addAction:okAction];
//            [alertView addAction:cancleAction];
//            [self presentViewController:alertView animated:YES completion:nil];
//            
//        }
//        else if(indexPath.row==3){
//            UIAlertController *actionSheett = [UIAlertController alertControllerWithTitle:@"热线服务时间:9:00-17:30(工作日)" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//            UIAlertAction *teleAction = [UIAlertAction actionWithTitle:@"4008-678-655" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"4008-678-655"]];
//                [[UIApplication sharedApplication] openURL:telURL];
//            }];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            [actionSheett addAction:teleAction];
//            [actionSheett addAction:cancelAction];
//            [self presentViewController:actionSheett animated:YES completion:nil];
//        }
//        else if(indexPath.row==4){
//            
//            if ([FXD_Utility sharedUtility].loginFlage) {
//                ChangePasswordViewController *   changePassVC =[[ChangePasswordViewController alloc]init];
//                [self.navigationController pushViewController:changePassVC animated:YES];
//            } else {
//                [self presentLogin:self];
//            }
//        }
//    }
//    else {
//
//        [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:nil content:@"您确定要退出登录吗？" attributeDic:nil TextAlignment:NSTextAlignmentCenter cancelTitle:@"取消" sureTitle:@"确定" compleBlock:^(NSInteger index) {
//            if (index == 1) {
//                [self userLoginOut];
//            }
//        }];
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


@end
