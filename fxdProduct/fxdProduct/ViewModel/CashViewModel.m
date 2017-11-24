//
//  CashViewModel.m
//  fxdProduct
//
//  Created by sxp on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CashViewModel.h"

@implementation CashViewModel


-(void)getPersonalCenterInfo{
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_PersonalCenterWithdrawCashAPI_url] isNeedNetStatus:true parameters:nil finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}


-(void)loadWithdrawCashInfoOperateType:(NSString *)operateType{
    
    NSDictionary *paramDic = @{@"operateType":operateType};
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_LoadWithdrawCashInfo_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
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
