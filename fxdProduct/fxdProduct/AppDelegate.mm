//
//  AppDelegate.m
//  fxdProduct
//
//  Created by dd on 15/7/27.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationViewController.h"
#import "LunchViewController.h"
#import "CALayer+Transition.h"
#import "DataBaseManager.h"
#import "testModelFmdb.h"
#import "BSFingerSDK.h"
#import "ShareConfig.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "FXDAppUpdateChecker.h"
#import "SetUpFMDevice.h"
#import "SetSome.h"



NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";

@interface AppDelegate () <JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>
{
    NSString *_deviceToken;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.window makeKeyAndVisible];
    [self monitorNetworkState];
    self.window.rootViewController = [UIViewController new];
    
//    [self heguiceshi];

    [self tripartiteInitialize];

    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    [[IQKeyboardManager sharedManager]setShouldResignOnTouchOutside:true];
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = true;

    if (!kiOS8Later) {
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:@"您的系统版本太低,请升级至iOS8.0以上使用!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            exit(0);
        }];
        [alertControl addAction:okAction];
        [self.window.rootViewController presentViewController:alertControl animated:YES completion:nil];
    }
    
    //判断屏幕尺寸适配
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(_k_h > 480){
        myDelegate.autoSizeScaleX = _k_w/320;
        myDelegate.autoSizeScaleY = _k_h/568;
    }
    
//    [self createFMDB:launchOptions];
    [self initJPush:launchOptions];

    BOOL isFirst = [LunchViewController canShowNewFeature];
//    isFirst = true;
    if (isFirst) {
        self.window.rootViewController = [LunchViewController newLunchVCWithModels:@[@"guide_1",@"guide_2",@"guide_3"] enterBlock:^{
            [self enter];
            [EmptyUserData EmptyData];
        }];
    } else {
        [self enter];
    }
    if (userTableName) {
        [[DataBaseManager shareManager] dbOpen:userTableName];
    }
    
    return YES;
}
/**
 三方初始化
 */
-(void)tripartiteInitialize{
    dispatch_queue_t queue = dispatch_queue_create("trilateral_initialize", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        //shareSDK
        [ShareConfig configDefaultShare];
        //FMDevice
        [SetUpFMDevice configFMDevice];
        [[SetSome shared]InitializeAppSet];
    });
}
-(void)createFMDB:(NSDictionary *)launchOptions{
    
    // [2-EXT]: 获取启动时收到的APN数据
    NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        NSString *payloadMsg = [message objectForKey:@"payload"];
        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        if (payloadMsg && ![payloadMsg isEqualToString:@""]) {
            //数据库创建
            if(![userTableName isEqualToString:@""])
            {
                testModelFmdb *msg=[[testModelFmdb alloc]init];
                msg.title=@"通知";
                msg.date=[Tool getNowTime];
                msg.content=payloadMsg;
                [[DataBaseManager shareManager]insertWithModel:msg:userTableName];
            }
        }
        DLog(@"%@",record);
    }
}

-(void)heguiceshi{
    
    [Utility sharedUtility].userInfo.juid = @"ab6a0ee1ecaa48069b1af882375891c4";
    [Utility sharedUtility].userInfo.tokenStr = [NSString stringWithFormat:@"%@token",@"ab6a0ee1ecaa48069b1af882375891c4"];
    [Utility sharedUtility].loginFlage = YES;
}

- (void)monitorNetworkState
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                DLog(@"未知网络 || 没有网络(断网)");
                [Utility sharedUtility].networkState = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                DLog(@"手机自带网络 || WIFI");
                [Utility sharedUtility].networkState = YES;
                break;
        }
    }];
    // 3.开始监控
    [mgr startMonitoring];
}


-(void)enter{
    
    self.btb = [[BaseTabBarViewController alloc]init];
    self.window.rootViewController = self.btb;
    
    //    [self.window.layer transitionWithAnimType:TransitionAnimTypeRamdom subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:2.0f];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddMaterailNotification object:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //清除激光推送JPush服务器中存储的badge值
    [JPUSHService resetBadge];
    [[FXDAppUpdateChecker sharedUpdateChecker] checkAPPVersion];

}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[DataBaseManager shareManager] dbClose];
    [[BSFingerSDK sharedInstance] cancelAll];
}
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)initJPush:(NSDictionary *)launchOptions{
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加 定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    //    NSDictionary * userInfo = [notification userInfo];
    //    NSString *content = [userInfo valueForKey:@"content"];
    //    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    //    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeNone categories:nil];
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    _notificationContentInfo = notification.request.content.userInfo;
    //    [self NotificationJump:notificationContentInfo];
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    _notificationContentInfo = response.notification.request.content.userInfo;
    [self NotificationJump:_notificationContentInfo];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:_notificationContentInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    _notificationContentInfo= userInfo;
    // Required, iOS 7 Support
    if (application.applicationState == UIApplicationStateActive ){
        
    }else if(application.applicationState == UIApplicationStateBackground){
        
        
    }else if(application.applicationState == UIApplicationStateInactive){
        
        
    }
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)NotificationJump:(NSDictionary *)contentInfo{
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}



//数据库创建
//if(![userTableName isEqualToString:@""])
//{
//    testModelFmdb *msg=[[testModelFmdb alloc]init];
//    msg.title=@"通知";
//    msg.date=[Tool getNowTime];
//    msg.content = payloadMsg;
//    [[DataBaseManager shareManager]insertWithModel:msg:userTableName];
//}



@end
