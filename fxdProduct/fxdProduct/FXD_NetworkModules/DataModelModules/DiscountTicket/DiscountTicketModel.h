//
//  DiscountTicketModel.h
//  fxdProduct
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol DiscountTicketDetailModel <NSObject>


@end

@interface DiscountTicketModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * activity_type;
@property(nonatomic,strong)NSString<Optional> * invalidsize;
@property(nonatomic,strong)NSString<Optional> * validsize;
@property(nonatomic,strong)NSString<Optional> * user_id;
@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * valid;
@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * invalid;
@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * list;

@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * canuselist;
@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * notuselist;

@end

@interface DiscountTicketDetailModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * activity_type;
@property(nonatomic,strong)NSString<Optional> * amount_payment_;
@property(nonatomic,strong)NSString<Optional> * baseid_;
@property(nonatomic,strong)NSString<Optional> * name_;
@property(nonatomic,strong)NSString<Optional> * user_id_;
@property(nonatomic,strong)NSString<Optional> * start_time_;
@property(nonatomic,strong)NSString<Optional> * end_time_;
@property(nonatomic,strong)NSString<Optional> * is_used_;


@property(nonatomic,strong)NSString<Optional> * base_id;
@property(nonatomic,strong)NSString<Optional> * is_using;
@property(nonatomic,strong)NSString<Optional> * loan_limit;
@property(nonatomic,strong)NSString<Optional> * total_amount;
@property(nonatomic,strong)NSString<Optional> * use_time;
@property(nonatomic,strong)NSString<Optional> * voucher_canuse_product;
@property(nonatomic,strong)NSString<Optional> * voucher_name;
@property(nonatomic,strong)NSString<Optional> * voucher_type;


@end






