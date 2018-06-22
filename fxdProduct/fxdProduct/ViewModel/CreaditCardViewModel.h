//
//  CreaditCardViewModel.h
//  fxdProduct
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface CreaditCardViewModel : FXD_ViewModelBaseClass

/**
 获取信用卡列表
 */
-(void)obtainCreaditCardListInfoRequest;
/**
 信用卡筛选条件
 
 @param banktype 银行类型
 @param cardType 卡类型
 @param sort 倒序正序
 */
-(void)obtainCreaditCardListConditionRequest:(NSString *)banktype cardType:(NSString *)cardType sort:(BOOL)sort;
/**
 提交信用卡跳转记录
 
 @param third_platform_id 三方id
 */
-(void)submitReaditCardRecord:(NSString *)third_platform_id;

@end
