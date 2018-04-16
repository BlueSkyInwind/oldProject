//
//  CollectionListModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/12.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CollectionListRowsModel <NSObject>

@end

@interface CollectionListRowsModel : JSONModel

//平台id
@property (nonatomic, strong)NSString<Optional> *id_;
//标签
@property (nonatomic, strong)NSString<Optional> *label;
//最大放款金额
@property (nonatomic, strong)NSString<Optional> *maximumAmount;
//最大放款金额单位  1 元 2 万元
@property (nonatomic, strong)NSString<Optional> *maximumAmountUnit;
//最小放款金额
@property (nonatomic, strong)NSString<Optional> *minimumAmount;
//最小放款金额单位  1 元 2 万元
@property (nonatomic, strong)NSString<Optional> *minimumAmountUnit;
//平台图片
@property (nonatomic, strong)NSString<Optional> *plantLogo;
//平台名称
@property (nonatomic, strong)NSString<Optional> *plantName;
//平台编号
@property (nonatomic, strong)NSString<Optional> *plantNumber;
//平台简介
@property (nonatomic, strong)NSString<Optional> *platformIntroduction;
//优先级
@property (nonatomic, strong)NSString<Optional> *priority;
//参考利率方式  1 日利率 2 月利率 3 年利率
@property (nonatomic, strong)NSString<Optional> *referenceMode;
//借款利率
@property (nonatomic, strong)NSString<Optional> *referenceRate;
//借款期限
@property (nonatomic, strong)NSString<Optional> *unitStr;
//收藏类型
@property (nonatomic, strong)NSString<Optional> *moduletype;

@end

@interface CollectionListModel : JSONModel

//平台id
@property (nonatomic, strong)NSArray<CollectionListRowsModel,Optional> *rows;

@property (nonatomic, strong)NSString<Optional> *total;


@end



