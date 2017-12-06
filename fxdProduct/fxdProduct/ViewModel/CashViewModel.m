//
//  CashViewModel.m
//  fxdProduct
//
//  Created by sxp on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CashViewModel.h"
#import "WithdrawCashParamModel.h"
#import "WithdrawCashDetailParamModel.h"

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
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_LoadWithdrawCash_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

-(void)withdrawCashAmount:(NSString *)amount bankCardId:(NSString *)bankCardId operateType:(NSString *)operateType payPassword:(NSString *)payPassword{
    
    WithdrawCashParamModel * withdrawCashParamModel = [[WithdrawCashParamModel alloc]init];
    withdrawCashParamModel.amount = amount;
    withdrawCashParamModel.bankCardId = bankCardId;
    withdrawCashParamModel.payPassword = [[payPassword DF_hashCode] AES256JAVA_Encrypt:[Fxd_pw openpf]];
    withdrawCashParamModel.operateType = operateType;
    NSDictionary * paramDic  = [withdrawCashParamModel toDictionary];
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_WithdrawCash_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
    
}

-(void)checkWithdrawCashOperateType:(NSString *)operateType{
    
    NSDictionary *paramDic = @{@"operateType":operateType};
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_CheckWithdrawCash_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}

-(void)withdrawCashDetailOperateType:(NSString *)operateType pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize{
    
    WithdrawCashDetailParamModel * withdrawCashDetailParamModel = [[WithdrawCashDetailParamModel alloc]init];
    withdrawCashDetailParamModel.operateType = operateType;
    withdrawCashDetailParamModel.pageNum = pageNum;
    withdrawCashDetailParamModel.pageSize = pageSize;
    NSDictionary *paramDic = [withdrawCashDetailParamModel toDictionary];
    
//    NSDictionary *paramDic = @{@"operateType":operateType};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_WithdrawCashDetail_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
