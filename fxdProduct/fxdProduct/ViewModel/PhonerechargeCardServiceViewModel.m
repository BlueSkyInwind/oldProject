//
//  PhonerechargeCardServiceViewModel.m
//  fxdProduct
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "PhonerechargeCardServiceViewModel.h"

@implementation PhonerechargeCardServiceViewModel

-(void)obtainRechargeCardListInfo{
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_rechargeCardsList_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

-(void)obtainOrderConfirmInfo:(NSString *)productNumber{
    
    NSDictionary *dic = @{@"productNumber":productNumber};
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_orderConfirmInfo_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

-(void)obtainOrderConfirmRequest:(NSString *)productNumber cardNum:(NSString *)num{
    
    NSDictionary *dic = @{@"cardProductNumber":productNumber,@"count":num};
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_orderConfirmRequest_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

-(void)obtainOrderDetailInfoRequest:(NSString *)orderNumber{
    
    NSDictionary *dic = @{@"orderNo":orderNumber};
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_orderDetailInfo_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}


@end
