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
    model.service_platform_type_ = SERVICE_PLATFORM;
    NSString * flag = @"";
    switch (verifyCodeType) {
        case LOGIN_CODE:
            flag = CODE_LOGIN;
            break;
        case CHANGEDEVID_CODE:
            flag = CODE_CHANGEDEVID;
            break;
        case FINDPASS_CODE:
            flag = CODE_FINDPASS;
            break;
        case DRAW_CODE:
            flag = CODE_DRAW;
            break;
        case ADDCARD_CODE:
            flag = CODE_ADDCARD;
            break;
        case TRADEPASSWORD_CODE:
            flag = CODE_TRADEPASSWORD;
            model.flag = CODE_TRADEPASSWORD;
            break;
        default:
            flag = @"";
            break;
    }
    NSDictionary *paramDic = [model toDictionary];
    NSString * splitUrl = [NSString stringWithFormat:@"%@/%@",_getCode_url,flag];
    [self postVerifyCode:paramDic urlStr:splitUrl];
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
    model.service_platform_type_ = SERVICE_PLATFORM;
    NSDictionary *paramDic = [model toDictionary];
    [self postVerifyCode:paramDic urlStr:_regCode_url];
    
}

-(void)postVerifyCode:(NSDictionary *)paramDic  urlStr:(NSString *)urlStr{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,urlStr] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseResultM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
}

#pragma mark - 获取图片验证码

-(void)postPicVerifyCode{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getPicCode_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseResultM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseResultM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            self.faileBlock();
        }
    }];
    
}



@end
