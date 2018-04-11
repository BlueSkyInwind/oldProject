//
//  ProtocolParamModel.h
//  fxdProduct
//
//  Created by admin on 2017/12/27.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProtocolParamModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * apply_id_;
@property(nonatomic,strong)NSString<Optional> * periods;
@property(nonatomic,strong)NSString<Optional> * product_id_;
@property(nonatomic,strong)NSString<Optional> * protocol_type_;

@property(nonatomic,strong)NSString<Optional> * applicationId;
@property(nonatomic,strong)NSString<Optional> * productId;
@property(nonatomic,strong)NSString<Optional> * protocolType;
@property(nonatomic,strong)NSString<Optional> * cardBank;
@property(nonatomic,strong)NSString<Optional> * cardNo;
//1、按周还款、2、按每2周还款、3、按月还款
@property(nonatomic,strong)NSString<Optional> * stagingType;


@end






