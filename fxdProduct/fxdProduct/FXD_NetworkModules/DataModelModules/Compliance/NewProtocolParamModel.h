//
//  NewProtocolParamModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/20.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NewProtocolParamModel : JSONModel

//申请件id
@property (nonatomic, strong)NSString<Optional> *applicationId;
//投资人id 合规放款的用户，调用借款协议时传
@property (nonatomic, strong)NSString<Optional> *inverBorrowId;
//期数  精英贷不传，其他产品传
@property (nonatomic, strong)NSString<Optional> *periods;
//产品id 注册协议 product_id_ : user_reg 隐私保护协议 product_id_ :user_privacy 运营商信息授权协议 产品id product_id_ :operInfo 用户信息授权协议 product:    fxd_userpro
@property (nonatomic, strong)NSString<Optional> *productId;
//产品类型 2 薪意贷 （其他产品不传）
@property (nonatomic, strong)NSString<Optional> *productType;
//协议类型 1，转账授权书2，借款协议3，信用咨询及管理服务协议4，运营商信息授权协议5，用户信息授权服务协议6，技术服务协议7，风险管理与数据服务协议8注册协议 9隐私保护协议 18 电子签章授权委托协议
@property (nonatomic, strong)NSString<Optional> *protocolType;
//还款方式 1、按周还款、2、按每2周还款、3、按月还款
@property (nonatomic, strong)NSString<Optional> *stagingType;

@end
