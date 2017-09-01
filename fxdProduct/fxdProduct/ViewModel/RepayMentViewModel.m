//
//  RepayMentViewModel.m
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "RepayMentViewModel.h"
@implementation RepayMentViewModel

- (void)fatchQueryWeekShouldAlsoAmount:(NSDictionary *)paramDic
{
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getContractStagingInfo_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        self.returnBlock(object);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}


- (void)getCurrentRenewalWithStagingId:(NSString *)stagingId{

    NSDictionary *paramDic = @{@"stagingId":stagingId};
    [[FXDNetWorkManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_repayment_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        self.returnBlock(object);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}
@end
