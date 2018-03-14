//
//  ComplianceViewModel.m
//  fxdProduct
//
//  Created by sxp on 2018/3/6.
//  Copyright © 2018年 dd. All rights reserved.
//

#import "ComplianceViewModel.h"
#import "SubmitAccountParamModel.h"
#import "SmsCodeParamModel.h"
#import "ChangeBankCardParamModel.h"

@implementation ComplianceViewModel

-(void)hgAccountInfo{
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_account_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
        
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}

-(void)hgSubmitAccountInfoBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone bankShortName:(NSString *)bankShortName cardId: (NSString *)cardId cardNo:(NSString *)cardNo retUrl:(NSString *)retUrl smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode{
    
    SubmitAccountParamModel *paramModel = [[SubmitAccountParamModel alloc]init];
    paramModel.bankNo = bankNo;
    paramModel.bankReservePhone = bankReservePhone;
    paramModel.bankShortName = bankShortName;
    paramModel.cardId = cardId;
    paramModel.cardNo = cardNo;
    paramModel.retUrl = retUrl;
    paramModel.smsSeq = smsSeq;
    paramModel.userCode = userCode;
    paramModel.verifyCode = verifyCode;
    NSDictionary *paramDic = [paramModel toDictionary];
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]HG_POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_account_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}

-(void)hgSendSmsCodeBusiType:(NSString *)busiType smsTempType:(NSString *)smsTempType bankCardNo:(NSString *)bankCardNo capitalPlatform:(NSString *)capitalPlatform mobile:(NSString *)mobile userCode:(NSString *)userCode{
    SmsCodeParamModel *paramModel = [[SmsCodeParamModel alloc]init];
    paramModel.BusiType = busiType;
    paramModel.SmsTempType = smsTempType;
    paramModel.bankCardNo = bankCardNo;
    paramModel.capitalPlatform = capitalPlatform;
    paramModel.mobile = mobile;
    paramModel.userCode = userCode;
    paramModel.client = @"3";
    NSDictionary *paramDic = [paramModel toDictionary];
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_sendSms_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)hgChangeBankCardBankNo:(NSString *)bankNo bankReservePhone:(NSString *)bankReservePhone cardNo:(NSString *)cardNo orgSmsCode:(NSString *)orgSmsCode orgSmsSeq:(NSString *)orgSmsSeq smsSeq:(NSString *)smsSeq userCode:(NSString *)userCode verifyCode:(NSString *)verifyCode{
    
    ChangeBankCardParamModel *paramModel = [[ChangeBankCardParamModel alloc]init];
    paramModel.bankNo = bankNo;
    paramModel.bankReservePhone = bankReservePhone;
    paramModel.cardNo = cardNo;
    paramModel.orgSmsCode = orgSmsCode;
    paramModel.orgSmsSeq = orgSmsSeq;
    paramModel.smsSeq = smsSeq;
    paramModel.userCode = userCode;
    paramModel.verifyCode = verifyCode;
    NSDictionary *paramDic = [paramModel toDictionary];
    [[FXD_NetWorkRequestManager sharedNetWorkManager]HG_POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_change_BankCards_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
        
    }];
}


//获取合规换绑卡信息
-(void)hgChangeBankCardInfo{
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_change_BankCards_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
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
