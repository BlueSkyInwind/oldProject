//
//  AuthenticationViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/6/26.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "AuthenticationViewModel.h"
#import "MobilePhoneOperatorParamModel.h"
@implementation AuthenticationViewModel


/**
 获取手机运营商
 */
-(void)obtainUserPhoneCarrierName{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getMobileOpera_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)TCphoneAuthenticationPhoneNum:(NSString *)number password:(NSString *)password smsCode:(NSString *)smsCode picCode:(NSString *)picCode{
    
    TCMobilePhoneOperatorParamModel * tcOperatorModel = [[TCMobilePhoneOperatorParamModel alloc]init];
    tcOperatorModel.mobile_phone_ = number;
    tcOperatorModel.service_password_ = password;
    if (![smsCode isEqualToString:@""] && smsCode) {
        tcOperatorModel.smsCode = smsCode;
    }
    if (![picCode isEqualToString:@""] && picCode) {
        tcOperatorModel.picCode = picCode;
    }
    NSDictionary * paramDic = [tcOperatorModel toDictionary];
    [[FXD_NetWorkRequestManager sharedNetWorkManager]TCPOSTWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_getTianChuangCertification_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
            if (self.returnBlock) {
                BaseResultModel * baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
                self.returnBlock(baseRM);
            }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

/**
 保存手机认证信息

 @param code 状态码
 */
-(void)SaveMobileAuth:(NSString *)code{
    
    NSDictionary *dic = @{@"code_":code};

    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_authMobilePhone_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            BaseResultModel * baseRM = [[BaseResultModel alloc]initWithDictionary:(NSDictionary *)object error:nil];
            self.returnBlock(baseRM);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

@end
