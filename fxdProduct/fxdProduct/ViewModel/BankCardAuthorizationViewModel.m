//
//  BankCardAuthorizationViewModel.m
//  fxdProduct
//
//  Created by sxp on 2018/4/25.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "BankCardAuthorizationViewModel.h"
#import "CardAuthAuthParamModel.h"
#import "CardAuthSmsSendParamModel.h"
@implementation BankCardAuthorizationViewModel

-(void)cardAuthauthAuthPlatCode:(NSString *)authPlatCode authSmsCode:(NSString *)authSmsCode bankCode:(NSString *)bankCode cardNo:(NSString *)cardNo phone:(NSString *)phone{

    CardAuthAuthParamModel *paramModel = [[CardAuthAuthParamModel alloc]init];
    paramModel.bankCode = bankCode;
    paramModel.cardNo = cardNo;
    paramModel.phone = phone;
    CardAuthAuthAuthCodeListParamModel *model = [[CardAuthAuthAuthCodeListParamModel alloc]init];
    model.authPlatCode = authPlatCode;
    model.authSmsCode = authSmsCode;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:model];
    paramModel.authCodeList = arr;
    NSDictionary *dic = [paramModel toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_cardAuthAuth_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];

}

-(void)cardAuthSmsSendAuthPlatCode:(NSString *)authPlatCode bankCode:(NSString *)bankCode cardNo:(NSString *)cardNo phone:(NSString *)phone{
    
    CardAuthSmsSendParamModel *paramModel = [[CardAuthSmsSendParamModel alloc]init];
    paramModel.authPlatCode = authPlatCode;
    paramModel.bankCode = bankCode;
    paramModel.cardNo = cardNo;
    paramModel.phone = phone;
    NSDictionary *dic = [paramModel toDictionary];
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_cardAuthSmsSend_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)cardAuthQueryBankShortName:(NSString *)bankShortName{
    
    NSDictionary *dic = @{@"bankShortName" : bankShortName};
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_cardAuthQuery_url] isNeedNetStatus:true isNeedWait:true parameters:dic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}
@end
