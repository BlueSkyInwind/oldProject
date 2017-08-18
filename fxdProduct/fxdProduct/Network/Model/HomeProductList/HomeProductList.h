//
//  HomeProductList.h
//  fxdProduct
//
//  Created by sxp on 17/4/26.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeProductListData,HomeProductListProducts,HomeProductLisTextAttr,HomePopList,HomePaidList,HomeProductsList,HomeBannerList;


@interface HomeProductList : NSObject

@property (nonatomic , copy) NSString              * errCode;
@property (nonatomic , strong) HomeProductListData              * data;
@property (nonatomic , copy) NSString              * errMsg;
@property (nonatomic , copy) NSString              * friendErrMsg;

@end


@interface HomeProductListData : NSObject

@property (nonatomic , strong) NSArray<HomeBannerList *>   * bannerList;
@property (nonatomic , strong) NSArray<NSString *>     * paidList;
@property (nonatomic , strong) NSArray<HomePopList *>      * popList;
@property (nonatomic , strong) HomeProductsList            * productList;
@property (nonatomic , copy)NSString *user;

@end

@interface HomeProductListProducts : NSObject

//利率
@property (nonatomic , copy) NSString      * dayServiceFeeRate;
//相关产品描述参数
@property (nonatomic , strong) HomeProductLisTextAttr     * extAttr;
//产品id
@property (nonatomic , copy) NSString              * id_;
//产品名称
@property (nonatomic , copy) NSString              * name;
//期数时长
@property (nonatomic , copy) NSString              * platformType;
//违约金额度
@property (nonatomic , copy) NSString              * liquidatedDamages;
//借款本金下限
@property (nonatomic , copy) NSString              * principalBottom;
//借款本金上限
@property (nonatomic , copy) NSString              * principalTop;
//期数下限
@property (nonatomic , copy) NSString              * stagingBottom;
//期数上限
@property (nonatomic , copy) NSString              * stagingDuration;
//是否超限
@property (nonatomic , copy) NSString              * isOverLimit;
//产品路径
@property (nonatomic , copy) NSString              * stagingTop;
//产品路径
@property (nonatomic , copy) NSString              * remark_;
//产品路径
@property (nonatomic , copy) NSString              * pre_service_fee_rate_;

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

@interface HomeBannerList : NSObject

@end

@interface HomePaidList : NSObject

@end

@interface HomePopList : NSObject

@end

@interface HomeProductsList : NSObject

@property (nonatomic , strong) NSArray<HomeProductListProducts *> * products;

@property (nonatomic , copy) NSString              * refuseMsg;
/*导流判断*/
@property (nonatomic , copy) NSString              * type;

@end
