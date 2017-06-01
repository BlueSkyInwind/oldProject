//
//  UnbundlingBankCardViewModel.m
//  fxdProduct
//
//  Created by sxp on 17/6/1.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UnbundlingBankCardViewModel.h"
#import "SendSmsParamModel.h"
@implementation UnbundlingBankCardViewModel

-(void)sendSmsSHService:(NSString *)bankNo BusiType:(NSString *)busi_type SmsType:(NSString *)sms_type{

    SendSmsParamModel *sendSmsParamModel = [[SendSmsParamModel alloc]init];
    sendSmsParamModel.busi_type_ = busi_type;
    sendSmsParamModel.card_number_ = bankNo;
    sendSmsParamModel.mobile_ = [Utility sharedUtility].userInfo.userMobilePhone;
    sendSmsParamModel.sms_type_ = sms_type;
    sendSmsParamModel.from_mobile_ = [Utility sharedUtility].userInfo.userMobilePhone;
    
    NSDictionary * paramDic  = [sendSmsParamModel toDictionary];
    [[FXDNetWorkManager sharedNetWorkManager]P2POSTWithURL:[NSString stringWithFormat:@"%@%@",_p2P_url,_sendSms_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
        
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
