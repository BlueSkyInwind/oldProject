//
//  UnbundlingBankCardViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UnbundlingBankCardViewModel.h"
#import "SendSmsParamModel.h"
#import "BankCardsParamModel.h"
#import "SaveAccountBankCardParamModel.h"
@implementation UnbundlingBankCardViewModel

-(void)sendSmsSHServiceBankNo:(NSString *)bankNo BusiType:(NSString *)busi_type SmsType:(NSString *)sms_type Mobile:(NSString *)mobile{

    SendSmsParamModel *sendSmsParamModel = [[SendSmsParamModel alloc]init];
    sendSmsParamModel.busi_type_ = busi_type;
    sendSmsParamModel.card_number_ = bankNo;
    sendSmsParamModel.mobile_ = mobile;
    sendSmsParamModel.sms_type_ = sms_type;
    sendSmsParamModel.from_mobile_ = [Utility sharedUtility].userInfo.userMobilePhone;
    
    NSDictionary * paramDic  = [sendSmsParamModel toDictionary];
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_P2P_url,_sendSms_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)bankCardsSHServiceParamArray:(NSMutableArray *)paramArray{

    BankCardsParamModel *bankCardsParamModel = [[BankCardsParamModel alloc]init];
    bankCardsParamModel.bank_code_ = paramArray[0];
    bankCardsParamModel.card_number_ = paramArray[1];
    bankCardsParamModel.from_mobile_ = paramArray[2];
    bankCardsParamModel.mobile_ = paramArray[3];
    bankCardsParamModel.ordsms_ext_ = paramArray[4];
    bankCardsParamModel.sms_code_ = paramArray[5];
    bankCardsParamModel.sms_seq_ = paramArray[6];
    bankCardsParamModel.trade_type_ = @"REBIND";
    NSDictionary * paramDic  = [bankCardsParamModel toDictionary];
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_P2P_url,_bankCards_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}


-(void)saveAccountBankCard:(NSMutableArray *)paramArray{

    SaveAccountBankCardParamModel *saveAccountBankCardParamModel = [[SaveAccountBankCardParamModel alloc]init];
    saveAccountBankCardParamModel.card_bank_ = paramArray[0];
    saveAccountBankCardParamModel.card_type_ = paramArray[1];
    saveAccountBankCardParamModel.card_no_ = paramArray[2];
    saveAccountBankCardParamModel.bank_reserve_phone_ = paramArray[3];
    saveAccountBankCardParamModel.verify_code_ = paramArray[4];
    
    NSDictionary *paramDic = [saveAccountBankCardParamModel toDictionary];
    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_BankNumCheck_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)getBankList{

    NSDictionary *paramDic = @{@"dict_type_":@"CARD_BANK_"};
    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_url,_getBankList_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
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
