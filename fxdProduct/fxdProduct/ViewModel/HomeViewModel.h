//
//  HomeViewModel.h
//  fxdProduct
//
//  Created by dd on 15/12/25.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"
#import "HomeBannerParamModel.h"
#import "HomePopParam.h"
@interface HomeViewModel : FXD_ViewModelBaseClass

/**
 用户装填请求

 @param productId 产品id
 */
- (void)fetchUserState:(NSString *)productId;

/**
 获取借款滚动记录
 */
-(void)fetchLoanRecord;

/**
 获取借款进度
 */
-(void)fetchLoanProcess;

/**
 首页用户请求
 */
-(void)homeDataRequest;

@end

@interface ProductListViewModel : FXD_ViewModelBaseClass

/**
 获取产品列表
 */
-(void)fetchProductListInfo;

@end




