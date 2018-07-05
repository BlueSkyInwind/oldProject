//
//  BankInfoViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/9/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BankInfoViewModel.h"

@implementation BankInfoViewModel

-(void)obtainUserBankCardListPlatformType:(NSString *)platformType{

    NSDictionary *paramDic = @{@"platformType":platformType == nil ? @"" : platformType };
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_BankCardList_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

@end
