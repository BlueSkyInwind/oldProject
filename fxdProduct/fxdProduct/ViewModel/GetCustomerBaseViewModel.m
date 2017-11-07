//
//  GetCustomerBaseViewModel.m
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "GetCustomerBaseViewModel.h"
#import "Custom_BaseInfo.h"


@implementation GetCustomerBaseViewModel

- (void)fatchCustomBaseInfo:(NSDictionary *)paramDic
{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getCustomerBase_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        Custom_BaseInfo *returnModel = [Custom_BaseInfo modelObjectWithDictionary:object];
        self.returnBlock(returnModel);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}

- (void)fatchCustomBaseInfoNoHud:(NSDictionary *)paramDic
{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTHideHUD:[NSString stringWithFormat:@"%@%@",_main_url,_getCustomerBase_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        Custom_BaseInfo *returnModel = [Custom_BaseInfo modelObjectWithDictionary:object];
        self.returnBlock(returnModel);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}

@end
