//
//  ChangePasswordViewModel.h
//  fxdProduct
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXD_ViewModelBaseClass.h"
#import "changePasswordParam.h"

@interface ChangePasswordViewModel : FXD_ViewModelBaseClass

/**
 请求修改密码

 @param CurrentPassword 当前密码
 @param newPassword 新密码
 */
-(void)fetchChangePassowrdCurrent:(NSString *)CurrentPassword new:(NSString *)newPassword;


@end
