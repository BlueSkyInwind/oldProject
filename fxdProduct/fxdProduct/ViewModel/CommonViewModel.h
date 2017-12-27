//
//  CommonViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/12/13.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface CommonViewModel : FXD_ViewModelBaseClass

/**
 版本检测
 */
-(void)appVersionChecker;

/**
 协议获取

 @param Type_id 协议类型\产品id
 @param typeCode 协议类型
 @param apply_id 申请件id
 @param periods 期数
 */
-(void)obtainProductProtocolType:(NSString *)Type_id typeCode:(NSString *)typeCode apply_id:(NSString *)apply_id periods:(NSString *)periods;
@end
