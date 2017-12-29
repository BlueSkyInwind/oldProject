//
//  GetCareerInfoViewModel.m
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "GetCareerInfoViewModel.h"

@implementation GetCareerInfoViewModel

- (void)fatchCareerInfo:(NSDictionary *)paramDic
{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getCustomerCarrer_jhtml] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseVM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseVM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

@end
