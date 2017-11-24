//
//  indexViewController.m
//  fxdProduct
//
//  Created by dd on 15/8/12.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "indexVCModules.h"
#import "RegViewController.h"
#import "LoginViewController.h"

@interface indexVCModules ()

@end

@implementation indexVCModules

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (IBAction)registerAction:(UIButton *)sender {
    RegViewController *regView = [RegViewController new];
    [self.navigationController pushViewController:regView animated:YES];
}

- (IBAction)loginAction:(UIButton *)sender {
    LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginView animated:YES];
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
