//
//  QueryUserBidStatusModel.h
//  fxdProduct
//
//  Created by sxp on 17/6/14.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QueryUserBidStatusResultModel;
@interface QueryUserBidStatusModel : NSObject

@property (nonatomic,copy)NSString *flag;

@property (nonatomic,strong)QueryUserBidStatusResultModel *result;


@end

@interface QueryUserBidStatusResultModel : NSObject

/*标的ID*/
@property (nonatomic,copy)NSString *bid_id_;
/**/
@property (nonatomic,copy)NSString *period_;
/*标的期数   yyyy-MM-dd HH:mm:ss格式的结清时间，若还未结清则为空*/
@property (nonatomic,copy)NSString *settle_date_;
/*标的状态   0	未开户 1	处理中 2	待激活 3	正常 4	标的录入失败 5	待放款 6	还款中 7	结清 8	提前结清*/
@property (nonatomic,copy)NSString *status;

@end
