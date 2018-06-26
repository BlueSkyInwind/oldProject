//
//  RepayWeeklyRecordViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/9.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "RepayWeeklyRecordViewModel.h"

@implementation RepayWeeklyRecordViewModel


-(void)getMoneyHistoryList{

    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getMoneyHistory_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
    
}


@end
