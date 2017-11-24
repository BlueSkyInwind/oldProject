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

@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * canuselist;
@property(nonatomic,strong)NSArray<DiscountTicketDetailModel,Optional> * notuselist;

@end

@interface DiscountTicketDetailModel : JSONModel


@property(nonatomic,strong)NSString<Optional> * base_id;
@property(nonatomic,strong)NSString<Optional> * is_using;
@property(nonatomic,strong)NSString<Optional> * loan_limit;
@property(nonatomic,strong)NSString<Optional> * total_amount;
@property(nonatomic,strong)NSString<Optional> * use_time;
@property(nonatomic,strong)NSString<Optional> * voucher_canuse_product;
@property(nonatomic,strong)NSString<Optional> * voucher_name;
@property(nonatomic,strong)NSString<Optional> * voucher_type;


@end






