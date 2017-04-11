//
//  RepayListInfo.h
//  fxdProduct
//
//  Created by dd on 16/9/5.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepayListInfoExt,Result,Situations,Available_Redpackets;
@interface RepayListInfo : NSObject


@property (nonatomic, copy) NSString *flag;

@property (nonatomic, strong) RepayListInfoExt *ext;

@property (nonatomic, strong) Result *result;

@property (nonatomic, copy) NSString *msg;


@end

@interface RepayListInfoExt : NSObject

@property (nonatomic, copy) NSString *mobile_phone_;

@end

@interface Result : NSObject

@property (nonatomic, assign) NSInteger periods_repayed;

@property (nonatomic, copy) NSString *socket;

@property (nonatomic, assign) CGFloat total_amount;

@property (nonatomic, assign) NSInteger periods_repaying;

@property (nonatomic, strong) NSArray<Situations *> *situations;

@property (nonatomic, assign) CGFloat repayment_amount;

@property (nonatomic, copy) NSString *contract_status;

@property (nonatomic, assign) CGFloat principal_amount;

@property (nonatomic, assign) CGFloat overdue_total_;  //逾期费用(急速贷)

@property (nonatomic, copy) NSString *siging_day;

@property (nonatomic, assign) CGFloat fee_amount;

@property (nonatomic, assign) NSInteger service_fee_min_period;

@property (nonatomic, strong) NSArray<Available_Redpackets *> *available_redpackets;

@end

@interface Situations : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) CGFloat debt_principal;

@property (nonatomic, assign) CGFloat debt_liquidatetimed_damages;

@property (nonatomic, copy) NSString *staging_id;

@property (nonatomic, assign) CGFloat debt_total;

@property (nonatomic, assign) NSInteger days;

@property (nonatomic, assign) NSInteger no;

@property (nonatomic, assign) CGFloat debt_service_fee;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, assign) CGFloat debt_penalty_interest;

@end

@interface Available_Redpackets : NSObject

@property (nonatomic, copy) NSString *available_means;

@property (nonatomic, copy) NSString *account_base_id;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *create_date;

@property (nonatomic, copy) NSString *RedpacketID;

@property (nonatomic, copy) NSString *modify_by;

@property (nonatomic, assign) CGFloat residual_amount;

@property (nonatomic, copy) NSString *validity_period_from;

@property (nonatomic, copy) NSString *get_date;

@property (nonatomic, copy) NSString *use_conditions;

@property (nonatomic, copy) NSString *modify_date;

@property (nonatomic, copy) NSString *is_split_use;

@property (nonatomic, assign) NSInteger used_amount;

@property (nonatomic, assign) NSInteger total_amount;

@property (nonatomic, copy) NSString *redpacket_name;

@property (nonatomic, assign) NSInteger is_using;

@property (nonatomic, copy) NSString *validity_period_to;

@property (nonatomic, copy) NSString *create_by;

@end

