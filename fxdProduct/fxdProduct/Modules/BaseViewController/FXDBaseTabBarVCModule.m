//
//  FXDBaseTabBarVCModule.m
//  fxdProduct
//
//  Created by dd on 15/8/3.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "FXDBaseTabBarVCModule.h"
#import "BaseNavigationViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface FXDBaseTabBarVCModule () <UITabBarControllerDelegate>

@end

@implementation FXDBaseTabBarVCModule

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [self dropShadowWithOffset:CGSizeMake(0, -0.5)
                        radius:2
                         color:[UIColor lightGrayColor]
                       opacity:0.3];
    [self setTabbarCon];
    self.delegate = self;
}

- (void)setTabbarCon
{
    
    NSArray *vcNameArr = @[@"FXD_HomePageVCModules",@"SupermarketViewController",@".CreaditCardViewController",@"MyViewController"];
    NSArray *titleArr = @[@"首页",@"超市",@"信用卡",@"我的"];
    NSArray *imageArr = @[@"home_tab_default",@"superLoan_tab_default",@"card_tab_default",@"mine_tab_default"];
    NSArray *seleteimageArr = @[@"home_tab_select",@"superLoan_tab_select",@"card_tab_select",@"mine_tab_select"];
    
    NSMutableArray *ncArr = [NSMutableArray array];
    
    for (int i = 0; i < vcNameArr.count; i++) {
        //将字符串转化成类
        Class vc = NSClassFromString([vcNameArr objectAtIndex:i]);
        if (vc == nil) {
            //swift通过类名获取的方法
           vc = NSClassFromString([[FXD_Tool getProjectName] stringByAppendingString:[vcNameArr objectAtIndex:i]]);
        }
        //父类指针指向子类对象
        UIViewController *viewController = [[vc alloc]init];
//        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:viewController];
        BaseNavigationViewController *nc = [[BaseNavigationViewController alloc]initWithRootViewController:viewController];
        viewController.navigationItem.title = [titleArr objectAtIndex:i];
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
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:rgb(132, 132, 132)} forState:UIControlStateNormal];
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
    if (tabBarController.selectedIndex == 1){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:isSuperMark object:nil];
    }
    
    
    if (tabBarController.selectedIndex == 2) {
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

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
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
