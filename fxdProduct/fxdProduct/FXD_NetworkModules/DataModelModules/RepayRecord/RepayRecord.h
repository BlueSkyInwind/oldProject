//
//  RepayRecord.h
//  A3WebView
//
//  Created by wxd on 15/12/21.
//  Copyright © 2015年 sjg. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RepayRecord : JSONModel

@property (nonatomic,strong)NSString<Optional> *principal_amount_;     //借款金额
@property (nonatomic,strong)NSString<Optional> * loan_staging_amount_;     //借款周期
@property (nonatomic,strong)NSString<Optional> * staging_repayment_amount_;  //每期还款
@property (nonatomic,strong)NSString<Optional> * repayment_amount_; //总还款额
@property (nonatomic,strong)NSString<Optional> *application_status_;    //申请状态
@property (nonatomic,strong)NSString<Optional> *create_date_;      //申请时间
@property (nonatomic, strong) NSString<Optional> *product_id_;
@property (nonatomic, strong) NSString<Optional> *loan_staging_duration_;  // 1：天    5：周
@property (nonatomic, strong) NSString<Optional> *staging_type_;  // 单位 汉字

@end
