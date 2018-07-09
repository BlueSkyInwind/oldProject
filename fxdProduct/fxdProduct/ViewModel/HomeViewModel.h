//
//  HomeViewModel.h
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"
@interface HomeViewModel : FXD_ViewModelBaseClass

/**
 首页用户请求
 */
-(void)homeDataRequest;
/**
 获取导流链接
 */
-(void)obtainDiversionUrl;
/**
 统计三方导流
 
 @param productId 产品id
 */
-(void)statisticsDiversionPro:(NSString *)productId;
/**
 钱爸爸提现申请
 
 @param capitalPlatform 资金平台 2 合规 5 钱爸爸
 */
-(void)paidcenterQbbWithDrawCapitalPlatform:(NSString *)capitalPlatform;

/**
 推广带参地址

 @param urlStr 原始urll
 @param linkType 类型
 */
-(void)obtainParamAddress:(NSString *)urlStr linkType:(NSString *)linkType;
@end





