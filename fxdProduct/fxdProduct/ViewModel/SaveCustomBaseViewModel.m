//
//  SaveCustomBaseViewModel.m
//  fxdProduct
//
//  Created by dd on 16/4/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "SaveCustomBaseViewModel.h"

@implementation SaveCustomBaseViewModel

- (void)saveCustomBaseInfo:(NSDictionary *)paramDic
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_saveCustomerBase_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        self.returnBlock(object);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}

@end
