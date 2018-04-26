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
#import "BankCardAuthorizationModel.h"
@implementation BankCardAuthorizationViewModel

-(void)cardAuthauthCodeListArr:(NSArray *)authCodeListArr smsCodeArray:(NSArray *)smsCodeArray bankCode:(NSString *)bankCode cardNo:(NSString *)cardNo phone:(NSString *)phone{

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:100];
    for (int i = 0; i<authCodeListArr.count; i++) {
        BankCardAuthorizationAuthListModel *model = (BankCardAuthorizationAuthListModel *)authCodeListArr[i];
        NSDictionary *modelDic = @{@"authPlatCode":model.authPlatCode,@"authSmsCode":smsCodeArray[i]};
        [arr addObject:modelDic];
    }
    NSDictionary *dic = @{@"authCodeList":arr, @"bankCode":bankCode,@"cardNo":cardNo,@"phone":phone};
    
    
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


-(void)cardAuthQueryBankShortName:(NSString *)bankShortName cardNo:(NSString *)cardNo{
    
    NSDictionary *dic = @{@"bankShortName" : bankShortName,@"cardNo":cardNo};
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
