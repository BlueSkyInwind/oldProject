//
//  PhoneOrderListModel.h
//  fxdProduct
//
//  Created by sxp on 2018/6/8.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneOrderListModel : JSONModel

//订单号
@property (nonatomic, strong)NSString<Optional> *order_no;
//订单总价
@property (nonatomic, strong)NSString<Optional> *order_price;
//订单时间
@property (nonatomic, strong)NSString<Optional> *payment_date;
//数量
@property (nonatomic, strong)NSString<Optional> *phone_card_count;
//单价
@property (nonatomic, strong)NSString<Optional> *phone_card_price;
//单价
@property (nonatomic, strong)NSString<Optional> *phone_card_name;

@end
