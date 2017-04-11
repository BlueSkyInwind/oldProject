//
//  Approval.m
//  fxdProduct
//
//  Created by dd on 2016/11/10.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "Approval.h"

@implementation Approval

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result":[ApprovalResult class]};
}

@end

@implementation ApprovalResult

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"approval_amount":@"approval_amount_",
             @"loan_staging_amount":@"loan_staging_amount_",
             @"week_service_fee_rate":@"week_service_fee_rate_",
             @"loan_staging_duration":@"loan_staging_duration_",
             @"actual_loan_amount":@"actual_loan_amount_",
             @"case_id":@"case_id_",
             @"first_repay_date":@"first_repay_date_",
             @"contract_id":@"contract_id_"};
}

@end
