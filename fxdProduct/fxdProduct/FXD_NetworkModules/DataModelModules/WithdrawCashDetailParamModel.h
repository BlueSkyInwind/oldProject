//
//  WithdrawCashDetailParamModel.h
//  fxdProduct
//
//  Created by sxp on 2017/12/4.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WithdrawCashDetailParamModel : JSONModel

//操作类型（1现金红包、2账户余额）
@property (nonatomic,copy)NSString *operateType;
//当前页
@property (nonatomic,copy)NSString *pageNum;
//每页数量
@property (nonatomic,copy)NSString *pageSize;

@end
