//
//  RepayListInfo.h
//  fxdProduct
//
//  Created by dd on 16/9/5.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Situations <NSObject>


@end

@protocol Available_Redpackets <NSObject>


@end

//@protocol OrderModel <NSObject>
//
//
//@end

@interface OrderModel : JSONModel

//订单号
@property (nonatomic, strong) NSString<Optional> *order_no;
//订单总额
@property (nonatomic, strong) NSString<Optional> * order_price;
//支付时间
@property (nonatomic, strong) NSString<Optional> * payment_date;
//数量
@property (nonatomic, strong) NSString<Optional> *phone_card_count;
//单价
@property (nonatomic, strong) NSString<Optional> *phone_card_price;
//订单名称
@property (nonatomic, strong) NSString<Optional> *phone_card_name;


@end

@interface RepayListInfo : JSONModel

@property (nonatomic, strong) NSNumber<Optional> *periods_repayed_;

@property (nonatomic, strong) NSString<Optional> *socket_;

@property (nonatomic, strong) NSNumber<Optional> * total_amount_;

@property (nonatomic, strong) NSNumber<Optional> * periods_repaying_;

@property (nonatomic, strong) NSArray<Situations,Optional> *situations_;

@property (nonatomic, strong) NSNumber<Optional> * repayment_amount_;
//合同状态
@property (nonatomic, strong) NSString<Optional> *contract_status_;

@property (nonatomic, strong) NSNumber<Optional> * principal_amount_;

@property (nonatomic, strong) NSNumber<Optional> * overdue_total_;  //逾期费用(急速贷)

@property (nonatomic, strong) NSString<Optional> *siging_day_;

@property (nonatomic, strong) NSNumber<Optional> * fee_amount_;

@property (nonatomic, strong) NSNumber<Optional> * service_fee_min_period_;

@property (nonatomic, strong) NSString<Optional> * quickOmit;    //立省

@property (nonatomic, strong) NSString<Optional> * settleRepayAmount;  //提前结清金额
//剩余应还金额
@property (nonatomic, strong) NSString<Optional> * debtRepayTotal;
//最后还款日
@property (nonatomic, strong) NSString<Optional> * dueDate;

@property (nonatomic, strong) NSArray<Available_Redpackets,Optional> *available_redpackets_;
//订单
@property (nonatomic, strong) OrderModel<Optional> *order;

@property (nonatomic, strong) NSString<Optional> *maxOverdueDays;

@property (nonatomic, strong) NSString<Optional> *maxOverdueDaysText;
//是否还款中
@property (nonatomic, strong) NSString<Optional> *isPending;
@end





@interface Situations : JSONModel

@property (nonatomic, strong) NSString<Optional> *status_;

@property (nonatomic, strong) NSString<Optional> * debt_principal_;

@property (nonatomic, strong) NSString<Optional> * debt_liquidatetimed_damages_;

@property (nonatomic, strong) NSString<Optional> *staging_id_;

@property (nonatomic, strong) NSString<Optional> *debt_total_;

@property (nonatomic, strong) NSString<Optional> *days_;

@property (nonatomic, strong) NSString<Optional> *no_;

@property (nonatomic, strong) NSString<Optional> * debt_service_fee_;

@property (nonatomic, strong) NSString<Optional> *start_time_;

@property (nonatomic, strong) NSString<Optional> *end_time_;

@property (nonatomic, strong) NSString<Optional> * debt_penalty_interest_;

@end

@interface Available_Redpackets : JSONModel

@property (nonatomic, strong) NSString<Optional> *available_means_;

@property (nonatomic, strong) NSString<Optional> *account_base_id_;

@property (nonatomic, strong) NSString<Optional> *type_;

@property (nonatomic, strong) NSString<Optional> *source_;

@property (nonatomic, strong) NSString<Optional> *create_date_;

@property (nonatomic, strong) NSString<Optional> *RedpacketID_;

@property (nonatomic, strong) NSString<Optional> *modify_by_;

@property (nonatomic, strong) NSNumber<Optional> * residual_amount_;

@property (nonatomic, strong) NSString<Optional> *validity_period_from_;

@property (nonatomic, strong) NSString<Optional> *get_date_;

@property (nonatomic, strong) NSString<Optional> *use_conditions_;

@property (nonatomic, strong) NSString<Optional> *modify_date_;

@property (nonatomic, strong) NSString<Optional> *is_split_use_;

@property (nonatomic, strong) NSNumber<Optional> *used_amount_;

@property (nonatomic, strong) NSNumber<Optional> *total_amount_;

@property (nonatomic, strong) NSString<Optional> *redpacket_name_;

@property (nonatomic, strong) NSNumber<Optional> * is_using_;

@property (nonatomic, strong) NSString<Optional> *validity_period_to_;

@property (nonatomic, strong) NSString<Optional> *create_by_;

@end

