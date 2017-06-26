//
//  SetSome.m
//  fxdProduct
//
//  Created by dd on 15/9/8.
//  Copyright (c) 2015年 dd. All rights reserved.
//

#import "SetSome.h"
#import "SSKeychain.h"


@implementation SetSome

+ (SetSome *)shared
{
    static dispatch_once_t predicate;
    static SetSome * _setSome = nil;
    
    dispatch_once(&predicate, ^{
        _setSome = [[SetSome alloc] init];
    });
    return _setSome;
}
-(void)InitializeAppSet{
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

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *identifyStr = [SSKeychain passwordForService:SERVERNAME account:SERVERNAME];
        if (![identifyStr isEqualToString:@""] && identifyStr) {
            [Utility sharedUtility].userInfo.uuidStr = identifyStr;
        } else {
            NSString *UUIDStr = [[NSUUID UUID] UUIDString];
            BOOL isValid = [SSKeychain setPassword:UUIDStr forService:SERVERNAME account:SERVERNAME];
            [Utility sharedUtility].userInfo.uuidStr = UUIDStr;
            if (isValid) {
                DLog(@"存储成功!");
            } else {
                DLog(@"存储失败");
            }
        }
        
        //        [Tool saveUserDefaul:nil Key:Fxd_JUID];
        //        [Tool saveUserDefaul:nil Key:kLoginFlag];
        //        [Tool saveUserDefaul:nil Key:UserName];
        [Utility sharedUtility].userInfo.juid = [Tool getContentWithKey:Fxd_JUID];
        [Utility sharedUtility].userInfo.tokenStr = [Tool getContentWithKey:Fxd_Token];
        [Utility sharedUtility].loginFlage = [[Tool getContentWithKey:kLoginFlag] integerValue];
        [Utility sharedUtility].userInfo.userName = [Tool getContentWithKey:UserName];
    });
}
@end
