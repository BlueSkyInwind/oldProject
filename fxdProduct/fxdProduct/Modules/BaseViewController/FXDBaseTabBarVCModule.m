//
//  FXDBaseTabBarVCModule.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "FXDBaseTabBarVCModule.h"
#import "BaseNavigationViewController.h"
#import "HomePageVCModules.h"
#import "MyViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface FXDBaseTabBarVCModule () <UITabBarControllerDelegate>

@end

@implementation FXDBaseTabBarVCModule

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTabbarCon];
    self.delegate = self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
    

}

//- (void)InfoNotificationAction:(NSNotification *)notification{
//
//    NSLog(@"%@",notification.userInfo);
//
//    NSLog(@"---接收到通知---");
//    NSDictionary  *dic = [notification userInfo];
//    NSString *info = [dic objectForKey:@"isDisplay"];
////    UITabBarItem * item = [self.tabBar.items objectAtIndex:2];
////    item.badgeValue = @" ";
//    [self.tabBarController.tabBar showBadgeOnItemIndex:2];
//
////    item.badgeValue = nil;
//
//}

- (void)setTabbarCon
{
    
    NSArray *vcNameArr = @[@"FXD_HomePageVCModules",@"AuthenticationCenterVCModules",@"MyViewController"];
    NSArray *titleArr = @[@"首页",@"认证",@"我的"];
    NSArray *imageArr = @[@"home_tab_default",@"icon_2-2",@"mine_tab_default"];
    NSArray *seleteimageArr = @[@"home_tab_select",@"icon_2-1",@"mine_tab_select"];
    
    NSMutableArray *ncArr = [NSMutableArray array];
    
    for (int i = 0; i < vcNameArr.count; i++) {

        //将字符串转化成类
        Class vc = NSClassFromString([vcNameArr objectAtIndex:i]);
        //父类指针指向子类对象
        UIViewController *viewController = [[vc alloc]init];
        BaseNavigationViewController *nc = [[BaseNavigationViewController alloc]initWithRootViewController:viewController];
        viewController.navigationItem.title = [titleArr objectAtIndex:i];
        //        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:[titleArr objectAtIndex:i] image:nil selectedImage:nil];
        nc.tabBarItem = [self tabBarItemWithName:[titleArr objectAtIndex:i] image:[imageArr objectAtIndex:i] selectedImage:[seleteimageArr objectAtIndex:i]];
        [ncArr addObject:nc];
    }
    self.viewControllers = ncArr;
}

//设置tabbar的图标
- (UITabBarItem *)tabBarItemWithName:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    UIImage *image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectedImage];
    //    [item setImageInsets:UIEdgeInsetsMake(3, 0, -3, 0)];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:rgb(153, 153, 153)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UI_MAIN_COLOR} forState:UIControlStateSelected];
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    return item;
}


-(void)makeTabBarHidden:(BOOL)hide { // Custom code to hide TabBar
    if ( [self.view.subviews count] < 2 ) { return;
    }
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
        contentView = [self.view.subviews objectAtIndex:1]; } else {
            contentView = [self.view.subviews objectAtIndex:0]; }
    if (hide) {
        contentView.frame = self.view.bounds; } else {
            contentView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y,
                                           self.view.bounds.size.width, self.view.bounds.size.height -
                                           self.tabBar.frame.size.height); }
    self.tabBar.hidden = hide;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex == 1 || tabBarController.selectedIndex == 2) {
        if ([FXD_Utility sharedUtility].loginFlage) {
            
        } else {
            [self presentLogin:self];
        }
    }
}

- (void)presentLogin:(UIViewController *)vc
{
    LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginView];
    [vc presentViewController:nav animated:YES completion:nil];
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
