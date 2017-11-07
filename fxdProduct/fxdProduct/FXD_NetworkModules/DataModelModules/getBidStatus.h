//
//  getBidStatus.h
//  fxdProduct
//
//  Created by sxp on 17/5/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getBidStatus : NSObject

/*1	初审中 2	银行审核中 3	筹款中 4	待放款（复审通过） 5	还款中（财务已放款） 6	结清 7	提前结清 -1	初审不通过 -2	银行审核不通过 -3	流标（固定期限内没有满标，系统执行流标） -4	复审不通过 8 用户未注册 9用户未开户 10 用户未激活*/
@property (nonatomic,copy)NSString *status;

@end
