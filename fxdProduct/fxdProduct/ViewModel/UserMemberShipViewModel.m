//
//  UserMemberShipViewModel.m
//  fxdProduct
//
//  Created by admin on 2018/4/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "UserMemberShipViewModel.h"

@implementation UserMemberShipViewModel

-(void)obtainMemberShipInfo{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_memberShipInfo_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
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
