//
//  HomeProductList.h
//  fxdProduct
//
//  Created by sxp on 17/4/26.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeProductListResult,HomeProductListProducts,HomeProductLisTextAttr;


@interface HomeProductList : NSObject

@property (nonatomic , copy) NSString              * flag;
@property (nonatomic , strong) HomeProductListResult              * result;
@property (nonatomic , copy) NSString              * ext;

@end


@interface HomeProductListResult : NSObject

@property (nonatomic , strong) NSArray<HomeProductListProducts *> * products;

@end

@interface HomeProductListProducts : NSObject

//利率
@property (nonatomic , copy) NSString      * day_service_fee_rate_;
//相关产品描述参数
@property (nonatomic , strong) HomeProductLisTextAttr     * ext_attr_;
//产品id
@property (nonatomic , copy) NSString              * ID;
//产品名称
@property (nonatomic , copy) NSString              * name_;
//期数时长
@property (nonatomic , copy) NSString              * staging_duration_;
//违约金额度
@property (nonatomic , copy) NSString              * liquidated_damages_;
//借款本金下限
@property (nonatomic , copy) NSString              * principal_bottom_;
//借款本金上限
@property (nonatomic , copy) NSString              * principal_top_;
//期数下限
@property (nonatomic , copy) NSString              * staging_bottom_;
//期数上限
@property (nonatomic , copy) NSString              * staging_top_;

@end

@interface HomeProductLisTextAttr : NSObject

//金额描述
@property (nonatomic , copy) NSString              * amt_desc_;
//利率描述
@property (nonatomic , copy) NSString              * charge_desc_;
//图标
@property (nonatomic , copy) NSString              * icon_;
//通过率
@property (nonatomic , copy) NSString              * pass_level_;
//详细地址
@property (nonatomic , copy) NSString              * path_;
//期限描述
@property (nonatomic , copy) NSString              * period_desc_;
//产品简述
@property (nonatomic , copy) NSArray              * tags;

@end
