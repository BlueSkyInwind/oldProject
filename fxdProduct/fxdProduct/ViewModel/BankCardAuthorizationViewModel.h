//
//  BankCardAuthorizationViewModel.h
//  fxdProduct
//
//  Created by sxp on 2018/4/25.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "FXD_ViewModelBaseClass.h"

@interface BankCardAuthorizationViewModel : FXD_ViewModelBaseClass

//银行卡授权接口
-(void)cardAuthauthAuthPlatCode:(NSString *)authPlatCode authSmsCode:(NSString *)authSmsCode bankCode:(NSString *)bankCode cardNo:(NSString *)cardNo phone:(NSString *)phone;

//银行卡授权短信发送
-(void)cardAuthSmsSendAuthPlatCode:(NSString *)authPlatCode bankCode:(NSString *)bankCode cardNo:(NSString *)cardNo phone:(NSString *)phone;

//银行卡授权查询页面
-(void)cardAuthQueryBankShortName:(NSString *)bankShortName;
@end
