//
//  RedPacketTicketModel.h
//  fxdProduct
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol RedpacketDetailModel <NSObject>


@end
@interface RedPacketTicketModel : JSONModel

@property(nonatomic,strong)NSArray<RedpacketDetailModel,Optional> * inValidRedPacket;
@property(nonatomic,strong)NSString<RedpacketDetailModel,Optional> * validRedPacket;

@end

@interface RedpacketDetailModel : JSONModel

@property(nonatomic,strong)NSNumber<Optional> * total_amount_;
@property(nonatomic,strong)NSString<Optional> * id_;
@property(nonatomic,strong)NSString<Optional> * validity_period_from_;
@property(nonatomic,strong)NSString<Optional> * redpacket_name_;
@property(nonatomic,strong)NSNumber<Optional> * is_valid_;
@property(nonatomic,strong)NSString<Optional> * validity_period_to_;
@property(nonatomic,strong)NSString<Optional> * use_conditions_;
@property(nonatomic,strong)NSNumber<Optional> * residual_amount_;

@end
