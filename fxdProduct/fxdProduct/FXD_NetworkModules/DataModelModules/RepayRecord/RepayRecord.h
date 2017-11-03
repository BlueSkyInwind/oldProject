//
//  RepayRecord.h
//  A3WebView
//
//  Created by wxd on 15/12/21.
//  Copyright © 2015年 sjg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepayRecord : NSObject

@property (nonatomic,assign)double principal_amount_;     //借款金额
@property (nonatomic,assign)double loan_staging_amount_;     //借款周期
@property (nonatomic,assign)double staging_repayment_amount_;  //每期还款
@property (nonatomic,assign)double repayment_amount_; //总还款额
@property (nonatomic,copy)NSString *application_status_;    //申请状态
@property (nonatomic,copy)NSString *create_date_;      //申请时间
@property (nonatomic, copy) NSString *product_id_;
@property (nonatomic, copy) NSString *loan_staging_duration_;  // 1：天    5：周

@end
