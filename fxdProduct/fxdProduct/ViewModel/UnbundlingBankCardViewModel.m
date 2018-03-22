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

-(void)saveAccountBankCard:(NSMutableArray *)paramArray{

    SaveAccountBankCardParamModel *saveAccountBankCardParamModel = [[SaveAccountBankCardParamModel alloc]init];
    saveAccountBankCardParamModel.card_bank_ = paramArray[0];
    saveAccountBankCardParamModel.card_type_ = paramArray[1];
    saveAccountBankCardParamModel.card_no_ = paramArray[2];
    saveAccountBankCardParamModel.bank_reserve_phone_ = paramArray[3];
    saveAccountBankCardParamModel.verify_code_ = paramArray[4];
    
    NSDictionary *paramDic = [saveAccountBankCardParamModel toDictionary];

    [[FXD_NetWorkRequestManager sharedNetWorkManager] DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_BankNumCheck_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
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
