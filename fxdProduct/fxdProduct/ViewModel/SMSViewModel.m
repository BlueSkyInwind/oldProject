//
//  SMSViewModel.m
//  fxdProduct
//
//  Created by dd on 15/12/28.
//  Copyright © 2015年 dd. All rights reserved.
//

#import "SMSViewModel.h"

@implementation SMSViewModel

/**
 发送验证码请求
 
 @param number 手机号
 @param flag 验证码类型
 */
- (void)fatchRequestSMSParamPhoneNumber:(NSString *)number verifyCodeType:(VerifyCodeType)verifyCodeType
{
    SMSModel * model  = [[SMSModel alloc]init];
    model.mobile_phone_  = number;
    
    switch (verifyCodeType) {
        case LOGIN_CODE:
            model.flag = CODE_LOGIN;
            break;
        case CHANGEDEVID_CODE:
            model.flag = CODE_CHANGEDEVID;
            break;
        case FINDPASS_CODE:
            model.flag = CODE_FINDPASS;
            break;
        case DRAW_CODE:
            model.flag = CODE_DRAW;
            break;
        case ADDCARD_CODE:
            model.flag = CODE_ADDCARD;
            break;
        default:
            break;
    }
    
    NSDictionary *paramDic = [model toDictionary];
    [self postVerifyCode:paramDic urlStr:_getCode_url];
}
/**
 注册验证码请求

 @param number 手机号
 @param picVerifyId 图片验证码id
 @param picVerifyCode 图片验证码
 */
- (void)fatchRequestRegSMSParamPhoneNumber:(NSString *)number
                            picVerifyId:(NSString *)picVerifyId
                          picVerifyCode:(NSString *)picVerifyCode;
{
    SMSModel * model  = [[SMSModel alloc]init];
    model.mobile_phone_  = number;
    model.flag = CODE_REG;
    model.pic_verify_code_ = picVerifyCode;
    model.pic_verify_id_ = picVerifyId;

    NSDictionary *paramDic = [model toDictionary];
    [self postVerifyCode:paramDic urlStr:_regCode_url];
    
}

-(void)postVerifyCode:(NSDictionary *)paramDic  urlStr:(NSString *)urlStr{
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,urlStr] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        ReturnMsgBaseClass *returnModel = [ReturnMsgBaseClass modelObjectWithDictionary:object];
        self.returnBlock(returnModel);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
}

#pragma mark - 获取图片验证码

-(void)postPicVerifyCode{
    
    [[FXDNetWorkManager sharedNetWorkManager] POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getPicCode_url] parameters:nil finished:^(EnumServerStatus status, id object) {
        self.returnBlock(object);
    } failure:^(EnumServerStatus status, id object) {
        [self faileBlock];
    }];
    
}



@end
