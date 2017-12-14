//
//  FXD_LaunchConfiguration.m
//  fxdProduct
//
//  Created by dd on 15/9/8.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "FXD_LaunchConfiguration.h"
#import "SSKeychain.h"

@implementation FXD_LaunchConfiguration

+ (FXD_LaunchConfiguration *)shared
{
    static dispatch_once_t predicate;
    static FXD_LaunchConfiguration * _launchConfiguration = nil;
    
    dispatch_once(&predicate, ^{
        _launchConfiguration = [[FXD_LaunchConfiguration alloc] init];
    });
    return _launchConfiguration;
}

-(void)InitializeAppConfiguration{
    // 使用umeng分析
    UMConfigInstance.appKey = UmengKey;
    //        [MobClick startWithAppkey:UmengKey reportPolicy:BATCH   channelId:@""];
    [MobClick startWithConfigure:UMConfigInstance];
    //获取Version，打包时的版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:YES];
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                DLog(@"未知网络 || 没有网络(断网)");
                [FXD_Utility sharedUtility].networkState = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                DLog(@"手机自带网络 || WIFI");
                [FXD_Utility sharedUtility].networkState = YES;
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
    
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *identifyStr = [SSKeychain passwordForService:SERVERNAME account:SERVERNAME];
        if (![identifyStr isEqualToString:@""] && identifyStr) {
            [FXD_Utility sharedUtility].userInfo.uuidStr = identifyStr;
        } else {
            NSString *UUIDStr = [[NSUUID UUID] UUIDString];
            BOOL isValid = [SSKeychain setPassword:UUIDStr forService:SERVERNAME account:SERVERNAME];
            [FXD_Utility sharedUtility].userInfo.uuidStr = UUIDStr;
            if (isValid) {
                DLog(@"存储成功!");
            } else {
                DLog(@"存储失败");
            }
        }
        //        [Tool saveUserDefaul:nil Key:Fxd_JUID];
        //        [Tool saveUserDefaul:nil Key:kLoginFlag];
        //        [Tool saveUserDefaul:nil Key:UserName];
        [FXD_Utility sharedUtility].userInfo.juid = [FXD_Tool getContentWithKey:Fxd_JUID];
        [FXD_Utility sharedUtility].userInfo.tokenStr = [FXD_Tool getContentWithKey:Fxd_Token];
        [FXD_Utility sharedUtility].loginFlage = [[FXD_Tool getContentWithKey:kLoginFlag] integerValue];
        [FXD_Utility sharedUtility].userInfo.userMobilePhone = [FXD_Tool getContentWithKey:UserName];
        [FXD_Utility sharedUtility].isObtainUserLocation = YES;
    });
}

- (void)checkAPPVersion
{
    CommonViewModel * commonVM = [[CommonViewModel alloc]init];
    [commonVM setBlockWithReturnBlock:^(id returnValue) {
        BaseResultModel * baseRM= returnValue;
        if ([baseRM.errCode isEqualToString:@"12"]) {
            [[FXD_AlertViewCust sharedHHAlertView] showAppVersionUpdate:baseRM.friendErrMsg isForce:false compleBlock:^(NSInteger index) {
                if (index == 1) {
                    [FXD_Utility sharedUtility].userInfo.isUpdate = NO;
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
                }
            }];
        }else if([baseRM.errCode isEqualToString:@"13"]) {
            [[FXD_AlertViewCust sharedHHAlertView] showAppVersionUpdate:baseRM.friendErrMsg isForce:true compleBlock:^(NSInteger index) {
                if (index == 1) {
                    [FXD_Utility sharedUtility].userInfo.isUpdate = YES;
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
                }
            }];
        }else{
            [FXD_Utility sharedUtility].userInfo.isUpdate = NO;
        }
    } WithFaileBlock:^{
        
    }];
    [commonVM appVersionChecker];
    
}


@end
