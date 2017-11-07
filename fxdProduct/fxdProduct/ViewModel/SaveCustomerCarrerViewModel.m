//
//  SaveCustomerCarrerViewModel.m
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "SaveCustomerCarrerViewModel.h"

@implementation SaveCustomerCarrerViewModel

- (void)saveCustomCarrer:(NSDictionary *)paramDic
{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_saveCustomerCarrer_jhtml] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        self.returnBlock(object);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}

@end
