//
//  P2PSettleRepay.h
//  fxdProduct
//
//  Created by dd on 2016/10/12.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SettleRepayResult;

@interface P2PSettleRepay : NSObject

@property (nonatomic, copy)NSString *flag;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)SettleRepayResult *result;

@end


@interface SettleRepayResult : NSObject

@property (nonatomic, copy)NSString *bill_id_;

@property (nonatomic, copy)NSString *socket;

@property (nonatomic, copy)NSString *total_amount_;

@property (nonatomic, copy)NSString *bid_id_;

@property (nonatomic, copy)NSString *reapy_interest_;

@property (nonatomic, copy)NSString *platform_type_;

@property (nonatomic, copy)NSString *settle_amount_;

@property (nonatomic, copy)NSString *available_redpackets_;

@property (nonatomic, copy)NSString *contract_status_;

@end
