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

typedef enum {
    
    LOGIN_CODE = 100,
    REGISTRE_CODE,
    CHANGEDEVID_CODE,
    FINDPASS_CODE,
    DRAW_CODE,
    ADDCARD_CODE,
    
}VerifyCodeType;

@interface SMSViewModel : ViewModelClass

/**
 发送验证码请求
 
 @param number 手机号
 @param verifyCodeType 验证码类型
 */
- (void)fatchRequestSMSParamPhoneNumber:(NSString *)number
                         verifyCodeType:(VerifyCodeType)verifyCodeType;


/**
 注册验证码请求
 
 @param number 手机号
 @param picVerifyId 图片验证码id
 @param picVerifyCode 图片验证码
 */
- (void)fatchRequestRegSMSParamPhoneNumber:(NSString *)number
                            picVerifyId:(NSString *)picVerifyId
                          picVerifyCode:(NSString *)picVerifyCode;

/**
 获取图片验证码
 */
-(void)postPicVerifyCode;






@end
