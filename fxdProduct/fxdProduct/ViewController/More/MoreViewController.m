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
#import "HelpViewController.h"
#import "NextViewCell.h"
#import "HelpViewCell.h"
#import "GesturesPasswordCell.h"
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


@interface MoreViewController () <UITableViewDataSource,UITableViewDelegate,MakeSureBtnDelegate,UIViewControllerTransitioningDelegate>
{
    NSArray *imgAry;
    NSArray *titleAry;
    UIView *lineView;
    //子功能视图
    AboutMainViewController *aboutUs;//关于视图
    HelpViewController *helpView;//常见问题
    IdeaBackViewController *ideaBack;//反馈视图
    ReturnMsgBaseClass *_returnMsgParse;
    testView *_alertView;
}
@property (weak, nonatomic) IBOutlet UITableView *MyTabView;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation MoreViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    //    [self.MyTabView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [_MyTabView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavMesRightBar];
    //    imgAry=@[@"7_gd_icon_04",@"7_gd_icon_05",@"7_gd_icon_06",@"7_gd_icon_07",@"7_gd_icon_08",@"7_gd_icon_09",@"7_gd_icon_10"];
    imgAry=@[@"7_gd_icon_04",@"7_gd_icon_05",@"7_gd_icon_06",@"7_gd_icon_08",@"7_gd_icon_09",@"7_gd_icon_09"];
    //    titleAry=@[@"关于我们",@"常见问题",@"意见反馈",@"分享好友",@"给个好评",@"客服热线",@"手势密码"];
    titleAry=@[@"关于我们",@"常见问题",@"意见反馈",@"给个好评",@"客服热线",@"修改密码"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    _MyTabView.scrollEnabled = NO;
    [_MyTabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_MyTabView registerNib:[UINib nibWithNibName:@"NextViewCell" bundle:nil] forCellReuseIdentifier:@"moreFunction"];
    [_MyTabView registerNib:[UINib nibWithNibName:@"HelpViewCell" bundle:nil] forCellReuseIdentifier:@"outLog"];
    [_MyTabView registerNib:[UINib nibWithNibName:@"GesturesPasswordCell" bundle:nil] forCellReuseIdentifier:@"password"];
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"当前版本 V%@",app_Version];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([Utility sharedUtility].loginFlage){
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
    //    else if(indexPath.section == 1)
    //    {
    //        //password
    //        GesturesPasswordCell *cell=[tableView dequeueReusableCellWithIdentifier:@"password"];
    //        cell.imgView.image=[UIImage imageNamed:imgAry[imgAry.count-1]];
    //        cell.lblTitle.text=titleAry[titleAry.count-1];
    //
    //        if ([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] isEqualToString:@""] || [PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] == nil) {
    //            cell.passwordSwitch.on = NO;
    //        } else {
    //            cell.passwordSwitch.on = YES;
    //        }
    //
    //        DLog(@"state  --- %d",cell.passwordSwitch.on);
    //        [cell.passwordSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        return cell;
    //    }
    
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
    if([Utility sharedUtility].loginFlage)
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
//            helpView=[[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
//            [self.navigationController pushViewController:helpView animated:YES];
            FXDWebViewController *webview = [[FXDWebViewController alloc] init];
            webview.urlStr = [NSString stringWithFormat:@"%@%@",_H5_url,_question_url];
            [self.navigationController pushViewController:webview animated:true];
        }
        else if(indexPath.row==2){
            if ([Utility sharedUtility].loginFlage) {
                ideaBack=[[IdeaBackViewController alloc]initWithNibName:@"IdeaBackViewController" bundle:nil];
                [self.navigationController pushViewController:ideaBack animated:YES];
            } else {
                [self presentLogin:self];
            }
        }
//        else if(indexPath.row==3)
//        {
//            [self shareContent:tableView];
//        }
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
        }    else if(indexPath.row==5){
            
          ChangePasswordViewController *   changePassVC =[[ChangePasswordViewController alloc]init];
            [self.navigationController pushViewController:changePassVC animated:YES];
        }
    }
    //    else if(indexPath.section==1) {
    //
    //    }
    else {
        _alertView = [[[NSBundle mainBundle] loadNibNamed:@"testView" owner:self options:nil] objectAtIndex:0];
        _alertView.frame=CGRectMake(0, 0, _k_w, _k_h);
        _alertView.delegat = self;
        _alertView.lbltitle.text = @"\n您确定要退出登录吗？";
        _alertView.lbltitle.textColor = [UIColor blackColor];
        [_alertView.sureBtn setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
        [_alertView show];
        
        
        //        [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeTop leaveMode:HHAlertLeaveModeBottom disPlayMode:HHAlertViewModeWarning title:nil detail:@"您当前尝试退出登录状态，是否继续操作？" cencelBtn:@"取消" otherBtn:@[@"确定"] Onview:[[UIApplication sharedApplication].delegate window]  compleBlock:^(NSInteger index) {
        //            if (index == 1) {
        //
        //
        //            }
        //        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#define mark ActionSheetDelegate

//- (void)switchClick:(UISwitch *)sender
//{
//    DLog(@"%d",sender.on);
//    if (sender.on == TRUE) {
//        GestureViewController *gestureVc = [[GestureViewController alloc] init];
//        gestureVc.type = GestureViewControllerTypeSetting;
//        gestureVc.delegate = self;
//        [self.navigationController pushViewController:gestureVc animated:YES];
//    } else {
//        GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
//        [self.navigationController pushViewController:gestureVerifyVc animated:YES];
//    }
//}


- (void)setSwithchState:(BOOL)state
{
    DLog(@"%@",[Utility sharedUtility].userInfo.userName);
    DLog(@"%@",[Utility sharedUtility].userInfo.userPass);
    [PCCircleViewConst saveGesture:[Utility sharedUtility].userInfo.userName Key:kUserID];
    if ([[PCCircleViewConst getGestureWithKey:kUserPass] isEqualToString:@""] && [PCCircleViewConst getGestureWithKey:kUserPass] == nil) {
        [PCCircleViewConst saveGesture:[Utility sharedUtility].userInfo.userPass Key:kUserPass];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.MyTabView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)gestureVerifyState
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.MyTabView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

//分享函数
-(void)shareContent:(UITableView*)tableView
{
    NSArray *imageArr = @[[UIImage imageNamed:@"logo_60"]];
    if (imageArr) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"发薪贷只专注于网络小额贷款。是一款新型网络小额贷款神器, 尽可能优化贷款申请流程，申请步骤更便捷，轻完成网上贷款。链接:http://www.faxindai.com"
                                         images:imageArr
                                            url:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]
                                          title:@"发薪贷"
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK showShareActionSheet:nil
                                 items:@[@(SSDKPlatformSubTypeWechatSession),
                                         @(SSDKPlatformSubTypeWechatTimeline),
                                         @(SSDKPlatformTypeSinaWeibo),
                                         @(SSDKPlatformTypeQQ),
                                         @(SSDKPlatformSubTypeQZone),
                                         @(SSDKPlatformTypeSMS)]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享成功"];
                               break;
                               
                           case SSDKResponseStateFail:
                               [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"分享失败"];
                           default:
                               break;
                       }
                   }];
    }
}

- (void)presentLogin:(UIViewController *)vc
{
    LoginViewController *loginView = [[LoginViewController alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
    nav.transitioningDelegate = self;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark arertViewDelegate
- (void)MakeSureBtn:(NSInteger)tag
{
    [_alertView hide];
    if ([Utility sharedUtility].networkState) {
        if ([Utility sharedUtility].userInfo.juid != nil && ![[Utility sharedUtility].userInfo.juid isEqualToString:@""]) {
            NSDictionary *paramDic = @{@"juid":[Utility sharedUtility].userInfo.juid};
            [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_loginOut_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
                _returnMsgParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
                if ([_returnMsgParse.flag isEqualToString:@"0000"]) {
                    LoginViewController *loginView = [LoginViewController new];
                    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
                    [self presentViewController:nav animated:YES completion:^{
                        [_alertView hide];
                        [EmptyUserData EmptyData];
                    }];
                } else {
                    [[MBPAlertView sharedMBPTextView] showTextOnly:self.view.window message:_returnMsgParse.msg];
                }
            } failure:^(EnumServerStatus status, id object) {
                
            }];
        } else {
            [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"参数错误"];
        }
        
    } else {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"似乎没有连接到网络"];
    }
}


@end
