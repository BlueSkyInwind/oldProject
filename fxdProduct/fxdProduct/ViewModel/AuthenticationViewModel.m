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
    [[FXD_NetWorkRequestManager sharedNetWorkManager]TCPOSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getTianChuangCertification_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            if (self.returnBlock) {
                self.returnBlock(object);
            }
        }else{
            
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

@end
