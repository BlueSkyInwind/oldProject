//
//  HomeViewModel.h
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "ViewModelClass.h"
#import "HomeBannerParamModel.h"
#import "HomePopParam.h"
@interface HomeViewModel : ViewModelClass

/**
 用户装填请求

 @param productId 产品id
 */
- (void)fetchUserState:(NSString *)productId;

/**
 获取借款滚动记录
 */
-(void)fetchLoanRecord;


@end


@interface BannerViewModel : ViewModelClass

/**
 请求轮播图信息
 */
-(void)fetchBannerInfo;

@end


@interface ProductListViewModel : ViewModelClass

/**
 获取产品列表
 */
-(void)fetchProductListInfo;

@end

@interface PopViewModel : ViewModelClass

/**
 获取弹窗信息
 */
-(void)fetchPopViewInfo;

@end


