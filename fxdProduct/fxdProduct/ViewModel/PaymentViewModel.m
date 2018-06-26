//
//  PaymentViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "PaymentViewModel.h"

@implementation PaymentViewModel

-(void)FXDpaymentDetail:(PaymentDetailModel *) paymentDetailModel{
    
    NSDictionary * paramDic = [paymentDetailModel toDictionary];
    
    [[HF_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_RepayOrSettleWithPeriod_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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

-(void)obtaineductibleAmountfDiscount:(NSString *)discount_id  stagingIds:(NSString *)stagingIds{
    
    PaymentDetailAmountParam * paymentDetailP = [[PaymentDetailAmountParam alloc]init];
    paymentDetailP.redpacketId = discount_id;
    paymentDetailP.stagingId = stagingIds;
    
    NSDictionary * paramDic = [paymentDetailP toDictionary];
    [[HF_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_repayDetailAmountInfo_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}





@end
