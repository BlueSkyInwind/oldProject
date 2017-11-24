//
//  RepayWeeklyRecord.h
//  fxdProduct
//
//  Created by zy on 16/3/25.
//  Copyright © 2016年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepayWeeklyRecord : NSObject
@property (nonatomic,strong) NSString *no_;//期数
@property (nonatomic,strong) NSString *principal; //本金
@property (nonatomic,strong) NSString *service_fee_;  //利息
@property (nonatomic,strong) NSString *penalty_interest_;   //罚息
@property (nonatomic,strong) NSString *liquidatetimed_damages_; //违约金
@property (nonatomic,strong) NSString *billing_time_;  //日期
@property (nonatomic,strong) NSString *contract_no_; //合同号
@end
