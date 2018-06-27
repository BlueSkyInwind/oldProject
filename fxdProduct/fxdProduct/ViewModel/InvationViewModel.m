//
//  InvationViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/12/14.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "InvationViewModel.h"

@implementation InvationViewModel
/**
 获取邀请好友规则
 */
-(void)obtainInvationRecomInfoList{
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_GetRecomfrInfo_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


@end
