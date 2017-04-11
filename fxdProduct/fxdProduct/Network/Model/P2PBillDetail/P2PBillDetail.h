//
//  P2PBillDetail.h
//  fxdProduct
//
//  Created by dd on 2016/12/19.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BillData,BillList;

@interface P2PBillDetail : NSObject

@property (nonatomic, copy) NSString *appmsg;

@property (nonatomic, copy) NSString *appcode;

@property (nonatomic, copy) NSString *tracemsg;

@property (nonatomic, strong) BillData *data;

@end


/*
 bid_release_time_  借款时间
 amount_ 总本金
 repay_svc_charge_  服务费
 
 repay_total_ 应还总金额
 
 paid_period_ 已还期数
 
 stay_period_ 待还期数
 
 status_   标的状态
 BID_STATUS_：标的状态
 1	初审中
 2	银行审核中
 3	筹款中
 4	待放款（复审通过）
 5	还款中（财务已放款）
 6	结清
 7	提前结清
 -1	初审不通过
 -2	银行审核不通过
 -3	流标（固定期限内没有满标，系统执行流标）
 -4	复审不通过


 */

@interface BillData : NSObject

@property (nonatomic, copy) NSString *status_;

@property (nonatomic, copy) NSString *appcode;

@property (nonatomic, assign) int paid_period_;

@property (nonatomic, assign) CGFloat repay_svc_charge_;

@property (nonatomic, assign) int stay_period_;

@property (nonatomic, assign) CGFloat repay_total_;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, assign) CGFloat amount_;

@property (nonatomic, copy) NSDate *bid_release_time_;

@property (nonatomic, assign) int service_fee_min_period;

@property (nonatomic, copy) NSString *bill_id_;

@property (nonatomic, copy) NSString *bid_id_;

@property (nonatomic, assign) CGFloat repay_interest_;

@property (nonatomic, assign) CGFloat curr_settle_amt_;

@property (nonatomic, strong) NSArray<BillList*> *bill_List_;


@end


/*
 cur_stage_no_ 期号
 bill_date_ 当前账单日
 repayment_corpus_ 当期本金
 repayment_interest_ 当期利息
 repayment_service_charge_ 当期服务费
 compensation_ 违约金
 overdue_fine_ 当期罚息
 amount_total_ 当前应还总额
 status_ 当期状态
 LOAN_BILL_STATUS_：借款账单状态
 0	未到期
 1	正常待还
 2	逾期
 3	垫付待还
 4	结清
 5	转催收
 6	线下还款
 7	提前结清

 */

@interface BillList : NSObject

@property (nonatomic, assign) NSInteger status_;

@property (nonatomic, assign) CGFloat repayment_interest_;

@property (nonatomic, assign) CGFloat repayment_service_charge_;

@property (nonatomic, assign) CGFloat overdue_days_;

@property (nonatomic, assign) CGFloat compensation_;

@property (nonatomic, assign) CGFloat amount_total_;

@property (nonatomic, assign) CGFloat overdue_fine_;

@property (nonatomic, assign) CGFloat repayment_corpus_;

@property (nonatomic, assign) int cur_stage_no_;

@property (nonatomic, copy) NSDate *bill_date_;

@property (nonatomic, assign) int days;

@end
