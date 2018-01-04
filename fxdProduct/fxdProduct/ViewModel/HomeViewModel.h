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

@end

@interface ProductListViewModel : FXD_ViewModelBaseClass


@end




