//
//  CompQueryModel.h
//  fxdProduct
//
//  Created by sxp on 2018/3/28.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol RowsModel <NSObject>

@end
@interface RowsModel : JSONModel

//右侧标签标识  0:不包借，1:包借，2:待还款
@property (nonatomic, strong)NSString<Optional> *borrowMoney;
//平台id
@property (nonatomic, strong)NSString<Optional> *id_;
//标签
@property (nonatomic, strong)NSString<Optional> *label;
//最大放款金额
@property (nonatomic, strong)NSString<Optional> *maximumAmount;
//最大放款金额单位 1 元 2 万元
@property (nonatomic, strong)NSString<Optional> *maximumAmountUnit;
//最小放款金额
@property (nonatomic, strong)NSString<Optional> *minimumAmount;
//最小放款金额单位  1 元 2 万元
@property (nonatomic, strong)NSString<Optional> *minimumAmountUnit;
//最大额度
@property (nonatomic, strong)NSString<Optional> *minunitMaximumAmount;
//最小额度
@property (nonatomic, strong)NSString<Optional> *minunitMinimumAmount;
//借款利率
@property (nonatomic, strong)NSString<Optional> *minunitReferenceRate;
//借款速度
@property (nonatomic, strong)NSString<Optional> *minunitTheFastest;
//平台LOGO
@property (nonatomic, strong)NSString<Optional> *plantLogo;
//平台名称
@property (nonatomic, strong)NSString<Optional> *plantName;
//平台简介
@property (nonatomic, strong)NSString<Optional> *platformIntroduction;
//优先级
@property (nonatomic, strong)NSString<Optional> *priority;
//参考利率方式  1 日利率 2 月利率 3 年利率
@property (nonatomic, strong)NSString<Optional> *referenceMode;
//借款利率
@property (nonatomic, strong)NSString<Optional> *referenceRate;
//期限
@property (nonatomic, strong)NSString<Optional> *unitStr;

@end

@interface CompQueryModel : JSONModel

//列表
@property(nonatomic,strong)NSArray<RowsModel,Optional> * rows;
//期限
@property (nonatomic, strong)NSString<Optional> *total;


@end


