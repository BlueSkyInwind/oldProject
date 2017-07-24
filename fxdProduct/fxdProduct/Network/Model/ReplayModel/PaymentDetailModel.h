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
