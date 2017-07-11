//
//  FXDAppUpdateChecker.m
//  fxdProduct
//
//  Created by dd on 2016/11/16.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXDAppUpdateChecker.h"
#import "ReturnMsgBaseClass.h"

@implementation FXDAppUpdateChecker

+ (FXDAppUpdateChecker *)sharedUpdateChecker
{
    static dispatch_once_t predicate;
    static FXDAppUpdateChecker *_checker = nil;
    
    dispatch_once(&predicate, ^{
        _checker = [[FXDAppUpdateChecker alloc] init];
    });
    return _checker;
}

- (void)checkAPPVersion
{
    
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *paramDic = @{@"platform_type_":PLATFORM,
                               @"app_version_":app_Version};
    [[FXDNetWorkManager sharedNetWorkManager] CheckVersion:[NSString stringWithFormat:@"%@%@",_main_url,_checkVersion_jhtml] paramters:paramDic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *returnParse = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        if ([returnParse.flag isEqualToString:@"0012"]) {
            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:returnParse.msg cencelBtn:nil otherBtn:@[@"好的"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                
            }];
        } else if ([returnParse.flag isEqualToString:@"0013"]) {
            [[HHAlertViewCust sharedHHAlertView] showHHalertView:HHAlertEnterModeFadeIn leaveMode:HHAlertLeaveModeFadeOut disPlayMode:HHAlertViewModeWarning title:nil detail:returnParse.msg cencelBtn:nil otherBtn:@[@"确定"] Onview:[UIApplication sharedApplication].keyWindow compleBlock:^(NSInteger index) {
                if (index == 1) {
                    [Utility sharedUtility].userInfo.isUpdate = YES;
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1089086853"]];
                }
            }];
        }
    } failure:^(EnumServerStatus status, id object) {
        
    }];
}

@end
