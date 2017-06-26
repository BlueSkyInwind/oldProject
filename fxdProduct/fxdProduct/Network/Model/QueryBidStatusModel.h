//
//  QueryBidStatusModel.h
//  fxdProduct
//
//  Created by sxp on 17/5/25.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryBidStatusModel : NSObject

/*期数*/
@property (nonatomic,copy)NSString *period_;
/*结清时间*/
@property (nonatomic,copy)NSString *settle_date_;
/*状态    1 初审中 2	银行审核中 3 筹款中 4	待放款（复审通过） 5 还款中（财务已放款） 6	结清 7 提前结清 0 没有此标的*/
@property (nonatomic,copy)NSString *status_;
@end
