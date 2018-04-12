//
//  MemberShipInfoModel.h
//  fxdProduct
//
//  Created by admin on 2018/4/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "BaseResultModel.h"

@interface MemberShipInfoModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * availableCredit;
@property(nonatomic,strong)NSString<Optional> * availableRefundAmount;
@property(nonatomic,strong)NSString<Optional> * chargeAmount;
@property(nonatomic,strong)NSString<Optional> * credit;
@property(nonatomic,strong)NSString<Optional> * isNeedRequest;
@property(nonatomic,strong)NSString<Optional> * isRefundAble;
@property(nonatomic,strong)NSString<Optional> * refundAmount;
@property(nonatomic,strong)NSString<Optional> * requestAmount;
@property(nonatomic,strong)NSString<Optional> * settleCount;
@property(nonatomic,strong)NSString<Optional> * status;  //会员状态（1-未开通；2-已开通；3-充值中；4-退款中）

@end
