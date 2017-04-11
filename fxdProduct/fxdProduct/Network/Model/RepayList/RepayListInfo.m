//
//  RepayListInfo.m
//  fxdProduct
//
//  Created by dd on 16/9/5.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "RepayListInfo.h"

@implementation RepayListInfo

@end


@implementation RepayListInfoExt

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ext" : [RepayListInfoExt class],
             @"result" : [Result class] };
}

@end


@implementation Result
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"periods_repayed" : @"periods_repayed_",
             @"total_amount" : @"total_amount_",
             @"periods_repaying" : @"periods_repaying_",
             @"repayment_amount" : @"repayment_amount_",
             @"contract_status":@"contract_status_",
             @"principal_amount":@"principal_amount_",
             @"siging_day":@"siging_day_",
             @"fee_amount":@"fee_amount_",
             @"situations":@"situations_",
             @"service_fee_min_period":@"service_fee_min_period_",
             @"available_redpackets":@"available_redpackets_"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"situations" : [Situations class],
             @"available_redpackets" : [Available_Redpackets class] };
}

@end


@implementation Situations

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"status" : @"status_",
             @"debt_principal" : @"debt_principal_",
             @"debt_liquidatetimed_damages" : @"debt_liquidatetimed_damages_",
             @"staging_id" : @"staging_id_",
             @"debt_total":@"debt_total_",
             @"days":@"days_",
             @"no":@"no_",
             @"debt_service_fee":@"debt_service_fee_",
             @"start_time":@"start_time_",
             @"end_time":@"end_time_",
             @"debt_penalty_interest":@"debt_penalty_interest_"};
}


@end


@implementation Available_Redpackets

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"available_means":@"available_means_",
             @"account_base_id":@"account_base_id_",
             @"type":@"type_",
             @"source":@"source_",
             @"create_date":@"create_date_",
             @"RedpacketID":@"id_",
             @"modify_by":@"modify_by_",
             @"residual_amount":@"residual_amount_",
             @"validity_period_from":@"validity_period_from_",
             @"get_date":@"get_date_",
             @"use_conditions":@"use_conditions_",
             @"modify_date":@"modify_date_",
             @"is_split_use":@"is_split_use_",
             @"used_amount":@"used_amount_",
             @"total_amount":@"total_amount_",
             @"redpacket_name":@"redpacket_name_",
             @"is_using":@"is_using_",
             @"validity_period_to":@"validity_period_to_",
             @"create_by":@"create_by_",
             };
}

@end


