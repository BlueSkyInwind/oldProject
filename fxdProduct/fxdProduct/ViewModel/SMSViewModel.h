//
//  SMSViewModel.h
//  fxdProduct
//
//  Created by dd on 15/12/28.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "ViewModelClass.h"
#import "ReturnMsgBaseClass.h"
#import "SMSModel.h"
@interface SMSViewModel : ViewModelClass

/**
 发送验证码请求
 
 @param number 手机号
 @param flag 验证码类型
 */
- (void)fatchRequestSMSParamPhoneNumber:(NSString *)number flag:(NSString *)flag;
@end
