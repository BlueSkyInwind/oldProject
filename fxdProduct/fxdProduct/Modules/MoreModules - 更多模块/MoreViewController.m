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
#import "PCCircleViewConst.h"
#import "LoginViewController.h"
#import "BaseNavigationViewController.h"
#import "ReturnMsgBaseClass.h"
#import "testView.h"
#import "FXDWebViewController.h"
#import "UIImage+Color.h"
#import "ChangePasswordViewController.h"
#import "LoginViewModel.h"

@interface MoreViewController () <UITableViewDataSource,UITableViewDelegate,MakeSureBtnDelegate,UIViewControllerTransitioningDelegate>
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

@end

@implementation MoreViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_MyTabView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"设置";
    [self addBackItem];
    imgAry=@[@"7_gd_icon_04",@"7_gd_icon_05",@"7_gd_icon_06",@"7_gd_icon_08",@"7_gd_icon_09",@"changeP_icon"];
    titleAry=@[@"关于我们",@"常见问题",@"意见反馈",@"给个好评",@"客服热线",@"修改密码"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_MyTabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_MyTabView registerNib:[UINib nibWithNibName:@"NextViewCell" bundle:nil] forCellReuseIdentifier:@"moreFunction"];
    [_MyTabView registerNib:[UINib nibWithNibName:@"HelpViewCell" bundle:nil] forCellReuseIdentifier:@"outLog"];
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"当前版本 V%@",app_Version];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([FXD_Utility sharedUtility].loginFlage){
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return imgAry.count;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section!=1)
    {
        return 12;
    } else
    {
        return 25;
    }
}

//创建自定义header视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 25)];
    view.backgroundColor=RGBColor(245, 245, 245, 1);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"moreFunction";
    NextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (indexPath.section == 0) {
        
        cell.imgView.image=[[UIImage imageNamed:imgAry[indexPath.row]] imageWithTintColor:UI_MAIN_COLOR];      cell.lblTitle.text=titleAry[indexPath.row];
        if (indexPath.row==imgAry.count-1) {
            cell.lineView.hidden=YES;
        }
        else
        {
            cell.lineView.hidden=NO;
        }

    }
    
    else{
        HelpViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"outLog"];
        cell.lblContent.text=@"退出登录";
        cell.lblContent.textAlignment=NSTextAlignmentCenter;
        cell.lblContent.font=[UIFont systemFontOfSize:17];
        cell.backgroundColor=[UIColor whiteColor];
        return cell;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([FXD_Utility sharedUtility].loginFlage)
    {
        return 50;
    }
    else
    {
        if(indexPath.section==0)
        {
            return 50;
        }
        else
        {
            return 0.1f;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        if(indexPath.row==0){
            aboutUs=[[AboutMainViewController alloc]initWithNibName:@"AboutMainViewController" bundle:nil];
            [self.navigationController pushViewController:aboutUs animated:YES];
        }
        else if(indexPath.row==1){
            FXDWebViewController *webview = [[FXDWebViewController alloc] init];
            webview.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_question_url];
            [self.navigationController pushViewController:webview animated:true];
        }
        else if(indexPath.row==2){
            if ([FXD_Utility sharedUtility].loginFlage) {
                ideaBack=[[IdeaBackViewController alloc]initWithNibName:@"IdeaBackViewController" bundle:nil];
                [self.navigationController pushViewController:ideaBack animated:YES];
            } else {
                [self presentLogin:self];
            }
        }
        else if(indexPath.row==3){
            
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"欢迎给出评价!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                dispatch_after(0.2, dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
                });
            }];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertView addAction:okAction];
            [alertView addAction:cancleAction];
            [self presentViewController:alertView animated:YES completion:nil];
            
        }
        else if(indexPath.row==4){
            UIAlertController *actionSheett = [UIAlertController alertControllerWithTitle:@"热线服务时间:9:00-17:30(工作日)" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *teleAction = [UIAlertAction actionWithTitle:@"4008-678-655" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"4008-678-655"]];
                [[UIApplication sharedApplication] openURL:telURL];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [actionSheett addAction:teleAction];
            [actionSheett addAction:cancelAction];
            [self presentViewController:actionSheett animated:YES completion:nil];
        }
        else if(indexPath.row==5){
            
            if ([FXD_Utility sharedUtility].loginFlage) {
                
                ChangePasswordViewController *   changePassVC =[[ChangePasswordViewController alloc]init];
                [self.navigationController pushViewController:changePassVC animated:YES];
            
            } else {
                [self presentLogin:self];
            }
        }
    }
    else {

        [[FXD_AlertViewCust sharedHHAlertView] showFXDAlertViewTitle:nil content:@"您确定要退出登录吗？" attributeDic:nil cancelTitle:@"取消" sureTitle:@"确定" compleBlock:^(NSInteger index) {
            if (index == 1) {
                [self userLoginOut];
            }
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 登录
- (void)presentLogin:(UIViewController *)vc
{
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
    nav.transitioningDelegate = self;
    [self presentViewController:nav animated:YES completion:nil];
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
            [self deleteUserRegisterID];
            LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
            [self presentViewController:nav animated:YES completion:^{
                [_alertView hide];
                [FXD_AppEmptyUserData EmptyData];
            }];
        }else{
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view.window message:baseVM.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    [loginVM userLoginOut];
}

#pragma mark 退出登录
-(void)deleteUserRegisterID{
    
    LoginViewModel * loginVM = [[LoginViewModel alloc]init];
    [loginVM deleteUserRegisterID];
}



@end
