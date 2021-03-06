//
//  ApplicationViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface ApplicationViewModel : FXD_ViewModelBaseClass


/**
 用户创建进件
 */
-(void)userCreateApplication:(NSString *)productId platformCode:(NSString *)platformCode baseId:(NSString *)baseId;


/**
 申请确认页信息
 */
-(void)queryApplicationInfo:(NSString *)productId;

/**
 资金平台列表
 */

-(void)capitalList:(NSString *)productId approvalAmount:(NSString *)approvalAmount;

/**
 资金平台放款接口
 */

-(void)capitalLoan:(NSString *)cardId loanfor:(NSString *)loanfor periods:(NSString *)periods;

/**
 app 连连绑卡页面用户放弃操作接口
 */
-(void)capitalLoanFail;

/**
 优惠券及现金红包接口
 @param type 类型 1 、优惠券 2、现金红包
 @param displayType 类型 1 、提额处 2、个人中心处
 */
-(void)obtainUserDiscountTicketList:(NSString *)type displayType:(NSString *)displayType;

/**
 获取优惠券
 
 @param type 类型
 @param displayType 用处
 @param pageNum 页数
 @param pageSize 每页数量
 @param product_id 产品id
 */
-(void)new_obtainUserDiscountTicketListDisplayType:(NSString *)displayType product_id:(NSString *)product_id pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize;


@end
