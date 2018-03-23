//
//  CheckViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "CheckViewModel.h"
#import "SaveLoanCaseParamModel.h"
#import "DrawingsInfoModel.h"

@implementation CheckViewModel

#pragma mark - 新API

-(void)newWithDrawalsApplyCard_id:(NSString *)card_id{
    
    WithDrawalsParamModel * withDrawalsM = [[WithDrawalsParamModel alloc]init];
    withDrawalsM.accountCardId = card_id;
    
    NSDictionary * paramDic = [withDrawalsM toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_newDrawApply_jhtml] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseRm = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRm);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}


-(void)withDrawFundsInfoApply{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_withDrawFunds_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseRm = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRm);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

@end


@implementation CheckBankViewModel

/**
 支持银行卡列表

 @param platform 平台     2 - 银生宝   4 - 汇付
 */
-(void)getSupportBankListInfo:(NSString *)platform{

    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getSupportBankList_url] isNeedNetStatus:true isNeedWait:true parameters:@{@"pay_platform_id_":platform} finished:^(EnumServerStatus status, id object) {
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
