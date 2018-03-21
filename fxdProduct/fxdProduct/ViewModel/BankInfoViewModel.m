//
//  BankInfoViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/9/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BankInfoViewModel.h"

@implementation BankInfoViewModel

-(void)obtainUserBankCardListPlatformType:(NSString *)platformType{

    NSDictionary *paramDic = @{@"platformType":platformType};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_BankCardList_url] isNeedNetStatus:true isNeedWait:true parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

//-(void)obtainUserCommitstaging:(NSString *)staging cardNo:(NSString *)cardNo{
//
//    NSDictionary *paramDic = @{@"cardNo":cardNo,@"staging":staging};
//    [[FXDNetWorkManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_Staging_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
//        if (self.returnBlock) {
//            self.returnBlock(object);
//        }
//    } failure:^(EnumServerStatus status, id object) {
//        if (self.faileBlock) {
//            [self faileBlock];
//        }
//    }];
//}


-(void)obtainUserCommitStaging:(NSString *)staging cardId:(NSString *)cardId{

    NSDictionary *paramDic = @{@"cardId":cardId,
                               @"stagingId":staging};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_Staging_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)obtainUserStagingRule{

    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_StagingRule_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
        
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)obtainTrilateralLink:(NSString * )stagingId  redPacketAmount:(NSString *)redPacketAmount redPacketId:(NSString *)redPacketId payType:(NSString *)payType stagingContinue:(BOOL)stagingContinue{
    
    NSDictionary *paramDic = @{@"payType":@"1",
                               @"redPacketAmount":redPacketAmount,
                               @"redPacketId":redPacketId,
                               @"stagingContinue":[NSNumber numberWithBool:stagingContinue],
                               @"stagingId":stagingId};
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_Trilateral_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
}

-(void)ChoosePatternList{
    
    [[FXD_NetWorkRequestManager sharedNetWorkManager]GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_ChoosePattern_url] isNeedNetStatus:true isNeedWait:true parameters:nil finished:^(EnumServerStatus status, id object) {
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
