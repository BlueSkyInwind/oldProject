//
//  ChangePasswordViewController.m
//  fxdProduct
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ChangePasswordTableViewCell.h"
#import "ChangePasswordViewModel.h"
#import "BaseNavigationViewController.h"
#import "LoginViewController.h"

@interface ChangePasswordViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>{
    
    //旧密码
    NSString * oldPassword;
    //新密码
    NSString * newPassword;
    //左边标题数组
    NSArray * tiitleArr;

}

@property (strong , nonatomic)UITableView * tableView;
@property (strong , nonatomic)UIButton * sureButton;

@end


@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改登录密码";
    [self addBackItem];
    tiitleArr = @[@"当前密码",@"新密码",@"确认新密码"];
    self.view.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [self configureview];

}
#pragma mark 初始化tableView
-(void)configureview{
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[ChangePasswordTableViewCell class] forCellReuseIdentifier:@"ChangePasswordTableViewCell"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_IS_IPHONE6P) {
        return 60;
    }else{
        return 46;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangePasswordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChangePasswordTableViewCell"];
    if (!cell) {
        cell = [[ChangePasswordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChangePasswordTableViewCell"];
    }
    switch (indexPath.row) {
        case 0:{
            cell.topLineView.hidden = NO;
            cell.titleLabel.text = tiitleArr[indexPath.row];
            [cell updateTitleWidth:tiitleArr[indexPath.row]];
            cell.contentTextField.placeholder = @"请输入当前的登录密码";
        }
            break;
        case 1:{
            cell.topLineView.hidden = YES;
            cell.titleLabel.text = tiitleArr[indexPath.row];
            [cell updateTitleWidth:tiitleArr[indexPath.row]];
            cell.contentTextField.placeholder = @"6-12位字母、数字";
        }
            break;
        case 2:{
            cell.topLineView.hidden = YES;
            cell.titleLabel.text = tiitleArr[indexPath.row];
            [cell updateTitleWidth:tiitleArr[indexPath.row]];
            cell.contentTextField.placeholder = @"6-12位字母、数字";
            [cell.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.backView.mas_left).offset(0);
            }];
        }
            break;
            
        default:
            break;
    }
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc]init];
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.sureButton setBackgroundColor:UI_MAIN_COLOR];
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(saveChangePassword:) forControlEvents:UIControlEventTouchUpInside];
    [FXD_Tool setCorner:self.sureButton borderColor:UI_MAIN_COLOR];
    [view addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(17);
        make.right.equalTo(view.mas_right).with.offset(-17);
        make.height.equalTo(@50);
        make.centerY.equalTo(view.mas_centerY);
    }];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

#pragma mark 确认提交按钮
-(void)saveChangePassword:(id)sender{
    
    ChangePasswordViewModel * changePasswordVM = [[ChangePasswordViewModel alloc]init];
    __weak typeof (self) weakSelf = self;
    [changePasswordVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel *model = returnValue;
        if ([model.errCode isEqualToString:@"0"]) {
            
            [[MBPAlertView sharedMBPTextView]showTextOnly:[UIApplication sharedApplication].keyWindow message:model.msg];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0/*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            [weakSelf presentLogin];
        }else{
            NSLog(@"%@",model.msg);
            [[MBPAlertView sharedMBPTextView]showTextOnly:self.view message:model.friendErrMsg];
        }
    } WithFaileBlock:^{
        
    }];
    
    if ([self checkInputPassword]) {
        [changePasswordVM fetchChangePassowrdCurrent:oldPassword new:newPassword];
    }
}

#pragma mark 初步检查用户输入情况
-(BOOL)checkInputPassword{
    
    ChangePasswordTableViewCell * oldcell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ChangePasswordTableViewCell * newcell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    ChangePasswordTableViewCell * newcell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if(oldcell.contentTextField.text.length < 6){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位"];
        return NO;
    }
    if(newcell1.contentTextField.text.length < 6){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位"];
        return NO;
    }
    if(newcell2.contentTextField.text.length < 6){
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"请保持密码长度在6~16位"];
        return NO;
    }
    if (![newcell1.contentTextField.text isEqualToString:newcell2.contentTextField.text]) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:self.view message:@"两次输入密码不一致！"];
        return NO;
    }
    oldPassword = oldcell.contentTextField.text;
    newPassword = newcell1.contentTextField.text;
    
    return YES;
}

#pragma mark 登录
- (void)presentLogin
{
    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
    nav.transitioningDelegate = self;
    [self presentViewController:nav animated:YES completion:nil];
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
