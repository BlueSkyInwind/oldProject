//
//  SetTransactionPasswordViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "SetTransactionPasswordViewModel.h"

@implementation SetTransactionPasswordViewModel

/**
 验证身份证

 @param IDnum 身份证号
 */
-(void)VerifyIdentityCardNumber:(NSString *)IDnum{
    
    NSDictionary *paramDic = @{@"identityNo":IDnum};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_verifyIdentityCard_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];
}

/**
 验证就交易密码

 @param password 旧密码
 */
-(void)VerifyOldTradePassword:(NSString *)password{
    
    NSDictionary *paramDic = @{@"oldPassword":password};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_verifyOldPassword_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];
}

/**
 保存新的交易密码

 @param firstPassword 首次密码
 @param secondpassword 二次密码
 @param operateType 操作类型   1设置、2重置
 */
-(void)saveNewTradePasswordFirst:(NSString *)firstPassword second:(NSString *)secondpassword operateType:(NSString *)operateType{
    
    SetTradePasswordParam * tradePasswordP = [[SetTradePasswordParam  alloc]init];
    tradePasswordP.firstPassword = firstPassword;
    tradePasswordP.secondPassword = secondpassword;
    tradePasswordP.operateType = operateType;
    NSDictionary *paramDic = [tradePasswordP toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_saveNewPassword_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock(object);
        }
    }];
}




@end
