//
//  UserMemberShipViewModel.h
//  fxdProduct
//
//  Created by admin on 2018/4/11.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface UserMemberShipViewModel : FXD_ViewModelBaseClass

/**
 获取会员信息
 */
-(void)obtainMemberShipInfo;

/**
 充值接口
 */
-(void)requestMemberCenterRecharge:(NSString *)bankCardID rechargeAmount:(NSString *)rechargeAmount;

/**
 扣费接口
 */
-(void)requestMemberCenterRefund:(NSString *)bankCardID refundAmount:(NSString *)refundAmount;



@end
