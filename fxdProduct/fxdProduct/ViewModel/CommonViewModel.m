//
//  CommonViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/12/13.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CommonViewModel.h"

@implementation CommonViewModel

/**
 版本检测
 */
-(void)appVersionChecker{
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *paramDic = @{@"platform_type_":PLATFORM,
                               @"app_version_":app_Version,
                               @"service_platform_type_":@"0"
                               };
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_checkVersion_jhtml] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}



@end
