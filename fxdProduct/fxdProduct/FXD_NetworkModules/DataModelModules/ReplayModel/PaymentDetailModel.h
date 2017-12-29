//
//  PaymentDetailModel.h
//  fxdProduct
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PaymentDetailModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * staging_ids_;
@property(nonatomic,strong)NSString<Optional> * account_card_id_;
@property(nonatomic,strong)NSNumber<Optional> * total_amount_;
@property(nonatomic,strong)NSNumber<Optional> * repay_amount_;
@property(nonatomic,strong)NSNumber<Optional> * repay_total_;
@property(nonatomic,strong)NSNumber<Optional> * save_amount_;
@property(nonatomic,strong)NSString<Optional> * socket;
@property(nonatomic,strong)NSString<Optional> * request_type_;
@property(nonatomic,strong)NSString<Optional> * redpacket_id_;
@property(nonatomic,strong)NSNumber<Optional> * redpacket_cash_;
//合规
@property(nonatomic,strong)NSString<Optional> * sms_code_ ;
@property(nonatomic,strong)NSString<Optional> * sms_seq_ ;


@end

@interface PaymentDetailAmountParam : JSONModel

@property(nonatomic,strong)NSString<Optional> * redpacketId;       //券id（可选）
@property(nonatomic,strong)NSString<Optional> * stagingId;             //分期id集合，逗号隔开

@end


@interface PaymentDetailAmountInfoModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * overpaidAmount;       //溢缴金
@property(nonatomic,strong)NSString<Optional> * payAmount;             //实际支付金额
@property(nonatomic,strong)NSString<Optional> * redPacketRepayAmount;    //使用的红包金额
@property(nonatomic,strong)NSString<Optional> * repayTotal;               //应还款总额
@property(nonatomic,strong)NSString<Optional> * debtOverdueTotal;    //逾期费用
@property(nonatomic,strong)NSString<Optional> * couponUsageDesc;   //券可用描述
@property(nonatomic,strong)NSString<Optional> * couponUsageStatus;    //可用券状态  0，可用，1，逾期不能用，2，结清不能用

@end

