//
//  PayNavigationViewController.m
//  fxdProduct
//
//  Created by dd on 16/7/18.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "PayNavigationViewController.h"

@interface PayNavigationViewController ()

@end

@implementation PayNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
            self.view.frame = CGRectMake(0, _k_h-270, _k_w, 270);
        } completion:nil];
        
    }else {
        self.view.frame = CGRectMake(0, 0, _k_w, 200);
    }
    [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        self.view.frame = CGRectMake(0, _k_h-200, _k_w, 200);
    }else {
        self.view.frame = CGRectMake(0, _k_h-270, _k_w, 270);
    }
    
    return [super popViewControllerAnimated:animated];
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
