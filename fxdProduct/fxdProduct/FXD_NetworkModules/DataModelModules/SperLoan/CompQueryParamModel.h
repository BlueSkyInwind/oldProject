//
//  CompQueryParamModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CompQueryParamModel : JSONModel

//每页显示量
@property (nonatomic, strong)NSString<Optional> *limit;
//偏移量
@property (nonatomic, strong)NSString<Optional> *offset;
//排序方式 升序：ASC;降序：DESC
@property (nonatomic, strong)NSString<Optional> *order;
//排序字段 默认:0:priority;1:最高借款额度;2:借款费率;3:借款速度;4借款周期
@property (nonatomic, strong)NSString<Optional> *sort;
//筛选条件最高额度
@property (nonatomic, strong)NSString<Optional> *maxAmount;
//筛选条件最大天数
@property (nonatomic, strong)NSString<Optional> *maxDays;
//筛选条件最低金额
@property (nonatomic, strong)NSString<Optional> *minAmount;
//筛选条件最小天数
@property (nonatomic, strong)NSString<Optional> *minDays;
//平台类型
@property (nonatomic, strong)NSString<Optional> *moduleType;


@end
