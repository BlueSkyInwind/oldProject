//
//  PaymentViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "ViewModelClass.h"
#import "PaymentDetailModel.h"

@interface PaymentViewModel : ViewModelClass


/**
 还款确认支付

 @param paymentDetailModel 参数
 */
-(void)FXDpaymentDetail:(PaymentDetailModel *) paymentDetailModel;


@end
