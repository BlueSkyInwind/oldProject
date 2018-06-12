//
//  PhoneOrderListModel.h
//  fxdProduct
//
//  Created by sxp on 2018/6/8.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneCardInfoModel <NSObject>

@end

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
//商品名
@property (nonatomic, strong)NSString<Optional> *phone_card_name;

@end


@interface PhoneOrderDetailModel : JSONModel

//订单号
@property (nonatomic, strong)NSString<Optional> *orderID;
//手机卡信息
@property (nonatomic, strong)NSArray<PhoneCardInfoModel,Optional> *cards;
//订单时间
@property (nonatomic, strong)NSString<Optional> *closing_day_;
//复制所有手机卡
@property (nonatomic, strong)NSString<Optional> * allPwd; //复制所有手机卡
@property (nonatomic, strong)NSString<Optional> * days;
@property (nonatomic, strong)NSString<Optional> * fee_amount_;
@property (nonatomic, strong)NSString<Optional> * order_no;
@property (nonatomic, strong)NSString<Optional> * order_price;
@property (nonatomic, strong)NSString<Optional> * payType;
@property (nonatomic, strong)NSString<Optional> * payment_date;
@property (nonatomic, strong)NSString<Optional> * phone_card_count;
@property (nonatomic, strong)NSString<Optional> * phone_card_price;
@property (nonatomic, strong)NSString<Optional> * principal_amount_;
@property (nonatomic, strong)NSString<Optional> * resellUrl;   //卖了换钱跳转地址
@property (nonatomic, strong)NSString<Optional> * smallIconUrl;   //图标

@end

@interface PhoneCardInfoModel : JSONModel

//手机卡账号
@property (nonatomic, strong)NSString<Optional> *cardNo;
//手机卡密码
@property (nonatomic, strong)NSString<Optional> *cardPwd;
//手机卡密码带掩码
@property (nonatomic, strong)NSString<Optional> *cardPwdHide;

@end





