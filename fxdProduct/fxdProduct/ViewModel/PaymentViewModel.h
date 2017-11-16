//
//  PaymentViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"
#import "PaymentDetailModel.h"

@interface PaymentViewModel : FXD_ViewModelBaseClass


/**
 还款确认支付

 @param paymentDetailModel 参数
 */
-(void)FXDpaymentDetail:(PaymentDetailModel *) paymentDetailModel;

/**
 获取折扣券抵扣金额

 @param discount_id 抵扣券id
 @param stagingIds 分期id
 */
-(void)obtaineductibleAmountfDiscount:(NSString *)discount_id  stagingIds:(NSString *)stagingIds;

@end
