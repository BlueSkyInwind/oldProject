//
//  FXD_AppUpdateChecker.m
//  fxdProduct
//
//  Created by dd on 2016/11/16.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXD_AppUpdateChecker.h"
#import "ReturnMsgBaseClass.h"

@implementation FXD_AppUpdateChecker

+ (FXD_AppUpdateChecker *)sharedUpdateChecker
{
    static dispatch_once_t predicate;
    static FXD_AppUpdateChecker *_checker = nil;
    dispatch_once(&predicate, ^{
        _checker = [[FXD_AppUpdateChecker alloc] init];
    });
    return _checker;
}

- (void)checkAPPVersion
{
    
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *paramDic = @{@"platform_type_":PLATFORM,
                               @"app_version_":app_Version};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] checkAppVersion:[NSString stringWithFormat:@"%@%@",_main_url,_checkVersion_jhtml] paramters:paramDic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *returnParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        if ([returnParse.flag isEqualToString:@"0012"]) {
            [[FXD_AlertViewCust sharedHHAlertView] showAppVersionUpdate:returnParse.msg isForce:false compleBlock:^(NSInteger index) {
                if (index == 1) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
                }
            }];
        } else if ([returnParse.flag isEqualToString:@"0013"]) {
            [[FXD_AlertViewCust sharedHHAlertView] showAppVersionUpdate:returnParse.msg isForce:true compleBlock:^(NSInteger index) {
                if (index == 1) {
                    [FXD_Utility sharedUtility].userInfo.isUpdate = YES;
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
                }
            }];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

@end
