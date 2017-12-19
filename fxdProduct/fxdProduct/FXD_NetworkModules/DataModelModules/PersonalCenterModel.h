//
//  PersonalCenterModel.h
//  fxdProduct
//
//  Created by sxp on 2017/11/24.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PersonalCenterModel : JSONModel

//可用优惠券数量
@property (strong,nonatomic)NSString<Optional> * voucherNum;

@end
