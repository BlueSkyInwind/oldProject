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
#import "GeTuiSdk.h"
#import "DataBaseManager.h"
#import "testModelFmdb.h"
#import "BSFingerSDK.h"
#import "ShareConfig.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
#import "FXDAppUpdateChecker.h"
#import "SetUpFMDevice.h"
#import "SetSome.h"



NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";

@interface AppDelegate () <GeTuiSdkDelegate,UNUserNotificationCenterDelegate>
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
    
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:GeTuiAppId appKey:GeTuiAppKey appSecret:GeTuiAppSecret];
    
    // [2]:注册APNS
    [self registerRemoteNotification];
    
    [self createFMDB:launchOptions];

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

//- (BOOL)application:(UIApplication *)application
//      handleOpenURL:(NSURL *)url
//{
//    
//    return [ShareSDK handleOpenURL:url
//                        wxDelegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
//    return [ShareSDK handleOpenURL:url
//                 sourceApplication:sourceApplication
//                        annotation:annotation
//                        wxDelegate:self];
//}

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
    [GeTuiSdk runBackgroundEnable:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddMaterailNotification object:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[FXDAppUpdateChecker sharedUpdateChecker] checkAPPVersion];
    // [EXT] 重新上线
    [self startSdkWith:GeTuiAppId appKey:GeTuiAppKey appSecret:GeTuiAppSecret];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[DataBaseManager shareManager] dbClose];
    [GeTuiSdk runBackgroundEnable:YES];
    [[BSFingerSDK sharedInstance] cancelAll];
}

#pragma mark - background fetch  唤醒
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //[5] Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLog(@"deviceToken:%@", _deviceToken);
    
    // [3]:向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:_deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // [3-EXT]:注册失败，通知个推服务器
    [GeTuiSdk registerDeviceToken:@""];
    DLog(@"%@",[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo {
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    if (payloadMsg) {
        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        DLog(@"%@",record);
        if (payloadMsg && ![payloadMsg isEqualToString:@""]) {
            //数据库创建
            if(![userTableName isEqualToString:@""])
            {
                testModelFmdb *msg=[[testModelFmdb alloc]init];
                msg.title=@"通知";
                msg.date=[Tool getNowTime];
                msg.content = payloadMsg;
                [[DataBaseManager shareManager]insertWithModel:msg:userTableName];
            }
            UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"通知" message:payloadMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self.window.rootViewController presentViewController:alertCon animated:YES completion:nil];
        }
    }
}


#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userInfo objectForKey:@"payload"];
    
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    
    DLog(@"%@",userInfo);
    
    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];
    
    if (payloadMsg && contentAvailable) {
        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];
        DLog(@"%@",record);
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - iOS 10中收到推送消息

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    DLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    DLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
}
#endif



- (void)registerRemoteNotification {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    //[1-1]:通过 AppId、 appKey 、appSecret 启动SDK
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self];
    
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    //[1-3]:设置电子围栏功能，开启LBS定位服务 和 是否允许SDK 弹出用户定位请求
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    
}

#pragma mark - GexinSdkDelegate
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId
{
    // [4-EXT-1]: clientId
    
    if (_deviceToken) {
        [GeTuiSdk registerDeviceToken:_deviceToken];
    }
    
    [Utility sharedUtility].userInfo.clientId = clientId;
    
    DLog(@"%@",clientId);
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId
{
    
    // [ GTSdk ]：汇报个推自定义事件(反馈透传消息)
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
    
    // [4]: 收到消息
    
    // 数据转换
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *record = [NSString stringWithFormat:@" %@, %@", [self formateTime:[NSDate date]], payloadMsg];
    DLog(@"%@",record);
    
    
    UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"通知" message:payloadMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self.window.rootViewController presentViewController:alertCon animated:YES completion:nil];
    
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

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    DLog(@"%@",record);
}

- (void)GeTuiSdkDidOccurError:(NSError *)error
{
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    DLog(@"%@",[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]);
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // 通知SDK运行状态
    DLog(@"\n>>[GTSdk SdkState]:%u\n\n", aStatus);
}

-(NSString*) formateTime:(NSDate*) date {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString* dateTime = [formatter stringFromDate:date];
    return dateTime;
}


@end
