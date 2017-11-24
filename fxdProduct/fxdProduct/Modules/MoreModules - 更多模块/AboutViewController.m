//
//  HelpViewController.m
//  fxdProduct
//
//  Created by zhangbaochuan on 15/10/9.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "AboutViewController.h"
#import "IdeaBackViewController.h"

@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUI
{
    self.title=@"帮助与反馈";
    self.view.backgroundColor=[UIColor colorWithRed:245./255.f green:245./255.f blue:245./255.f alpha:1.f];
}

#pragma mark---uitableView的代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifiercell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"新手指引";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"登录与注册";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"积分问题";
        } else {
            cell.textLabel.text = @"现金卷使用";
        }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"常见问题：";
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 60;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击");
}
//+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle;
//
//- (void)addAction:(UIAlertAction *)action;

- (IBAction)telephoneBtn:(id)sender {
    UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"" message:@"工作时间：9：00~18：00" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"400-8888-666" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"112"]];
        [[UIApplication sharedApplication] openURL:telURL];
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertCon animated:YES completion:nil];
    
}

- (IBAction)ideaBtn:(id)sender {
    IdeaBackViewController *ideaVC=[IdeaBackViewController new];
    [self.navigationController pushViewController:ideaVC animated:YES];

}


@end
