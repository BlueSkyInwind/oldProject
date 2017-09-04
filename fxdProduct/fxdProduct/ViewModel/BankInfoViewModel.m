//
//  BankInfoViewModel.m
//  fxdProduct
//
//  Created by admin on 2017/9/2.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "BankInfoViewModel.h"

@implementation BankInfoViewModel

-(void)obtainUserBankCardList{

    [[FXDNetWorkManager sharedNetWorkManager] GetWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_BankCardList_url] parameters:nil finished:^(EnumServerStatus status, id object) {
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


-(void)obtainUserCommitstaging:(NSString *)staging cardId:(NSString *)cardId{

    //@"juid":[Utility sharedUtility].userInfo.juid,

    NSDictionary *paramDic = @{@"cardId":cardId,
                               @"staging":staging};
    
    [[FXDNetWorkManager sharedNetWorkManager]DataRequestWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_Staging_url] isNeedNetStatus:YES isNeedWait:YES parameters:paramDic finished:^(EnumServerStatus status, id object) {
        if (self.returnBlock) {
            self.returnBlock(object);
        }
    } failure:^(EnumServerStatus status, id object) {
        if (self.faileBlock) {
            [self faileBlock];
        }
    }];
//    [[FXDNetWorkManager sharedNetWorkManager]POSTWithURL:[NSString stringWithFormat:@"%@%@",_main_new_url,_Staging_url] parameters:paramDic finished:^(EnumServerStatus status, id object) {
//        if (self.returnBlock) {
//            self.returnBlock(object);
//        }
//    } failure:^(EnumServerStatus status, id object) {
//        if (self.faileBlock) {
//            [self faileBlock];
//        }
//    }];
}
@end
