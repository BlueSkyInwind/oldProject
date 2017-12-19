//
//  FindPassViewModel.h
//  fxdProduct
//
//  Created by dd on 16/1/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface FindPassViewModel : FXD_ViewModelBaseClass

/**
 找回密码

 @param phone 手机号
 @param password 密码
 @param verify_code 验证码
 */
- (void)fatchFindPassPhone:(NSString *)phone password:(NSString *)password verify_code:(NSString *)verify_code;

@end
