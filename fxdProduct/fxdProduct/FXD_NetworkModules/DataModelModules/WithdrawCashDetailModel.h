//
//  WithdrawCashDetailModel.h
//  fxdProduct
//
//  Created by sxp on 2017/12/4.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol RedPacketMapModel <NSObject>


@end

@protocol WithdrawCashDetailListModel <NSObject>


@end

@interface WithdrawCashDetailModel : JSONModel

//展示数据
@property(nonatomic,strong)NSArray<RedPacketMapModel,Optional> * redPacketMap;
//展示数据
@property(nonatomic,strong)NSArray<WithdrawCashDetailListModel,Optional> * withdrawCashDetailList;


@end

@interface RedPacketMapModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * total_amount_;
@property(nonatomic,strong)NSString<Optional> * get_date_;
@property(nonatomic,strong)NSString<Optional> * redpacket_name_;

@end

@interface WithdrawCashDetailListModel : JSONModel

//@property(nonatomic,strong)NSString<Optional> * total_amount_;
//@property(nonatomic,strong)NSString<Optional> * get_date_;
//@property(nonatomic,strong)NSString<Optional> * redpacket_name_;

@end
