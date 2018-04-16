//
//  UserMemberShipViewModel.m
//  fxdProduct
//
//  Created by admin on 2018/4/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "UserMemberShipViewModel.h"

@implementation UserMemberShipViewModel

-(void)obtainMemberShipInfo{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_memberShipInfo_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)requestMemberCenterRecharge:(NSString *)bankCardID rechargeAmount:(NSString *)rechargeAmount {
    
    NSDictionary * dic = @{@"accountCardId":bankCardID,@"amount":rechargeAmount};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_memberRecharge_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)requestMemberCenterRefund:(NSString *)bankCardID refundAmount:(NSString *)refundAmount {
    
    NSDictionary * dic = @{@"cardId":bankCardID,@"amount":refundAmount};

    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_memberRefund_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel *baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}






@end
