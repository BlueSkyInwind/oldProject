//
//  weekRepayModel.h
//  fxdProduct
//
//  Created by zy on 16/3/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weekRepayModel : NSObject
@property (nonatomic,assign) double loan_amount_;
@property (nonatomic,assign) double periods;
@property (nonatomic,assign) double total_amount_;
@property (nonatomic,copy) NSString * socket;
@property (nonatomic,copy) NSString * repay_date_;
@property (nonatomic,assign) double should_reapy_rincipal_;
@property (nonatomic,assign) double should_reapy_interest_;
@property (nonatomic,assign) double offset_interest_;
@property (nonatomic,assign) double should_reapy_amount_;
@property (nonatomic,assign) double overdue_amount_;
@property (nonatomic,strong) NSArray *available_redpackets_;
@property (nonatomic,copy) NSString *contract_status_;

@end
