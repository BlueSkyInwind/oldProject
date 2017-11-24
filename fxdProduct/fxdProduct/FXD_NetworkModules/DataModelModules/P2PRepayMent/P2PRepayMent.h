//
//  P2PRepayMent.h
//  fxdProduct
//
//  Created by dd on 2016/10/10.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class P2PRepayMentResult;

@interface P2PRepayMent : NSObject

@property (nonatomic, copy)NSString *flag;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)P2PRepayMentResult *result;

@end


@interface P2PRepayMentResult : NSObject

@property (nonatomic, copy)NSString *contract_status_;

@property (nonatomic, copy)NSString *bill_id_;

@property (nonatomic, copy)NSString *available_redpackets_;

@property (nonatomic, copy)NSString *should_reapy_interest_;

@property (nonatomic, copy)NSString *repay_date_;

@property (nonatomic, copy)NSString *platform_type_;

@property (nonatomic, copy)NSString *socket;

@property (nonatomic, copy)NSString *should_reapy_rincipal_;

@property (nonatomic, copy)NSString *bid_id_;

@property (nonatomic, copy)NSString *overdue_amount_;

@property (nonatomic, copy)NSString *loan_amount_;

@property (nonatomic, copy)NSString *should_reapy_amount_;

@property (nonatomic, copy)NSString *total_amount_;

@property (nonatomic, assign)NSInteger periods;

@end
