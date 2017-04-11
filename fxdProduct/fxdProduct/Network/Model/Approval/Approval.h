//
//  Approval.h
//  fxdProduct
//
//  Created by dd on 2016/11/10.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ApprovalResult;


@interface Approval : NSObject

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) ApprovalResult *result;

@end


@interface ApprovalResult : NSObject

@property (nonatomic, assign) CGFloat approval_amount;

//期数
@property (nonatomic, copy) NSString *loan_staging_amount;

@property (nonatomic, assign) CGFloat week_service_fee_rate;

@property (nonatomic, copy) NSString *loan_staging_duration;

@property (nonatomic, assign) CGFloat actual_loan_amount;

@property (nonatomic, copy) NSString *case_id;

@property (nonatomic, copy) NSString *first_repay_date;

@property (nonatomic, copy) NSString *contract_id;

@end
