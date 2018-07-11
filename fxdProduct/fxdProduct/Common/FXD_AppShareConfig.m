//
//  ShareConfig.m
//  fxdProduct
//
//  Created by dd on 2016/12/13.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXD_AppShareConfig.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
//#import "WXApi.h"
//#import "WeiboSDK.h"

@implementation FXD_AppShareConfig

+ (void)configShareInitialSetting
{
//    [ShareSDK  registerActivePlatforms:@[@(SSDKPlatformSubTypeWechatSession),
//                            @(SSDKPlatformSubTypeWechatTimeline),
//                            @(SSDKPlatformTypeSinaWeibo),
//                            @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformSubTypeQZone),
//                            @(SSDKPlatformTypeSMS)]
//                 onImport:^(SSDKPlatformType platformType) {
//                     switch (platformType) {
//                         case SSDKPlatformTypeWechat:
//                             [ShareSDKConnector connectWeChat:[WXApi class]];
//                             break;
//
//                         case SSDKPlatformTypeSinaWeibo:
//                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                             break;
//
//                         case SSDKPlatformTypeQQ:
//                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                             break;
//
//                         default:
//                             break;
//                     }
//                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//                     switch (platformType) {
//                         case SSDKPlatformTypeWechat:
//                             [appInfo SSDKSetupWeChatByAppId:@"wx648c720f24702923" appSecret:@"2161cac362189a704a403f71c311a784"];
//                             break;
//
//                         case SSDKPlatformTypeSinaWeibo:
//                             [appInfo SSDKSetupSinaWeiboByAppKey:@"2097363984" appSecret:@"88b9a099b6a5dee9650a897d672438e8" redirectUri:@"http://www.faxindai.com" authType:SSDKAuthTypeBoth];
//                             break;
//
//                         case SSDKPlatformTypeQQ:
//                             [appInfo SSDKSetupQQByAppId:@"1104953275" appKey:@"dvALe64XZs1G0hW7" authType:SSDKAuthTypeBoth];
//                             break;
//                         default:
//                             break;
//                     }
//                 }];
}

@end
