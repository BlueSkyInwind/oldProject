//
//  HotRecommendModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HotRecommendModel : JSONModel

//链接地址
@property (nonatomic, strong)NSString<Optional> *linkAddress;
//平台LOGO
@property (nonatomic, strong)NSString<Optional> *plantLogo;
//平台名称
@property (nonatomic, strong)NSString<Optional> *plantName;
//平台简介
@property (nonatomic, strong)NSString<Optional> *platformIntroduction;
//1 日利率 2 月利率 3 年利率
@property (nonatomic, strong)NSString<Optional> *referenceMode;
//借款利率
@property (nonatomic, strong)NSString<Optional> *referenceRate;
//0已收藏 1 未收藏
@property (nonatomic, strong)NSString<Optional> *isCollect;



@end
