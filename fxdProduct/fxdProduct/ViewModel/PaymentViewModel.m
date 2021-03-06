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
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_RepayOrSettleWithPeriod_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)obtaineductibleAmountfDiscount:(NSString *)discount_id  stagingIds:(NSString *)stagingIds{
    
    NSDictionary * paramDic = @{@"redpacketId":discount_id,@"stagingIds":stagingIds};
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_DeductibleAmountOfDiscountTicket_url] isNeedNetStatus:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
