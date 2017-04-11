//
//  RateModel.h
//  fxdProduct
//
//  Created by dd on 2017/3/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RateModelResult;

@interface RateModel : NSObject

@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , copy) NSString              * flag;
@property (nonatomic , strong) RateModelResult     * result;

@end

@interface RateModelResult :NSObject
@property (nonatomic , copy) NSString              * id_;
@property (nonatomic , assign) NSInteger              principal_top_;
@property (nonatomic , copy) NSString              * create_date_;
@property (nonatomic , copy) NSString              * modify_by_;
@property (nonatomic , assign) CGFloat              liquidated_damages_;
@property (nonatomic , copy) NSString              * status_;
@property (nonatomic , copy) NSString              * staging_duration_;
@property (nonatomic , assign) NSInteger              principal_bottom_;
@property (nonatomic , copy) NSString              * name_;
@property (nonatomic , assign) NSInteger              staging_bottom_;
@property (nonatomic , assign) NSInteger              staging_top_;
@property (nonatomic , copy) NSString              * remark_;
@property (nonatomic , assign) CGFloat              day_service_fee_rate_;
@property (nonatomic , assign) CGFloat              pre_service_fee_rate_;
@property (nonatomic , assign) CGFloat              out_day_interest_fee_;  //日利息率
@property (nonatomic , assign) CGFloat              out_day_service_fee_;   //日服务费率
@property (nonatomic , assign) CGFloat              out_operate_fee_;  //运营费
@property (nonatomic , assign) NSInteger              apply_level_;
@property (nonatomic , copy) NSString              * modify_date_;
@property (nonatomic , copy) NSString              * create_by_;
@property (nonatomic , assign) NSInteger              service_fee_min_period_;

@end
